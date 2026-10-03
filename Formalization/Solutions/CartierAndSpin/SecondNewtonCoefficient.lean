import Mathlib.RingTheory.Polynomial.Vieta
import Mathlib.LinearAlgebra.Lagrange
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

open Polynomial

variable {R ι : Type*} [CommRing R]

theorem multiset_esymm_first (s : Multiset R) : s.esymm 1 = s.sum := by
  simp [Multiset.esymm, Multiset.powersetCard_one]

/-- The second Newton identity over every commutative ring, with no
division by two and no distinct-root assumption. -/
theorem multiset_second_newton (s : Multiset R) :
    (s.map (fun x => x ^ 2)).sum = s.esymm 1 ^ 2 - 2 * s.esymm 2 := by
  induction s using Multiset.induction_on with
  | empty => simp [Multiset.esymm]
  | @cons a s ih =>
    have he2 : (a ::ₘ s).esymm 2 = a * s.esymm 1 + s.esymm 2 := by
      simp only [Multiset.esymm, Multiset.powersetCard_cons, Multiset.map_add,
        Multiset.sum_add, Multiset.map_map, Function.comp_def, Multiset.prod_cons]
      rw [Multiset.sum_map_mul_left]
      exact add_comm _ _
    rw [Multiset.map_cons, Multiset.sum_cons, ih, he2]
    simp only [multiset_esymm_first, Multiset.sum_cons]
    ring

theorem nodal_five_second_newton (s : Finset ι) (node : ι → R) (hcard : s.card = 5) :
    (∑ i ∈ s, node i ^ 2) =
      (Lagrange.nodal s node).coeff 4 ^ 2 - 2 * (Lagrange.nodal s node).coeff 3 := by
  classical
  have hval : s.val.card = 5 := hcard
  have h4 := (s.val.map node).prod_X_sub_C_coeff (k := 4)
    (by simpa only [Multiset.card_map, hval] using (by omega : 4 ≤ 5))
  have h3 := (s.val.map node).prod_X_sub_C_coeff (k := 3)
    (by simpa only [Multiset.card_map, hval] using (by omega : 3 ≤ 5))
  have h4' : (Lagrange.nodal s node).coeff 4 = -(s.val.map node).esymm 1 := by
    simpa only [Lagrange.nodal, Finset.prod, Multiset.map_map, Function.comp_def,
      Multiset.card_map, hval, Nat.reduceSub, pow_one, neg_one_mul] using h4
  have h3' : (Lagrange.nodal s node).coeff 3 = (s.val.map node).esymm 2 := by
    simpa only [Lagrange.nodal, Finset.prod, Multiset.map_map, Function.comp_def,
      Multiset.card_map, hval, Nat.reduceSub, neg_one_sq, one_mul] using h3
  rw [h4', h3', neg_sq]
  simpa only [Multiset.map_map, Function.comp_def, Finset.sum] using
    multiset_second_newton (s.val.map node)

end Litt3.CartierAndSpin

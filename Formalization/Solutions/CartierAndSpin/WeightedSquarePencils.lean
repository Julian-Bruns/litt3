import Solutions.CartierAndSpin.RationalSquareClassIndependence
import Mathlib.Data.Nat.Factorization.Basic
import Mathlib.Data.Set.Card

namespace Litt3.CartierAndSpin

open Polynomial

variable {k T L : Type*} {ι : Type*} [Field k] [Field T] [Field L]
  [Algebra k[X] T] [IsFractionRing k[X] T] [Algebra T L]

/-- Exact power-of-two degree obstruction for any finite collection of
weighted square-pencil values. The weight need not be a square. The
rational function field and all square roots live in the actual same
ambient field. -/
theorem weighted_square_pencil_degree_divisibility [FiniteDimensional T L]
    (s : Finset ι) (theta : ι → k) (g : L) (hg : g ≠ 0)
    (htwo : (2 : T) ≠ 0) (hinj : Set.InjOn theta s)
    (hsquare : ∀ i ∈ s, IsSquare
      (g * algebraMap T L (algebraMap k[X] T (X - C (theta i))))) :
    2 ^ (s.card - 1) ∣ Module.finrank T L := by
  classical
  rcases s.eq_empty_or_nonempty with rfl | hs
  · simp
  obtain ⟨base, hbase⟩ := hs
  let a : ι → T := fun i => algebraMap k[X] T (X - C (theta i))
  have ha : ∀ i, a i ≠ 0 := by
    intro i
    have h := (IsFractionRing.injective k[X] T).ne (Polynomial.X_sub_C_ne_zero (theta i))
    simpa only [a, map_zero] using h
  have roots : ∀ i ∈ s, ∃ r : L, r ^ 2 = g * algebraMap T L (a i) := by
    intro i hi
    obtain ⟨r, hr⟩ := hsquare i hi
    exact ⟨r, by simpa only [pow_two] using hr.symm⟩
  choose root hroot using roots
  let r0 := root base hbase
  have hr0 : r0 ^ 2 = g * algebraMap T L (a base) := hroot base hbase
  have hr0ne : r0 ≠ 0 := by
    intro hz
    have hzero : g * algebraMap T L (a base) = 0 := by simpa [hz] using hr0.symm
    exact (mul_ne_zero hg (by
      simpa only [map_zero] using (algebraMap T L).injective.ne (ha base))) hzero
  let paired : ι → T := fun i => a i * a base
  let newroot : ι → L := fun i => if hi : i ∈ s then
    root i hi / r0 * algebraMap T L (a base) else 0
  have hind : SquareClassIndependent (s.erase base) paired := by
    apply paired_linear_square_classes_independent (s.erase base) base theta
      (Finset.notMem_erase base s)
    simpa only [Finset.insert_erase hbase] using hinj
  have hnewroot : ∀ i ∈ s.erase base, newroot i ^ 2 = algebraMap T L (paired i) := by
    intro i hi
    have his : i ∈ s := Finset.mem_of_mem_erase hi
    dsimp only [newroot]
    rw [dif_pos his]
    dsimp only [paired]
    rw [map_mul]
    rw [mul_pow, div_pow, div_mul_eq_mul_div]
    apply (div_eq_iff (pow_ne_zero 2 hr0ne)).mpr
    rw [hroot i his, hr0]
    ring
  have hdvd := independent_square_roots_degree_divisibility (s.erase base) paired newroot
    htwo hind hnewroot
  simpa only [Finset.card_erase_of_mem hbase] using hdvd

/-- The finite square-pencil support bound is 1+v₂ of the actual field
degree, stated using the exact natural-number prime factorization. -/
theorem weighted_square_pencil_finset_card_bound [FiniteDimensional T L]
    (s : Finset k) (g : L) (hg : g ≠ 0) (htwo : (2 : T) ≠ 0)
    (hsquare : ∀ theta ∈ s, IsSquare
      (g * algebraMap T L (algebraMap k[X] T (X - C theta)))) :
    s.card ≤ 1 + (Module.finrank T L).factorization 2 := by
  have hdvd := weighted_square_pencil_degree_divisibility s id g hg htwo
    (fun _ _ _ _ h => h) hsquare
  have hdegree : Module.finrank T L ≠ 0 := Module.finrank_pos.ne'
  have hle := (Nat.prime_two.pow_dvd_iff_le_factorization hdegree).mp hdvd
  omega

/-- Genuine set finiteness and the same exact cardinality bound follow
from the field tower theorem, without enumerating square roots or fibers. -/
theorem weighted_square_pencil_support_finite [FiniteDimensional T L]
    (g : L) (hg : g ≠ 0) (htwo : (2 : T) ≠ 0) :
    let support : Set k := {theta | IsSquare
      (g * algebraMap T L (algebraMap k[X] T (X - C theta)))}
    support.Finite ∧ support.ncard ≤ 1 + (Module.finrank T L).factorization 2 := by
  intro support
  have hfinite : support.Finite := by
    by_contra h
    obtain ⟨s, hs, hcard⟩ := Set.Infinite.exists_subset_card_eq h
      (2 + (Module.finrank T L).factorization 2)
    have hle := weighted_square_pencil_finset_card_bound s g hg htwo (fun i hi => hs hi)
    omega
  refine ⟨hfinite, ?_⟩
  have hle := weighted_square_pencil_finset_card_bound hfinite.toFinset g hg htwo
    (fun i hi => hfinite.mem_toFinset.mp hi)
  rw [Set.ncard_eq_toFinset_card support hfinite]
  exact hle

end Litt3.CartierAndSpin

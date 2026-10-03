import Solutions.CartierAndSpin.SquareClassTowers
import Solutions.QuotientGeometry.QuadraticFunctionFields
import Mathlib.LinearAlgebra.Lagrange
import Mathlib.Algebra.Ring.Parity

namespace Litt3.CartierAndSpin

open Polynomial Lagrange

variable {k T : Type*} {ι : Type*} [Field k] [Field T]
  [Algebra k[X] T] [IsFractionRing k[X] T]

/-- Every nonempty product of distinct linear factors is genuinely
nonsquare in the actual rational function field. This uses squarefree
integrality, without computing a chosen valuation. -/
theorem distinct_linear_product_nonsquare (s : Finset ι) (theta : ι → k)
    (hs : s.Nonempty) (hinj : Set.InjOn theta s) :
    ¬ IsSquare (algebraMap k[X] T (nodal s theta)) := by
  have hsep : (nodal s theta).Separable :=
    Polynomial.separable_prod_X_sub_C_iff'.mpr hinj
  have hnonunit : ¬ IsUnit (nodal s theta) := by
    intro hu
    have hz := Polynomial.natDegree_eq_zero_of_isUnit hu
    rw [natDegree_nodal] at hz
    exact hs.card_pos.ne' hz
  rintro ⟨root, hroot⟩
  exact Litt3.QuotientGeometry.squarefree_nonunit_nonsquare_in_fraction_field
    (nodal s theta) hsep.squarefree hnonunit root (by
      simpa only [pow_two] using hroot.symm)

theorem distinct_linear_square_classes_independent (s : Finset ι) (theta : ι → k)
    (hinj : Set.InjOn theta s) :
    SquareClassIndependent s
      (fun i => algebraMap k[X] T (X - C (theta i))) := by
  intro t ht htnonempty
  have h := distinct_linear_product_nonsquare (T := T) t theta htnonempty
    (hinj.mono ht)
  simpa only [nodal, map_prod] using h

/-- The pair-products (X-theta_i)(X-theta_0) are independent square
classes as i ranges over distinct constants different from theta_0.
The common factor's parity is handled exactly; no divisor oracle or
numerical square testing is used. -/
theorem paired_linear_square_classes_independent [DecidableEq ι]
    (s : Finset ι) (base : ι) (theta : ι → k)
    (hbase : base ∉ s) (hinj : Set.InjOn theta ((insert base s : Finset ι) : Set ι)) :
    SquareClassIndependent s
      (fun i => algebraMap k[X] T (X - C (theta i)) *
        algebraMap k[X] T (X - C (theta base))) := by
  classical
  intro t ht htne hsquare
  let z : T := algebraMap k[X] T (X - C (theta base))
  let product : T := algebraMap k[X] T (nodal t theta)
  have hz : z ≠ 0 := by
    simpa only [z, map_zero] using
      (IsFractionRing.injective k[X] T).ne (Polynomial.X_sub_C_ne_zero (theta base))
  have hproduct : IsSquare (product * z ^ t.card) := by
    simpa only [product, z, nodal, Finset.prod_mul_distrib, map_prod,
      Finset.prod_const] using hsquare
  obtain ⟨n, hn | hn⟩ := Nat.even_or_odd' t.card
  · have hp : IsSquare product := by
      apply (isSquare_mul_square_iff product (z ^ n) (pow_ne_zero _ hz)).mp
      rw [hn, Nat.mul_comm 2 n, pow_mul] at hproduct
      exact hproduct
    exact distinct_linear_product_nonsquare (T := T) t theta htne
      (hinj.mono (ht.trans (Finset.subset_insert base s))) hp
  · have hit : base ∉ t := fun hit => hbase (ht hit)
    have hp : IsSquare (z * product) := by
      apply (isSquare_mul_square_iff (z * product) (z ^ n) (pow_ne_zero _ hz)).mp
      convert hproduct using 1 <;> rw [hn] <;> ring
    have hnodal : algebraMap k[X] T (nodal (insert base t) theta) = z * product := by
      simp only [nodal, Finset.prod_insert hit, map_mul, product, z, map_prod]
    apply distinct_linear_product_nonsquare (T := T) (insert base t) theta
      (Finset.insert_nonempty base t) (hinj.mono (Finset.insert_subset_insert base ht))
    rwa [hnodal]

end Litt3.CartierAndSpin

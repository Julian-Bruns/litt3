import Solutions.Deformations.ElementaryAugmentationBasis
import Mathlib.Algebra.CharP.Lemmas
import Mathlib.Algebra.Polynomial.FieldDivision
import Mathlib.Algebra.Ring.GeomSum
import Mathlib.Algebra.BigOperators.Fin

namespace Litt3.Deformations

open scoped BigOperators

/-- The whole original prime-cycle norm polynomial follows from the
symbolic characteristic-p identity and cancellation in a polynomial ring.
It is then evaluated in an arbitrary coefficient algebra. -/
theorem prime_norm_polynomial (p : ℕ) [Fact p.Prime]
    (k A : Type*) [Field k] [CharP k p] [CommRing A] [Algebra k A] (s : A) :
    (s - 1) ^ (p - 1) = ∑ j : Fin p, s ^ j.val := by
  have prime := (Fact.out : p.Prime)
  have nonzero : (Polynomial.X - 1 : Polynomial k) ≠ 0 := by
    simpa only [Polynomial.C_1] using Polynomial.X_sub_C_ne_zero (1 : k)
  have formula : (Polynomial.X - 1 : Polynomial k) ^ (p - 1) =
      ∑ j : Fin p, (Polynomial.X : Polynomial k) ^ j.val := by
    apply mul_right_cancel₀ nonzero
    rw [← pow_succ, Nat.sub_add_cancel prime.one_le, sub_pow_char, one_pow]
    rw [Fin.sum_univ_eq_sum_range, geom_sum_mul]
  have mapped := congrArg (Polynomial.aeval s) formula
  simpa only [map_pow, map_sub, map_one, map_sum, Polynomial.aeval_X] using mapped

variable (p : ℕ) [Fact p.Prime]
variable {k : Type*} [Field k] [CharP k p]

/-- The highest original augmentation monomial is exactly the literal
whole group norm, at arbitrary prime and rank. -/
theorem elementary_prime_top_monomial_is_norm (r : ℕ) :
    (∏ i : Fin r, elementaryAugmentationParameter (R := k) p r i ^ (p - 1)) =
      ∑ g : Fin r → ZMod p, AddMonoidAlgebra.single g (1 : k) := by
  classical
  simp_rw [elementaryAugmentationParameter,
    prime_norm_polynomial p k (AddMonoidAlgebra k (Fin r → ZMod p))]
  rw [Fintype.prod_sum (fun i (j : Fin p) =>
    (AddMonoidAlgebra.single (Pi.single i (1 : ZMod p)) (1 : k)) ^ j.val)]
  have term (alpha : Fin r → Fin p) :
      (∏ i : Fin r, (AddMonoidAlgebra.single (Pi.single i (1 : ZMod p)) (1 : k)) ^
        (alpha i).val) =
      AddMonoidAlgebra.single (fun i => ZMod.finEquiv p (alpha i)) (1 : k) := by
    simp only [AddMonoidAlgebra.single_pow, one_pow]
    rw [AddMonoidAlgebra.prod_single]
    have index : (∑ i : Fin r, (alpha i).val • (Pi.single i (1 : ZMod p) : Fin r → ZMod p)) =
        fun i => ZMod.finEquiv p (alpha i) := by
      ext j
      simp [Pi.single_apply, nsmul_eq_mul]
      have originalVal : (ZMod.finEquiv p (alpha j)).val = (alpha j).val := by
        cases p with
        | zero => exact ((Fact.out : Nat.Prime 0).ne_zero rfl).elim
        | succ n => rfl
      simpa only [originalVal] using ZMod.natCast_zmod_val (ZMod.finEquiv p (alpha j))
    rw [index]
    simp
  simp_rw [term]
  exact Equiv.sum_comp (Equiv.piCongrRight (fun _ : Fin r => (ZMod.finEquiv p).toEquiv))
    (fun g => AddMonoidAlgebra.single g (1 : k))

end Litt3.Deformations

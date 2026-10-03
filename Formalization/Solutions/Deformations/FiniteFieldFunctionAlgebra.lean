import Mathlib.Algebra.MvPolynomial.Eval
import Mathlib.FieldTheory.Finite.Basic
import Mathlib.Algebra.BigOperators.Ring.Finset

namespace Litt3.Deformations

open scoped BigOperators

variable (F : Type*) [Field F] [Fintype F] [DecidableEq F]
variable {I K : Type*} [Fintype I] [DecidableEq I] [Field K]

/-- Actual multivariate Lagrange delta polynomial for an original
finite-field coordinate tuple. -/
noncomputable def finiteFieldDeltaPolynomial (φ : F →+* K) (a : I → F) : MvPolynomial I K :=
  ∏ i, (1 - (MvPolynomial.X i - MvPolynomial.C (φ (a i))) ^ (Fintype.card F - 1))

theorem finite_field_delta_evaluation (φ : F →+* K) (a x : I → F) :
    MvPolynomial.eval (fun i => φ (x i)) (finiteFieldDeltaPolynomial F φ a) =
      if x = a then 1 else 0 := by
  classical
  simp only [finiteFieldDeltaPolynomial, map_prod, map_sub, map_one, map_pow,
    MvPolynomial.eval_X, MvPolynomial.eval_C]
  have positive : 0 < Fintype.card F - 1 := by
    have := Fintype.one_lt_card (α := F)
    omega
  split_ifs with same
  · subst x
    simp [zero_pow (Nat.ne_of_gt positive)]
  · obtain ⟨i, different⟩ := Function.ne_iff.mp same
    apply Finset.prod_eq_zero (Finset.mem_univ i)
    have power : (φ (x i) - φ (a i)) ^ (Fintype.card F - 1) = 1 := by
      rw [← map_sub, ← map_pow,
        FiniteField.pow_card_sub_one_eq_one (x i - a i) (sub_ne_zero.mpr different), map_one]
    rw [power, sub_self]

/-- Genuine polynomial evaluation on the entire original finite-field
coordinate set is onto, by an explicit uniform interpolation formula. -/
theorem finite_field_polynomial_functions_surjective (φ : F →+* K) :
    Function.Surjective (fun p : MvPolynomial I K =>
      fun x : I → F => MvPolynomial.eval (fun i => φ (x i)) p) := by
  classical
  intro f
  refine ⟨∑ a : I → F, MvPolynomial.C (f a) * finiteFieldDeltaPolynomial F φ a, ?_⟩
  funext x
  simp only [map_sum, map_mul, MvPolynomial.eval_C, finite_field_delta_evaluation]
  simp

/-- Multiplication by a function vanishing only at the origin has
exactly the actual one-dimensional origin-supported kernel. -/
theorem finite_function_origin_kernel (q f : (I → F) → K)
    (zero : q 0 = 0) (directions : ∀ a : I → F, a ≠ 0 → q a ≠ 0) :
    (∀ a, q a * f a = 0) ↔ ∃ c : K, f = Pi.single 0 c := by
  classical
  constructor
  · intro vanish
    refine ⟨f 0, ?_⟩
    funext a
    by_cases origin : a = 0
    · subst a; simp
    · have value : f a = 0 := (mul_eq_zero.mp (vanish a)).resolve_left (directions a origin)
      simp [Pi.single_apply, origin, value]
  · rintro ⟨c, equality⟩ a
    rw [equality]
    by_cases origin : a = 0
    · subst a; simp [zero]
    · simp [Pi.single_apply, origin]

end Litt3.Deformations

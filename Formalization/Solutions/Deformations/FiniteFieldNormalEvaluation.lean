import Solutions.Deformations.FiniteFieldFunctionAlgebra
import Mathlib.RingTheory.MvPolynomial.Basic
import Mathlib.LinearAlgebra.FiniteDimensional.Lemmas

namespace Litt3.Deformations

open scoped BigOperators

variable (F : Type*) [Field F] [Fintype F] [DecidableEq F]
variable {I K : Type*} [Fintype I] [DecidableEq I] [Field K]

theorem finite_field_delta_normal_degree (φ : F →+* K) (a : I → F) :
    finiteFieldDeltaPolynomial F φ a ∈ MvPolynomial.restrictDegree I K (Fintype.card F - 1) := by
  classical
  apply (MvPolynomial.mem_restrictDegree I _ _).mpr
  intro alpha member j
  apply (MvPolynomial.monomial_le_degreeOf j member).trans
  let n := Fintype.card F - 1
  have factorBound (i : I) :
      (1 - (MvPolynomial.X i - MvPolynomial.C (φ (a i))) ^ n : MvPolynomial I K).degreeOf j ≤
        if i = j then n else 0 := by
    have inner := MvPolynomial.degreeOf_sub_le j (MvPolynomial.X i : MvPolynomial I K)
      (MvPolynomial.C (φ (a i)))
    simp only [MvPolynomial.degreeOf_X, MvPolynomial.degreeOf_C, Nat.max_zero] at inner
    have power := (MvPolynomial.degreeOf_pow_le j
      (MvPolynomial.X i - MvPolynomial.C (φ (a i))) n).trans (Nat.mul_le_mul_left n inner)
    have outer := MvPolynomial.degreeOf_sub_le j (1 : MvPolynomial I K)
      ((MvPolynomial.X i - MvPolynomial.C (φ (a i))) ^ n)
    have oneDegree : (1 : MvPolynomial I K).degreeOf j = 0 := by
      simpa using MvPolynomial.degreeOf_C (1 : K) j
    rw [oneDegree, Nat.zero_max] at outer
    by_cases same : i = j
    · subst i
      simpa only [ite_true, mul_one] using outer.trans power
    · simpa only [same, Ne.symm same, ite_false, mul_zero] using outer.trans power
  calc
    _ ≤ ∑ i : I,
        (1 - (MvPolynomial.X i - MvPolynomial.C (φ (a i))) ^ n : MvPolynomial I K).degreeOf j :=
      MvPolynomial.degreeOf_prod_le j Finset.univ _
    _ ≤ ∑ i : I, if i = j then n else 0 := Finset.sum_le_sum (fun i _ => factorBound i)
    _ = _ := by simp [n]

/-- Evaluation on all original finite-field tuples, restricted to
actual normal polynomials of degree at most card(F)-1 in each coordinate. -/
noncomputable def finiteFieldNormalEvaluation (φ : F →+* K) :
    MvPolynomial.restrictDegree I K (Fintype.card F - 1) →ₗ[K] ((I → F) → K) where
  toFun p a := MvPolynomial.eval (fun i => φ (a i)) p.val
  map_add' p q := by ext a; simp
  map_smul' c p := by ext a; simp [MvPolynomial.smul_eval]

/-- Actual bounded normal polynomials already interpolate every
function, rather than an unrestricted polynomial existence assumption. -/
theorem finite_field_normal_evaluation_surjective (φ : F →+* K) :
    Function.Surjective (finiteFieldNormalEvaluation (I := I) F φ) := by
  classical
  intro f
  let delta := fun a => (⟨finiteFieldDeltaPolynomial F φ a,
    finite_field_delta_normal_degree F φ a⟩ :
      MvPolynomial.restrictDegree I K (Fintype.card F - 1))
  refine ⟨∑ a : I → F, f a • delta a, ?_⟩
  ext x
  change finiteFieldNormalEvaluation F φ (∑ a : I → F, f a • delta a) x = f x
  simp only [map_sum, map_smul, Finset.sum_apply, Pi.smul_apply, smul_eq_mul]
  change (∑ a : I → F, f a *
    MvPolynomial.eval (fun i => φ (x i)) (finiteFieldDeltaPolynomial F φ a)) = f x
  simp only [finite_field_delta_evaluation]
  simp

end Litt3.Deformations

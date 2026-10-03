import Solutions.Deformations.FiniteFieldNormalEvaluation
import Mathlib.LinearAlgebra.Dimension.Constructions

namespace Litt3.Deformations

variable {I : Type*} [Fintype I] [DecidableEq I]

/-- Actual bounded monomial indices are the actual finite exponent
tuples, independently of any polynomial-function theorem. -/
noncomputable def normalPolynomialExponentEquiv (n : ℕ) :
    {alpha : I →₀ ℕ // ∀ i, alpha i ≤ n} ≃ (I → Fin (n + 1)) where
  toFun alpha i := ⟨alpha.val i, by have := alpha.property i; omega⟩
  invFun beta := ⟨Finsupp.equivFunOnFinite.symm (fun i => (beta i).val),
    fun i => by have := (beta i).isLt; change (beta i).val ≤ n; omega⟩
  left_inv alpha := by apply Subtype.ext; ext i; rfl
  right_inv beta := by ext i; rfl

variable (K : Type*) [Field K]

/-- Actual original normal polynomials have their literal normal
monomial basis indexed by finite exponent tuples. -/
noncomputable def normalPolynomialBasis (n : ℕ) :
    Module.Basis (I → Fin (n + 1)) K (MvPolynomial.restrictDegree I K n) :=
  (MvPolynomial.basisRestrictSupport K {alpha : I →₀ ℕ | ∀ i, alpha i ≤ n}).reindex
    (normalPolynomialExponentEquiv n)

theorem normal_polynomial_finrank (n : ℕ) :
    Module.finrank K (MvPolynomial.restrictDegree I K n) =
      (n + 1) ^ Fintype.card I := by
  rw [Module.finrank_eq_card_basis (normalPolynomialBasis (I := I) K n)]
  simp [Fintype.card_fun]

variable (F : Type*) [Field F] [Fintype F] [DecidableEq F]

/-- Literal bounded normal evaluation is bijective; interpolation
and exact monomial dimension prove injectivity without enumerating points. -/
theorem finite_field_normal_evaluation_bijective (φ : F →+* K) :
    Function.Bijective (finiteFieldNormalEvaluation (I := I) F φ) := by
  have dimensions : Module.finrank K (MvPolynomial.restrictDegree I K (Fintype.card F - 1)) =
      Module.finrank K ((I → F) → K) := by
    rw [normal_polynomial_finrank, Module.finrank_fintype_fun_eq_card]
    simp only [Fintype.card_fun]
    rw [Nat.sub_add_cancel Fintype.card_pos]
  exact ⟨(LinearMap.injective_iff_surjective_of_finrank_eq_finrank dimensions).mpr
    (finite_field_normal_evaluation_surjective F φ), finite_field_normal_evaluation_surjective F φ⟩

/-- Actual polynomial functions are identified with actual normal
polynomials, over every field extension of every finite field. -/
noncomputable def finiteFieldNormalEquiv (φ : F →+* K) :
    MvPolynomial.restrictDegree I K (Fintype.card F - 1) ≃ₗ[K] ((I → F) → K) :=
  LinearEquiv.ofBijective (finiteFieldNormalEvaluation F φ)
    (finite_field_normal_evaluation_bijective K F φ)

end Litt3.Deformations

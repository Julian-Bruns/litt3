import Solutions.Deformations.FiniteFieldNormalMonomials

namespace Litt3.Deformations

open scoped BigOperators

variable (F K : Type*) [Field F] [Fintype F] [DecidableEq F] [Field K]
variable {I : Type*} [Fintype I] [DecidableEq I]

/-- Actual coefficient arrays of original normal monomials are
equivalent to actual functions on all original finite-field tuples. -/
noncomputable def finiteFieldNormalFunctionCoordinates (φ : F →+* K) :
    ((I → Fin (Fintype.card F - 1 + 1)) → K) ≃ₗ[K] ((I → F) → K) :=
  (normalPolynomialBasis (I := I) K (Fintype.card F - 1)).equivFun.symm.trans
    (finiteFieldNormalEquiv K F φ)

theorem finite_field_normal_function_coordinates_apply (φ : F →+* K)
    (c : (I → Fin (Fintype.card F - 1 + 1)) → K) (a : I → F) :
    finiteFieldNormalFunctionCoordinates (I := I) F K φ c a =
      ∑ alpha : I → Fin (Fintype.card F - 1 + 1), c alpha *
        (∏ i, φ (a i) ^ (alpha i).val) := by
  rw [finiteFieldNormalFunctionCoordinates, LinearEquiv.trans_apply,
    Module.Basis.equivFun_symm_apply]
  change finiteFieldNormalEvaluation F φ
    (∑ alpha : I → Fin (Fintype.card F - 1 + 1),
      c alpha • normalPolynomialBasis (I := I) K (Fintype.card F - 1) alpha) a = _
  simp only [map_sum, map_smul, Finset.sum_apply, Pi.smul_apply, smul_eq_mul]
  apply Finset.sum_congr rfl
  intro alpha _
  change c alpha * MvPolynomial.eval (fun i => φ (a i))
    (normalPolynomialBasis (I := I) K (Fintype.card F - 1) alpha).val = _
  rw [normal_polynomial_basis_evaluation]

end Litt3.Deformations

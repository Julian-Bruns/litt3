import Solutions.Deformations.FiniteFieldNormalEquiv

namespace Litt3.Deformations

open scoped BigOperators

variable {I K : Type*} [Fintype I] [DecidableEq I] [Field K]

theorem normal_polynomial_basis_monomial (n : ℕ) (alpha : I → Fin (n + 1)) :
    (normalPolynomialBasis (I := I) K n alpha).val =
      MvPolynomial.monomial
        (Finsupp.equivFunOnFinite.symm (fun i => (alpha i).val)) (1 : K) := by
  unfold normalPolynomialBasis
  have value := (MvPolynomial.basisRestrictSupport K
    {beta : I →₀ ℕ | ∀ i, beta i ≤ n}).reindex_apply
      (normalPolynomialExponentEquiv n) alpha
  have underlying := congrArg Subtype.val value
  apply underlying.trans
  change ((Finsupp.supportedEquivFinsupp (R := K) (M := K)
    {beta : I →₀ ℕ | ∀ i, beta i ≤ n}).symm
      (Finsupp.single ((normalPolynomialExponentEquiv n).symm alpha) (1 : K))).val = _
  rw [Finsupp.supportedEquivFinsupp_symm_single]
  rfl

theorem normal_polynomial_basis_evaluation (n : ℕ) (alpha : I → Fin (n + 1)) (x : I → K) :
    MvPolynomial.eval x (normalPolynomialBasis (I := I) K n alpha).val =
      ∏ i, x i ^ (alpha i).val := by
  rw [normal_polynomial_basis_monomial, MvPolynomial.eval_monomial, one_mul]
  rw [Finsupp.prod_fintype _ _ (fun i => pow_zero (x i))]
  rfl

end Litt3.Deformations

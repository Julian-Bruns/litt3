import Definitions.Deformations.TruncatedMonomialAlgebra
import Solutions.Deformations.BasisQuotientComplement
import Mathlib.Data.Finsupp.Order

namespace Litt3.Deformations

variable (R I : Type*) [CommRing R]

/-- Actual ideal membership is exactly domination by at least one of
the literal original variable-power exponents. -/
theorem truncated_monomial_ideal_membership (q : I → ℕ) (f : MvPolynomial I R) :
    f ∈ truncatedMonomialIdeal R I q ↔
      ∀ a ∈ f.support, ∃ i, q i ≤ a i := by
  classical
  rw [truncatedMonomialIdeal, MvPolynomial.mem_ideal_span_monomial_image]
  simp only [Set.mem_range, exists_exists_eq_and, Finsupp.single_le_iff]

/-- The full actual relation ideal is precisely the coefficient span
of the removed original monomials, as a coefficient-ring submodule. -/
theorem truncated_monomial_ideal_span (q : I → ℕ) :
    (truncatedMonomialIdeal R I q).restrictScalars R =
      Submodule.span R ((MvPolynomial.basisMonomials I R) '' oversizedMonomialExponents I q) := by
  ext f
  rw [Module.Basis.mem_span_image]
  change (f ∈ truncatedMonomialIdeal R I q) ↔
    ∀ a ∈ f.support, a ∈ oversizedMonomialExponents I q
  exact truncated_monomial_ideal_membership R I q f

/-- The genuine original monomial quotient basis is constructed from
the full original coefficient basis and exact relation ideal. -/
noncomputable def truncatedMonomialBasis (q : I → ℕ) :
    Module.Basis {a : I →₀ ℕ // a ∉ oversizedMonomialExponents I q} R
      (TruncatedMonomialAlgebra R I q) :=
  (basisQuotientComplement (MvPolynomial.basisMonomials I R) (oversizedMonomialExponents I q)).map
    ((Submodule.quotEquivOfEq _ _ (truncated_monomial_ideal_span R I q).symm).trans
      (Submodule.Quotient.restrictScalarsEquiv R (truncatedMonomialIdeal R I q)))

end Litt3.Deformations

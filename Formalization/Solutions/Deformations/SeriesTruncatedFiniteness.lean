import Solutions.Deformations.SeriesTruncatedDimensions
import Mathlib.LinearAlgebra.FreeModule.Finite.Basic

namespace Litt3.Deformations

variable (R : Type*) [CommRing R] (d : ℕ)

/-- The ORIGINAL positive unequal-power formal-series quotient is a
finite coefficient module over ANY commutative ring, by its genuine
quotient equivalence and the constructed finite original tuple basis. -/
theorem series_truncated_finite (q : Fin d → ℕ) (positive : ∀ i, 0 < q i) :
    Module.Finite R (MvPowerSeries (Fin d) R ⧸ seriesVariablePowerIdeal R d q) := by
  classical
  letI : Module.Finite R (TruncatedMonomialAlgebra R (Fin d) q) :=
    Module.Finite.of_basis (truncatedMonomialTupleBasis R (Fin d) q)
  exact Module.Finite.equiv
    (seriesTruncatedPolynomialEquiv R d q positive).symm.toLinearEquiv

/-- EVERY actual further quotient containing the original variable
powers is finite. No restriction on the extra ideal or its coefficients
and no finite-dimensional hypothesis is supplied. -/
theorem series_quotient_finite_of_variable_powers
    (q : Fin d → ℕ) (positive : ∀ i, 0 < q i)
    (I : Ideal (MvPowerSeries (Fin d) R)) (contains : seriesVariablePowerIdeal R d q ≤ I) :
    Module.Finite R (MvPowerSeries (Fin d) R ⧸ I) := by
  letI := series_truncated_finite R d q positive
  let factor := Ideal.Quotient.factorₐ R contains
  apply Module.Finite.of_surjective factor.toLinearMap
  intro b
  obtain ⟨f, rfl⟩ := Ideal.Quotient.mk_surjective b
  exact ⟨Ideal.Quotient.mk (seriesVariablePowerIdeal R d q) f, rfl⟩

/-- Every ORIGINAL truncated hypersurface is finite over its coefficient
ring, regardless of the original full-series equation. In particular the
source's length formulas measure genuinely finite-dimensional quotients. -/
theorem series_truncated_hypersurface_finite
    (q : Fin d → ℕ) (positive : ∀ i, 0 < q i) (f : MvPowerSeries (Fin d) R) :
    Module.Finite R (MvPowerSeries (Fin d) R ⧸
      (seriesVariablePowerIdeal R d q ⊔ Ideal.span ({f} : Set _))) :=
  series_quotient_finite_of_variable_powers R d q positive _ le_sup_left

end Litt3.Deformations

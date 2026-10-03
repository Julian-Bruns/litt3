import Definitions.Deformations.TruncatedMonomialAlgebra
import Mathlib.RingTheory.MvPowerSeries.Trunc

namespace Litt3.Deformations

variable (R I : Type*) [CommRing R] [Fintype I]

/-- The exact surviving original coefficient rectangle. -/
noncomputable def originalTruncationRectangle (q : I → ℕ) : I →₀ ℕ :=
  Finsupp.equivFunOnFinite.symm (fun i => q i - 1)

/-- The literal finite coefficient projection of a genuine multivariate
formal power series to the original unequal-power polynomial quotient. -/
noncomputable def truncatedMonomialSeriesProjectionFun (q : I → ℕ)
    (f : MvPowerSeries I R) : TruncatedMonomialAlgebra R I q := by
  classical
  exact Ideal.Quotient.mk (truncatedMonomialIdeal R I q)
    (MvPowerSeries.trunc' R (originalTruncationRectangle I q) f)

end Litt3.Deformations

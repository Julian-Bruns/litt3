import Definitions.Deformations.ToricHypersurfaceAlgebra
import Definitions.Deformations.SeriesVariablePowerIdeal

namespace Litt3.Deformations

def toricHypersurfacePowers (Q R : ℕ) (i : Fin 3) := if i=2 then R else Q

variable (K : Type*) [CommRing K]

/-- The literal original toric FORMAL-SERIES ideal with all original
variable powers; no abstract completion is substituted. -/
noncomputable def toricHypersurfaceSeriesIdeal (Q R s : ℕ) : Ideal (MvPowerSeries (Fin 3) K) :=
  Ideal.span ({MvPowerSeries.X 0 * MvPowerSeries.X 1 - MvPowerSeries.X 2 ^ s,
    MvPowerSeries.X 0 ^ Q, MvPowerSeries.X 1 ^ Q, MvPowerSeries.X 2 ^ R} : Set _)

abbrev ToricHypersurfaceSeriesAlgebra (Q R s : ℕ) :=
  MvPowerSeries (Fin 3) K ⧸ toricHypersurfaceSeriesIdeal K Q R s

end Litt3.Deformations

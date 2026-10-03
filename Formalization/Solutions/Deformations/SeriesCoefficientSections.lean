import Solutions.Deformations.SeriesLastMonomial
import Solutions.Deformations.FormalCyclicCoefficientReduction

namespace Litt3.Deformations

variable {R K L : Type*} [CommRing R] [AddCommGroup K] [Module R K]
    [AddCommGroup L] [Module R L]

theorem coefficient_series_lift_section (f : K →ₗ[R] L) (h : ℕ) (v : Fin h → K) :
    coefficientSeriesLift f (coefficientSeriesPrefixSection (R := R) h v) =
      coefficientSeriesPrefixSection (R := R) h (finiteCoefficientMap h f v) := by
  funext m
  change f (if low : m < h then v ⟨m, low⟩ else 0) =
    if low : m < h then f (v ⟨m, low⟩) else 0
  by_cases low : m < h <;> simp [low]

theorem scalar_coefficient_reduction_section (r : R) (h : ℕ) (v : Fin h → K) :
    scalarCoefficientReduction r (coefficientSeriesPrefixSection (R := R) h v) =
      coefficientSeriesPrefixSection (R := R) h
        (finiteCoefficientMap h (coefficientScalarRange (K := K) r).mkQ v) :=
  coefficient_series_lift_section _ h v

theorem formal_cyclic_finite_representative_reduction (p a : ℕ) [Fact p.Prime]
    (vanish : (p : R) ^ (a + 1) = 0) (y : FormalCyclicModule (R := R) (K := K) p a) :
    scalarCoefficientReduction (p : R)
      (coefficientSeriesPrefixSection (R := R) (p ^ a)
        (formalCyclicCoordinates (K := K) p a vanish y)) =
      coefficientSeriesPrefixSection (R := R) (p ^ a)
        (formalCyclicCoefficientReduction (K := K) p a vanish y) :=
  scalar_coefficient_reduction_section _ _ _

end Litt3.Deformations

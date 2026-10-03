import Definitions.Deformations.FiniteCoefficientReduction
import Solutions.Deformations.FormalCyclicGeneration
import Solutions.Deformations.SeriesCoefficientReduction
import Solutions.Deformations.PolynomialCyclicCompletion

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- Actual original coefficients modulo p, through the constructed
full cyclic coordinates. Its literal representative formula is proved. -/
noncomputable def formalCyclicCoefficientReduction (p a : ℕ) [Fact p.Prime]
    (vanish : (p : R) ^ (a + 1) = 0) :
    FormalCyclicModule (R := R) (K := K) p a →ₗ[R]
      (Fin (p ^ a) → K ⧸ coefficientScalarRange (K := K) (p : R)) :=
  (finiteCoefficientMap (p ^ a) (coefficientScalarRange (K := K) (p : R)).mkQ).comp
    (formalCyclicCoordinates (R := R) (K := K) p a vanish).toLinearMap

theorem formal_cyclic_coefficient_reduction_mk (p a : ℕ) [Fact p.Prime]
    (vanish : (p : R) ^ (a + 1) = 0) (v : CoefficientSeries (K := K)) (j : Fin (p ^ a)) :
    formalCyclicCoefficientReduction (K := K) p a vanish
      ((LinearMap.range (formalCyclicRelation (R := R) (K := K) p a)).mkQ v) j =
      (coefficientScalarRange (K := K) (p : R)).mkQ (v j.val) := by
  change (coefficientScalarRange (K := K) (p : R)).mkQ
    (preparedSeriesRemainder (p ^ a) (p : R) ⟨a + 1, vanish⟩
      (formalCyclicCorrection (R := R) (K := K) p a) v j) = _
  exact prepared_series_remainder_scalar_reduction _ _ _ _ v j

/-- Literal original polynomial coefficients modulo p. -/
noncomputable def polynomialCyclicCoefficientReduction (p a : ℕ) [Fact p.Prime]
    (vanish : (p : R) ^ (a + 1) = 0) :
    PolynomialCyclicModule (R := R) (K := K) p a →ₗ[R]
      (Fin (p ^ a) → K ⧸ coefficientScalarRange (K := K) (p : R)) :=
  (formalCyclicCoefficientReduction (K := K) p a vanish).comp
    (polynomialCyclicCompletionEquiv (K := K) p a vanish).toLinearMap

theorem polynomial_cyclic_coefficient_reduction_mk (p a : ℕ) [Fact p.Prime]
    (vanish : (p : R) ^ (a + 1) = 0) (u : PolynomialModule R K) (j : Fin (p ^ a)) :
    polynomialCyclicCoefficientReduction (K := K) p a vanish
      ((LinearMap.range (polynomialCyclicOperator (R := R) (K := K) p a)).mkQ u) j =
      (coefficientScalarRange (K := K) (p : R)).mkQ (u j.val) := by
  change formalCyclicCoefficientReduction (K := K) p a vanish
    (polynomialCyclicCompletionEquiv (K := K) p a vanish
      ((LinearMap.range (polynomialCyclicOperator (R := R) (K := K) p a)).mkQ u)) j = _
  rw [polynomial_cyclic_completion_equiv_mk, formal_cyclic_coefficient_reduction_mk]
  rfl

end Litt3.Deformations

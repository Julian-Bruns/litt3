import Definitions.Deformations.CyclicPowerNormInput
import Definitions.Deformations.ScalarPowerDiagonalization
import Definitions.Deformations.PreparedCyclicLogNorm
import Definitions.Deformations.FiniteCoefficientReduction

namespace Litt3.Deformations

variable {p a n : ℕ} [Fact p.Prime] {K : Type*}
    [AddCommGroup K] [Module (CyclicPowerBase p a) K]

/-- Exact whole abstract source scope of the cyclic-power mixed-additive
norm theorem: original norm solvability and full primitive image,
original cokernel with its norm class, constructed finite Smith form,
and literal original terminal carry. The original operators occur in
every clause. Geometric comparisons and repairs are separate inputs. -/
structure CyclicPowerNormResult (input : CyclicPowerNormInput p a n K) : Prop where
  solvability : ∀ eta : K,
    (∃ y, input.L y = cyclicPowerNormTarget p a eta) ↔
      eta ∈ coefficientScalarRange (K := K) (p : CyclicPowerBase p a)
  primitiveImage : ∀ (eta : K)
      (v : Fin (p ^ a) → K ⧸ coefficientScalarRange (K := K) (p : CyclicPowerBase p a)),
    (∃ y, input.L y = cyclicPowerNormTarget p a eta ∧ cyclicPowerReduction p a y = v) ↔
      eta ∈ coefficientScalarRange (K := K) (p : CyclicPowerBase p a) ∧
        ∃ theta, v = finiteSocleCoefficient (R := CyclicPowerBase p a) (p ^ a) theta
  cokernel : ∃ f :
      (PolynomialCyclicModule (R := CyclicPowerBase p a) (K := K) p a ⧸
        LinearMap.range input.comparison) ≃ₗ[CyclicPowerBase p a]
      (K × (Fin n → K ⧸ coefficientScalarRange (K := K) ((p : CyclicPowerBase p a) ^ a))),
    ∀ eta : K, f ((LinearMap.range input.comparison).mkQ (cyclicPowerNormTarget p a eta)) =
      ((p : CyclicPowerBase p a) ^ a • eta, 0)
  smith : ∀ (f : ℕ) (basis : K ≃ₗ[CyclicPowerBase p a] (Fin f → CyclicPowerBase p a)),
    ∃ normal : ScalarPowerDiagonalization (p : CyclicPowerBase p a) (p ^ a * f) (a + 1) input.comparison,
      (∀ i, normal.exponent i = 0 ∨ normal.exponent i = a ∨ normal.exponent i = a + 1) ∧
      (Finset.univ.filter (fun i : Fin (p ^ a * f) => normal.exponent i = 0)).card = f * (p ^ a - (n + 1)) ∧
      (Finset.univ.filter (fun i : Fin (p ^ a * f) => normal.exponent i = a)).card = f * n ∧
      (Finset.univ.filter (fun i : Fin (p ^ a * f) => normal.exponent i = a + 1)).card = f
  carry : ∀ (eta : K)
      (C : K ⧸ coefficientScalarRange (K := K) (p : CyclicPowerBase p a))
      (D : Fin (n + 1) → K ⧸ coefficientScalarRange (K := K) (p : CyclicPowerBase p a))
      (y r : PolynomialCyclicModule (R := CyclicPowerBase p a) (K := K) p a),
    input.comparison y - cyclicPowerNormTarget p a eta = (p : CyclicPowerBase p a) ^ a • r →
    (coefficientScalarRange (K := K) (p : CyclicPowerBase p a)).mkQ eta = C →
    coefficientSeriesPrefixSection (R := CyclicPowerBase p a) (p ^ a) (cyclicPowerReduction p a y) =
      coefficientSeriesShift (R := CyclicPowerBase p a) (p ^ a - (n + 1) - 1)
        (coefficientSeriesConstant (R := CyclicPowerBase p a) C) +
      coefficientSeriesShift (R := CyclicPowerBase p a) (p ^ a - (n + 1))
        (coefficientSeriesPrefixSection (R := CyclicPowerBase p a) (n + 1) D) →
    coefficientSeriesPrefix (R := CyclicPowerBase p a) (n + 1)
      (coefficientSeriesPrefixSection (R := CyclicPowerBase p a) (p ^ a) (cyclicPowerReduction p a r)) =
      -truncatedLogValue (R := CyclicPowerBase p a) (n + 1)
        (finiteCoefficientShift (R := CyclicPowerBase p a) (n + 1))
        ((Fin.cons C 0 : Fin (n + 1) → K ⧸ coefficientScalarRange (K := K) (p : CyclicPowerBase p a)) +
          finiteCoefficientShift (R := CyclicPowerBase p a) (n + 1) D)

end Litt3.Deformations

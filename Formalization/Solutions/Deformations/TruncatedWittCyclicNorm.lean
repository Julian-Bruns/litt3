import Definitions.Deformations.TruncatedWittCyclicNorm
import Solutions.Deformations.TruncatedWittBasis
import Solutions.Deformations.CyclicPowerNormFive

namespace Litt3.Deformations

/-- The whole original cyclic-power norm theorem on actual truncated
perfect-field Witt vectors. Freeness and Frobenius are constructed,
including arbitrary residue-field rank and merely additive operators. -/
theorem truncated_witt_cyclic_power_norm (p a n : ℕ) [Fact p.Prime]
    (k : Type*) [Field k] [CharP k p] [PerfectRing k p]
    (aPositive : 0 < a) (characteristic : 2 * (n + 1) < p)
    (operator : TruncatedWittCyclicNormOperator p a n k) :
    CyclicPowerNormResult (operator.toInput p a n k) := by
  letI : Module.Free (CyclicPowerBase p a) (WittCyclicCoefficients p a k) :=
    truncated_witt_free p (a + 1) (by omega) k
  exact cyclic_power_norm p a n (WittCyclicCoefficients p a k)
    aPositive characteristic (operator.toInput p a n k)

end Litt3.Deformations

import Definitions.Jacobians.ValuationDivisors

namespace Litt3.Jacobians.Targets

/-- The divisor-class formulation of single-point torsion, with an actual
nonzero function and a valuation-built principal divisor. No Jacobian
identification or Riemann--Roch basis is presumed. -/
def SinglePointDivisorClassTorsion : Prop :=
  ∀ (K Points : Type) [Field K] (system : ValuationDivisorSystem K Points)
    (point basepoint : Points) (N : ℕ),
    N • divisorClassMap system (pointDivisor point - pointDivisor basepoint) = 0 ↔
    ∃ f : Additive Kˣ, principalDivisorMap system f =
      N • (pointDivisor point - pointDivisor basepoint)

end Litt3.Jacobians.Targets

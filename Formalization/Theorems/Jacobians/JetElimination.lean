import Definitions.Jacobians.JetElimination

namespace Litt3.Jacobians.Targets

/-- Exact kernel elimination used by the polynomial Hasse-jet test.
Identifying the jet map with sections of the actual curve is separate. -/
def BlockJetKernelCriterion : Prop :=
  ∀ (K P Q R : Type) [Ring K]
    [AddCommGroup P] [AddCommGroup Q] [AddCommGroup R]
    [Module K P] [Module K Q] [Module K R]
    (T : Q →ₗ[K] P) (B : Q →ₗ[K] R),
    (∃ v : P × Q, v ≠ 0 ∧ blockJetMap T B v = 0) ↔
    ∃ q : Q, q ≠ 0 ∧ B q = 0

end Litt3.Jacobians.Targets

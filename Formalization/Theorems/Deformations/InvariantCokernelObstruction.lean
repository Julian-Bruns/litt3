import Definitions.Deformations.InvariantCokernelObstruction

namespace Litt3.Deformations.Specifications

universe u

variable {k G L U DL DU : Type u} [Field k] [Group G]
    [AddCommGroup L] [Module k L] [AddCommGroup U] [Module k U]
    [AddCommGroup DL] [Module k DL] [AddCommGroup DU] [Module k DU]

/-- The genuine cohomology/cokernel obstruction comparison, including
its value on every actual cocycle primitive. The two upper and lower
spaces may retain distinct scalar transports. -/
def InvariantCokernelComparison
    (square : InvariantDescentSquare k G L U DL DU) : Prop :=
  ∃ e : groupCohomology (Rep.of square.kernelAction) 1 ≃ₗ[k]
      LinearMap.ker square.cokernelPullback,
    ∀ b : square.invariantPreimage,
      (e (square.cohomologyConnectingMap b)).1 = square.cokernelRepresentativeMap b

end Litt3.Deformations.Specifications

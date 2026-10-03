import Theorems.Deformations.InvariantCokernelObstruction
import Mathlib.LinearAlgebra.FiniteDimensional.Lemmas

namespace Litt3.Deformations.Specifications

universe u

variable {k G L U DL DU : Type u} [Field k] [Group G]
    [AddCommGroup L] [Module k L] [AddCommGroup U] [Module k U]
    [AddCommGroup DL] [Module k DL] [AddCommGroup DU] [Module k DU]

/-- Actual pullback rank counts the downstairs kernel dimension
left outside the full genuine cohomological obstruction kernel. -/
def InvariantCokernelRank (square : InvariantDescentSquare k G L U DL DU) : Prop :=
  Module.finrank k (LinearMap.range square.cokernelPullback) +
    Module.finrank k (groupCohomology (Rep.of square.kernelAction) 1) =
      Module.finrank k (LinearMap.ker square.lowerMap)

end Litt3.Deformations.Specifications

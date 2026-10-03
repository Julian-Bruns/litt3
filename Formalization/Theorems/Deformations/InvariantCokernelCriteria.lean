import Theorems.Deformations.InvariantCokernelObstruction
import Definitions.Deformations.InvariantKernelPullback

namespace Litt3.Deformations.Specifications

open scoped MonoidAlgebra

universe u

variable {k G L U DL DU : Type u} [Field k] [Group G]
    [AddCommGroup L] [Module k L] [AddCommGroup U] [Module k U]
    [AddCommGroup DL] [Module k DL] [AddCommGroup DU] [Module k DU]

/-- Actual kernel growth and actual obstruction vanishing for the
specified invariant-descent square. This leaves geometric construction
of that square separate from its full coefficient-module conclusions. -/
def InvariantCokernelCriteria
    (square : InvariantDescentSquare k G L U DL DU) : Prop :=
  let δL := Module.finrank k (LinearMap.ker square.upperMap)
  let δD := Module.finrank k (LinearMap.ker square.lowerMap)
  δD ≤ δL ∧ δL ≤ Nat.card G * δD ∧
    (δL = Nat.card G * δD ↔ Module.Free k[G] square.kernelAction.asModule) ∧
    (Module.Free k[G] square.kernelAction.asModule ↔
      ∀ x : groupCohomology (Rep.of square.kernelAction) 1, x = 0) ∧
    ((∀ x : groupCohomology (Rep.of square.kernelAction) 1, x = 0) ↔
      Function.Injective square.cokernelPullback)

end Litt3.Deformations.Specifications

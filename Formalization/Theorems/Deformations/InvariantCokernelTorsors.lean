import Theorems.Deformations.InvariantCokernelObstruction
import Definitions.Deformations.RepresentationAffineTorsors

namespace Litt3.Deformations.Specifications

universe u

variable {k G L U DL DU A : Type u} [Field k] [Group G]
    [AddCommGroup L] [Module k L] [AddCommGroup U] [Module k U]
    [AddCommGroup DL] [Module k DL] [AddCommGroup DU] [Module k DU]
    (square : InvariantDescentSquare k G L U DL DU)
    [AddTorsor (LinearMap.ker square.upperMap) A] [MulAction G A]

/-- The actual affine-kernel torsor has one well-defined obstruction
in the actual cokernel pullback kernel. Its zero means existence of
a fixed point, and every actual ambient primitive gives its stated
cokernel representative. -/
def InvariantCokernelTorsorCriterion : Prop :=
  ∃ obstruction : A → LinearMap.ker square.cokernelPullback,
    (∀ a b, obstruction a = obstruction b) ∧
    (∀ a, obstruction a = 0 ↔ ∃ b : A, ∀ g : G, g • b = b) ∧
    (∀ (a : A) (b : square.invariantPreimage),
      (∀ g : G, square.differenceCocycle b g = g • a -ᵥ a) →
        (obstruction a).1 = square.cokernelRepresentativeMap b)

end Litt3.Deformations.Specifications

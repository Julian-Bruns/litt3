import Definitions.Deformations.KernelTransport

namespace Litt3.Deformations.Specifications

variable {R V W Z Z' : Type*} [Ring R]
variable [AddCommGroup V] [Module R V] [AddCommGroup W] [Module R W]
variable [AddCommGroup Z] [Module R Z] [AddCommGroup Z'] [Module R Z']

def TransportedKernelEquivalent (T : V →ₗ[R] Z) (domain : W ≃ₗ[R] V)
    (codomain : Z ≃ₗ[R] Z') : Prop :=
  Nonempty (LinearMap.ker (transportedLinearMap T domain codomain) ≃ₗ[R] LinearMap.ker T)

end Litt3.Deformations.Specifications

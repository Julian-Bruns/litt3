import Theorems.Deformations.KernelTransport

namespace Litt3.Deformations

variable {R V W Z Z' : Type*} [Ring R]
variable [AddCommGroup V] [Module R V] [AddCommGroup W] [Module R W]
variable [AddCommGroup Z] [Module R Z] [AddCommGroup Z'] [Module R Z']

/-- Actual kernel equivalence with the full scalar action
retained, for arbitrary rings and arbitrary modules. -/
def transportedKernelEquiv (T : V →ₗ[R] Z) (domain : W ≃ₗ[R] V)
    (codomain : Z ≃ₗ[R] Z') :
    LinearMap.ker (transportedLinearMap T domain codomain) ≃ₗ[R] LinearMap.ker T where
  toFun x := ⟨domain x.val, by
    apply codomain.injective
    have h := x.property
    change codomain (T (domain x.val)) = 0 at h
    simpa only [map_zero] using h⟩
  invFun y := ⟨domain.symm y.val, by
    change codomain (T (domain (domain.symm y.val))) = 0
    rw [LinearEquiv.apply_symm_apply, LinearMap.mem_ker.mp y.property, map_zero]⟩
  left_inv x := by
    apply Subtype.ext
    exact domain.symm_apply_apply x.val
  right_inv y := by
    apply Subtype.ext
    exact domain.apply_symm_apply y.val
  map_add' x y := by
    apply Subtype.ext
    exact domain.map_add x.val y.val
  map_smul' c x := by
    apply Subtype.ext
    exact domain.map_smul c x.val

theorem transported_kernel_equivalent (T : V →ₗ[R] Z) (domain : W ≃ₗ[R] V)
    (codomain : Z ≃ₗ[R] Z') : Specifications.TransportedKernelEquivalent T domain codomain :=
  ⟨transportedKernelEquiv T domain codomain⟩

end Litt3.Deformations

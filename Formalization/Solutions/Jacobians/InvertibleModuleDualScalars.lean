import Solutions.Jacobians.InvertibleModuleFractionalIdeals

open scoped nonZeroDivisors TensorProduct

namespace Litt3.Jacobians

variable (R K : Type*) [CommRing R] [IsDomain R] [Field K]
  [Algebra R K] [IsFractionRing R K]
variable (M : Type*) [AddCommGroup M] [Module R M] [Module.Invertible R M]

/-- A genuine rank-one frame after passage to the true fraction field. -/
noncomputable def invertibleModuleGenericFrame : (K ⊗[R] M) ≃ₗ[K] K :=
  (Module.Invertible.free_iff_linearEquiv.mp
    (inferInstance : Module.Free K (K ⊗[R] M))).some

theorem invertibleModuleGenericFrame_emb (m : M) :
    invertibleModuleGenericFrame R K M (1 ⊗ₜ[R] m) =
      Module.Invertible.embAlgebra R M K m := by
  simp [invertibleModuleGenericFrame, Module.Invertible.embAlgebra]

/-- Extension of an ORIGINAL ring-valued functional to the genuine generic fiber. -/
noncomputable def invertibleModuleGenericFunctional (g : Module.Dual R M) :
    (K ⊗[R] M) →ₗ[K] K :=
  (TensorProduct.AlgebraTensorModule.rid R K K).toLinearMap.comp (g.baseChange K)

theorem invertibleModuleGenericFunctional_tmul (g : Module.Dual R M) (m : M) :
    invertibleModuleGenericFunctional R K M g (1 ⊗ₜ[R] m) =
      algebraMap R K (g m) := by
  simp [invertibleModuleGenericFunctional, Algebra.smul_def]

noncomputable def invertibleModuleDualScalar (g : Module.Dual R M) : K :=
  invertibleModuleGenericFunctional R K M g
    ((invertibleModuleGenericFrame R K M).symm 1)

/-- Every original dual functional is actual multiplication by a fraction-field scalar.
The scalar is derived from the actual generic frame. -/
theorem invertibleModuleDualScalar_mul_emb (g : Module.Dual R M) (m : M) :
    invertibleModuleDualScalar R K M g * Module.Invertible.embAlgebra R M K m =
      algebraMap R K (g m) := by
  let e := invertibleModuleGenericFrame R K M
  have htmul : (1 : K) ⊗ₜ[R] m =
      Module.Invertible.embAlgebra R M K m • e.symm 1 := by
    apply e.injective
    rw [map_smul, e.apply_symm_apply, smul_eq_mul, mul_one]
    exact invertibleModuleGenericFrame_emb R K M m
  calc
    _ = Module.Invertible.embAlgebra R M K m •
        invertibleModuleDualScalar R K M g := by rw [smul_eq_mul, mul_comm]
    _ = invertibleModuleGenericFunctional R K M g
        (Module.Invertible.embAlgebra R M K m • e.symm 1) := by rw [map_smul]; rfl
    _ = invertibleModuleGenericFunctional R K M g (1 ⊗ₜ[R] m) := by rw [← htmul]
    _ = algebraMap R K (g m) := invertibleModuleGenericFunctional_tmul R K M g m

end Litt3.Jacobians

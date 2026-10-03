import Solutions.Jacobians.InvertibleModuleDualScalars

open scoped nonZeroDivisors TensorProduct

namespace Litt3.Jacobians

variable (R K : Type*) [CommRing R] [IsDomain R] [Field K]
  [Algebra R K] [IsFractionRing R K]
variable (M : Type*) [AddCommGroup M] [Module R M] [Module.Invertible R M]

theorem invertibleModuleDualScalar_mem_inverse (g : Module.Dual R M) :
    invertibleModuleDualScalar R K M g ∈ (invertibleModuleFractionalIdeal R K M)⁻¹ := by
  apply (FractionalIdeal.mem_inv_iff (invertibleModuleFractionalIdeal_ne_zero R K M)).mpr
  intro x hx
  obtain ⟨m, rfl⟩ := hx
  rw [invertibleModuleDualScalar_mul_emb]
  exact FractionalIdeal.coe_mem_one R⁰ (g m)

theorem invertibleModule_contraction_mem_product (u : Module.Dual R M ⊗[R] M) :
    algebraMap R K (contractLeft R M u) ∈
      invertibleModuleFractionalIdeal R K M * (invertibleModuleFractionalIdeal R K M)⁻¹ := by
  induction u using TensorProduct.induction_on with
  | zero =>
    rw [map_zero, map_zero]
    exact (invertibleModuleFractionalIdeal R K M *
      (invertibleModuleFractionalIdeal R K M)⁻¹).val.zero_mem
  | tmul g m =>
    rw [contractLeft_apply, ← invertibleModuleDualScalar_mul_emb R K M g m,
      mul_comm (invertibleModuleDualScalar R K M g) (Module.Invertible.embAlgebra R M K m)]
    exact FractionalIdeal.mul_mem_mul (show Module.Invertible.embAlgebra R M K m ∈
      invertibleModuleFractionalIdeal R K M from ⟨m, rfl⟩)
      (invertibleModuleDualScalar_mem_inverse R K M g)
  | add u v hu hv =>
    rw [map_add, map_add]
    exact (invertibleModuleFractionalIdeal R K M *
      (invertibleModuleFractionalIdeal R K M)⁻¹).val.add_mem hu hv

/-- The canonical ORIGINAL dual contraction derives the true fractional-ideal inverse.
No Dedekind, normality or Noetherian hypothesis is required. -/
theorem invertibleModuleFractionalIdeal_mul_inverse :
    invertibleModuleFractionalIdeal R K M * (invertibleModuleFractionalIdeal R K M)⁻¹ = 1 := by
  apply le_antisymm
  · apply FractionalIdeal.mul_le.mpr
    intro x hx y hy
    rw [mul_comm]
    exact (FractionalIdeal.mem_inv_iff (invertibleModuleFractionalIdeal_ne_zero R K M)).mp
      hy x hx
  · apply FractionalIdeal.one_le.mpr
    obtain ⟨u, hu⟩ := (Module.Invertible.bijective (R := R) (M := M)).surjective 1
    simpa only [hu, map_one] using invertibleModule_contraction_mem_product R K M u

noncomputable def actualInvertibleModuleFractionalIdealUnit : (FractionalIdeal R⁰ K)ˣ :=
  Units.mkOfMulEqOne (invertibleModuleFractionalIdeal R K M)
    (invertibleModuleFractionalIdeal R K M)⁻¹
    (invertibleModuleFractionalIdeal_mul_inverse R K M)

theorem actualInvertibleModuleFractionalIdealUnit_picard :
    fractionalIdealPicardClass (actualInvertibleModuleFractionalIdealUnit R K M) =
      CommRing.Pic.mk R M := by
  letI := actual_invertible_fractional_ideal_module
    (actualInvertibleModuleFractionalIdealUnit R K M)
  apply CommRing.Pic.mk_eq_mk_iff.mpr
  exact ⟨(invertibleModuleFractionalIdealEquiv R K M).symm⟩

end Litt3.Jacobians

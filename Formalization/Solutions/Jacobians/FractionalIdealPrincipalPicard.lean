import Solutions.Jacobians.FractionalIdealPicardClasses

open scoped nonZeroDivisors TensorProduct

namespace Litt3.Jacobians

variable {R K : Type*} [CommRing R] [IsDomain R] [Field K]
  [Algebra R K] [IsFractionRing R K]

noncomputable def fractionalIdealPrincipalModuleMap (x : K) :
    R →ₗ[R] (FractionalIdeal.spanSingleton R⁰ x : Submodule R K) :=
  ((LinearMap.mulRight R x).comp (Algebra.linearMap R K)).codRestrict _
    (fun r => (FractionalIdeal.mem_spanSingleton R⁰).mpr ⟨r, by rw [Algebra.smul_def]; rfl⟩)

theorem fractionalIdealPrincipalModuleMap_bijective (x : K) (hx : x ≠ 0) :
    Function.Bijective (fractionalIdealPrincipalModuleMap (R := R) x) := by
  constructor
  · intro a b h
    apply IsFractionRing.injective R K
    apply mul_right_cancel₀ hx
    exact congrArg Subtype.val h
  · intro y
    obtain ⟨r, hr⟩ := (FractionalIdeal.mem_spanSingleton R⁰).mp y.property
    refine ⟨r, Subtype.ext ?_⟩
    simpa only [Algebra.smul_def] using hr

noncomputable def fractionalIdealPrincipalModuleEquiv (x : K) (hx : x ≠ 0) :
    R ≃ₗ[R] (FractionalIdeal.spanSingleton R⁰ x : Submodule R K) :=
  LinearEquiv.ofBijective (fractionalIdealPrincipalModuleMap x)
    (fractionalIdealPrincipalModuleMap_bijective x hx)

/-- A true linear equivalence of the ACTUAL fractional-ideal module
with the original ring gives a genuine principal fractional ideal. -/
theorem fractionalIdeal_principal_of_module_equiv
    (I : FractionalIdeal R⁰ K) (e : (I : Submodule R K) ≃ₗ[R] R) :
    ∃ x : K, I = FractionalIdeal.spanSingleton R⁰ x := by
  let g : (I : Submodule R K) := e.symm 1
  have hxgen (x : (I : Submodule R K)) : x = e x • g := by
    apply e.injective
    simp [g]
  refine ⟨g.val, ?_⟩
  ext x
  constructor
  · intro hx
    let xi : (I : Submodule R K) := ⟨x, hx⟩
    apply (FractionalIdeal.mem_spanSingleton R⁰).mpr
    refine ⟨e xi, ?_⟩
    simpa only [Submodule.coe_smul] using (congrArg Subtype.val (hxgen xi)).symm
  · intro hx
    obtain ⟨r, hr⟩ := (FractionalIdeal.mem_spanSingleton R⁰).mp hx
    rw [← hr]
    exact (I : Submodule R K).smul_mem r g.property

theorem fractionalIdealPicardClass_principal (x : Kˣ) :
    fractionalIdealPicardClass (toPrincipalIdeal R K x) = 1 := by
  letI := actual_invertible_fractional_ideal_module (toPrincipalIdeal R K x)
  apply CommRing.Pic.mk_eq_one_iff.mpr
  change Nonempty (((toPrincipalIdeal R K x).val : Submodule R K) ≃ₗ[R] R)
  rw [coe_toPrincipalIdeal]
  exact
    (show Nonempty ((FractionalIdeal.spanSingleton R⁰ x.val : Submodule R K) ≃ₗ[R] R) from
      ⟨(fractionalIdealPrincipalModuleEquiv x.val x.ne_zero).symm⟩)

/-- Exact principal kernel in Mathlib's genuine ring Picard group:
no original divisor class or Picard vanishing is an assumption. -/
theorem fractionalIdealPicardClass_eq_one_iff
    (I : (FractionalIdeal R⁰ K)ˣ) :
    fractionalIdealPicardClass I = 1 ↔ I ∈ (toPrincipalIdeal R K).range := by
  constructor
  · intro h
    letI := actual_invertible_fractional_ideal_module I
    obtain ⟨e⟩ := CommRing.Pic.mk_eq_one_iff.mp h
    obtain ⟨x, hx⟩ := fractionalIdeal_principal_of_module_equiv I.val e
    apply mem_principal_ideals_iff.mpr
    exact ⟨x, hx.symm⟩
  · rintro ⟨x, rfl⟩
    exact fractionalIdealPicardClass_principal x

theorem fractionalIdealPicardHom_ker :
    (fractionalIdealPicardHom (R := R) (K := K)).ker = (toPrincipalIdeal R K).range := by
  ext I
  exact fractionalIdealPicardClass_eq_one_iff I

end Litt3.Jacobians

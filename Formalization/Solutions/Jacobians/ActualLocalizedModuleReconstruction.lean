import Solutions.Jacobians.ActualTildeGlobalLinear

open CategoryTheory Opposite TopologicalSpace AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {R : Type u} [CommRing R] (M : ModuleCat.{u} R)

noncomputable def actualLocalizedModuleFunctional (x : PrimeSpectrum R) (g : M →ₗ[R] R) :
    LocalizedModule x.asIdeal.primeCompl M →ₗ[Localization.AtPrime x.asIdeal]
      Localization.AtPrime x.asIdeal :=
  (actualLocalizedRingModuleEquiv R x).toLinearMap.comp
    (LocalizedModule.map x.asIdeal.primeCompl g)

theorem actualLocalizedModuleFunctional_original
    (x : PrimeSpectrum R) (g : M →ₗ[R] R) (m : M) :
    actualLocalizedModuleFunctional M x g
      (LocalizedModule.mkLinearMap x.asIdeal.primeCompl M m) =
        algebraMap R (Localization.AtPrime x.asIdeal) (g m) := by
  change actualLocalizedRingModuleEquiv R x
    (LocalizedModule.map x.asIdeal.primeCompl g (LocalizedModule.mk m 1)) = _
  rw [LocalizedModule.map_mk]
  exact actualLocalizedRingModuleEquiv_original R x (g m)

/-- A genuine finite ORIGINAL module reconstruction holds on EVERY full localization.
This uses the universal localization property, with no finite-support hypothesis on elements. -/
theorem actual_localized_module_reconstruction
    {ι : Type*} [Fintype ι] (m : ι → M) (g : ι → M →ₗ[R] R)
    (h : ∀ a : M, ∑ i, g i a • m i = a) (x : PrimeSpectrum R)
    (u : LocalizedModule x.asIdeal.primeCompl M) :
    ∑ i, actualLocalizedModuleFunctional M x (g i) u •
      LocalizedModule.mkLinearMap x.asIdeal.primeCompl M (m i) = u := by
  let H : LocalizedModule x.asIdeal.primeCompl M →ₗ[Localization.AtPrime x.asIdeal]
      LocalizedModule x.asIdeal.primeCompl M :=
    ∑ i, (LinearMap.toSpanSingleton (Localization.AtPrime x.asIdeal)
      (LocalizedModule x.asIdeal.primeCompl M)
        (LocalizedModule.mkLinearMap x.asIdeal.primeCompl M (m i))).comp
          (actualLocalizedModuleFunctional M x (g i))
  have hH : H.restrictScalars R = LinearMap.id := by
    apply IsLocalizedModule.linearMap_ext x.asIdeal.primeCompl
      (LocalizedModule.mkLinearMap x.asIdeal.primeCompl M)
      (LocalizedModule.mkLinearMap x.asIdeal.primeCompl M)
    apply LinearMap.ext
    intro a
    simp only [LinearMap.comp_apply, LinearMap.restrictScalars_apply, H,
      LinearMap.sum_apply, LinearMap.toSpanSingleton_apply, actualLocalizedModuleFunctional_original,
      LinearMap.id_apply, algebraMap_smul]
    simp_rw [← (LocalizedModule.mkLinearMap x.asIdeal.primeCompl M).map_smul]
    rw [← map_sum, h]
  simpa only [LinearMap.restrictScalars_apply, H, LinearMap.sum_apply,
    LinearMap.comp_apply, LinearMap.toSpanSingleton_apply, LinearMap.id_apply] using
      LinearMap.congr_fun hH u

end Litt3.Jacobians

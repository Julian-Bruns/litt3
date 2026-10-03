import Solutions.Jacobians.ActualLocalizedModuleReconstruction
import Mathlib.RingTheory.Finiteness.Projective

open CategoryTheory Opposite TopologicalSpace AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {R : Type u} [CommRing R] (M : ModuleCat.{u} R)

/-- Original finite reconstruction DERIVES global-section recovery for the actual sheaf. -/
theorem actualTildeGlobalSections_surjective_of_reconstruction
    {ι : Type*} [Fintype ι] (m : ι → M) (g : ι → M →ₗ[R] R)
    (h : ∀ a : M, ∑ i, g i a • m i = a) :
    Function.Surjective (actualTildeOriginalGlobalSection M) := by
  intro s
  let t (i : ι) : (ModuleCat.of R R).tildeInModuleCat.obj (op ⊤) :=
    (actualTildeMap (ModuleCat.ofHom (g i))).val.app (op ⊤) s
  choose r hr using fun i => actualTildeRingGlobalSections_surjective (t i)
  refine ⟨∑ i, r i • m i, ?_⟩
  apply Subtype.ext
  funext x
  have hg (i : ι) : actualLocalizedModuleFunctional M x.1 (g i) (s.val x) =
      algebraMap R (Localization.AtPrime x.1.asIdeal) (r i) := by
    have hh := congrArg (fun a => actualLocalizedRingModuleEquiv R x.1 (a.val x)) (hr i)
    change actualLocalizedRingModuleEquiv R x.1
      (LocalizedModule.mkLinearMap x.1.asIdeal.primeCompl R (r i)) =
        actualLocalizedModuleFunctional M x.1 (g i) (s.val x) at hh
    rw [actualLocalizedRingModuleEquiv_original] at hh
    exact hh.symm
  change LocalizedModule.mkLinearMap x.1.asIdeal.primeCompl M (∑ i, r i • m i) = s.val x
  rw [map_sum]
  simp_rw [map_smul]
  have hrecon := actual_localized_module_reconstruction M m g h x.1 (s.val x)
  simpa only [hg, algebraMap_smul] using hrecon

/-- EVERY actual finite projective module is recovered from the original global
sections of its actual associated O_Spec-module SHEAF, via a derived finite-free splitting. -/
theorem actualTildeGlobalSections_surjective_of_finite_projective
    [Module.Finite R M] [Module.Projective R M] :
    Function.Surjective (actualTildeOriginalGlobalSection M) := by
  classical
  obtain ⟨n, f, g, _hf, _hg, hfg⟩ := Module.Finite.exists_comp_eq_id_of_projective R M
  let m (i : Fin n) := f (Pi.single i (1 : R))
  let G (i : Fin n) : M →ₗ[R] R := (LinearMap.proj i).comp g
  apply actualTildeGlobalSections_surjective_of_reconstruction M m G
  intro a
  have hv : ∑ i : Fin n, g a i • (Pi.single i (1 : R) : Fin n → R) = g a := by
    ext j
    simp [Pi.single_apply]
  change ∑ i : Fin n, g a i • f (Pi.single i (1 : R)) = a
  simp_rw [← f.map_smul]
  rw [← map_sum, hv]
  exact LinearMap.congr_fun hfg a

noncomputable def actualTildeProjectiveGlobalSectionsEquiv
    [Module.Finite R M] [Module.Projective R M] :
    M ≃ₗ[R] M.tildeInModuleCat.obj (op ⊤) :=
  LinearEquiv.ofBijective (actualTildeOriginalGlobalLinearMap M)
    ⟨actualTildeOriginalGlobalSection_injective M,
      actualTildeGlobalSections_surjective_of_finite_projective M⟩

end Litt3.Jacobians

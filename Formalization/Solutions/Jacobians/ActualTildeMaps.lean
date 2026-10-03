import Mathlib.AlgebraicGeometry.Modules.Tilde
import Mathlib.RingTheory.Localization.Module

open CategoryTheory Opposite TopologicalSpace AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {R : Type u} [CommRing R] {M N : ModuleCat.{u} R}

/-- The actual map on sections of the associated O_Spec-module sheaf.
It acts on EVERY original localized component, preserving actual local fractions. -/
noncomputable def actualTildeSectionMap (f : M ⟶ N)
    (U : (Opens (PrimeSpectrum R))ᵒᵖ) :
    ModuleCat.Tilde.sectionsSubmodule M U →ₗ[(Spec.structureSheaf R).val.obj U]
      ModuleCat.Tilde.sectionsSubmodule N U where
  toFun s := ⟨fun x => LocalizedModule.map x.1.asIdeal.primeCompl f.hom (s.val x), by
    intro y
    obtain ⟨V, hy, i, m, r, h⟩ := s.property y
    refine ⟨V, hy, i, f m, r, ?_⟩
    intro x
    obtain ⟨hr, he⟩ := h x
    refine ⟨hr, ?_⟩
    change r • LocalizedModule.map x.1.asIdeal.primeCompl f.hom (s.val (i x)) =
      LocalizedModule.mkLinearMap x.1.asIdeal.primeCompl N (f m)
    rw [← (LocalizedModule.map x.1.asIdeal.primeCompl f.hom).map_smul_of_tower, he]
    exact LocalizedModule.map_mk _ _ _ _⟩
  map_add' a b := by ext x; exact map_add _ _ _
  map_smul' r s := by
    apply Subtype.ext
    funext x
    change LocalizedModule.map x.1.asIdeal.primeCompl f.hom ((r.val x) • s.val x) =
      (r.val x) • LocalizedModule.map x.1.asIdeal.primeCompl f.hom (s.val x)
    exact map_smul _ _ _

noncomputable def actualTildeMap (f : M ⟶ N) : M.tilde ⟶ N.tilde where
  val :=
    { app := fun U => ModuleCat.ofHom (actualTildeSectionMap f U)
      naturality := fun {U V} i => by
        apply ModuleCat.hom_ext
        apply LinearMap.ext
        intro s
        apply Subtype.ext
        funext x
        rfl }

theorem actualTildeMap_id (M : ModuleCat.{u} R) : actualTildeMap (𝟙 M) = 𝟙 M.tilde := by
  apply SheafOfModules.hom_ext
  apply PresheafOfModules.hom_ext
  intro U
  apply ModuleCat.hom_ext
  apply LinearMap.ext
  intro s
  apply Subtype.ext
  funext x
  exact LinearMap.congr_fun (LocalizedModule.map_id x.1.asIdeal.primeCompl) (s.val x)

theorem actualTildeMap_comp {P : ModuleCat.{u} R} (f : M ⟶ N) (g : N ⟶ P) :
    actualTildeMap (f ≫ g) = actualTildeMap f ≫ actualTildeMap g := by
  apply SheafOfModules.hom_ext
  apply PresheafOfModules.hom_ext
  intro U
  apply ModuleCat.hom_ext
  apply LinearMap.ext
  intro s
  apply Subtype.ext
  funext x
  exact LinearMap.congr_fun (IsLocalizedModule.map_comp' x.1.asIdeal.primeCompl
    (LocalizedModule.mkLinearMap _ M) (LocalizedModule.mkLinearMap _ N)
    (LocalizedModule.mkLinearMap _ P) f.hom g.hom) (s.val x)

/-- A genuine functor into the ACTUAL category of O_Spec-module sheaves. -/
noncomputable def actualTildeFunctor (R : Type u) [CommRing R] :
    ModuleCat.{u} R ⥤ (Spec (.of R)).Modules where
  obj M := M.tilde
  map := actualTildeMap
  map_id := actualTildeMap_id
  map_comp := actualTildeMap_comp

end Litt3.Jacobians

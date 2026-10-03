import Solutions.Jacobians.ActualTildeMaps

open CategoryTheory Opposite TopologicalSpace AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable (R : Type u) [CommRing R]

/-- The ACTUAL localized original ring module equals the actual prime-local ring. -/
noncomputable def actualLocalizedRingModuleEquiv (x : PrimeSpectrum R) :
    LocalizedModule x.asIdeal.primeCompl R ≃ₗ[Localization.AtPrime x.asIdeal]
      Localization.AtPrime x.asIdeal :=
  (IsLocalizedModule.linearEquiv x.asIdeal.primeCompl
    (LocalizedModule.mkLinearMap x.asIdeal.primeCompl R)
    (Algebra.linearMap R (Localization.AtPrime x.asIdeal))).extendScalarsOfIsLocalization
      x.asIdeal.primeCompl (Localization.AtPrime x.asIdeal)

theorem actualLocalizedRingModuleEquiv_original (x : PrimeSpectrum R) (r : R) :
    actualLocalizedRingModuleEquiv R x (LocalizedModule.mkLinearMap x.asIdeal.primeCompl R r) =
      algebraMap R (Localization.AtPrime x.asIdeal) r :=
  IsLocalizedModule.linearEquiv_apply _ _ _ r

theorem actualLocalizedRingModuleEquiv_rsmul (x : PrimeSpectrum R) (r : R)
    (m : LocalizedModule x.asIdeal.primeCompl R) :
    actualLocalizedRingModuleEquiv R x (r • m) =
      algebraMap R (Localization.AtPrime x.asIdeal) r * actualLocalizedRingModuleEquiv R x m := by
  calc
    _ = r • actualLocalizedRingModuleEquiv R x m :=
      (actualLocalizedRingModuleEquiv R x).restrictScalars R |>.map_smul r m
    _ = _ := Algebra.smul_def r _

noncomputable def actualTildeRingSectionMap (U : (Opens (PrimeSpectrum R))ᵒᵖ) :
    ModuleCat.Tilde.sectionsSubmodule (ModuleCat.of R R) U →ₗ[(Spec.structureSheaf R).val.obj U]
      (Spec.structureSheaf R).val.obj U where
  toFun s := ⟨fun x => actualLocalizedRingModuleEquiv R x.1 (s.val x), by
    intro y
    obtain ⟨V, hy, i, m, r, h⟩ := s.property y
    refine ⟨V, hy, i, m, r, ?_⟩
    intro x
    obtain ⟨hr, he⟩ := h x
    refine ⟨hr, ?_⟩
    have he' := congrArg (actualLocalizedRingModuleEquiv R x.1) he
    change actualLocalizedRingModuleEquiv R x.1 (r • s.val (i x)) =
      actualLocalizedRingModuleEquiv R x.1 (LocalizedModule.mkLinearMap _ R m) at he'
    rw [actualLocalizedRingModuleEquiv_rsmul, actualLocalizedRingModuleEquiv_original] at he'
    exact (mul_comm _ _).trans he'⟩
  map_add' a b := by apply Subtype.ext; funext x; exact map_add _ _ _
  map_smul' a b := by
    apply Subtype.ext
    funext x
    let ax : Localization.AtPrime x.1.asIdeal := a.val x
    change actualLocalizedRingModuleEquiv R x.1 (ax • b.val x) =
      ax * actualLocalizedRingModuleEquiv R x.1 (b.val x)
    exact (actualLocalizedRingModuleEquiv R x.1).map_smul _ _

noncomputable def actualTildeRingSectionInverse (U : (Opens (PrimeSpectrum R))ᵒᵖ) :
    (Spec.structureSheaf R).val.obj U →ₗ[(Spec.structureSheaf R).val.obj U]
      ModuleCat.Tilde.sectionsSubmodule (ModuleCat.of R R) U where
  toFun s := ⟨fun x => (actualLocalizedRingModuleEquiv R x.1).symm (s.val x), by
    intro y
    obtain ⟨V, hy, i, m, r, h⟩ := s.property y
    refine ⟨V, hy, i, m, r, ?_⟩
    intro x
    obtain ⟨hr, he⟩ := h x
    refine ⟨hr, ?_⟩
    apply (actualLocalizedRingModuleEquiv R x.1).injective
    change actualLocalizedRingModuleEquiv R x.1
      (r • (actualLocalizedRingModuleEquiv R x.1).symm (s.val (i x))) =
        actualLocalizedRingModuleEquiv R x.1 (LocalizedModule.mkLinearMap _ R m)
    rw [actualLocalizedRingModuleEquiv_rsmul,
      LinearEquiv.apply_symm_apply, actualLocalizedRingModuleEquiv_original,
      ]
    exact (mul_comm _ _).trans he⟩
  map_add' a b := by ext x; exact map_add _ _ _
  map_smul' a b := by
    apply Subtype.ext
    funext x
    change (actualLocalizedRingModuleEquiv R x.1).symm
      ((a.val x : Localization.AtPrime x.1.asIdeal) * b.val x) =
        (a.val x : Localization.AtPrime x.1.asIdeal) •
          (actualLocalizedRingModuleEquiv R x.1).symm (b.val x)
    exact (actualLocalizedRingModuleEquiv R x.1).symm.map_smul _ _

noncomputable def actualTildeRingSectionEquiv (U : (Opens (PrimeSpectrum R))ᵒᵖ) :
    ModuleCat.Tilde.sectionsSubmodule (ModuleCat.of R R) U ≃ₗ[(Spec.structureSheaf R).val.obj U]
      (Spec.structureSheaf R).val.obj U :=
  LinearEquiv.ofLinear (actualTildeRingSectionMap R U) (actualTildeRingSectionInverse R U)
    (by apply LinearMap.ext; intro s; apply Subtype.ext; funext x
        exact (actualLocalizedRingModuleEquiv R x.1).apply_symm_apply (s.val x))
    (by apply LinearMap.ext; intro s; apply Subtype.ext; funext x
        exact (actualLocalizedRingModuleEquiv R x.1).symm_apply_apply (s.val x))

/-- The actual associated sheaf of the original ring is the ACTUAL structure-sheaf module. -/
noncomputable def actualTildeUnitIso : (ModuleCat.of R R).tilde ≅
    SheafOfModules.unit (Spec (.of R)).ringCatSheaf :=
  let e := PresheafOfModules.isoMk
    (fun U => (actualTildeRingSectionEquiv R U).toModuleIso)
    (fun {U V} i => by
      apply ModuleCat.hom_ext
      apply LinearMap.ext
      intro s
      apply Subtype.ext
      funext x
      rfl)
  { hom := ⟨e.hom⟩
    inv := ⟨e.inv⟩
    hom_inv_id := SheafOfModules.hom_ext e.hom_inv_id
    inv_hom_id := SheafOfModules.hom_ext e.inv_hom_id }

end Litt3.Jacobians

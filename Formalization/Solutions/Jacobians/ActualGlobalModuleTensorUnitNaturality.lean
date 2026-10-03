import Solutions.Jacobians.ActualGlobalModuleTensorMorphisms

open CategoryTheory MonoidalCategory AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u})

noncomputable local instance : MonoidalCategory (PresheafOfModules X.ringCatSheaf.val) :=
  PresheafOfModules.monoidalCategory (R := X.presheaf)

/-- The genuine GLOBAL left-unit isomorphism respects EVERY actual
original SHEAF morphism, via true presheaf unitor naturality and the
genuine sheafification counit. -/
theorem actualSchemeModuleTensorLeftUnit_naturality
    {M N : X.Modules} (f : M ⟶ N) :
    actualSchemeModuleTensorHom X (𝟙 (SheafOfModules.unit X.ringCatSheaf)) f ≫
      (actualSchemeModuleTensorLeftUnitIso X N).hom =
    (actualSchemeModuleTensorLeftUnitIso X M).hom ≫ f := by
  let F := PresheafOfModules.sheafification (𝟙 X.ringCatSheaf.val)
  let adj := PresheafOfModules.sheafificationAdjunction (𝟙 X.ringCatSheaf.val)
  have hc := adj.counit.naturality f
  change F.map f.val ≫ adj.counit.app N = adj.counit.app M ≫ f at hc
  change F.map (𝟙 (𝟙_ (PresheafOfModules X.ringCatSheaf.val)) ⊗ₘ f.val) ≫
      (F.map (λ_ N.val).hom ≫ adj.counit.app N) =
    (F.map (λ_ M.val).hom ≫ adj.counit.app M) ≫ f
  rw [← Category.assoc, ← CategoryTheory.Functor.map_comp,
    MonoidalCategory.id_tensorHom, MonoidalCategory.leftUnitor_naturality,
    CategoryTheory.Functor.map_comp, Category.assoc, hc, ← Category.assoc]

theorem actualSchemeModuleTensorRightUnit_naturality
    {M N : X.Modules} (f : M ⟶ N) :
    actualSchemeModuleTensorHom X f (𝟙 (SheafOfModules.unit X.ringCatSheaf)) ≫
      (actualSchemeModuleTensorRightUnitIso X N).hom =
    (actualSchemeModuleTensorRightUnitIso X M).hom ≫ f := by
  let F := PresheafOfModules.sheafification (𝟙 X.ringCatSheaf.val)
  let adj := PresheafOfModules.sheafificationAdjunction (𝟙 X.ringCatSheaf.val)
  have hc := adj.counit.naturality f
  change F.map f.val ≫ adj.counit.app N = adj.counit.app M ≫ f at hc
  change F.map (f.val ⊗ₘ 𝟙 (𝟙_ (PresheafOfModules X.ringCatSheaf.val))) ≫
      (F.map (ρ_ N.val).hom ≫ adj.counit.app N) =
    (F.map (ρ_ M.val).hom ≫ adj.counit.app M) ≫ f
  rw [← Category.assoc, ← CategoryTheory.Functor.map_comp,
    MonoidalCategory.tensorHom_id, MonoidalCategory.rightUnitor_naturality,
    CategoryTheory.Functor.map_comp, Category.assoc, hc, ← Category.assoc]

noncomputable def actualSchemeModuleTensorLeftUnitNaturalIso :
    actualSchemeModuleLeftTensorFunctor X (SheafOfModules.unit X.ringCatSheaf) ≅
      𝟭 X.Modules :=
  NatIso.ofComponents (actualSchemeModuleTensorLeftUnitIso X)
    (fun f => actualSchemeModuleTensorLeftUnit_naturality X f)

noncomputable def actualSchemeModuleTensorRightUnitNaturalIso :
    actualSchemeModuleRightTensorFunctor X (SheafOfModules.unit X.ringCatSheaf) ≅
      𝟭 X.Modules :=
  NatIso.ofComponents (actualSchemeModuleTensorRightUnitIso X)
    (fun f => actualSchemeModuleTensorRightUnit_naturality X f)

end Litt3.Jacobians

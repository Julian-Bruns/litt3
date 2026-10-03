import Solutions.Jacobians.SchemeDivisorSheaves
import Mathlib.Algebra.Category.ModuleCat.Sheaf.PushforwardContinuous

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u}) [IsIntegral X] [ClosedPointDVRStalks X]

/-- The actual restriction functor to the entire original site below U. -/
noncomputable def actualSchemeSheafOverFunctor (U : X.Opens) :
    X.Modules ⥤ SheafOfModules (X.ringCatSheaf.over U) :=
  SheafOfModules.pushforward (F := Over.forget U) (𝟙 _)

/-- Equality of original divisor coefficients on an original open
gives an actual morphism of restricted SHEAVES on EVERY smaller open. -/
noncomputable def actualDivisorSheafRestrictionMap
    (D E : Divisor (Litt3.SharedTensors.ClosedPoint X)) (U : X.Opens)
    (h : ∀ (x : Litt3.SharedTensors.ClosedPoint X), x.val ∈ U → D x = E x) :
    (actualSchemeDivisorSheaf X D).over U ⟶ (actualSchemeDivisorSheaf X E).over U where
  val :=
    { app := fun V => ModuleCat.ofHom
        (X := ((actualSchemeDivisorSheaf X D).over U).val.obj V)
        (Y := ((actualSchemeDivisorSheaf X E).over U).val.obj V)
        { toFun := fun a => ⟨a.val, by
            intro x hx
            rw [← h x (V.unop.hom.le hx)]
            exact a.property x hx⟩
          map_add' := fun a b => Subtype.ext rfl
          map_smul' := fun r a => Subtype.ext rfl }
      naturality := fun i => by
        apply ModuleCat.hom_ext
        apply DFunLike.ext
        intro a
        apply Subtype.ext
        rfl }

/-- True original divisor sheaves agree on the entire restricted
original open site when their literal original coefficients agree there. -/
noncomputable def actualDivisorSheafRestrictionIso
    (D E : Divisor (Litt3.SharedTensors.ClosedPoint X)) (U : X.Opens)
    (h : ∀ (x : Litt3.SharedTensors.ClosedPoint X), x.val ∈ U → D x = E x) :
    (actualSchemeDivisorSheaf X D).over U ≅ (actualSchemeDivisorSheaf X E).over U where
  hom := actualDivisorSheafRestrictionMap X D E U h
  inv := actualDivisorSheafRestrictionMap X E D U (fun x hx => (h x hx).symm)
  hom_inv_id := by
    apply SheafOfModules.hom_ext
    apply PresheafOfModules.hom_ext
    intro V
    apply ModuleCat.hom_ext
    apply DFunLike.ext
    intro a
    apply Subtype.ext
    rfl
  inv_hom_id := by
    apply SheafOfModules.hom_ext
    apply PresheafOfModules.hom_ext
    intro V
    apply ModuleCat.hom_ext
    apply DFunLike.ext
    intro a
    apply Subtype.ext
    rfl

end Litt3.Jacobians

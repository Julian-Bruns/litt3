import Solutions.Jacobians.ActualTildeMaps
import Mathlib.Algebra.Category.ModuleCat.Sheaf.PushforwardContinuous

open CategoryTheory Opposite TopologicalSpace AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {R : Type u} [CommRing R]

/-- Restriction to the actual site of opens contained in U. -/
noncomputable def actualSheafOverFunctor (U : Opens (PrimeSpectrum R)) :
    (Spec (.of R)).Modules ⥤ SheafOfModules ((Spec (.of R)).ringCatSheaf.over U) :=
  SheafOfModules.pushforward (F := Over.forget U) (𝟙 _)

/-- Multiplication on an actual restricted sheaf by an original section on U;
the section is restricted to EVERY actual smaller open. -/
noncomputable def actualSheafOverScalarEnd
    (M : (Spec (.of R)).Modules) (U : Opens (PrimeSpectrum R))
    (a : (Spec.structureSheaf R).val.obj (op U)) :
    M.over U ⟶ M.over U where
  val :=
    { app := fun X => ModuleCat.ofHom
        (X := (M.over U).val.obj X) (Y := (M.over U).val.obj X)
        { toFun := fun s => (Spec.structureSheaf R).val.map X.unop.hom.op a • s
          map_add' := fun s t => smul_add _ _ _
          map_smul' := fun b s => smul_comm _ b s }
      naturality := fun {X Y} i => by
        apply ModuleCat.hom_ext
        apply LinearMap.ext
        intro s
        change (Spec.structureSheaf R).val.map Y.unop.hom.op a •
            M.val.map i.unop.left.op s = M.val.map i.unop.left.op
              ((Spec.structureSheaf R).val.map X.unop.hom.op a • s)
        rw [M.val.map_smul]
        congr 1
        }

theorem actualSheafOverScalarEnd_apply
    (M : (Spec (.of R)).Modules) (U : Opens (PrimeSpectrum R))
    (a : (Spec.structureSheaf R).val.obj (op U))
    (X : (Over U)ᵒᵖ) (s : (M.over U).val.obj X) :
    (actualSheafOverScalarEnd M U a).val.app X s =
      (Spec.structureSheaf R).val.map X.unop.hom.op a • s := rfl

end Litt3.Jacobians

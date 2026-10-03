import Solutions.Jacobians.ActualTildeTensorSheaves
import Solutions.Jacobians.ActualTildeUnit
import Mathlib.RingTheory.PicardGroup

open CategoryTheory Opposite TopologicalSpace AlgebraicGeometry TensorProduct
open scoped TensorProduct

namespace Litt3.Jacobians

universe u
variable {R : Type u} [CommRing R] (M : ModuleCat.{u} R)
  [Module.Invertible R M]

/-- The genuine tensor SHEAF of an original invertible module and its
actual module dual is the actual structure-sheaf unit. The contraction
is the true evaluation of the original dual, extended on every open. -/
noncomputable def actualTildeInvertibleDualTensorUnitIso :
    actualTildeTensorSheaf (ModuleCat.of R (Module.Dual R M)) M ≅
      SheafOfModules.unit (Spec (.of R)).ringCatSheaf :=
  actualTildeTensorSheafIso _ _ ≪≫
    (actualTildeFunctor R).mapIso (Module.Invertible.linearEquiv R M).toModuleIso ≪≫
      actualTildeUnitIso R

/-- The inverse order also gives the true structure-sheaf unit, using
the actual original tensor symmetry rather than a class-group equality. -/
noncomputable def actualTildeInvertibleTensorDualUnitIso :
    actualTildeTensorSheaf M (ModuleCat.of R (Module.Dual R M)) ≅
      SheafOfModules.unit (Spec (.of R)).ringCatSheaf :=
  actualTildeTensorSheafIso _ _ ≪≫
    (actualTildeFunctor R).mapIso
      ((TensorProduct.comm R M (Module.Dual R M)) ≪≫ₗ
        (Module.Invertible.linearEquiv R M)).toModuleIso ≪≫ actualTildeUnitIso R

end Litt3.Jacobians

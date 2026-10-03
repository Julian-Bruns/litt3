import Solutions.Jacobians.ActualTildeTensorSheaves
import Solutions.Jacobians.ActualTildeUnit
import Solutions.Jacobians.FractionalIdealProductModules

open CategoryTheory Opposite TopologicalSpace AlgebraicGeometry TensorProduct
open scoped nonZeroDivisors TensorProduct

namespace Litt3.Jacobians

universe u
variable {R K : Type u} [CommRing R] [IsDomain R] [Field K]
  [Algebra R K] [IsFractionRing R K]

/-- The original module of a genuine invertible fractional ideal. -/
noncomputable def actualFractionalIdealModule (I : (FractionalIdeal R⁰ K)ˣ) :
    ModuleCat.{u} R := ModuleCat.of R (I.val : Submodule R K)

noncomputable instance actualFractionalIdealModule_invertible
    (I : (FractionalIdeal R⁰ K)ˣ) :
    Module.Invertible R (actualFractionalIdealModule I) :=
  actual_invertible_fractional_ideal_module I

/-- Genuine multiplication of actual fractional ideals is the tensor
product of their genuine associated SHEAVES, over every original open. -/
noncomputable def actualFractionalIdealTensorSheafProductIso
    (I J : (FractionalIdeal R⁰ K)ˣ) :
    actualTildeTensorSheaf (actualFractionalIdealModule I) (actualFractionalIdealModule J) ≅
      (actualFractionalIdealModule (I * J)).tilde :=
  actualTildeTensorSheafIso _ _ ≪≫
    (actualTildeFunctor R).mapIso (fractionalIdealTensorMultiplyEquiv I J).toModuleIso

/-- The actual sheaf of the unit ideal is the actual structure-sheaf unit. -/
noncomputable def actualFractionalIdealUnitSheafIso :
    (actualFractionalIdealModule (1 : (FractionalIdeal R⁰ K)ˣ)).tilde ≅
      SheafOfModules.unit (Spec (.of R)).ringCatSheaf :=
  (actualTildeFunctor R).mapIso
    (fractionalIdealOneModuleEquiv (R := R) (K := K)).symm.toModuleIso ≪≫ actualTildeUnitIso R

/-- The genuine inverse fractional ideal gives an actual inverse SHEAF;
this uses literal ideal multiplication and the genuine tensor comparison. -/
noncomputable def actualFractionalIdealInverseTensorUnitIso
    (I : (FractionalIdeal R⁰ K)ˣ) :
    actualTildeTensorSheaf (actualFractionalIdealModule I) (actualFractionalIdealModule I⁻¹) ≅
      SheafOfModules.unit (Spec (.of R)).ringCatSheaf := by
  exact actualFractionalIdealTensorSheafProductIso I I⁻¹ ≪≫
    (by simpa only [mul_inv_cancel] using
      (actualFractionalIdealUnitSheafIso (R := R) (K := K)))

end Litt3.Jacobians

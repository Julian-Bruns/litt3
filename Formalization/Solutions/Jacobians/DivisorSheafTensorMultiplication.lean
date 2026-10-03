import Solutions.Jacobians.ActualGlobalModuleTensor
import Solutions.Jacobians.SchemeDivisorSheaves
import Solutions.Jacobians.RationalFunctionSheafScalarAlgebra

open CategoryTheory Opposite AlgebraicGeometry
open scoped WithZero TensorProduct

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u}) [IsIntegral X] [ClosedPointDVRStalks X]

noncomputable def actualDivisorSheafSectionRational
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X)) (U : X.Opensᵒᵖ)
    (a : (actualSchemeDivisorSheaf X D).val.obj U) :
    (actualSchemeRationalFunctionRingSheaf X).val.obj U := a.val

/-- Literal multiplication of ORIGINAL rational sections adds the
true original closed-point pole bounds, on EVERY original open. -/
noncomputable def actualDivisorSheafSectionProduct
    (D E : Divisor (Litt3.SharedTensors.ClosedPoint X)) (U : X.Opensᵒᵖ)
    (a : (actualSchemeDivisorSheaf X D).val.obj U)
    (b : (actualSchemeDivisorSheaf X E).val.obj U) :
    (actualSchemeDivisorSheaf X (D + E)).val.obj U :=
  ⟨actualDivisorSheafSectionRational X D U a *
    actualDivisorSheafSectionRational X E U b, by
    intro x hx
    change closedPointValuation X x
      (actualRationalFunctionEvaluation X U.unop x.val hx
        (actualDivisorSheafSectionRational X D U a *
          actualDivisorSheafSectionRational X E U b)) ≤ _
    rw [map_mul, map_mul]
    simpa only [Finsupp.add_apply, WithZero.exp_add] using
      mul_le_mul' (a.property x hx) (b.property x hx)⟩

/-- The actual original tensor PRESHEAF maps to the actual divisor
SHEAF by genuine bilinear rational multiplication. -/
noncomputable def actualDivisorSheafTensorPresheafMultiply
    (D E : Divisor (Litt3.SharedTensors.ClosedPoint X)) :
    actualSchemeModuleTensorPresheaf X (actualSchemeDivisorSheaf X D)
      (actualSchemeDivisorSheaf X E) ⟶ (actualSchemeDivisorSheaf X (D + E)).val where
  app U := ModuleCat.MonoidalCategory.tensorLift
    (actualDivisorSheafSectionProduct X D E U)
    (by
      intro a a' b
      apply Subtype.ext
      change (actualDivisorSheafSectionRational X D U a +
        actualDivisorSheafSectionRational X D U a') *
          actualDivisorSheafSectionRational X E U b = _
      exact add_mul _ _ _)
    (by
      intro r a b
      apply Subtype.ext
      change ((actualSchemeStructureToRationalFunctions X).val.app U r *
        actualDivisorSheafSectionRational X D U a) *
          actualDivisorSheafSectionRational X E U b =
        (actualSchemeStructureToRationalFunctions X).val.app U r *
          (actualDivisorSheafSectionRational X D U a *
            actualDivisorSheafSectionRational X E U b)
      exact mul_assoc _ _ _)
    (by
      intro a b b'
      apply Subtype.ext
      change actualDivisorSheafSectionRational X D U a *
        (actualDivisorSheafSectionRational X E U b +
          actualDivisorSheafSectionRational X E U b') = _
      exact mul_add _ _ _)
    (by
      intro r a b
      apply Subtype.ext
      change actualDivisorSheafSectionRational X D U a *
        ((actualSchemeStructureToRationalFunctions X).val.app U r *
          actualDivisorSheafSectionRational X E U b) =
        (actualSchemeStructureToRationalFunctions X).val.app U r *
          (actualDivisorSheafSectionRational X D U a *
            actualDivisorSheafSectionRational X E U b)
      exact mul_left_comm _ _ _)
  naturality {U V} i := by
    apply ModuleCat.MonoidalCategory.tensor_ext
    intro a b
    apply Subtype.ext
    change (actualSchemeRationalFunctionRingSheaf X).val.map i
      (actualDivisorSheafSectionRational X D U a) *
      (actualSchemeRationalFunctionRingSheaf X).val.map i
        (actualDivisorSheafSectionRational X E U b) =
      (actualSchemeRationalFunctionRingSheaf X).val.map i
        (actualDivisorSheafSectionRational X D U a *
          actualDivisorSheafSectionRational X E U b)
    exact (((actualSchemeRationalFunctionRingSheaf X).val.map i).hom.map_mul _ _).symm

/-- Genuine GLOBAL sheafified tensor multiplication. No assertion
that pointwise tensor sections already form a sheaf is used. -/
noncomputable def actualDivisorSheafTensorMultiply
    (D E : Divisor (Litt3.SharedTensors.ClosedPoint X)) :
    actualSchemeModuleTensorSheaf X (actualSchemeDivisorSheaf X D)
      (actualSchemeDivisorSheaf X E) ⟶ actualSchemeDivisorSheaf X (D + E) :=
  (PresheafOfModules.sheafificationHomEquiv (𝟙 X.ringCatSheaf.val)).symm
    (actualDivisorSheafTensorPresheafMultiply X D E)

end Litt3.Jacobians

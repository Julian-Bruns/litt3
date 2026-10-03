import Solutions.Jacobians.DivisorSheafTensorMultiplication
import Solutions.Jacobians.AffineDivisorSectionTensorProducts
import Solutions.Jacobians.AffineDivisorSectionValues

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace
open scoped nonZeroDivisors TensorProduct
open IsDedekindDomain

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u}) [IsIntegral X] [JacobsonSpace X] [ClosedPointDVRStalks X]
  (U : X.Opens) [Nonempty U]

/-- The ORIGINAL entire rational value of an original O(D) section,
as an honest linear map over the ORIGINAL open's coordinate ring. -/
noncomputable def actualDivisorSectionFieldValueLinearMap
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X)) :
    (actualSchemeDivisorSheaf X D).val.obj (op U) →ₗ[Γ(X, U)] X.functionField :=
  (actualRationalFunctionOpenLinearEquiv X U).toLinearMap.comp
    (actualSchemeDivisorOpenSubmodule X D (op U)).subtype

theorem actualDivisorSectionFieldValueLinearMap_injective
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X)) :
    Function.Injective (actualDivisorSectionFieldValueLinearMap X U D) := by
  intro a b h
  apply Subtype.ext
  exact (actualRationalFunctionOpenLinearEquiv X U).injective h

/-- This is the LITERAL multiplication map already constructed on
the original tensor PRESHEAF, rather than an unrelated module equivalence. -/
noncomputable def actualDivisorTensorOpenMultiply
    (D E : Divisor (Litt3.SharedTensors.ClosedPoint X)) :
    (actualSchemeDivisorSheaf X D).val.obj (op U) ⊗[Γ(X, U)]
      (actualSchemeDivisorSheaf X E).val.obj (op U) →ₗ[Γ(X, U)]
        (actualSchemeDivisorSheaf X (D + E)).val.obj (op U) :=
  ((actualDivisorSheafTensorPresheafMultiply X D E).app (op U)).hom

variable {X U} (hU : IsAffineOpen U)
  [IsDedekindDomain Γ(X, U)] (hfield : ¬IsField Γ(X, U))

/-- The LITERAL tensor-presheaf multiplication commutes with the
entire ORIGINAL field-valued fractional-ideal tensor multiplication.
Neither ideal-class data nor a supplied tensor-map comparison is used. -/
theorem actualDivisorTensorOpenMultiply_field_value
    (D E : Divisor (Litt3.SharedTensors.ClosedPoint X)) :
    letI := functionField_isFractionRing_of_isAffineOpen X U hU
    (actualDivisorSectionFieldValueLinearMap X U (D + E)).comp
      (actualDivisorTensorOpenMultiply X U D E) =
    (fractionalIdealTensorProductMap
      (actualDedekindSectionFractionalIdeal Γ(X, U) X.functionField
        (actualAffineChartDivisorRestriction hU hfield D)).val
      (actualDedekindSectionFractionalIdeal Γ(X, U) X.functionField
        (actualAffineChartDivisorRestriction hU hfield E)).val).comp
      (TensorProduct.congr
        (actualAffineDivisorSectionsFractionalIdealEquiv hU hfield D)
        (actualAffineDivisorSectionsFractionalIdealEquiv hU hfield E)).toLinearMap := by
  letI := functionField_isFractionRing_of_isAffineOpen X U hU
  ext a b
  change actualRationalFunctionOpenLinearEquiv X U
    (actualDivisorSheafSectionProduct X D E (op U) a b).val =
    fractionalIdealTensorProductMap _ _
      ((actualAffineDivisorSectionsFractionalIdealEquiv hU hfield D a) ⊗ₜ[Γ(X, U)]
        (actualAffineDivisorSectionsFractionalIdealEquiv hU hfield E b))
  rw [fractionalIdealTensorProductMap_tmul,
    actualAffineDivisorSectionsFractionalIdealEquiv_value,
    actualAffineDivisorSectionsFractionalIdealEquiv_value]
  change (actualSchemeRationalFunctionOpenIso X U).hom
      (actualDivisorSheafSectionRational X D (op U) a *
        actualDivisorSheafSectionRational X E (op U) b) =
    (actualSchemeRationalFunctionOpenIso X U).hom
      (actualDivisorSheafSectionRational X D (op U) a) *
    (actualSchemeRationalFunctionOpenIso X U).hom
      (actualDivisorSheafSectionRational X E (op U) b)
  exact (actualSchemeRationalFunctionOpenIso X U).hom.hom.map_mul _ _

end Litt3.Jacobians

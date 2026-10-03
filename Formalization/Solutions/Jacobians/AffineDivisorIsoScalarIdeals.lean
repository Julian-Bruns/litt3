import Solutions.Jacobians.DivisorSheafHomScalarAlgebra
import Solutions.Jacobians.AffineDivisorSectionValues

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace
open scoped nonZeroDivisors

namespace Litt3.Jacobians

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X] [JacobsonSpace X] [ClosedPointDVRStalks X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
  {U : X.Opens} (hU : IsAffineOpen U)
  [IsDedekindDomain Γ(X, U)] [Nonempty U] (hfield : ¬IsField Γ(X, U))
  (D E : Divisor (Litt3.SharedTensors.ClosedPoint X))
  (e : actualSchemeDivisorSheaf X D ≅ actualSchemeDivisorSheaf X E)

/-- A TRUE global divisor-sheaf isomorphism gives a TRUE linear
equivalence of its original affine fractional ideals. -/
noncomputable def actualAffineDivisorSheafIsoIdealEquiv :
    letI := functionField_isFractionRing_of_isAffineOpen X U hU
    (((actualDedekindSectionFractionalIdeal Γ(X, U) X.functionField
      (actualAffineChartDivisorRestriction hU hfield D)).val :
        FractionalIdeal (Γ(X, U))⁰ X.functionField) : Submodule Γ(X, U) X.functionField) ≃ₗ[Γ(X, U)]
    (((actualDedekindSectionFractionalIdeal Γ(X, U) X.functionField
      (actualAffineChartDivisorRestriction hU hfield E)).val :
        FractionalIdeal (Γ(X, U))⁰ X.functionField) : Submodule Γ(X, U) X.functionField) :=
  (actualAffineDivisorSectionsFractionalIdealEquiv hU hfield D).symm ≪≫ₗ
    ((SheafOfModules.evaluation X.ringCatSheaf (op U)).mapIso e).toLinearEquiv ≪≫ₗ
      actualAffineDivisorSectionsFractionalIdealEquiv hU hfield E

include sX in
/-- The TRUE affine ideal equivalence acts by the SAME derived
ORIGINAL global rational scalar, on the entire original field values. -/
theorem actualAffineDivisorSheafIsoIdealEquiv_value
    (a :
      letI := functionField_isFractionRing_of_isAffineOpen X U hU
      (((actualDedekindSectionFractionalIdeal Γ(X, U) X.functionField
        (actualAffineChartDivisorRestriction hU hfield D)).val :
          FractionalIdeal (Γ(X, U))⁰ X.functionField) : Submodule Γ(X, U) X.functionField)) :
    (actualAffineDivisorSheafIsoIdealEquiv hU hfield D E e a).val =
      actualDivisorSheafHomScalar X D E e.hom * a.val := by
  let d := actualAffineDivisorSectionsFractionalIdealEquiv hU hfield D
  have h := actualDivisorSheafHomScalar_on_open X D E sX e.hom U (d.symm a)
  have ha : (actualSchemeRationalFunctionOpenIso X U).hom.hom (d.symm a).val = a.val := by
    change (d (d.symm a)).val = a.val
    rw [d.apply_symm_apply]
  change (actualSchemeRationalFunctionOpenIso X U).hom.hom
    ((e.hom.val.app (op U)) (d.symm a)).val = _
  rw [← ha]
  exact h

include sX in
/-- The original affine ideal equality induced by a genuine global
SHEAF isomorphism is literal multiplication by its ONE global principal
fractional ideal. Merely locally principal class equality is insufficient. -/
theorem actualAffineDivisorIsoIdeal_eq_scalar_mul :
    letI := functionField_isFractionRing_of_isAffineOpen X U hU
    (actualDedekindSectionFractionalIdeal Γ(X, U) X.functionField
      (actualAffineChartDivisorRestriction hU hfield E)).val =
    FractionalIdeal.spanSingleton (Γ(X, U))⁰ (actualDivisorSheafHomScalar X D E e.hom) *
      (actualDedekindSectionFractionalIdeal Γ(X, U) X.functionField
        (actualAffineChartDivisorRestriction hU hfield D)).val := by
  letI := functionField_isFractionRing_of_isAffineOpen X U hU
  let φ := actualAffineDivisorSheafIsoIdealEquiv hU hfield D E e
  apply FractionalIdeal.eq_spanSingleton_mul.mpr
  constructor
  · intro z hz
    let b := (⟨z, hz⟩ :
      ((actualDedekindSectionFractionalIdeal Γ(X, U) X.functionField
        (actualAffineChartDivisorRestriction hU hfield E)).val :
          Submodule Γ(X, U) X.functionField))
    refine ⟨(φ.symm b).val, (φ.symm b).property, ?_⟩
    have h := actualAffineDivisorSheafIsoIdealEquiv_value sX hU hfield D E e (φ.symm b)
    change (φ (φ.symm b)).val = _ at h
    rw [φ.apply_symm_apply] at h
    exact h.symm
  · intro z hz
    let a := (⟨z, hz⟩ :
      ((actualDedekindSectionFractionalIdeal Γ(X, U) X.functionField
        (actualAffineChartDivisorRestriction hU hfield D)).val :
          Submodule Γ(X, U) X.functionField))
    have h := actualAffineDivisorSheafIsoIdealEquiv_value sX hU hfield D E e a
    change (φ a).val = _ at h
    rw [← h]
    exact (φ a).property

end Litt3.Jacobians

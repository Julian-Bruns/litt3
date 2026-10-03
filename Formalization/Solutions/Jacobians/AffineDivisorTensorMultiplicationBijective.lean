import Solutions.Jacobians.AffineDivisorTensorMultiplicationValues

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace
open scoped nonZeroDivisors TensorProduct
open IsDedekindDomain

namespace Litt3.Jacobians

universe u
variable {X : Scheme.{u}} [IsIntegral X] [JacobsonSpace X] [ClosedPointDVRStalks X]
  {U : X.Opens} (hU : IsAffineOpen U)
  [IsDedekindDomain Γ(X, U)] [Nonempty U] (hfield : ¬IsField Γ(X, U))

include hU hfield

/-- The LITERAL original tensor-presheaf multiplication is surjective
on an actual affine chart: actual fractional-ideal product elements lift
through the original full-field section equivalences. -/
theorem actualDivisorTensorOpenMultiply_affine_surjective
    (D E : Divisor (Litt3.SharedTensors.ClosedPoint X)) :
    Function.Surjective (actualDivisorTensorOpenMultiply X U D E) := by
  letI := functionField_isFractionRing_of_isAffineOpen X U hU
  let I := actualDedekindSectionFractionalIdeal Γ(X, U) X.functionField
    (actualAffineChartDivisorRestriction hU hfield D)
  let J := actualDedekindSectionFractionalIdeal Γ(X, U) X.functionField
    (actualAffineChartDivisorRestriction hU hfield E)
  let IJ := actualDedekindSectionFractionalIdeal Γ(X, U) X.functionField
    (actualAffineChartDivisorRestriction hU hfield (D + E))
  have hIJ : IJ = I * J := by
    dsimp only [IJ, I, J]
    rw [actualAffineChartDivisorRestriction_add_tensor hU hfield,
      actualDedekindSectionFractionalIdeal_add]
  let e := TensorProduct.congr
    (actualAffineDivisorSectionsFractionalIdealEquiv hU hfield D)
    (actualAffineDivisorSectionsFractionalIdealEquiv hU hfield E)
  intro c
  have hmember : actualDivisorSectionFieldValueLinearMap X U (D + E) c ∈ I.val * J.val := by
    have hc := (actualAffineDivisorSectionsFractionalIdealEquiv hU hfield (D + E) c).property
    change actualDivisorSectionFieldValueLinearMap X U (D + E) c ∈ IJ.val at hc
    rw [hIJ] at hc
    exact hc
  obtain ⟨a, ha⟩ := fractionalIdealTensorProductMap_exists_of_mem I.val J.val hmember
  refine ⟨e.symm a, ?_⟩
  apply actualDivisorSectionFieldValueLinearMap_injective X U (D + E)
  have hv := LinearMap.congr_fun
    (actualDivisorTensorOpenMultiply_field_value hU hfield D E) (e.symm a)
  change actualDivisorSectionFieldValueLinearMap X U (D + E)
      (actualDivisorTensorOpenMultiply X U D E (e.symm a)) =
    fractionalIdealTensorProductMap I.val J.val (e (e.symm a)) at hv
  rw [e.apply_symm_apply] at hv
  exact hv.trans ha

/-- The entire LITERAL tensor-presheaf section multiplication is
bijective on the actual affine chart. True invertibility of all three
original section modules is derived from their genuine fractional ideals. -/
theorem actualDivisorTensorOpenMultiply_affine_bijective
    (D E : Divisor (Litt3.SharedTensors.ClosedPoint X)) :
    Function.Bijective (actualDivisorTensorOpenMultiply X U D E) := by
  letI : Module.Invertible Γ(X, U) ((actualSchemeDivisorSheaf X D).val.obj (op U)) :=
    actualAffineDivisorSections_invertible hU hfield D
  letI : Module.Invertible Γ(X, U) ((actualSchemeDivisorSheaf X E).val.obj (op U)) :=
    actualAffineDivisorSections_invertible hU hfield E
  letI : Module.Invertible Γ(X, U) ((actualSchemeDivisorSheaf X (D + E)).val.obj (op U)) :=
    actualAffineDivisorSections_invertible hU hfield (D + E)
  exact Module.Invertible.bijective_of_surjective
    (actualDivisorTensorOpenMultiply_affine_surjective hU hfield D E)

end Litt3.Jacobians

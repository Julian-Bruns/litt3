import Solutions.Jacobians.AffineChartDivisorRestriction
import Solutions.Jacobians.DedekindSectionFractionalIdeals
import Solutions.Jacobians.SchemeDivisorSheaves
import Solutions.Jacobians.RationalFunctionOpenLinearEquivalence

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace
open scoped nonZeroDivisors WithZero
open IsDedekindDomain

namespace Litt3.Jacobians

universe u
variable {X : Scheme.{u}} [IsIntegral X] [JacobsonSpace X] [ClosedPointDVRStalks X]
  {U : X.Opens} (hU : IsAffineOpen U)
  [IsDedekindDomain Γ(X, U)] [Nonempty U] (hfield : ¬IsField Γ(X, U))

/-- On an ORIGINAL affine chart the valuation-bounded original divisor
SHEAF sections correspond EXACTLY to the true Dedekind fractional ideal
of the actual restricted divisor. The point correspondence, normalization
and original generic field map are all proved, not assumed. -/
theorem actual_affine_divisor_section_mem_iff
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X))
    (a : (actualSchemeRationalFunctionModuleSheaf X).val.obj (op U)) :
    a ∈ actualSchemeDivisorOpenSubmodule X D (op U) ↔
      (actualRationalFunctionOpenLinearEquiv X U) a ∈
        letI := functionField_isFractionRing_of_isAffineOpen X U hU
        (actualDedekindSectionFractionalIdeal Γ(X, U) X.functionField
          (actualAffineChartDivisorRestriction hU hfield D)).val := by
  letI := functionField_isFractionRing_of_isAffineOpen X U hU
  rw [actual_dedekind_section_fractional_ideal_mem]
  constructor
  · intro ha v
    obtain ⟨x, rfl⟩ := chart_height_one_surjective hU hfield v
    rw [actualAffineChartDivisorRestriction_coefficient]
    have h := ha x.val x.property
    rw [actualRationalFunctionEvaluation_eq_open] at h
    rw [← actual_affine_chart_closed_point_valuation hU hfield x]
    exact h
  · intro ha x hx
    let y : ChartClosedPoint U := ⟨x, hx⟩
    have h := ha (chartHeightOne hU hfield y)
    rw [actualAffineChartDivisorRestriction_coefficient] at h
    rw [actualRationalFunctionEvaluation_eq_open,
      actual_affine_chart_closed_point_valuation hU hfield y]
    exact h

end Litt3.Jacobians

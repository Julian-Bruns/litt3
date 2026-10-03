import Solutions.Jacobians.DedekindLocalValuationComparison
import Solutions.Jacobians.AffineChartClosedPointEquivalence

open CategoryTheory AlgebraicGeometry TopologicalSpace
open IsDedekindDomain

namespace Litt3.Jacobians

universe u

/-- On an ORIGINAL affine Dedekind chart, the true normalized valuation
of each ORIGINAL closed stalk agrees exactly with the true prime valuation
of its ORIGINAL coordinate ideal on the ENTIRE ORIGINAL function field.
Both localization and scalar-tower compatibility are derived from the
literal original chart and stalk maps. -/
theorem actual_affine_chart_closed_point_valuation
    {X : Scheme.{u}} [IsIntegral X] [ClosedPointDVRStalks X]
    {U : X.Opens} (hU : IsAffineOpen U)
    [IsDedekindDomain Γ(X, U)] [Nonempty U] (hfield : ¬IsField Γ(X, U))
    (x : ChartClosedPoint U) :
    letI := functionField_isFractionRing_of_isAffineOpen X U hU
    closedPointValuation X x.val =
      (chartHeightOne hU hfield x).valuation X.functionField := by
  let xU : U := ⟨x.val.val, x.property⟩
  letI := TopCat.Presheaf.algebra_section_stalk X.presheaf xU
  letI := hU.isLocalization_stalk xU
  letI : IsLocalization.AtPrime (X.presheaf.stalk x.val.val)
      (chartHeightOne hU hfield x).asIdeal := hU.isLocalization_stalk xU
  letI := functionField_isScalarTower X U xU
  letI := functionField_isFractionRing_of_isAffineOpen X U hU
  exact actual_dedekind_prime_localization_normalized_valuation
    (S := X.presheaf.stalk x.val.val) (K := X.functionField) (chartHeightOne hU hfield x)

end Litt3.Jacobians

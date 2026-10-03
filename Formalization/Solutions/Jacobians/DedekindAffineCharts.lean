import Definitions.Jacobians.DedekindAffineCharts
import Solutions.Jacobians.SchemeValuationPullbacks

open AlgebraicGeometry CategoryTheory

namespace Litt3.Jacobians

universe u

theorem chart_height_one_injective
    {X : Scheme.{u}} {U : X.Opens} (hU : IsAffineOpen U)
    [IsDedekindDomain Γ(X, U)] (hfield : ¬IsField Γ(X, U)) :
    Function.Injective (chartHeightOne hU hfield) := by
  intro x y hxy
  have hideal : hU.primeIdealOf ⟨x.val.val, x.property⟩ =
      hU.primeIdealOf ⟨y.val.val, y.property⟩ :=
    PrimeSpectrum.ext (congrArg IsDedekindDomain.HeightOneSpectrum.asIdeal hxy)
  have hpoint := congrArg hU.fromSpec hideal
  simp only [hU.fromSpec_primeIdealOf] at hpoint
  exact Subtype.ext (Subtype.ext hpoint)

theorem dedekind_chart_closed_stalk_dvr
    {X : Scheme.{u}} [IsIntegral X] {U : X.Opens} (hU : IsAffineOpen U)
    [IsDedekindDomain Γ(X, U)] (hfield : ¬IsField Γ(X, U)) (x : ChartClosedPoint U) :
    IsDiscreteValuationRing (X.presheaf.stalk x.val.val) := by
  let xU : U := ⟨x.val.val, x.property⟩
  letI := TopCat.Presheaf.algebra_section_stalk X.presheaf xU
  haveI := hU.isLocalization_stalk xU
  haveI : IsLocalization.AtPrime (X.presheaf.stalk x.val.val)
      (chartHeightOne hU hfield x).asIdeal := hU.isLocalization_stalk xU
  exact IsLocalization.AtPrime.isDiscreteValuationRing_of_dedekind_domain
    Γ(X, U) (chartHeightOne hU hfield x).ne_bot (X.presheaf.stalk x.val.val)

/-- A finite cover by genuine non-field affine Dedekind charts proves the
closed-point DVR condition. No point valuations are supplied as inputs. -/
theorem closed_point_dvr_stalks_of_dedekind_cover
    {X : Scheme.{u}} [IsIntegral X] {ι : Type*} (U : ι → X.Opens)
    (hU : ∀ i, IsAffineOpen (U i)) [∀ i, IsDedekindDomain Γ(X, U i)]
    (hfield : ∀ i, ¬IsField Γ(X, U i)) (hcover : ∀ x : X, ∃ i, x ∈ U i) :
    ClosedPointDVRStalks X where
  dvr_stalk x := by
    obtain ⟨i, hi⟩ := hcover x.val
    exact dedekind_chart_closed_stalk_dvr (hU i) (hfield i) ⟨x, hi⟩

theorem chart_valuation_one_of_not_mem
    {X : Scheme.{u}} [IsIntegral X] [ClosedPointDVRStalks X]
    {U : X.Opens} (hU : IsAffineOpen U)
    [IsDedekindDomain Γ(X, U)] [Nonempty U] (hfield : ¬IsField Γ(X, U))
    (x : ChartClosedPoint U) (a : Γ(X, U)) (ha : a ∉ (chartHeightOne hU hfield x).asIdeal) :
    closedPointValuation X x.val (algebraMap Γ(X, U) X.functionField a) = 1 := by
  let xU : U := ⟨x.val.val, x.property⟩
  letI := TopCat.Presheaf.algebra_section_stalk X.presheaf xU
  haveI := hU.isLocalization_stalk xU
  haveI := functionField_isScalarTower X U xU
  have hunit : IsUnit (algebraMap Γ(X, U) (X.presheaf.stalk x.val.val) a) :=
    (IsLocalization.AtPrime.isUnit_to_map_iff
      (X.presheaf.stalk x.val.val) (hU.primeIdealOf xU).asIdeal a).mpr ha
  rw [IsScalarTower.algebraMap_apply Γ(X, U) (X.presheaf.stalk x.val.val) X.functionField]
  change (discreteValuationPlace (X.presheaf.stalk x.val.val)).valuation X.functionField
    (algebraMap (X.presheaf.stalk x.val.val) X.functionField _) = 1
  rw [IsDedekindDomain.HeightOneSpectrum.valuation_of_algebraMap,
    IsDedekindDomain.HeightOneSpectrum.intValuation_eq_one_iff]
  exact IsLocalRing.notMem_maximalIdeal.mpr hunit

end Litt3.Jacobians

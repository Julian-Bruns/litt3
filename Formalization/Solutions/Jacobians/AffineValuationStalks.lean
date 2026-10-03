import Definitions.Jacobians.DedekindAffineCharts
import Mathlib.RingTheory.DiscreteValuationRing.TFAE

open AlgebraicGeometry

namespace Litt3.Jacobians

universe u

/-- Every actual stalk in an affine Dedekind chart is a valuation ring,
including the generic-point stalk, which may be a field. -/
theorem dedekind_chart_stalk_valuation_ring
    {X : Scheme.{u}} [IsIntegral X] {U : X.Opens} (hU : IsAffineOpen U)
    [IsDedekindDomain Γ(X, U)] (x : U) : ValuationRing (X.presheaf.stalk x.val) := by
  letI := TopCat.Presheaf.algebra_section_stalk X.presheaf x
  haveI := hU.isLocalization_stalk x
  haveI : IsDedekindDomain (X.presheaf.stalk x.val) :=
    IsLocalization.AtPrime.isDedekindDomain Γ(X, U) (hU.primeIdealOf x).asIdeal
      (X.presheaf.stalk x.val)
  exact ((tfae_of_isNoetherianRing_of_isLocalRing_of_isDomain
    (X.presheaf.stalk x.val)).out 1 2).mpr
      (show IsDedekindDomain (X.presheaf.stalk x.val) from inferInstance)

theorem valuation_stalks_of_dedekind_cover
    {X : Scheme.{u}} [IsIntegral X] {ι : Type*} (U : ι → X.Opens)
    (hU : ∀ i, IsAffineOpen (U i)) [∀ i, IsDedekindDomain Γ(X, U i)]
    (hcover : ∀ x : X, ∃ i, x ∈ U i) (x : X) : ValuationRing (X.presheaf.stalk x) := by
  obtain ⟨i, hi⟩ := hcover x
  exact dedekind_chart_stalk_valuation_ring (hU i) ⟨x, hi⟩

end Litt3.Jacobians

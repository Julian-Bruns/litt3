import Solutions.Jacobians.DedekindAffineCharts
import Mathlib.Data.Set.Finite.Lattice

open AlgebraicGeometry

namespace Litt3.Jacobians

universe u

/-- Principal valuations have finite support on each actual affine
Dedekind chart, by the finitely many prime ideal factors of a numerator
and a denominator. -/
theorem dedekind_chart_principal_support_finite
    {X : Scheme.{u}} [IsIntegral X] [ClosedPointDVRStalks X]
    {U : X.Opens} (hU : IsAffineOpen U)
    [IsDedekindDomain Γ(X, U)] [Nonempty U] (hfield : ¬IsField Γ(X, U))
    (f : Additive X.functionFieldˣ) :
    (Function.support (fun x : ChartClosedPoint U =>
      valuationOrder (closedPointValuation X x.val) f)).Finite := by
  haveI := functionField_isFractionRing_of_isAffineOpen X U hU
  obtain ⟨a, b, hb, hab⟩ := IsFractionRing.div_surjective (A := Γ(X, U)) f.toMul.val
  have ha : a ≠ 0 := by
    intro ha
    apply f.toMul.ne_zero
    rw [← hab, ha, map_zero, zero_div]
  have hmapa : algebraMap Γ(X, U) X.functionField a ≠ 0 :=
    (map_ne_zero_iff _ (IsFractionRing.injective Γ(X, U) X.functionField)).mpr ha
  have hmapb : algebraMap Γ(X, U) X.functionField b ≠ 0 :=
    (map_ne_zero_iff _ (IsFractionRing.injective Γ(X, U) X.functionField)).mpr
      (nonZeroDivisors.ne_zero hb)
  have hs := ((dedekind_valuation_ne_one_finite Γ(X, U) X.functionField _ hmapa).union
    (dedekind_valuation_ne_one_finite Γ(X, U) X.functionField _ hmapb)).preimage
      (chart_height_one_injective hU hfield).injOn
  apply hs.subset
  intro x hx
  by_contra hxnot
  change ¬ ((chartHeightOne hU hfield x).valuation X.functionField
      (algebraMap Γ(X, U) X.functionField a) ≠ 1 ∨
    (chartHeightOne hU hfield x).valuation X.functionField
      (algebraMap Γ(X, U) X.functionField b) ≠ 1) at hxnot
  have hvalues := not_or.mp hxnot
  have ha' : a ∉ (chartHeightOne hU hfield x).asIdeal := by
    apply IsDedekindDomain.HeightOneSpectrum.intValuation_eq_one_iff.mp
    simpa only [IsDedekindDomain.HeightOneSpectrum.valuation_of_algebraMap] using
      not_ne_iff.mp hvalues.1
  have hb' : b ∉ (chartHeightOne hU hfield x).asIdeal := by
    apply IsDedekindDomain.HeightOneSpectrum.intValuation_eq_one_iff.mp
    simpa only [IsDedekindDomain.HeightOneSpectrum.valuation_of_algebraMap] using
      not_ne_iff.mp hvalues.2
  have hvalue : closedPointValuation X x.val f.toMul.val = 1 := by
    rw [← hab, map_div₀, chart_valuation_one_of_not_mem hU hfield x a ha',
      chart_valuation_one_of_not_mem hU hfield x b hb', div_self one_ne_zero]
  exact hx (valuation_order_eq_zero_of_value_one (closedPointValuation X x.val) f hvalue)

/-- A finite actual Dedekind affine cover proves global finite support.
Finite support is a conclusion here, rather than an accepted input. -/
theorem finite_principal_support_of_dedekind_cover
    {X : Scheme.{u}} [IsIntegral X] [ClosedPointDVRStalks X]
    {ι : Type*} [Finite ι] (U : ι → X.Opens)
    (hU : ∀ i, IsAffineOpen (U i)) [∀ i, IsDedekindDomain Γ(X, U i)]
    [∀ i, Nonempty (U i)] (hfield : ∀ i, ¬IsField Γ(X, U i))
    (hcover : ∀ x : X, ∃ i, x ∈ U i) : FinitePrincipalSupport X where
  finite_support f := by
    let s : ι → Set (Litt3.SharedTensors.ClosedPoint X) := fun i =>
      Subtype.val '' Function.support (fun x : ChartClosedPoint (U i) =>
        valuationOrder (closedPointValuation X x.val) f)
    have hs : ∀ i, (s i).Finite := fun i =>
      (dedekind_chart_principal_support_finite (hU i) (hfield i) f).image Subtype.val
    apply (Set.finite_iUnion hs).subset
    intro x hx
    obtain ⟨i, hi⟩ := hcover x.val
    exact Set.mem_iUnion.mpr ⟨i, ⟨⟨x, hi⟩, hx, rfl⟩⟩

end Litt3.Jacobians

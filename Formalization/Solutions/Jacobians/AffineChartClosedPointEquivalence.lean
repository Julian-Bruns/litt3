import Solutions.Jacobians.DedekindAffineCharts
import Solutions.SharedTensors.SmoothCurveFiniteSupport

open CategoryTheory AlgebraicGeometry TopologicalSpace
open IsDedekindDomain

namespace Litt3.Jacobians

universe u

/-- Every true height-one ideal of an original non-field affine Dedekind
chart corresponds to an ORIGINAL closed point of the ambient Jacobson
scheme. Closedness is transferred along the actual chart open immersion. -/
theorem chart_height_one_surjective
    {X : Scheme.{u}} [JacobsonSpace X] {U : X.Opens} (hU : IsAffineOpen U)
    [IsDedekindDomain Γ(X, U)] (hfield : ¬IsField Γ(X, U)) :
    Function.Surjective (chartHeightOne hU hfield) := by
  intro v
  let y : PrimeSpectrum Γ(X, U) := ⟨v.asIdeal, v.isPrime⟩
  have hy : y ∈ closedPoints (Spec Γ(X, U)) :=
    y.isClosed_singleton_iff_isMaximal.mpr (v.isPrime.isMaximal v.ne_bot)
  have hclosed : IsClosed ({hU.fromSpec y} : Set X) :=
    (Set.ext_iff.mp hU.fromSpec.isOpenEmbedding.preimage_closedPoints y).mpr hy
  have hmem : hU.fromSpec y ∈ U := by
    change hU.fromSpec y ∈ (U : Set X)
    rw [← hU.range_fromSpec]
    exact ⟨y, rfl⟩
  let x : ChartClosedPoint U := ⟨⟨hU.fromSpec y, hclosed⟩, hmem⟩
  refine ⟨x, ?_⟩
  apply HeightOneSpectrum.ext
  change (hU.primeIdealOf ⟨hU.fromSpec y, hmem⟩).asIdeal = v.asIdeal
  have hp := hU.fromSpec_primeIdealOf ⟨hU.fromSpec y, hmem⟩
  exact congrArg PrimeSpectrum.asIdeal (hU.fromSpec.isOpenEmbedding.injective hp)

/-- Literal original closed points in the chart and literal original
height-one prime ideals are genuinely equivalent, without a supplied
point enumeration or residue-field identification. -/
noncomputable def actualAffineChartClosedPointEquiv
    {X : Scheme.{u}} [JacobsonSpace X] {U : X.Opens} (hU : IsAffineOpen U)
    [IsDedekindDomain Γ(X, U)] (hfield : ¬IsField Γ(X, U)) :
    ChartClosedPoint U ≃ HeightOneSpectrum Γ(X, U) :=
  Equiv.ofBijective (chartHeightOne hU hfield)
    ⟨chart_height_one_injective hU hfield, chart_height_one_surjective hU hfield⟩

/-- For actual smooth curves both original Dedekindness and the non-field
condition are DERIVED; the full point/prime equivalence has no chart
normality, DVR, residue or prime-correspondence hypotheses. -/
noncomputable def actualSmoothCurveAffineClosedPointEquiv
    {k : Type u} [Field k] [IsAlgClosed k]
    {X : Scheme.{u}} [IsIntegral X]
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
    (U : X.Opens) (hU : IsAffineOpen U) [Nonempty U] :
    ChartClosedPoint U ≃ HeightOneSpectrum Γ(X, U) := by
  letI : IsSmooth sX := IsSmoothOfRelativeDimension.isSmooth 1 sX
  letI : JacobsonSpace X := LocallyOfFiniteType.jacobsonSpace sX
  letI : IsDedekindDomain Γ(X, U) :=
    Litt3.QuotientGeometry.actual_smooth_curve_affine_chart_dedekind sX U hU
  exact actualAffineChartClosedPointEquiv hU
    (Litt3.SharedTensors.actual_smooth_curve_affine_chart_not_isField sX U hU)

end Litt3.Jacobians

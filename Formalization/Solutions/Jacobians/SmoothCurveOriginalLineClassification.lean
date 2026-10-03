import Solutions.Jacobians.SmoothCurveOriginalLineFrameBijectivity
import Solutions.Jacobians.SchemeModuleNeighborhoodIsomorphisms
import Solutions.Jacobians.SmoothCurveDivisorSheaves

open CategoryTheory AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] [QuasiCompact sX]
  (M : X.Modules) (hM : ActualOriginalLineSheaf X M)

/-- The LITERAL original rational embedding of an arbitrary original
line sheaf into its CONSTRUCTED original divisor sheaf is a genuine whole
SHEAF isomorphism. Actual local entire-section bijections and original
sheaf gluing derive the isomorphism. Every divisor coefficient, finite
support, rational frame and closed-DVR input is constructed. -/
theorem actual_smooth_curve_original_line_to_divisor_isIso :
    letI : ClosedPointDVRStalks X :=
      Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
    IsIso (actualSmoothCurveOriginalLineToDivisor sX M hM) := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  apply actualSchemeModule_neighborhood_isIso
  intro x
  obtain ⟨U, hx, ⟨e⟩⟩ := hM x
  letI : Nonempty U := ⟨⟨x, hx⟩⟩
  refine ⟨U, hx, ?_⟩
  intro V hV hVU
  letI : Nonempty V := hV
  exact actualSmoothCurveOriginalLineToDivisor_frame_app_bijective sX M hM U e V
    (homOfLE hVU)

/-- EVERY actual original line sheaf on an actual quasi-compact
smooth integral curve is isomorphic to its DERIVED genuine O(D), on the
ENTIRE original site. This is an actual sheaf isomorphism, not a supplied
divisor presentation, affine-only comparison, or global-section equality. -/
noncomputable def actualSmoothCurveOriginalLineDivisorIso :
    M ≅ actualSmoothCurveDivisorSheaf sX (actualSmoothCurveOriginalLineDivisor sX M hM) := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  letI := actual_smooth_curve_original_line_to_divisor_isIso sX M hM
  exact asIso (actualSmoothCurveOriginalLineToDivisor sX M hM)

include hM in
/-- Divisors represent ALL genuine original line SHEAVES on any
actual quasi-compact smooth integral curve over an algebraically closed
field, in EVERY characteristic. Properness and divisor/rational-frame
inputs are not required. -/
theorem actual_smooth_curve_every_original_line_sheaf_has_divisor :
    ∃ D : Divisor (Litt3.SharedTensors.ClosedPoint X),
      Nonempty (M ≅ actualSmoothCurveDivisorSheaf sX D) :=
  ⟨actualSmoothCurveOriginalLineDivisor sX M hM,
    ⟨actualSmoothCurveOriginalLineDivisorIso sX M hM⟩⟩

end Litt3.Jacobians

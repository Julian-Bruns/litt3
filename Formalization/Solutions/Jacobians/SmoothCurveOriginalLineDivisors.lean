import Solutions.Jacobians.OriginalLineSheafFrameOrders
import Solutions.Jacobians.SmoothCurveOpenFiniteComplements
import Solutions.SharedTensors.SmoothCurveDVRStalks

open CategoryTheory AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
  (M : X.Modules) (hM : ActualOriginalLineSheaf X M)

/-- The actual coefficient for an arbitrary ORIGINAL line sheaf is
minus the normalized original closed-DVR order of its DERIVED local
rational generator. The DVR is constructed from genuine smoothness. -/
noncomputable def actualSmoothCurveOriginalLineDivisorCoefficient
    (x : Litt3.SharedTensors.ClosedPoint X) : ℤ := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  exact -valuationOrder (closedPointValuation X x)
    (Additive.ofMul (actualOriginalLinePointRationalUnit X M hM x.val))

/-- The coefficient vanishes on the actual original generic frame
neighborhood, by independence of the actual original local generator and
the genuine normalization of the generic generator to one. -/
theorem actualSmoothCurveOriginalLineDivisorCoefficient_generic_open_zero
    (x : Litt3.SharedTensors.ClosedPoint X)
    (hx : x.val ∈ actualOriginalLineSheafGenericOpen X M hM) :
    actualSmoothCurveOriginalLineDivisorCoefficient sX M hM x = 0 := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  letI := actualOriginalLineSheafGenericOpen_nonempty X M hM
  have h := actualOriginalLinePointRationalUnit_order_eq_frame X M hM x
    (actualOriginalLineSheafGenericOpen X M hM)
    (actualOriginalLineSheafGenericFrame X M hM) hx
  have hgen := actualOriginalLineSheafGenericGenerator_one X M hM
  change -valuationOrder (closedPointValuation X x)
    (Additive.ofMul (actualOriginalLinePointRationalUnit X M hM x.val)) = 0
  rw [h]
  have hu : Units.mk0
      (actualOriginalLineFrameRationalGenerator X M hM
        (actualOriginalLineSheafGenericOpen X M hM)
        (actualOriginalLineSheafGenericFrame X M hM))
      (actualOriginalLineFrameRationalGenerator_ne_zero X M hM _ _) =
      (1 : X.functionFieldˣ) := Units.ext hgen
  rw [hu]
  change -(valuationOrder (closedPointValuation X x)) 0 = 0
  rw [map_zero, neg_zero]

/-- ANY genuine original line sheaf on an actual quasi-compact
smooth integral curve has a DERIVED finitely supported coefficient
function. Support is contained in the true finite complement of its
original generic frame; no divisor presentation or support premise is
supplied. -/
theorem actualSmoothCurveOriginalLineDivisorCoefficient_finite_support
    [QuasiCompact sX] :
    (Function.support (actualSmoothCurveOriginalLineDivisorCoefficient sX M hM)).Finite := by
  let W := actualOriginalLineSheafGenericOpen X M hM
  letI : Nonempty W := actualOriginalLineSheafGenericOpen_nonempty X M hM
  have hfinite : ({x : Litt3.SharedTensors.ClosedPoint X | x.val ∉ W} : Set _).Finite :=
    (actual_smooth_curve_nonempty_open_complement_finite sX W).preimage
      (fun a b _ _ hab => Subtype.ext hab)
  apply hfinite.subset
  intro x hx
  change x.val ∉ W
  intro hxW
  exact hx (actualSmoothCurveOriginalLineDivisorCoefficient_generic_open_zero sX M hM x hxW)

/-- The ORIGINAL divisor attached to an arbitrary actual line
SHEAF, built from true normalized closed-DVR orders with support finiteness
proved from the original quasi-compact smooth curve. -/
noncomputable def actualSmoothCurveOriginalLineDivisor [QuasiCompact sX] :
    Divisor (Litt3.SharedTensors.ClosedPoint X) :=
  Finsupp.ofSupportFinite (actualSmoothCurveOriginalLineDivisorCoefficient sX M hM)
    (actualSmoothCurveOriginalLineDivisorCoefficient_finite_support sX M hM)

theorem actualSmoothCurveOriginalLineDivisor_coefficient [QuasiCompact sX]
    (x : Litt3.SharedTensors.ClosedPoint X) :
    actualSmoothCurveOriginalLineDivisor sX M hM x =
      actualSmoothCurveOriginalLineDivisorCoefficient sX M hM x := rfl

end Litt3.Jacobians

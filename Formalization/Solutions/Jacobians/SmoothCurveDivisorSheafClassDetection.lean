import Solutions.Jacobians.AffineDivisorIsoScalarOrders
import Solutions.Jacobians.SmoothCurvePrincipalDivisorSheaves
import Solutions.Jacobians.ValuationDivisorClasses

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.Jacobians

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]

/-- An actual original divisor-sheaf isomorphism determines ONE
original rational unit whose original closed-stalk orders are D−E.
No quasi-compactness, Picard identification or local multiplier is assumed. -/
theorem actual_smooth_curve_divisor_sheaf_iso_orders
    (D E : Divisor (Litt3.SharedTensors.ClosedPoint X))
    (e : actualSmoothCurveDivisorSheaf sX D ≅ actualSmoothCurveDivisorSheaf sX E) :
    ∃ f : X.functionFieldˣ, ∀ x : Litt3.SharedTensors.ClosedPoint X,
      letI : ClosedPointDVRStalks X :=
        Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
      valuationOrder (closedPointValuation X x) (Additive.ofMul f) = D x - E x := by
  letI : IsSmooth sX := IsSmoothOfRelativeDimension.isSmooth 1 sX
  letI : JacobsonSpace X := LocallyOfFiniteType.jacobsonSpace sX
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  refine ⟨actualDivisorSheafIsoRationalUnit X D E sX e, ?_⟩
  intro x
  obtain ⟨U, hU, hx, _⟩ := Litt3.SharedTensors.actual_smooth_point_chart sX 1 x.val
  letI : Nonempty U := ⟨⟨x.val, hx⟩⟩
  letI : IsDedekindDomain Γ(X, U) :=
    Litt3.QuotientGeometry.actual_smooth_curve_affine_chart_dedekind sX U hU
  exact actualAffineDivisorIsoScalar_order sX hU
    (Litt3.SharedTensors.actual_smooth_curve_affine_chart_not_isField sX U hU)
    D E e ⟨x, hx⟩

variable [QuasiCompact sX]

/-- TRUE global divisor SHEAVES are isomorphic precisely when
their ORIGINAL divisor difference is an actual ORIGINAL principal divisor.
Every DVR, support, scalar and original restriction compatibility is derived. -/
theorem actual_smooth_curve_divisor_sheaves_iso_iff_principal_difference
    (D E : Divisor (Litt3.SharedTensors.ClosedPoint X)) :
    Nonempty (actualSmoothCurveDivisorSheaf sX D ≅ actualSmoothCurveDivisorSheaf sX E) ↔
      ∃ f : X.functionFieldˣ, actualSmoothCurvePrincipalDivisor sX f = D - E := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  letI : FinitePrincipalSupport X :=
    Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sX
  constructor
  · rintro ⟨e⟩
    obtain ⟨f, hf⟩ := actual_smooth_curve_divisor_sheaf_iso_orders sX D E e
    refine ⟨f, ?_⟩
    ext x
    exact hf x
  · rintro ⟨f, hf⟩
    have he : D - actualSmoothCurvePrincipalDivisor sX f = E := by
      rw [hf]
      ext x
      simp only [Finsupp.sub_apply]
      omega
    exact ⟨by simpa only [he] using actualSmoothCurvePrincipalDivisorSheafShiftIso sX D f⟩

/-- The ACTUAL original divisor-class quotient detects exactly the
isomorphism classes of ACTUAL original divisor SHEAVES. This proves
faithfulness for these true sheaves; classification of all line SHEAVES
or representability by a Picard/Jacobian scheme is a distinct obligation. -/
theorem actual_smooth_curve_divisor_class_eq_iff_sheaves_iso
    (D E : Divisor (Litt3.SharedTensors.ClosedPoint X)) :
    letI : ClosedPointDVRStalks X :=
      Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
    letI : FinitePrincipalSupport X :=
      Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sX
    divisorClassMap (schemeDivisorSystem X) D = divisorClassMap (schemeDivisorSystem X) E ↔
      Nonempty (actualSmoothCurveDivisorSheaf sX D ≅ actualSmoothCurveDivisorSheaf sX E) := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  letI : FinitePrincipalSupport X :=
    Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sX
  rw [← sub_eq_zero, ← map_sub, divisor_class_zero_iff_principal]
  constructor
  · rintro ⟨f, hf⟩
    exact (actual_smooth_curve_divisor_sheaves_iso_iff_principal_difference sX D E).mpr
      ⟨f.toMul, hf⟩
  · intro he
    obtain ⟨f, hf⟩ :=
      (actual_smooth_curve_divisor_sheaves_iso_iff_principal_difference sX D E).mp he
    exact ⟨Additive.ofMul f, hf⟩

end Litt3.Jacobians

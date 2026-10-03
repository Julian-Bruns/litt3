import Solutions.QuotientGeometry.SmoothCurveAffineNormality
import Solutions.QuotientGeometry.FiniteAffineChartAlgebras
import Solutions.QuotientGeometry.FunctionFieldChartTowers
import Solutions.QuotientGeometry.NormalIntegralAffineNormalization

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
  (f : X ⟶ Y) [IsFinite f] [Surjective f]
  (U : Y.Opens) (hU : IsAffineOpen U) [Nonempty U] [Nonempty (f ⁻¹ᵁ U)]

include sX hU

/-- The ORIGINAL inverse-image coordinate ring of a finite morphism
from an actual integral smooth curve is the integral closure of the
original base-chart ring inside the true source function field.
No normalization presentation, normality or chart integrality is supplied. -/
theorem actual_finite_smooth_chart_isIntegralClosure :
    letI := (f.app U).hom.toAlgebra
    letI : Algebra Γ(Y, U) X.functionField :=
      ((Litt3.SharedTensors.schemeFunctionFieldPullback f).comp
        (algebraMap Γ(Y, U) Y.functionField)).toAlgebra
    IsIntegralClosure Γ(X, f ⁻¹ᵁ U) Γ(Y, U) X.functionField := by
  letI := (f.app U).hom.toAlgebra
  letI := (Litt3.SharedTensors.schemeFunctionFieldPullback f).toAlgebra
  letI : Algebra Γ(Y, U) X.functionField :=
    ((Litt3.SharedTensors.schemeFunctionFieldPullback f).comp
      (algebraMap Γ(Y, U) Y.functionField)).toAlgebra
  let hR := hU.preimage f
  letI : IsFractionRing Γ(X, f ⁻¹ᵁ U) X.functionField :=
    functionField_isFractionRing_of_isAffineOpen X (f ⁻¹ᵁ U) hR
  letI : IsScalarTower Γ(Y, U) Γ(X, f ⁻¹ᵁ U) X.functionField :=
    actual_function_field_chart_scalar_tower f U
  letI : IsIntegrallyClosed Γ(X, f ⁻¹ᵁ U) :=
    actual_smooth_curve_affine_chart_isIntegrallyClosed sX (f ⁻¹ᵁ U) hR
  letI : Algebra.IsIntegral Γ(Y, U) Γ(X, f ⁻¹ᵁ U) :=
    actual_finite_map_affine_chart_integral f U hU
  infer_instance

/-- The actual affine coordinate-ring normalization equivalence
uses the original chart pullback and true generic-stalk function field. -/
noncomputable def actualFiniteSmoothChartNormalizationEquiv :
    letI := (f.app U).hom.toAlgebra
    letI : Algebra Γ(Y, U) X.functionField :=
      ((Litt3.SharedTensors.schemeFunctionFieldPullback f).comp
        (algebraMap Γ(Y, U) Y.functionField)).toAlgebra
    Γ(X, f ⁻¹ᵁ U) ≃ₐ[Γ(Y, U)] integralClosure Γ(Y, U) X.functionField := by
  letI := (f.app U).hom.toAlgebra
  letI := (Litt3.SharedTensors.schemeFunctionFieldPullback f).toAlgebra
  letI : Algebra Γ(Y, U) X.functionField :=
    ((Litt3.SharedTensors.schemeFunctionFieldPullback f).comp
      (algebraMap Γ(Y, U) Y.functionField)).toAlgebra
  letI : IsIntegralClosure Γ(X, f ⁻¹ᵁ U) Γ(Y, U) X.functionField :=
    actual_finite_smooth_chart_isIntegralClosure sX f U hU
  letI : IsScalarTower Γ(Y, U) Γ(X, f ⁻¹ᵁ U) X.functionField :=
    actual_function_field_chart_scalar_tower f U
  exact IsIntegralClosure.equiv Γ(Y, U) Γ(X, f ⁻¹ᵁ U) X.functionField
    (integralClosure Γ(Y, U) X.functionField)

omit sX in
/-- The genuine chart map commutes with the ORIGINAL finite map
into the original base curve, not merely with an abstract ring model. -/
theorem actual_finite_original_affine_chart_square :
    Spec.map (f.app U) ≫ hU.fromSpec = (hU.preimage f).fromSpec ≫ f := by
  simpa only [Scheme.Hom.app_eq_appLE] using
    IsAffineOpen.SpecMap_appLE_fromSpec f hU (hU.preimage f) le_rfl

end Litt3.QuotientGeometry

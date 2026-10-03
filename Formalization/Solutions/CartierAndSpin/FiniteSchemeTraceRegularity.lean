import Solutions.CartierAndSpin.IntegralSchemeOpenFunctions
import Solutions.CartierAndSpin.FiniteAlgebraFractionTraceIntegrality
import Solutions.QuotientGeometry.FiniteSchemeFunctionFields
import Solutions.QuotientGeometry.SmoothCurveAffineNormality

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.CartierAndSpin

universe u

/-- An actual finite surjective map preserves regularity under its
literal original function-field trace on every normal affine chart.
Regularity upstairs is tested on ALL original stalks of the full
inverse image. The finite chart algebra and field degree are derived. -/
theorem actual_finite_map_trace_regular_on_normal_affine
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (f : X ⟶ Y) [IsFinite f] [Surjective f]
    (U : Y.Opens) (hU : IsAffineOpen U) [Nonempty U]
    [IsIntegrallyClosed Γ(Y, U)] (x : X.functionField) :
    letI := (Litt3.SharedTensors.schemeFunctionFieldPullback f).toAlgebra
    (∀ p : (f ⁻¹ᵁ U), ∃ r : X.presheaf.stalk p,
      algebraMap (X.presheaf.stalk p) X.functionField r = x) →
    ∃ a : Γ(Y, U), algebraMap Γ(Y, U) Y.functionField a =
      Algebra.trace Y.functionField X.functionField x := by
  letI := (Litt3.SharedTensors.schemeFunctionFieldPullback f).toAlgebra
  letI : Nonempty (f ⁻¹ᵁ U) := ⟨⟨genericPoint X, by
    change f (genericPoint X) ∈ U
    rw [Litt3.SharedTensors.scheme_genericPoint_eq_of_surjective f]
    exact ((genericPoint_spec Y).mem_open_set_iff U.isOpen).mpr
      (by simpa using ‹Nonempty U›)⟩⟩
  let R := Γ(Y, U)
  let A := Γ(X, f ⁻¹ᵁ U)
  letI : Algebra R A := (f.app U).hom.toAlgebra
  letI : Algebra R X.functionField :=
    ((Litt3.SharedTensors.schemeFunctionFieldPullback f).comp
      (algebraMap R Y.functionField)).toAlgebra
  letI : IsScalarTower R Y.functionField X.functionField :=
    IsScalarTower.of_algebraMap_eq' rfl
  letI : IsScalarTower R A X.functionField :=
    Litt3.QuotientGeometry.actual_function_field_chart_scalar_tower f U
  letI : IsFractionRing R Y.functionField :=
    functionField_isFractionRing_of_isAffineOpen Y U hU
  letI : Module.Finite R A :=
    Litt3.QuotientGeometry.actual_finite_map_affine_chart_module f U hU
  letI : FiniteDimensional Y.functionField X.functionField :=
    Litt3.QuotientGeometry.actual_finite_scheme_function_field_extension f
  intro hregular
  obtain ⟨a, ha⟩ := (actual_function_field_regular_on_open_iff_section
    (f ⁻¹ᵁ U) x).mp hregular
  have h := finite_algebra_fraction_field_trace_descends (K := Y.functionField)
    (IsScalarTower.toAlgHom R A X.functionField) a
  change ∃ r : R, algebraMap R Y.functionField r =
    Algebra.trace Y.functionField X.functionField (algebraMap A X.functionField a) at h
  rwa [ha] at h

/-- A genuine smooth integral base curve supplies the normal chart
condition. No normality, affine normalization, field degree, splitting
or trace-regularity hypothesis is supplied. The source need only be
integral and the actual morphism finite and surjective. -/
theorem actual_finite_smooth_curve_trace_regular_on_affine
    {k : Type u} [Field k] [IsAlgClosed k]
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY]
    (f : X ⟶ Y) [IsFinite f] [Surjective f]
    (U : Y.Opens) (hU : IsAffineOpen U) [Nonempty U]
    (x : X.functionField) :
    letI := (Litt3.SharedTensors.schemeFunctionFieldPullback f).toAlgebra
    (∀ p : (f ⁻¹ᵁ U), ∃ r : X.presheaf.stalk p,
      algebraMap (X.presheaf.stalk p) X.functionField r = x) →
    ∃ a : Γ(Y, U), algebraMap Γ(Y, U) Y.functionField a =
      Algebra.trace Y.functionField X.functionField x := by
  letI : IsIntegrallyClosed Γ(Y, U) :=
    Litt3.QuotientGeometry.actual_smooth_curve_affine_chart_isIntegrallyClosed sY U hU
  exact actual_finite_map_trace_regular_on_normal_affine f U hU x

end Litt3.CartierAndSpin

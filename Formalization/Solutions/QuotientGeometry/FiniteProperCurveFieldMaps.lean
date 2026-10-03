import Solutions.QuotientGeometry.ProperSmoothCurveFiniteMaps

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

open Litt3.SharedTensors

universe u

/-- A genuine finite separating constant-field embedding between the
ORIGINAL proper smooth curve generic stalks is realized by an ACTUAL
finite surjective morphism preserving its exact original base diagram
and exact original generic-stalk pullback. All original valuation stalks,
extension everywhere and finiteness are DERIVED. -/
theorem actual_finite_proper_smooth_curve_field_embedding_realized
    {k : Type u} [Field k] [IsAlgClosed k]
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (sX : X ⟶ Spec (.of k)) (sY : Y ⟶ Spec (.of k))
    [IsSmoothOfRelativeDimension 1 sX] [IsSmoothOfRelativeDimension 1 sY]
    [IsProper sX] [IsProper sY] :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    ∀ φ : Y.functionField →ₐ[k] X.functionField,
      letI := φ.toRingHom.toAlgebra
      FiniteDimensional Y.functionField X.functionField →
      Algebra.IsSeparable Y.functionField X.functionField →
      ∃ (f : X ⟶ Y) (_ : Surjective f), f ≫ sY = sX ∧ IsFinite f ∧
        schemeFunctionFieldPullback f = φ.toRingHom := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (genericBaseFieldHom sY).toAlgebra
  intro φ
  letI := φ.toRingHom.toAlgebra
  intro hfinite hseparable
  obtain ⟨f, hsurj, hbase, hproper, hfield⟩ :=
    actual_proper_smooth_curve_field_embedding_realized sX sY φ
  letI : Surjective f := hsurj
  letI : IsProper f := hproper
  have hfinitef : letI := (schemeFunctionFieldPullback f).toAlgebra;
      FiniteDimensional Y.functionField X.functionField := by
    simpa only [hfield] using hfinite
  have hseparablef : letI := (schemeFunctionFieldPullback f).toAlgebra;
      Algebra.IsSeparable Y.functionField X.functionField := by
    simpa only [hfield] using hseparable
  exact ⟨f, hsurj, hbase,
    actual_proper_smooth_curve_map_finite sX sY f hfinitef hseparablef, hfield⟩

end Litt3.QuotientGeometry

import Solutions.QuotientGeometry.AffineChartFields
import Mathlib.AlgebraicGeometry.Morphisms.Finite

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

/-- A finite original scheme morphism gives the genuine finite module
of coordinate rings on a full inverse image of an affine chart. -/
theorem actual_finite_map_affine_chart_module
    {X Y : Scheme.{u}} (f : X ⟶ Y) [IsFinite f]
    (U : Y.Opens) (hU : IsAffineOpen U) :
    letI := (f.app U).hom.toAlgebra
    Module.Finite Γ(Y, U) Γ(X, f ⁻¹ᵁ U) := by
  letI := (f.app U).hom.toAlgebra
  exact RingHom.finite_algebraMap.mp (IsFinite.finite_app U hU)

/-- Integrality of the original chart pullback is derived from the
actual finite morphism, rather than posited as normalization data. -/
theorem actual_finite_map_affine_chart_integral
    {X Y : Scheme.{u}} (f : X ⟶ Y) [IsFinite f]
    (U : Y.Opens) (hU : IsAffineOpen U) :
    letI := (f.app U).hom.toAlgebra
    Algebra.IsIntegral Γ(Y, U) Γ(X, f ⁻¹ᵁ U) := by
  letI := (f.app U).hom.toAlgebra
  letI : Module.Finite Γ(Y, U) Γ(X, f ⁻¹ᵁ U) :=
    actual_finite_map_affine_chart_module f U hU
  infer_instance

end Litt3.QuotientGeometry

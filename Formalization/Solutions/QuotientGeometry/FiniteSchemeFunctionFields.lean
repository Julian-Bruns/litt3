import Solutions.CurveArithmetic.FiniteIntegralFractionExtensions
import Solutions.QuotientGeometry.FiniteAffineChartAlgebras
import Solutions.QuotientGeometry.FunctionFieldChartTowers

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.QuotientGeometry

universe u

/-- An actual finite surjective morphism of arbitrary integral
schemes gives a finite extension through its TRUE original generic
stalk pullback. No smoothness, coefficient field, finite-type base
or supplied function-field degree hypothesis is needed. -/
theorem actual_finite_scheme_function_field_extension
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (f : X ⟶ Y) [IsFinite f] [Surjective f] :
    letI := (Litt3.SharedTensors.schemeFunctionFieldPullback f).toAlgebra
    FiniteDimensional Y.functionField X.functionField := by
  letI := (Litt3.SharedTensors.schemeFunctionFieldPullback f).toAlgebra
  obtain ⟨U, hU, hxU, _⟩ := exists_isAffineOpen_mem_and_subset
    (show genericPoint Y ∈ (⊤ : Y.Opens) from trivial)
  letI : Nonempty U := ⟨⟨genericPoint Y, hxU⟩⟩
  letI : Nonempty (f ⁻¹ᵁ U) := ⟨⟨genericPoint X, by
    change f (genericPoint X) ∈ U
    rw [Litt3.SharedTensors.scheme_genericPoint_eq_of_surjective f]
    exact hxU⟩⟩
  let A := Γ(Y, U)
  let R := Γ(X, f ⁻¹ᵁ U)
  letI : Algebra A R := (f.app U).hom.toAlgebra
  letI : Algebra A X.functionField :=
    ((Litt3.SharedTensors.schemeFunctionFieldPullback f).comp
      (algebraMap A Y.functionField)).toAlgebra
  letI : IsScalarTower A Y.functionField X.functionField :=
    IsScalarTower.of_algebraMap_eq' rfl
  letI : IsScalarTower A R X.functionField := actual_function_field_chart_scalar_tower f U
  letI : IsFractionRing R X.functionField :=
    functionField_isFractionRing_of_isAffineOpen X (f ⁻¹ᵁ U) (hU.preimage f)
  letI : Module.Finite A R := actual_finite_map_affine_chart_module f U hU
  letI : Algebra.IsIntegral A R := actual_finite_map_affine_chart_integral f U hU
  exact Litt3.CurveArithmetic.actual_integral_finite_type_fraction_extension_finite
    (A := A) (R := R)

end Litt3.QuotientGeometry

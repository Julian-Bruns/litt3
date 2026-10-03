import Solutions.SharedTensors.FiniteTypeFractionFieldGeneration
import Solutions.SharedTensors.SeparatingTranscendenceDifferentials
import Solutions.SharedTensors.SmoothSchemeDifferentials
import Solutions.QuotientGeometry.AffineChartFiniteType

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.SharedTensors

open Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] {X : Scheme.{u}} [IsIntegral X]

/-- Finite generation of the ORIGINAL scheme function field follows
from any actual locally finite-type structure morphism. No supplied chart
or function-field presentation is required. -/
theorem actual_locally_finite_type_function_field_finitely_generated
    (sX : X ⟶ Spec (.of k)) [LocallyOfFiniteType sX] :
    letI := (genericBaseFieldHom sX).toAlgebra
    IntermediateField.FG (F := k) (E := X.functionField) ⊤ := by
  letI := (genericBaseFieldHom sX).toAlgebra
  obtain ⟨U, hU, hx, _⟩ := exists_isAffineOpen_mem_and_subset
    (X := X) (x := genericPoint X) (U := ⊤) trivial
  letI : Nonempty U := ⟨⟨genericPoint X, hx⟩⟩
  letI : Algebra k Γ(X, U) := (chartBaseFieldHom sX U).toAlgebra
  letI : IsScalarTower k Γ(X, U) X.functionField :=
    IsScalarTower.of_algebraMap_eq' (chart_base_field_hom_generic_compatibility sX U).symm
  letI : IsFractionRing Γ(X, U) X.functionField :=
    functionField_isFractionRing_of_isAffineOpen X U hU
  letI : Algebra.FiniteType k Γ(X, U) := actual_affine_chart_finiteType sX U hU
  exact actual_finite_type_fraction_field_finitely_generated (R := Γ(X, U))

/-- The genuine generic field of an actual integral smooth scheme has
transcendence degree equal to the actual relative dimension. Perfectness
supplies a separating transcendence basis; no degree hypothesis is input. -/
theorem actual_smooth_function_field_transcendence_degree [PerfectField k]
    (sX : X ⟶ Spec (.of k)) (n : ℕ) [IsSmoothOfRelativeDimension n sX] :
    letI := (genericBaseFieldHom sX).toAlgebra
    Algebra.trdeg k X.functionField = n := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI : IsSmooth sX := IsSmoothOfRelativeDimension.isSmooth n sX
  rw [← actual_finitely_generated_kaehler_rank_eq_trdeg
    (actual_locally_finite_type_function_field_finitely_generated sX)]
  exact actual_smooth_function_field_kaehler_rank sX n

end Litt3.SharedTensors

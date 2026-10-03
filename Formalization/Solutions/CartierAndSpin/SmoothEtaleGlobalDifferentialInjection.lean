import Solutions.CartierAndSpin.SmoothEtaleGlobalDifferentialPullbacks
import Solutions.CartierAndSpin.LogarithmicDifferentialPullbacks
import Solutions.SharedTensors.SchemeFunctionFieldGeneration

set_option maxHeartbeats 1000000
set_option synthInstance.maxHeartbeats 100000

open CategoryTheory AlgebraicGeometry

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
  (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY]
  (f : X ⟶ Y) [IsFinite f] [IsEtale f] [Surjective f]
  (hover : f ≫ sY = sX)

noncomputable local instance globalInjectionTargetTopNonempty : Nonempty (⊤ : Y.Opens) :=
  ⟨⟨genericPoint Y, trivial⟩⟩

/-- The true global differential SHEAF pullback along an actual finite
étale surjection is injective. Actual field separability, rank-one
universal coordinates and generic H0 injection are derived. No
properness, characteristic, H0 finiteness or supplied coordinate is used. -/
theorem actualSmoothEtaleGlobalDifferentialPullback_injective :
    Function.Injective (actualSmoothEtaleGlobalDifferentialPullback sX sY f hover) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (genericBaseFieldHom sY).toAlgebra
  letI := (schemeFunctionFieldPullback f).toAlgebra
  letI := actualFunctionFieldBaseTower f sY sX hover
  letI : IsSmooth sY := IsSmoothOfRelativeDimension.isSmooth 1 sY
  letI : Algebra.IsSeparable Y.functionField X.functionField :=
    (actual_unramified_function_field_finite_separable f).2
  obtain ⟨eY⟩ := one_variable_kaehler_coordinate_exists
    (actual_locally_finite_type_function_field_finitely_generated sY)
    (actual_smooth_function_field_transcendence_degree sY 1)
  intro a b h
  have hgeneric := congrArg (schemeDifferentialGlobalSectionsToFunctionField sX) h
  rw [actualSmoothEtaleGlobalDifferentialPullback_rational,
    actualSmoothEtaleGlobalDifferentialPullback_rational] at hgeneric
  apply schemeDifferentialSheafOpenToFunctionField_injective sY 1 ⊤
  exact (separable_universal_differential_map_injective (E := X.functionField) eY) hgeneric

end Litt3.CartierAndSpin

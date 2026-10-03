import Solutions.CartierAndSpin.AffineLineSquareSupport
import Solutions.SharedTensors.SchemeFunctionFieldGeneration

namespace Litt3.CartierAndSpin

open CategoryTheory AlgebraicGeometry
open Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {Z : Scheme.{u}} [IsIntegral Z]

/-- Weighted square pencils on the actual smooth curve have finite
support with the exact actual field-degree bound. Field finite generation
and transcendence degree are derived from the actual structure morphism. -/
theorem smooth_curve_weighted_square_pencil_finite
    (sZ : Z ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sZ] :
    letI := (genericBaseFieldHom sZ).toAlgebra
    ∀ (r g : Z.functionField) (hr : r ∉ Set.range (algebraMap k Z.functionField))
      (hg : g ≠ 0) (htwo : (2 : k) ≠ 0),
      let support : Set k := {theta | IsSquare (g * (r - algebraMap k Z.functionField theta))}
      support.Finite ∧ support.ncard ≤
        1 + (Module.finrank (IntermediateField.adjoin k {r}) Z.functionField).factorization 2 := by
  letI := (genericBaseFieldHom sZ).toAlgebra
  letI : IsSmooth sZ := IsSmoothOfRelativeDimension.isSmooth 1 sZ
  intro r g hr hg htwo
  exact one_variable_weighted_square_pencil_finite
    (Litt3.SharedTensors.actual_locally_finite_type_function_field_finitely_generated sZ)
    (Litt3.SharedTensors.actual_smooth_function_field_transcendence_degree sZ 1)
    r hr g hg htwo

/-- Every actual affine parameter line has finite weighted square
support on the same actual smooth curve, without an assumed function-field
model, derivation, Gauss field, degree parity or plane smoothness. -/
theorem smooth_curve_affine_line_weighted_square_support_bound
    (sZ : Z ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sZ] :
    letI := (genericBaseFieldHom sZ).toAlgebra
    ∀ (x H g : Z.functionField) (hx : x ∉ Set.range (algebraMap k Z.functionField))
      (hH : H ∉ IntermediateField.adjoin k {x}) (hg : g ≠ 0)
      (htwo : (2 : k) ≠ 0) (s0 r0 a b : k) (hdir : a ≠ 0 ∨ b ≠ 0),
      let support : Set k := {theta | IsSquare
        (g * (H + algebraMap k Z.functionField (s0 + theta * a) +
          algebraMap k Z.functionField (r0 + theta * b) * x))}
      support.Finite ∧ support.ncard ≤ 1 +
        (Module.finrank (IntermediateField.adjoin k
          {(H + algebraMap k Z.functionField s0 + algebraMap k Z.functionField r0 * x) /
            (algebraMap k Z.functionField a + algebraMap k Z.functionField b * x)})
          Z.functionField).factorization 2 := by
  letI := (genericBaseFieldHom sZ).toAlgebra
  letI : IsSmooth sZ := IsSmoothOfRelativeDimension.isSmooth 1 sZ
  intro x H g hx hH hg htwo s0 r0 a b hdir
  exact affine_line_weighted_square_support_bound
    (Litt3.SharedTensors.actual_locally_finite_type_function_field_finitely_generated sZ)
    (Litt3.SharedTensors.actual_smooth_function_field_transcendence_degree sZ 1)
    x H g hx hH hg htwo s0 r0 a b hdir

end Litt3.CartierAndSpin

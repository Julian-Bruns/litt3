import Solutions.Jacobians.SmoothCurvePrincipalOpenFrames
import Solutions.Jacobians.RationalFunctionOpenLinearEquivalence

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace

namespace Litt3.Jacobians

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] [QuasiCompact sX]
  (D : Divisor (Litt3.SharedTensors.ClosedPoint X)) (a : X.functionFieldˣ)
  (U : X.Opens)
  (h : ∀ z : Litt3.SharedTensors.ClosedPoint X, z.val ∈ U →
    (D - actualSmoothCurvePrincipalDivisor sX a) z = 0)
  (V : X.Opens) [Nonempty V] (i : V ⟶ U)

/-- The ENTIRE original rational value of a genuine inverse
principal frame is its literal original inverse multiplier times the
actual original section-ring value. -/
theorem actualSmoothCurvePrincipalOpenFrameIso_symm_field_value (r : Γ(X, V)) :
    actualRationalFunctionOpenLinearEquiv X V
      ((actualOriginalLineFrameSectionEquiv X (actualSmoothCurveDivisorSheaf sX D) U
        (actualSmoothCurvePrincipalOpenFrameIso sX D a U h) V i).symm r).val =
      a⁻¹.val * algebraMap Γ(X, V) X.functionField r := by
  rw [actualSmoothCurvePrincipalOpenFrameIso_symm_value]
  let x : V := Classical.arbitrary V
  have he : actualRationalFunctionEvaluation X V x.val x.property
      (actualRationalFunctionScalar X a⁻¹.val (op V) *
        (actualSchemeStructureToRationalFunctions X).val.app (op V) r) =
      a⁻¹.val * algebraMap Γ(X, V) X.functionField r := by
    rw [map_mul, actualRationalFunctionScalar_evaluation,
      actualRationalFunctionEvaluation_eq_open]
    exact congrArg (fun z => a⁻¹.val * z) (CategoryTheory.congr_fun
      (actualSchemeStructureToRationalFunctions_open X V) r)
  rw [actualRationalFunctionEvaluation_eq_open] at he
  exact he

/-- Every actual principal frame's true original unit generator
has exactly the inverse ORIGINAL rational multiplier as its full value. -/
theorem actualSmoothCurvePrincipalOpenFrameIso_generator_field_value :
    actualRationalFunctionOpenLinearEquiv X V
      ((actualOriginalLineFrameSectionEquiv X (actualSmoothCurveDivisorSheaf sX D) U
        (actualSmoothCurvePrincipalOpenFrameIso sX D a U h) V i).symm (1 : Γ(X, V))).val =
      a⁻¹.val := by
  rw [actualSmoothCurvePrincipalOpenFrameIso_symm_field_value, map_one, mul_one]

end Litt3.Jacobians

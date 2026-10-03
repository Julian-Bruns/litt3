import Definitions.SharedTensors.SchemeFunctionFields

open CategoryTheory AlgebraicGeometry

namespace Litt3.SharedTensors

universe u

theorem schemeFunctionFieldPullback_injective
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (f : X ⟶ Y) [Surjective f] :
    Function.Injective (schemeFunctionFieldPullback f) :=
  (schemeFunctionFieldPullback f).injective

theorem span_retains_both_actual_function_fields
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (s : FiniteEtaleSpan X Y) [IsIntegral s.source] :
    Function.Injective s.leftFunctionField ∧ Function.Injective s.rightFunctionField :=
  ⟨schemeFunctionFieldPullback_injective s.left,
    schemeFunctionFieldPullback_injective s.right⟩

end Litt3.SharedTensors

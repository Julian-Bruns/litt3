import Definitions.SharedTensors.EtaleSpans
import Mathlib.AlgebraicGeometry.FunctionField

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.SharedTensors

universe u

variable {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]

/-- A surjective actual scheme map sends the actual generic point to
the generic point. No simultaneous Galois closure is introduced. -/
theorem scheme_genericPoint_eq_of_surjective (f : X ⟶ Y) [Surjective f] :
    f (genericPoint X) = genericPoint Y := by
  symm
  apply (genericPoint_spec Y).eq
  convert (genericPoint_spec X).image f.continuous using 1
  simp only [Set.image_univ, f.surjective.range_eq, closure_univ]

/-- The pullback of function fields is the actual map of generic stalks. -/
noncomputable def schemeFunctionFieldPullback (f : X ⟶ Y) [Surjective f] :
    Y.functionField →+* X.functionField :=
  ((Y.presheaf.stalkCongr (.of_eq (scheme_genericPoint_eq_of_surjective f))).inv ≫
    f.stalkMap (genericPoint X)).hom

namespace FiniteEtaleSpan

variable (s : FiniteEtaleSpan X Y) [IsIntegral s.source]

/-- Both endpoint fields are embedded through the original two maps
inside the ONE actual source function field. -/
noncomputable def leftFunctionField : X.functionField →+* s.source.functionField :=
  schemeFunctionFieldPullback s.left

noncomputable def rightFunctionField : Y.functionField →+* s.source.functionField :=
  schemeFunctionFieldPullback s.right

end FiniteEtaleSpan
end Litt3.SharedTensors

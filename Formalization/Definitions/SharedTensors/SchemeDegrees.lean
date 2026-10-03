import Definitions.SharedTensors.SchemeFunctionFields
import Mathlib.LinearAlgebra.Dimension.Finrank

open CategoryTheory AlgebraicGeometry

namespace Litt3.SharedTensors
universe u

/-- The usual generic degree is computed through the actual generic-stalk
pullback. Its positivity and finiteness are separate proved properties. -/
noncomputable def schemeGenericDegree
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (f : X ⟶ Y) [Surjective f] : ℕ :=
  letI := (schemeFunctionFieldPullback f).toAlgebra
  Module.finrank Y.functionField X.functionField

end Litt3.SharedTensors

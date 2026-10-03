import Definitions.QuotientGeometry.OpenFunctionFields
import Definitions.SharedTensors.SchemeFunctionFields

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.QuotientGeometry

universe u

/-- The true generic-stalk pullback of ANY actual Scheme morphism
carrying the original generic point to the original generic point. -/
noncomputable def actualGenericFieldPullback
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (f : X ⟶ Y) (hgeneric : f (genericPoint X) = genericPoint Y) :
    Y.functionField →+* X.functionField :=
  ((Y.presheaf.stalkCongr (.of_eq hgeneric)).inv ≫
    f.stalkMap (genericPoint X)).hom

end Litt3.QuotientGeometry

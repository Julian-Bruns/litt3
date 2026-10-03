import Definitions.SharedTensors.MultiplicativeQuotients
import Definitions.SharedTensors.SchemeFunctionFields

open AlgebraicGeometry

namespace Litt3.SharedTensors

universe u

abbrev FiniteEtaleSpan.unitRelationQuotient
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (s : FiniteEtaleSpan X Y) [IsIntegral s.source] :=
  UnitRelationQuotient (schemeFunctionFieldPullback s.left) (schemeFunctionFieldPullback s.right)

end Litt3.SharedTensors

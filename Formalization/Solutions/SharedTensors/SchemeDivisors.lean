import Definitions.SharedTensors.SchemeDivisors
import Solutions.SharedTensors.DivisorRelations

open AlgebraicGeometry

namespace Litt3.SharedTensors

universe u

/-- The integral relation quotient for the two actual closed-point maps
is torsion-free, with no corelessness, characteristic, or genus restriction. -/
instance finiteEtaleSpan_divisorRelations_torsionFree
    {X Y : Scheme.{u}} (s : FiniteEtaleSpan X Y) :
    IsAddTorsionFree s.divisorRelations := inferInstance

end Litt3.SharedTensors

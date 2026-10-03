import Solutions.SharedTensors.SchemeClumps
import Solutions.SharedTensors.SchemeDivisorGluing
import Solutions.SharedTensors.FiberClumpSources

open AlgebraicGeometry

namespace Litt3.SharedTensors

universe u

variable {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  [Litt3.Jacobians.ClosedPointDVRStalks X] [Litt3.Jacobians.ClosedPointDVRStalks Y]
  [Litt3.Jacobians.FinitePrincipalSupport X] [Litt3.Jacobians.FinitePrincipalSupport Y]
  (s : FiniteEtaleSpan X Y) [IsIntegral s.source] [JacobsonSpace s.source]
  [Litt3.Jacobians.ClosedPointDVRStalks s.source]
  [Litt3.Jacobians.FinitePrincipalSupport s.source]

/-- In the actual no-clump scheme span, the actual divisor gluing classes
equal the actual multiplicative relation subgroup, by genuine exactness. -/
noncomputable def actual_same_source_no_clump_gluing_equiv_relations
    (hc : IsEmpty s.fiberClump) :
    s.divisorGluingSquare.GluingClasses ≃+ s.quotientPrincipalDivisorMap.ker :=
  DivisorGluingSquare.gluingRelationEquivOfNoInvariantDivisors _
    ((actual_same_source_no_clump_iff_invariant_divisors_zero s).mp hc)

end Litt3.SharedTensors

import Solutions.SharedTensors.UniqueClumpDivisors
import Solutions.SharedTensors.ClosedPointSurjectivity

open AlgebraicGeometry

namespace Litt3.SharedTensors

universe u

abbrev FiniteEtaleSpan.fiberClump {X Y : Scheme.{u}} (s : FiniteEtaleSpan X Y) :=
  FiberClump (mapClosedPoint s.left) (mapClosedPoint s.right)

theorem actual_same_source_no_clump_iff_invariant_divisors_zero
    {X Y : Scheme.{u}} (s : FiniteEtaleSpan X Y) [JacobsonSpace s.source] :
    IsEmpty s.fiberClump ↔ ∀ a : (divisorRelationMap
      (mapClosedPoint s.left) (mapClosedPoint s.right)
      (mapClosedPoint_finite_preimage s.left) (mapClosedPoint_finite_preimage s.right)).ker,
        a = 0 :=
  no_clump_iff_invariant_divisors_zero _ _ _ _
    (mapClosedPoint_surjective s.left) (mapClosedPoint_surjective s.right)

noncomputable def actual_same_source_unique_clump_invariant_divisors_equiv_int
    {X Y : Scheme.{u}} (s : FiniteEtaleSpan X Y) [JacobsonSpace s.source]
    (c : s.fiberClump)
    (hc : UniqueFiberClump (mapClosedPoint s.left) (mapClosedPoint s.right) c) :
    (divisorRelationMap (mapClosedPoint s.left) (mapClosedPoint s.right)
      (mapClosedPoint_finite_preimage s.left) (mapClosedPoint_finite_preimage s.right)).ker ≃+ ℤ :=
  c.invariantDivisorsEquivInt _ _ _ _
    (mapClosedPoint_surjective s.left) (mapClosedPoint_surjective s.right) hc

end Litt3.SharedTensors

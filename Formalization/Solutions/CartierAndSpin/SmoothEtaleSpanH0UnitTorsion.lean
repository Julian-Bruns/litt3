import Solutions.CartierAndSpin.SharedGlobalCartierFixedEquivalence
import Solutions.CartierAndSpin.UniqueClumpSharedDifferentialRegularity
import Solutions.CartierAndSpin.SmoothEtaleSpanUnitTorsion
import Solutions.CartierAndSpin.SharedGlobalCartierFixedCardinality

set_option maxHeartbeats 1000000
set_option synthInstance.maxHeartbeats 100000

open CategoryTheory AlgebraicGeometry

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry
open scoped Classical

universe u

variable {k : Type u} [Field k] [IsAlgClosed k] [PerfectField k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  (s : FiniteEtaleSpan X Y) [IsIntegral s.source]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] [IsProper sX]
  (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY] [IsProper sY]
  (hbase : s.right ≫ sY = s.left ≫ sX)
  {p : ℕ} [Fact p.Prime] [CharP k p]

/-- In the ORIGINAL SAME-source finite étale span, the actual unit
quotient p-kernel is canonically PRIME-LINEAR equivalent to the C=1
subgroup of the literal intersection of BOTH original differential
SHEAF H0 images. Genuine H0 recovery and Cartier are derived.
Literal at-most-one-clump and ONE true H0 rank≥2 supply regularity;
their genus/clump-count bridges remain explicit rather than presumed. -/
noncomputable def actual_at_most_one_clump_unit_torsion_shared_H0_equiv
    (hinter : EndpointFieldIntersectionConstants
      (genericBaseFieldHom sX) (genericBaseFieldHom sY)
      (schemeFunctionFieldPullback s.left) (schemeFunctionFieldPullback s.right))
    (hunique : ∀ c d : s.fiberClump, c.left = d.left)
    (hdimension : 2 ≤ Module.rank k (schemeDifferentialGlobalSections sX)) :
    powerTorsionSubgroup s.unitRelationQuotient p ≃ₗ[ZMod p]
      actualSharedGlobalCartierFixed (p := p) s sX sY hbase := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (genericBaseFieldHom sY).toAlgebra
  letI := (genericBaseFieldHom (s.left ≫ sX)).toAlgebra
  letI := (schemeFunctionFieldPullback s.left).toAlgebra
  letI := (schemeFunctionFieldPullback s.right).toAlgebra
  letI := actualFunctionFieldBaseTower s.left sX (s.left ≫ sX) rfl
  letI := actualFunctionFieldBaseTower s.right sY (s.left ≫ sX) hbase
  letI : IsSmoothOfRelativeDimension 1 (s.left ≫ sX) := by
    have h : IsSmoothOfRelativeDimension (0 + 1) (s.left ≫ sX) := inferInstance
    exact h
  let C := actualSmoothCurveRationalCartier (p := p) (s.left ≫ sX)
  exact (actual_smooth_etale_span_unit_torsion_cartier_equiv
    s sX sY hbase hinter C).trans
    (actualSharedH0FixedRationalEquivOfRegular (p := p) s sX sY hbase
      (actual_at_most_one_clump_shared_rational_differentials_regular
        s sX sY hbase hunique hdimension)).symm

/-- The actual unit quotient p-kernel has one element precisely in
the zero-Cartier branch and p in the nonzero branch on true shared H0. -/
theorem actual_at_most_one_clump_unit_torsion_cardinality
    (hinter : EndpointFieldIntersectionConstants
      (genericBaseFieldHom sX) (genericBaseFieldHom sY)
      (schemeFunctionFieldPullback s.left) (schemeFunctionFieldPullback s.right))
    (hunique : ∀ c d : s.fiberClump, c.left = d.left)
    (hdimension : 2 ≤ Module.rank k (schemeDifferentialGlobalSections sX)) :
    Nat.card (powerTorsionSubgroup s.unitRelationQuotient p) =
      if actualSharedGlobalCartier (p := p) s sX sY hbase = 0 then 1 else p := by
  classical
  rw [Nat.card_congr (actual_at_most_one_clump_unit_torsion_shared_H0_equiv
    s sX sY hbase hinter hunique hdimension).toEquiv]
  exact actual_shared_H0_cartier_fixed_cardinality s sX sY hbase hinter

end Litt3.CartierAndSpin

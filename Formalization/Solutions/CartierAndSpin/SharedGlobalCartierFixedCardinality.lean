import Definitions.CartierAndSpin.SharedGlobalCartierFixed
import Solutions.CartierAndSpin.SharedGlobalDifferentialRank
import Solutions.SharedTensors.PrimeCartierFixedLine

set_option synthInstance.maxHeartbeats 100000

open CategoryTheory AlgebraicGeometry

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry
open scoped Classical

universe u

variable {k : Type u} [Field k] [IsAlgClosed k] [PerfectField k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  (s : FiniteEtaleSpan X Y) [IsIntegral s.source]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
  (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY]
  (hbase : s.right ≫ sY = s.left ≫ sX)
  {p : ℕ} [Fact p.Prime] [CharP k p]

/-- On the literal intersection of BOTH original H0 images, actual
Cartier fixed forms have cardinality one if Cartier is zero and p
otherwise. The genuine shared H0 finiteness and dimension bound are
derived from literal original endpoint constant intersection. No
properness, clump, genus, finite H0 or regularity premise is required. -/
theorem actual_shared_H0_cartier_fixed_cardinality
    (hinter : EndpointFieldIntersectionConstants
      (genericBaseFieldHom sX) (genericBaseFieldHom sY)
      (schemeFunctionFieldPullback s.left) (schemeFunctionFieldPullback s.right)) :
    Nat.card (actualSharedGlobalCartierFixed (p := p) s sX sY hbase) =
      if actualSharedGlobalCartier (p := p) s sX sY hbase = 0 then 1 else p := by
  obtain ⟨hfinite, hdim⟩ := actual_endpoint_constants_shared_H0_finite_and_small
    s sX sY hbase hinter
  letI := hfinite
  exact actual_rank_le_one_cartier_fixed_card hdim
    (actualSharedGlobalCartier (p := p) s sX sY hbase)
    (actualSharedGlobalCartier_pth_semilinear s sX sY hbase)

end Litt3.CartierAndSpin

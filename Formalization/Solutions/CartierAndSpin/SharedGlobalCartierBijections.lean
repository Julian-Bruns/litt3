import Solutions.CartierAndSpin.InversePowerCartierBijections
import Solutions.CartierAndSpin.SharedGlobalDifferentialRank
import Solutions.CartierAndSpin.SharedGlobalCartier
import Mathlib.Logic.Function.Iterate

set_option synthInstance.maxHeartbeats 100000

open CategoryTheory AlgebraicGeometry

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] [IsAlgClosed k] [PerfectField k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  (s : FiniteEtaleSpan X Y) [IsIntegral s.source]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
  (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY]
  (hbase : s.right ≫ sY = s.left ≫ sX)
  {p : ℕ} [Fact p.Prime] [CharP k p]

/-- A nonzero actual Cartier restriction on BOTH true H0 images is
bijective. Genuine rank/finiteness are derived from the literal
constant intersection of the ORIGINAL endpoint fields. No properness,
clump, genus, finite H0 or supplied coordinate is assumed. -/
theorem actual_shared_H0_nonzero_cartier_bijective
    (hinter : EndpointFieldIntersectionConstants
      (genericBaseFieldHom sX) (genericBaseFieldHom sY)
      (schemeFunctionFieldPullback s.left) (schemeFunctionFieldPullback s.right))
    (hne : actualSharedGlobalCartier (p := p) s sX sY hbase ≠ 0) :
    Function.Bijective (actualSharedGlobalCartier (p := p) s sX sY hbase) := by
  obtain ⟨hfinite, hdim⟩ := actual_endpoint_constants_shared_H0_finite_and_small
    s sX sY hbase hinter
  letI := hfinite
  exact actual_rank_le_one_nonzero_inverse_power_cartier_bijective
    (Fact.out : p.Prime).pos hdim
    (actualSharedGlobalCartier (p := p) s sX sY hbase)
    (actualSharedGlobalCartier_pth_semilinear s sX sY hbase) hne

/-- EVERY finite iterate of nonzero actual shared H0 Cartier is
bijective, including height zero. This is not a B_a or Lie-kernel claim. -/
theorem actual_shared_H0_nonzero_cartier_iterate_bijective
    (hinter : EndpointFieldIntersectionConstants
      (genericBaseFieldHom sX) (genericBaseFieldHom sY)
      (schemeFunctionFieldPullback s.left) (schemeFunctionFieldPullback s.right))
    (hne : actualSharedGlobalCartier (p := p) s sX sY hbase ≠ 0) (n : ℕ) :
    Function.Bijective ((actualSharedGlobalCartier (p := p) s sX sY hbase)^[n]) :=
  (actual_shared_H0_nonzero_cartier_bijective s sX sY hbase hinter hne).iterate n

/-- In the nonzero shared H0 Cartier branch every finite-height
kernel is literally zero, without supplied nilpotence data. -/
theorem actual_shared_H0_nonzero_cartier_iterate_zero_iff
    (hinter : EndpointFieldIntersectionConstants
      (genericBaseFieldHom sX) (genericBaseFieldHom sY)
      (schemeFunctionFieldPullback s.left) (schemeFunctionFieldPullback s.right))
    (hne : actualSharedGlobalCartier (p := p) s sX sY hbase ≠ 0)
    (n : ℕ) (a : actualSharedGlobalDifferentialSubspace s sX sY hbase) :
    (actualSharedGlobalCartier (p := p) s sX sY hbase)^[n] a = 0 ↔ a = 0 := by
  have hzero : (actualSharedGlobalCartier (p := p) s sX sY hbase)^[n] 0 = 0 := by
    induction n with
    | zero => rfl
    | succ n ih => rw [Function.iterate_succ_apply', ih, map_zero]
  constructor
  · intro ha
    exact (actual_shared_H0_nonzero_cartier_iterate_bijective
      s sX sY hbase hinter hne n).1 (ha.trans hzero.symm)
  · intro ha
    rw [ha, hzero]

/-- In the zero shared H0 Cartier branch every positive iterate
is literally zero. This concerns the true H0 operator itself. -/
theorem actual_shared_H0_zero_cartier_positive_iterate
    (hzero : actualSharedGlobalCartier (p := p) s sX sY hbase = 0)
    (n : ℕ) (a : actualSharedGlobalDifferentialSubspace s sX sY hbase) :
    (actualSharedGlobalCartier (p := p) s sX sY hbase)^[n + 1] a = 0 := by
  rw [Function.iterate_succ_apply', hzero]
  rfl

end Litt3.CartierAndSpin

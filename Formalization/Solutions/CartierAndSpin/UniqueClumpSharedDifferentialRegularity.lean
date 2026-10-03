import Solutions.CartierAndSpin.ProperRationalDifferentialZeros
import Solutions.CartierAndSpin.SharedDifferentialZeroClumps
import Solutions.CartierAndSpin.SharedRationalDifferentialRegularity
import Solutions.CartierAndSpin.SchemeDifferentialZeroPoleSeparation

set_option maxHeartbeats 1000000
set_option synthInstance.maxHeartbeats 100000

open CategoryTheory AlgebraicGeometry

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  (s : FiniteEtaleSpan X Y) [IsIntegral s.source]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] [IsProper sX]
  (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY] [IsProper sY]
  (hbase : s.right ≫ sY = s.left ≫ sX)

/-- EVERY shared rational one-form is genuinely regular when the
actual finite clump is at most unique and ONE original endpoint's
genuine differential H0 rank is at least two. A pole and a zero would
give TWO actual disjoint finite clumps of the SAME two maps.
Uniqueness and H0 rank are explicit inputs; their canonical geometric
bridges are not presumed. No canonical-degree theorem is assumed. -/
theorem actual_at_most_one_clump_shared_rational_differentials_regular
    (hunique : ∀ c d : s.fiberClump, c.left = d.left)
    (hdimension : 2 ≤ Module.rank k (schemeDifferentialGlobalSections sX)) :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (genericBaseFieldHom (s.left ≫ sX)).toAlgebra
    letI := (schemeFunctionFieldPullback s.left).toAlgebra
    letI := (schemeFunctionFieldPullback s.right).toAlgebra
    letI := actualFunctionFieldBaseTower s.left sX (s.left ≫ sX) rfl
    letI := actualFunctionFieldBaseTower s.right sY (s.left ≫ sX) hbase
    sharedRationalDifferentialSubspace k X.functionField Y.functionField
      s.source.functionField ≤ schemeGlobalRegularDifferentials (s.left ≫ sX) := by
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
  letI : IsSmooth (s.left ≫ sX) :=
    IsSmoothOfRelativeDimension.isSmooth 1 (s.left ≫ sX)
  letI : JacobsonSpace s.source := LocallyOfFiniteType.jacobsonSpace (s.left ≫ sX)
  letI : CompactSpace X := QuasiCompact.compactSpace_of_compactSpace sX
  letI : CompactSpace Y := QuasiCompact.compactSpace_of_compactSpace sY
  intro omega hshared
  apply (mem_schemeGlobalRegularDifferentials_iff (s.left ≫ sX) omega).mpr
  intro z
  by_contra hpole
  have homega : omega ≠ 0 := by
    intro h
    apply hpole
    rw [h]
    exact Submodule.zero_mem _
  obtain ⟨alpha, halpha⟩ := hshared.1
  obtain ⟨beta, hbeta⟩ := hshared.2
  change KaehlerDifferential.map k k X.functionField s.source.functionField alpha = omega at halpha
  change KaehlerDifferential.map k k Y.functionField s.source.functionField beta = omega at hbeta
  have halphane : alpha ≠ 0 := by
    intro h
    apply homega
    rw [← halpha, h, map_zero]
  have hbetane : beta ≠ 0 := by
    intro h
    apply homega
    rw [← hbeta, h, map_zero]
  have hcommon := halpha.trans hbeta.symm
  have hpoleL := actual_smooth_etale_differential_pole_set_pullback
    (s.left ≫ sX) sX s.left rfl alpha
  have hpoleR := actual_smooth_etale_differential_pole_set_pullback
    (s.left ≫ sX) sY s.right hbase beta
  have hsamePole : (mapClosedPoint s.left) ⁻¹' schemeDifferentialPoleSet sX alpha =
      (mapClosedPoint s.right) ⁻¹' schemeDifferentialPoleSet sY beta := by
    rw [← hpoleL, ← hpoleR, hcommon]
  have hzPoleL : z ∈ (mapClosedPoint s.left) ⁻¹' schemeDifferentialPoleSet sX alpha := by
    rw [← hpoleL, halpha]
    exact hpole
  have hzPoleR : z ∈ (mapClosedPoint s.right) ⁻¹' schemeDifferentialPoleSet sY beta := by
    rwa [← hsamePole]
  let poleClump : s.fiberClump := {
    left := schemeDifferentialPoleSet sX alpha
    right := schemeDifferentialPoleSet sY beta
    left_finite := actual_compact_smooth_rational_differential_poles_finite sX alpha
    right_finite := actual_compact_smooth_rational_differential_poles_finite sY beta
    left_nonempty := ⟨mapClosedPoint s.left z, hzPoleL⟩
    right_nonempty := ⟨mapClosedPoint s.right z, hzPoleR⟩
    same_source := hsamePole }
  obtain ⟨x, hx⟩ := actual_global_rank_two_every_rational_differential_has_zero
    sX hdimension alpha halphane
  obtain ⟨z0, hz0⟩ := mapClosedPoint_surjective s.left x
  have hzeroL := actual_smooth_etale_differential_zero_set_pullback
    (s.left ≫ sX) sX s.left rfl alpha
  have hzeroR := actual_smooth_etale_differential_zero_set_pullback
    (s.left ≫ sX) sY s.right hbase beta
  have hsameZero : (mapClosedPoint s.left) ⁻¹' schemeDifferentialZeroSet sX alpha =
      (mapClosedPoint s.right) ⁻¹' schemeDifferentialZeroSet sY beta := by
    rw [← hzeroL, ← hzeroR, hcommon]
  have hzZeroL : z0 ∈ (mapClosedPoint s.left) ⁻¹' schemeDifferentialZeroSet sX alpha := by
    change mapClosedPoint s.left z0 ∈ schemeDifferentialZeroSet sX alpha
    rwa [hz0]
  have hzZeroR : z0 ∈ (mapClosedPoint s.right) ⁻¹' schemeDifferentialZeroSet sY beta := by
    rwa [← hsameZero]
  let zeroClump : s.fiberClump := {
    left := schemeDifferentialZeroSet sX alpha
    right := schemeDifferentialZeroSet sY beta
    left_finite := actual_compact_smooth_rational_differential_zeros_finite sX alpha halphane
    right_finite := actual_compact_smooth_rational_differential_zeros_finite sY beta hbetane
    left_nonempty := ⟨mapClosedPoint s.left z0, hzZeroL⟩
    right_nonempty := ⟨mapClosedPoint s.right z0, hzZeroR⟩
    same_source := hsameZero }
  have hequal : schemeDifferentialPoleSet sX alpha = schemeDifferentialZeroSet sX alpha :=
    hunique poleClump zeroClump
  have hzero : mapClosedPoint s.left z ∈ schemeDifferentialZeroSet sX alpha := by
    rwa [← hequal]
  exact hzPoleL (actual_original_differential_zero_regular sX alpha
    (mapClosedPoint s.left z) hzero)

end Litt3.CartierAndSpin

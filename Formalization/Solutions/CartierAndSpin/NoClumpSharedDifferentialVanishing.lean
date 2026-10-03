import Solutions.CartierAndSpin.SharedDifferentialZeroClumps
import Solutions.CartierAndSpin.SharedEndpointDifferentialRegularity
import Solutions.CartierAndSpin.GlobalDifferentialDimensionZeros

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

/-- Literal absence of a finite clump forces the ENTIRE actual shared
rational differential space to vanish, provided ONE original endpoint's
GENUINE differential sheaf H0 has rank at least two. Original zeros,
poles, endpoint regularity, finite supports and both pullbacks are all
derived. No genus conversion, constant intersection, or characteristic
premise is assumed. -/
theorem actual_no_clump_shared_rational_differentials_eq_bot
    (hno : IsEmpty s.fiberClump)
    (hdimension : 2 ≤ Module.rank k (schemeDifferentialGlobalSections sX)) :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (genericBaseFieldHom (s.left ≫ sX)).toAlgebra
    letI := (schemeFunctionFieldPullback s.left).toAlgebra
    letI := (schemeFunctionFieldPullback s.right).toAlgebra
    letI := actualFunctionFieldBaseTower s.left sX (s.left ≫ sX) rfl
    letI := actualFunctionFieldBaseTower s.right sY (s.left ≫ sX) hbase
    sharedRationalDifferentialSubspace k X.functionField Y.functionField
      s.source.functionField = ⊥ := by
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
  apply le_antisymm ?_ bot_le
  intro omega hshared
  change omega = 0
  by_contra homega
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
  have hregular := (actual_no_clump_shared_endpoint_differentials_regular
    s sX sY hbase hno alpha beta hcommon).1
  obtain ⟨x, hx⟩ := actual_global_differential_rank_two_forces_zero
    sX hdimension alpha halphane hregular
  obtain ⟨z, hz⟩ := mapClosedPoint_surjective s.left x
  have hzendpoint : mapClosedPoint s.left z ∈ schemeDifferentialZeroSet sX alpha := by
    rwa [hz]
  have hzsource := (actual_smooth_etale_rational_differential_zero_iff
    (s.left ≫ sX) sX s.left rfl z alpha).mpr hzendpoint
  obtain ⟨c⟩ := actual_shared_nonzero_differential_zero_gives_finite_clump
    s sX sY hbase alpha beta z halphane hbetane hcommon hzsource
  exact hno.false c

end Litt3.CartierAndSpin

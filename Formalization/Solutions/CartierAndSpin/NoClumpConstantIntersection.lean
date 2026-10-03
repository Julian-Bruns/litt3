import Definitions.SharedTensors.ConstantIntersection
import Solutions.SharedTensors.SmoothProperSpans
import Solutions.SharedTensors.SchemeFieldTowers
import Solutions.Jacobians.SchemeValuationPullbacks

set_option maxHeartbeats 1000000
set_option synthInstance.maxHeartbeats 100000

open CategoryTheory AlgebraicGeometry

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry Litt3.Jacobians

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  (s : FiniteEtaleSpan X Y) [IsIntegral s.source]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] [IsProper sX]
  (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY] [QuasiCompact sY]
  (hbase : s.right ≫ sY = s.left ≫ sX)

include hbase

/-- Literal no-clump forces the ACTUAL two embedded endpoint fields
to meet in the SAME original constants. The actual principal-divisor
relation has zero kernel, and original proper principal-kernel constants
identify the common rational function. All DVR/support hypotheses are
derived; the second endpoint needs only quasi-compactness. -/
theorem actual_no_clump_endpoint_function_field_intersection_constants
    (hno : IsEmpty s.fiberClump) :
    EndpointFieldIntersectionConstants
      (genericBaseFieldHom sX) (genericBaseFieldHom sY)
      (schemeFunctionFieldPullback s.left) (schemeFunctionFieldPullback s.right) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (genericBaseFieldHom sY).toAlgebra
  letI := (genericBaseFieldHom (s.left ≫ sX)).toAlgebra
  letI := (schemeFunctionFieldPullback s.left).toAlgebra
  letI := (schemeFunctionFieldPullback s.right).toAlgebra
  letI := actualFunctionFieldBaseTower s.left sX (s.left ≫ sX) rfl
  letI := actualFunctionFieldBaseTower s.right sY (s.left ≫ sX) hbase
  letI := actual_etale_span_source_smooth s sX
  letI := actual_finite_span_source_proper s sX
  letI : IsSmooth (s.left ≫ sX) :=
    IsSmoothOfRelativeDimension.isSmooth 1 (s.left ≫ sX)
  letI : JacobsonSpace s.source := LocallyOfFiniteType.jacobsonSpace (s.left ≫ sX)
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  letI := actual_smooth_curve_closed_point_dvr_stalks sY
  letI := actual_smooth_curve_closed_point_dvr_stalks (s.left ≫ sX)
  letI := actual_proper_smooth_curve_finite_principal_support sX
  letI := actual_quasiCompact_smooth_curve_finite_principal_support sY
  letI := actual_proper_smooth_curve_finite_principal_support (s.left ≫ sX)
  intro a b hab
  by_cases ha : a = 0
  · refine ⟨0, by simpa only [map_zero] using ha.symm, ?_⟩
    have hb : b = 0 := (schemeFunctionFieldPullback s.right).injective (by
      rw [← hab, ha, map_zero, map_zero])
    simpa only [map_zero] using hb.symm
  have hb : b ≠ 0 := by
    intro hb
    apply ha
    apply (schemeFunctionFieldPullback s.left).injective
    rw [hab, hb, map_zero, map_zero]
  let ua : Additive X.functionFieldˣ := Additive.ofMul (Units.mk0 a ha)
  let ub : Additive Y.functionFieldˣ := Additive.ofMul (Units.mk0 b hb)
  have hunit : rationalUnitPullback (schemeFunctionFieldPullback s.left) ua =
      rationalUnitPullback (schemeFunctionFieldPullback s.right) ub := by
    apply Additive.toMul.injective
    apply Units.ext
    exact hab
  let d := (principalDivisorMap (schemeDivisorSystem X) ua,
    principalDivisorMap (schemeDivisorSystem Y) ub)
  let r := divisorRelationMap (mapClosedPoint s.left) (mapClosedPoint s.right)
    (mapClosedPoint_finite_preimage s.left) (mapClosedPoint_finite_preimage s.right)
  have hd : d ∈ r.ker := by
    change schemeDivisorPullback s.left d.1 - schemeDivisorPullback s.right d.2 = 0
    rw [← scheme_principal_divisor_pullback s.left,
      ← scheme_principal_divisor_pullback s.right, hunit, sub_self]
  have hdz : (⟨d, hd⟩ : r.ker) = 0 :=
    (actual_same_source_no_clump_iff_invariant_divisors_zero s).mp hno ⟨d, hd⟩
  have hda : principalDivisorMap (schemeDivisorSystem X) ua = 0 :=
    congrArg (fun z : r.ker => z.val.1) hdz
  obtain ⟨c, hc⟩ := actual_proper_smooth_curve_principal_kernel_constants sX ua hda
  have hca : genericBaseFieldHom sX c.toMul.val = a :=
    congrArg (fun z : Additive X.functionFieldˣ => z.toMul.val) hc
  refine ⟨c.toMul.val, hca, ?_⟩
  apply (schemeFunctionFieldPullback s.right).injective
  rw [← hab, ← hca]
  change algebraMap Y.functionField s.source.functionField
      (algebraMap k Y.functionField c.toMul.val) =
    algebraMap X.functionField s.source.functionField
      (algebraMap k X.functionField c.toMul.val)
  rw [← IsScalarTower.algebraMap_apply k Y.functionField s.source.functionField,
    ← IsScalarTower.algebraMap_apply k X.functionField s.source.functionField]

end Litt3.CartierAndSpin

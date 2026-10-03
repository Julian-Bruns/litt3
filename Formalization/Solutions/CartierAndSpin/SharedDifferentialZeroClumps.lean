import Solutions.CartierAndSpin.RationalDifferentialFiniteZeros
import Solutions.CartierAndSpin.SmoothEtaleDifferentialZeros
import Solutions.SharedTensors.SchemeClumps

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

/-- A genuine zero of a nonzero shared rational one-form constructs
a genuine finite clump of BOTH original maps from their SAME source.
Actual m·Ω zero supports are proved finite and their true pullbacks
are proved equal. No saturated-zero-set hypothesis is supplied. -/
theorem actual_shared_nonzero_differential_zero_gives_finite_clump :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (genericBaseFieldHom (s.left ≫ sX)).toAlgebra
    letI := (schemeFunctionFieldPullback s.left).toAlgebra
    letI := (schemeFunctionFieldPullback s.right).toAlgebra
    letI := actualFunctionFieldBaseTower s.left sX (s.left ≫ sX) rfl
    letI := actualFunctionFieldBaseTower s.right sY (s.left ≫ sX) hbase
    ∀ (alpha : KaehlerDifferential k X.functionField)
      (beta : KaehlerDifferential k Y.functionField) (z : ClosedPoint s.source),
      alpha ≠ 0 → beta ≠ 0 →
      KaehlerDifferential.map k k X.functionField s.source.functionField alpha =
        KaehlerDifferential.map k k Y.functionField s.source.functionField beta →
      z ∈ schemeDifferentialZeroSet (s.left ≫ sX)
        (KaehlerDifferential.map k k X.functionField s.source.functionField alpha) →
      Nonempty s.fiberClump := by
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
  letI : CompactSpace X := QuasiCompact.compactSpace_of_compactSpace sX
  letI : CompactSpace Y := QuasiCompact.compactSpace_of_compactSpace sY
  intro alpha beta z halpha hbeta hcommon hzero
  have hleft := actual_smooth_etale_differential_zero_set_pullback
    (s.left ≫ sX) sX s.left rfl alpha
  have hright := actual_smooth_etale_differential_zero_set_pullback
    (s.left ≫ sX) sY s.right hbase beta
  have hsame : (mapClosedPoint s.left) ⁻¹' schemeDifferentialZeroSet sX alpha =
      (mapClosedPoint s.right) ⁻¹' schemeDifferentialZeroSet sY beta := by
    rw [← hleft, ← hright, hcommon]
  have hzleft : z ∈ (mapClosedPoint s.left) ⁻¹' schemeDifferentialZeroSet sX alpha := by
    rwa [← hleft]
  have hzright : z ∈ (mapClosedPoint s.right) ⁻¹' schemeDifferentialZeroSet sY beta := by
    rwa [← hsame]
  exact ⟨{
    left := schemeDifferentialZeroSet sX alpha
    right := schemeDifferentialZeroSet sY beta
    left_finite := actual_compact_smooth_rational_differential_zeros_finite sX alpha halpha
    right_finite := actual_compact_smooth_rational_differential_zeros_finite sY beta hbeta
    left_nonempty := ⟨mapClosedPoint s.left z, hzleft⟩
    right_nonempty := ⟨mapClosedPoint s.right z, hzright⟩
    same_source := hsame }⟩

end Litt3.CartierAndSpin

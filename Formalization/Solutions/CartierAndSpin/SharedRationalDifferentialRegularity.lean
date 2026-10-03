import Definitions.CartierAndSpin.SharedDifferentialSubspaces
import Solutions.CartierAndSpin.RationalDifferentialFinitePoles
import Solutions.CartierAndSpin.SmoothEtaleDifferentialPoleSets
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

/-- A genuine pole of a shared ORIGINAL rational one-form produces a
genuine finite clump on BOTH actual finite etale maps from their SAME
source. Both actual endpoint pole sets are finite, their pullbacks are
proved equal, and their nonemptiness comes from the actual pole. -/
theorem actual_shared_differential_pole_gives_finite_clump :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (genericBaseFieldHom (s.left ≫ sX)).toAlgebra
    letI := (schemeFunctionFieldPullback s.left).toAlgebra
    letI := (schemeFunctionFieldPullback s.right).toAlgebra
    letI := actualFunctionFieldBaseTower s.left sX (s.left ≫ sX) rfl
    letI := actualFunctionFieldBaseTower s.right sY (s.left ≫ sX) hbase
    ∀ (alpha : KaehlerDifferential k X.functionField)
      (beta : KaehlerDifferential k Y.functionField) (z : ClosedPoint s.source),
      KaehlerDifferential.map k k X.functionField s.source.functionField alpha =
        KaehlerDifferential.map k k Y.functionField s.source.functionField beta →
      KaehlerDifferential.map k k X.functionField s.source.functionField alpha ∉
        schemeLocalRegularDifferentials (s.left ≫ sX) z.val →
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
  intro alpha beta z hcommon hpole
  have hleft : schemeDifferentialPoleSet (s.left ≫ sX)
        (KaehlerDifferential.map k k X.functionField s.source.functionField alpha) =
      (mapClosedPoint s.left) ⁻¹' schemeDifferentialPoleSet sX alpha :=
    actual_smooth_etale_differential_pole_set_pullback (s.left ≫ sX) sX s.left rfl alpha
  have hright : schemeDifferentialPoleSet (s.left ≫ sX)
        (KaehlerDifferential.map k k Y.functionField s.source.functionField beta) =
      (mapClosedPoint s.right) ⁻¹' schemeDifferentialPoleSet sY beta :=
    actual_smooth_etale_differential_pole_set_pullback (s.left ≫ sX) sY s.right hbase beta
  have hsame : (mapClosedPoint s.left) ⁻¹' schemeDifferentialPoleSet sX alpha =
      (mapClosedPoint s.right) ⁻¹' schemeDifferentialPoleSet sY beta := by
    rw [← hleft, ← hright, hcommon]
  have hzleft : z ∈ (mapClosedPoint s.left) ⁻¹' schemeDifferentialPoleSet sX alpha := by
    rw [← hleft]
    exact hpole
  have hzright : z ∈ (mapClosedPoint s.right) ⁻¹' schemeDifferentialPoleSet sY beta := by
    rw [← hsame]
    exact hzleft
  exact ⟨{
    left := schemeDifferentialPoleSet sX alpha
    right := schemeDifferentialPoleSet sY beta
    left_finite := actual_compact_smooth_rational_differential_poles_finite sX alpha
    right_finite := actual_compact_smooth_rational_differential_poles_finite sY beta
    left_nonempty := ⟨mapClosedPoint s.left z, hzleft⟩
    right_nonempty := ⟨mapClosedPoint s.right z, hzright⟩
    same_source := hsame }⟩

/-- In the absence of a literal finite clump, EVERY shared actual
rational differential lies in EVERY original closed-stalk regular
image. No shared regularity, polar-support equality, field-intersection,
genus, characteristic, primitive or H0 identification is an input. -/
theorem actual_no_clump_shared_rational_differentials_regular
    (hno : IsEmpty s.fiberClump) :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (genericBaseFieldHom (s.left ≫ sX)).toAlgebra
    letI := (schemeFunctionFieldPullback s.left).toAlgebra
    letI := (schemeFunctionFieldPullback s.right).toAlgebra
    letI := actualFunctionFieldBaseTower s.left sX (s.left ≫ sX) rfl
    letI := actualFunctionFieldBaseTower s.right sY (s.left ≫ sX) hbase
    sharedRationalDifferentialSubspace k X.functionField Y.functionField s.source.functionField ≤
      schemeGlobalRegularDifferentials (s.left ≫ sX) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (genericBaseFieldHom sY).toAlgebra
  letI := (genericBaseFieldHom (s.left ≫ sX)).toAlgebra
  letI := (schemeFunctionFieldPullback s.left).toAlgebra
  letI := (schemeFunctionFieldPullback s.right).toAlgebra
  letI := actualFunctionFieldBaseTower s.left sX (s.left ≫ sX) rfl
  letI := actualFunctionFieldBaseTower s.right sY (s.left ≫ sX) hbase
  intro omega hshared
  obtain ⟨alpha, halpha⟩ := hshared.1
  obtain ⟨beta, hbeta⟩ := hshared.2
  change KaehlerDifferential.map k k X.functionField s.source.functionField alpha = omega at halpha
  change KaehlerDifferential.map k k Y.functionField s.source.functionField beta = omega at hbeta
  apply (mem_schemeGlobalRegularDifferentials_iff (s.left ≫ sX) omega).mpr
  intro z
  by_contra hpole
  have hcommon := halpha.trans hbeta.symm
  have hpolealpha : KaehlerDifferential.map k k X.functionField s.source.functionField alpha ∉
      schemeLocalRegularDifferentials (s.left ≫ sX) z.val := by
    rwa [halpha]
  obtain ⟨c⟩ := actual_shared_differential_pole_gives_finite_clump
    s sX sY hbase alpha beta z hcommon hpolealpha
  exact hno.false c

end Litt3.CartierAndSpin

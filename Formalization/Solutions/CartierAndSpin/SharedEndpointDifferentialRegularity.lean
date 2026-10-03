import Solutions.CartierAndSpin.SharedRationalDifferentialRegularity
import Solutions.CartierAndSpin.SmoothEtaleGlobalDifferentialRegularity

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

/-- The literal no-clump hypothesis forces BOTH original endpoint
representatives of EVERY shared rational one-form to be globally
regular. The conclusion concerns the endpoint forms themselves, not
only their common pullback. Both original maps are preserved. -/
theorem actual_no_clump_shared_endpoint_differentials_regular
    (hno : IsEmpty s.fiberClump) :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (genericBaseFieldHom (s.left ≫ sX)).toAlgebra
    letI := (schemeFunctionFieldPullback s.left).toAlgebra
    letI := (schemeFunctionFieldPullback s.right).toAlgebra
    letI := actualFunctionFieldBaseTower s.left sX (s.left ≫ sX) rfl
    letI := actualFunctionFieldBaseTower s.right sY (s.left ≫ sX) hbase
    ∀ (alpha : KaehlerDifferential k X.functionField)
      (beta : KaehlerDifferential k Y.functionField),
      KaehlerDifferential.map k k X.functionField s.source.functionField alpha =
        KaehlerDifferential.map k k Y.functionField s.source.functionField beta →
      alpha ∈ schemeGlobalRegularDifferentials sX ∧
        beta ∈ schemeGlobalRegularDifferentials sY := by
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
  intro alpha beta hcommon
  have hshared : KaehlerDifferential.map k k X.functionField s.source.functionField alpha ∈
      sharedRationalDifferentialSubspace k X.functionField Y.functionField s.source.functionField :=
    ⟨⟨alpha, rfl⟩, ⟨beta, hcommon.symm⟩⟩
  have hregular := actual_no_clump_shared_rational_differentials_regular
    s sX sY hbase hno hshared
  constructor
  · exact (actual_smooth_etale_global_rational_differential_regular_iff
      (s.left ≫ sX) sX s.left rfl alpha).mp hregular
  · apply (actual_smooth_etale_global_rational_differential_regular_iff
      (s.left ≫ sX) sY s.right hbase beta).mp
    rwa [← hcommon]

end Litt3.CartierAndSpin

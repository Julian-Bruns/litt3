import Solutions.CartierAndSpin.SmoothEtaleDifferentialCategoricalPullbacks
import Solutions.CartierAndSpin.SmoothEtaleSpanDifferentialDivisors

open CategoryTheory AlgebraicGeometry

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry Litt3.Jacobians

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  [CompactSpace X] [CompactSpace Y]
  (s : FiniteEtaleSpan X Y) [IsIntegral s.source] [CompactSpace s.source]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
  (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY]
  (hbase : s.right ≫ sY = s.left ≫ sX)

/-- BOTH actual canonical adjoints are isomorphisms of the ORIGINAL
differential sheaves from the SAME smooth source. Source smoothness is
derived from the actual left etale leg. The theorem retains the literal
left and right morphisms and does not decide whether a common cover exists. -/
theorem same_source_actual_differential_categorical_pullback_isomorphisms :
    letI : IsSmoothOfRelativeDimension 1 (s.left ≫ sX) := by
      have h : IsSmoothOfRelativeDimension (0 + 1) (s.left ≫ sX) := inferInstance
      exact h
    IsIso (actualSmoothEtaleDifferentialCategoricalPullbackMap
      (s.left ≫ sX) sX s.left rfl) ∧
    IsIso (actualSmoothEtaleDifferentialCategoricalPullbackMap
      (s.left ≫ sX) sY s.right hbase) := by
  letI : IsSmoothOfRelativeDimension 1 (s.left ≫ sX) := by
    have h : IsSmoothOfRelativeDimension (0 + 1) (s.left ≫ sX) := inferInstance
    exact h
  exact ⟨actual_smooth_etale_differential_categorical_pullback_map_isIso
      (s.left ≫ sX) sX s.left rfl,
    actual_smooth_etale_differential_categorical_pullback_map_isIso
      (s.left ≫ sX) sY s.right hbase⟩

end Litt3.CartierAndSpin

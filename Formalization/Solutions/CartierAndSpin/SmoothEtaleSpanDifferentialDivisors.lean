import Solutions.CartierAndSpin.SmoothEtaleDifferentialDivisors

open CategoryTheory AlgebraicGeometry

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.Jacobians Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  [CompactSpace X] [CompactSpace Y]
  (s : FiniteEtaleSpan X Y) [IsIntegral s.source] [CompactSpace s.source]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
  (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY]
  (hbase : s.right ≫ sY = s.left ≫ sX)

/-- BOTH actual finite etale maps from the SAME original smooth source
transport the genuine differential divisors. The source smoothness is
derived from its left map, and the right map uses the stated common base.
This gives no decision of existence of an unmarked common cover. -/
theorem same_source_actual_rational_differential_divisor_pullbacks :
    letI : IsSmoothOfRelativeDimension 1 (s.left ≫ sX) := by
      have h : IsSmoothOfRelativeDimension (0 + 1) (s.left ≫ sX) := inferInstance
      exact h
    (letI := (genericBaseFieldHom (s.left ≫ sX)).toAlgebra
     letI := (genericBaseFieldHom sX).toAlgebra
     letI := (schemeFunctionFieldPullback s.left).toAlgebra
     letI := actualFunctionFieldBaseTower s.left sX (s.left ≫ sX) rfl
     ∀ (omega : KaehlerDifferential k X.functionField) (h : omega ≠ 0),
       actualRationalDifferentialDivisor (s.left ≫ sX)
           (KaehlerDifferential.map k k X.functionField s.source.functionField omega)
           (actual_smooth_etale_rational_differential_pullback_ne_zero
             (s.left ≫ sX) sX s.left rfl omega h) =
         schemeDivisorPullback s.left (actualRationalDifferentialDivisor sX omega h)) ∧
    (letI := (genericBaseFieldHom (s.left ≫ sX)).toAlgebra
     letI := (genericBaseFieldHom sY).toAlgebra
     letI := (schemeFunctionFieldPullback s.right).toAlgebra
     letI := actualFunctionFieldBaseTower s.right sY (s.left ≫ sX) hbase
     ∀ (omega : KaehlerDifferential k Y.functionField) (h : omega ≠ 0),
       actualRationalDifferentialDivisor (s.left ≫ sX)
           (KaehlerDifferential.map k k Y.functionField s.source.functionField omega)
           (actual_smooth_etale_rational_differential_pullback_ne_zero
             (s.left ≫ sX) sY s.right hbase omega h) =
         schemeDivisorPullback s.right (actualRationalDifferentialDivisor sY omega h)) := by
  letI : IsSmoothOfRelativeDimension 1 (s.left ≫ sX) := by
    have h : IsSmoothOfRelativeDimension (0 + 1) (s.left ≫ sX) := inferInstance
    exact h
  exact ⟨actual_smooth_etale_rational_differential_divisor_pullback
      (s.left ≫ sX) sX s.left rfl,
    actual_smooth_etale_rational_differential_divisor_pullback
      (s.left ≫ sX) sY s.right hbase⟩

end Litt3.CartierAndSpin

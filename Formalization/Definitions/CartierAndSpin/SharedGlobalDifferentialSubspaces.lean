import Solutions.CartierAndSpin.SmoothEtaleGlobalDifferentialPullbacks
import Definitions.CartierAndSpin.SharedDifferentialSubspaces

open CategoryTheory AlgebraicGeometry

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  (s : FiniteEtaleSpan X Y) [IsIntegral s.source]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
  (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY]
  (hbase : s.right ≫ sY = s.left ≫ sX)

/-- The literal intersection of BOTH genuine endpoint H0 pullback
images in the SAME original source's genuine differential sheaf H0.
No rational-image model defines this global-section module. -/
noncomputable def actualSharedGlobalDifferentialSubspace :
    Submodule k (schemeDifferentialGlobalSections (s.left ≫ sX)) := by
  letI : IsSmoothOfRelativeDimension 1 (s.left ≫ sX) := by
    have h : IsSmoothOfRelativeDimension (0 + 1) (s.left ≫ sX) := inferInstance
    exact h
  exact LinearMap.range (actualSmoothEtaleGlobalDifferentialPullback
      (s.left ≫ sX) sX s.left rfl) ⊓
    LinearMap.range (actualSmoothEtaleGlobalDifferentialPullback
      (s.left ≫ sX) sY s.right hbase)

end Litt3.CartierAndSpin

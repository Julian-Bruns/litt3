import Definitions.CartierAndSpin.SharedGlobalDifferentialSubspaces
import Solutions.SharedTensors.SchemeDifferentialGlobalCartierNaturality

set_option maxHeartbeats 1000000
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

/-- Intrinsic Cartier preserves the literal intersection of BOTH
genuine endpoint H0 images in the SAME source H0. All pullback
commutation is proved for the original étale maps. No clump,
properness, rank, finite H0 or rational regularity premise is needed. -/
theorem actual_shared_H0_cartier_stable :
    letI : IsSmoothOfRelativeDimension 1 (s.left ≫ sX) := by
      have h : IsSmoothOfRelativeDimension (0 + 1) (s.left ≫ sX) := inferInstance
      exact h
    ∀ a : schemeDifferentialGlobalSections (s.left ≫ sX),
      a ∈ actualSharedGlobalDifferentialSubspace s sX sY hbase →
        actualSmoothCurveSheafGlobalCartier (p := p) (s.left ≫ sX) a ∈
          actualSharedGlobalDifferentialSubspace s sX sY hbase := by
  letI : IsSmoothOfRelativeDimension 1 (s.left ≫ sX) := by
    have h : IsSmoothOfRelativeDimension (0 + 1) (s.left ≫ sX) := inferInstance
    exact h
  intro a ha
  obtain ⟨b, hb⟩ := ha.1
  obtain ⟨c, hc⟩ := ha.2
  constructor
  · refine ⟨actualSmoothCurveSheafGlobalCartier (p := p) sX b, ?_⟩
    rw [← actualSmoothEtaleSheafGlobalCartier_pullback, hb]
  · refine ⟨actualSmoothCurveSheafGlobalCartier (p := p) sY c, ?_⟩
    rw [← actualSmoothEtaleSheafGlobalCartier_pullback, hc]

/-- Actual intrinsic Cartier restricted to the ORIGINAL shared H0
intersection. This is an additive map on literal sheaf global sections. -/
noncomputable def actualSharedGlobalCartier :
    actualSharedGlobalDifferentialSubspace s sX sY hbase →+
      actualSharedGlobalDifferentialSubspace s sX sY hbase := by
  letI : IsSmoothOfRelativeDimension 1 (s.left ≫ sX) := by
    have h : IsSmoothOfRelativeDimension (0 + 1) (s.left ≫ sX) := inferInstance
    exact h
  exact {
    toFun := fun a => ⟨actualSmoothCurveSheafGlobalCartier (p := p)
      (s.left ≫ sX) a.val, actual_shared_H0_cartier_stable s sX sY hbase a.val a.property⟩
    map_zero' := by apply Subtype.ext; exact map_zero _
    map_add' := by intro a b; apply Subtype.ext; exact map_add _ _ _ }

/-- The literal shared H0 restriction is inverse-p semilinear for the
ACTUAL original coefficient-field action. -/
theorem actualSharedGlobalCartier_pth_semilinear
    (c : k) (a : actualSharedGlobalDifferentialSubspace s sX sY hbase) :
    actualSharedGlobalCartier (p := p) s sX sY hbase (c ^ p • a) =
      c • actualSharedGlobalCartier (p := p) s sX sY hbase a := by
  letI : IsSmoothOfRelativeDimension 1 (s.left ≫ sX) := by
    have h : IsSmoothOfRelativeDimension (0 + 1) (s.left ≫ sX) := inferInstance
    exact h
  apply Subtype.ext
  exact actualSmoothCurveSheafGlobalCartier_pth_semilinear (s.left ≫ sX) c a.val

end Litt3.CartierAndSpin

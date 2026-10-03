import Solutions.CartierAndSpin.SharedGlobalCartier
import Mathlib.Algebra.Module.ZMod

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

/-- The literal fixed subgroup of intrinsic Cartier on the actual
intersection of BOTH genuine endpoint H0 images in the SAME source. -/
noncomputable def actualSharedGlobalCartierFixed :
    AddSubgroup (actualSharedGlobalDifferentialSubspace s sX sY hbase) :=
  (actualSharedGlobalCartier (p := p) s sX sY hbase -
    AddMonoidHom.id (actualSharedGlobalDifferentialSubspace s sX sY hbase)).ker

/-- The canonical prime-subfield action on actual shared H0 fixed
forms, derived from the ORIGINAL coefficient-field action. -/
noncomputable instance actualSharedGlobalCartierFixedZModModule :
    Module (ZMod p) (actualSharedGlobalCartierFixed (p := p) s sX sY hbase) :=
  AddCommGroup.zmodModule (by
    intro a
    apply Subtype.ext
    apply Subtype.ext
    change p • a.val.val = 0
    rw [← Nat.cast_smul_eq_nsmul k, CharP.cast_eq_zero k p, zero_smul])

end Litt3.CartierAndSpin

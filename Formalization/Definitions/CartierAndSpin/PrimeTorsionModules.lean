import Definitions.CartierAndSpin.LogarithmicQuotientBoundary
import Definitions.CartierAndSpin.SharedCartierFixedForms
import Mathlib.Algebra.Module.ZMod

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

/-- The canonical Z/p module on the literal subgroup killed by p. -/
noncomputable instance powerTorsionSubgroupZModModule
    (A : Type*) [AddCommGroup A] (p : ℕ) :
    Module (ZMod p) (powerTorsionSubgroup A p) :=
  AddCommGroup.zmodModule (by
    intro q
    apply Subtype.ext
    exact q.property)

variable {k F G E : Type*} [Field k] [Field F] [Field G] [Field E]
  [Algebra k F] [Algebra k G] [Algebra k E] [Algebra F E] [Algebra G E]
  [IsScalarTower k F E] [IsScalarTower k G E]
variable {p : ℕ} [CharP k p]

/-- The canonical prime-subfield module on the literal shared
Cartier-fixed forms; p-annihilation follows from the original k action. -/
noncomputable instance sharedIntrinsicCartierFixedFormsZModModule
    (C : RationalCartierOperator k E p) :
    Module (ZMod p) (sharedIntrinsicCartierFixedForms k F G E C) :=
  AddCommGroup.zmodModule (by
    intro omega
    apply Subtype.ext
    change p • omega.val = 0
    rw [← Nat.cast_smul_eq_nsmul k, CharP.cast_eq_zero k p, zero_smul])

end Litt3.CartierAndSpin

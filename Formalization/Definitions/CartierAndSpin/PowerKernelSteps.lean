import Definitions.CartierAndSpin.LogarithmicQuotientBoundary

namespace Litt3.CartierAndSpin

variable (A : Type*) [AddCommGroup A]

/-- Actual p-multiplication between successive literal torsion kernels. -/
def powerKernelStep (p n : ℕ) :
    powerTorsionSubgroup A (p ^ (n + 1)) →+ powerTorsionSubgroup A (p ^ n) where
  toFun a := ⟨p • a.val, by
    change p ^ n • (p • a.val) = 0
    rw [← mul_nsmul, ← pow_succ']
    exact a.property⟩
  map_zero' := by apply Subtype.ext; exact nsmul_zero p
  map_add' a b := by apply Subtype.ext; exact nsmul_add a.val b.val p

/-- The kernel of the true successive map embeds into the original
ambient p-kernel by the actual underlying element. -/
def powerKernelStepKernelInclusion (p n : ℕ) :
    (powerKernelStep A p n).ker → powerTorsionSubgroup A p := fun x =>
  ⟨x.val.val, congrArg Subtype.val (show powerKernelStep A p n x.val = 0 from x.property)⟩

end Litt3.CartierAndSpin

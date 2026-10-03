import Definitions.CartierAndSpin.CanonicalWeightedSquareSupport
import Solutions.CartierAndSpin.PrimitiveFunctionRoots

namespace Litt3.CartierAndSpin

variable {k L : Type*} [Field k] [Field L] [Algebra k L]

/-- The algebraic finite-support clause of the canonical critical square
pencil statement. The field degree and universal differential are actual
objects, and the Frobenius root is quantified rather than supplied. -/
def CanonicalWeightedSquareSupport (p : ℕ) (g q : L) : Prop :=
  ∃ e : ℕ, ∃ r : L, r ^ (p ^ e) = q ∧
    KaehlerDifferential.D k L r ≠ 0 ∧ (¬ ∃ s : L, s ^ p = r) ∧
    e ≤ Nat.log p (Module.finrank (IntermediateField.adjoin k {q}) L) ∧
    (nonzeroWeightedSquareSupport (k := k) g q).Finite ∧
    (nonzeroWeightedSquareSupport (k := k) g q).ncard ≤
      1 + (Module.finrank (IntermediateField.adjoin k {r}) L).factorization 2

end Litt3.CartierAndSpin

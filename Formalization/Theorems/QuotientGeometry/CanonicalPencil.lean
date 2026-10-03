import Definitions.QuotientGeometry.CanonicalPencil
import Mathlib.RingTheory.MvPolynomial.Homogeneous
import Mathlib.Algebra.MvPolynomial.Eval

namespace Litt3.QuotientGeometry.Targets

/-- The function-field reconstruction component. The remaining source
claim additionally constructs the proper morphism and proves étaleness. -/
def CanonicalPencilFieldReconstruction : Prop :=
  ∀ (k L : Type) [Field k] [Field L] [Algebra k L]
    (D : Derivation k L L) (H : MvPolynomial (Fin 2) k),
    H.IsHomogeneous 6 → ∀ (A B : L), A ≠ 0 →
    canonicalPencilBracket D A B ≠ 0 →
    (canonicalPencilBracket D A B) ^ 2 = H.eval₂ (algebraMap k L) ![A, B] →
    let x := canonicalPencilX A B
    let y := canonicalPencilY A (canonicalPencilBracket D A B)
    y ^ 2 = H.eval₂ (algebraMap k L) ![1, x] ∧
      D x ≠ 0 ∧ D x / y = A ∧ x * (D x / y) = B

end Litt3.QuotientGeometry.Targets

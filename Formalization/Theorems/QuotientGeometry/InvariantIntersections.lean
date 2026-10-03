import Theorems.QuotientGeometry.RefinementAlgebra
import Mathlib.FieldTheory.Galois.Basic

namespace Litt3.QuotientGeometry.Targets

/-- This is a genuine embedded-field assertion: a finite automorphism
group preserving E and with constant invariant intersection forces E to
be the constant field. The ambient field can be transcendental. -/
def FiniteInvariantIntermediateFieldTriviality : Prop :=
  ∀ (K L : Type) [Field K] [Field L] [Algebra K L] [IsAlgClosed K]
    (H : Subgroup (L ≃ₐ[K] L)) [Finite H] (E : IntermediateField K L),
    (∀ (σ : H) (x : L), x ∈ E → σ.val x ∈ E) →
    E ⊓ IntermediateField.fixedField H = ⊥ → E = ⊥

end Litt3.QuotientGeometry.Targets

import Theorems.QuotientGeometry.RefinementAlgebra
import Mathlib.FieldTheory.Galois.Basic

namespace Litt3.QuotientGeometry.Targets

/-- In a finite Galois extension with perfect automorphism group,
an m-th root of a base element descends whenever all m-th roots of
unity are already in the base. No positive-characteristic assumption
is needed beyond that explicit roots-of-unity hypothesis. -/
def PerfectGaloisRootDescent : Prop :=
  ∀ (K L : Type) [Field K] [Field L] [Algebra K L]
    [FiniteDimensional K L] [IsGalois K L],
    commutator (L ≃ₐ[K] L) = ⊤ → ∀ (m : ℕ) (x : L) (a : K),
    x ^ m = algebraMap K L a →
    (∀ ζ : L, ζ ^ m = 1 → ∃ k : K, algebraMap K L k = ζ) →
    x ∈ (⊥ : IntermediateField K L)

end Litt3.QuotientGeometry.Targets

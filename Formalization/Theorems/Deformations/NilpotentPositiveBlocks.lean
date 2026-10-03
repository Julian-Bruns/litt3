import Definitions.Deformations.TruncatedCoefficientRing
import Mathlib.LinearAlgebra.FiniteDimensional.Defs

namespace Litt3.Deformations.Specifications

variable {k V : Type*} [Field k] [AddCommGroup V] [Module k V]

/-- A genuine complete decomposition of the actual nilpotent operator
into positive truncated quotient blocks with their literal parameter
action and with no length exceeding its global nilpotence exponent. -/
def NilpotentPositiveBlocks (T : V →ₗ[k] V) (N : ℕ) : Prop :=
  ∃ (d : ℕ) (length : Fin d → ℕ),
    (∀ i, 0 < length i) ∧ (∀ i, length i ≤ N) ∧
    ∃ e : V ≃ₗ[k] (∀ i, TruncatedCoefficientRing k (length i)),
      ∀ v i, e (T v) i = truncatedParameter k (length i) * e v i

end Litt3.Deformations.Specifications

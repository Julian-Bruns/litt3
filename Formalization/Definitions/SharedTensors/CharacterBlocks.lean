import Mathlib.Algebra.Polynomial.AlgebraMap
import Mathlib.Algebra.Polynomial.Degree.Operations

namespace Litt3.SharedTensors

open Polynomial

variable {k K : Type*} [Field k] [Field K] [Algebra k K]

/-- The exact coefficient system for one characteristic-power block.
Linearity over the constants suffices; a derivation is not needed for
this linear algebraic uniqueness step. -/
def IsCharacterBlock (D : K →ₗ[k] K) (eta beta : K) (s : ℕ) (r : K[X]) : Prop :=
  ∀ i : ℕ, D (r.coeff i) =
    -((i + 1 : ℕ) : K) * eta * r.coeff (i + 1) +
      ((s : K) - (i : K)) * beta * r.coeff i

def CoefficientsIn (V : Submodule k K) (r : K[X]) : Prop :=
  ∀ i : ℕ, r.coeff i ∈ V

/-- Every nonresonant homogeneous character vanishes in the actual
coefficient space. This is an explicit hypothesis, not an automatic fact
about arbitrary pole divisors. -/
def NoBlockCharacters (D : K →ₗ[k] K) (beta : K) (V : Submodule k K)
    (p s : ℕ) : Prop :=
  ∀ i : ℕ, i < p → i ≠ s → ∀ a : K, a ∈ V →
    D a = ((s : K) - (i : K)) * beta * a → a = 0

def NoNonconstantDifferentialConstants (D : K →ₗ[k] K) (V : Submodule k K) : Prop :=
  ∀ a : K, a ∈ V → D a = 0 → ∃ c : k, algebraMap k K c = a

/-- The homogeneous-character hypothesis stated with its original
positive representatives of the prime-field characters. -/
def NoHomogeneousCharacters (D : K →ₗ[k] K) (beta : K) (V : Submodule k K)
    (p : ℕ) : Prop :=
  ∀ j : ℕ, 0 < j → j < p → ∀ a : K, a ∈ V →
    D a = (j : K) * beta * a → a = 0

end Litt3.SharedTensors

import Mathlib.LinearAlgebra.Basis.Basic
import Mathlib.LinearAlgebra.Span.Basic

namespace Litt3.CartierAndSpin.Specifications

open Module

variable {K V W ι : Type*} [Field K]
  [AddCommGroup V] [Module K V] [AddCommGroup W] [Module K W]

/-- A basis tests whether a prescribed map differs from another by a scalar
graph along a specified nonzero vector. The basis may be infinite. -/
def ScalarGraphBasisCriterion (M A : V →ₗ[K] W) (e : W) (basis : Basis ι K V) : Prop :=
  e ≠ 0 → ((∃ a : V →ₗ[K] K, M = A + a.smulRight e) ↔
    ∀ i, M (basis i) - A (basis i) ∈ Submodule.span K ({e} : Set W))

end Litt3.CartierAndSpin.Specifications

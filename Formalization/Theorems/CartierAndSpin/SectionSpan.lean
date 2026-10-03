import Mathlib.LinearAlgebra.FiniteDimensional.Lemmas

namespace Litt3.CartierAndSpin.Specifications

variable {K V W : Type*} [DivisionRing K]
  [AddCommGroup V] [Module K V] [FiniteDimensional K V]
  [AddCommGroup W] [Module K W]

/-- The linear-algebraic restriction bound used in the scheme-theoretic
section-span fiber argument. Geometric restriction surjectivity is explicit. -/
def SectionSpanRestrictionBound (f : V →ₗ[K] W) (S : Submodule K V) : Prop :=
  Function.Surjective f →
    Module.finrank K W ≤
      Module.finrank K (V ⧸ S) + Module.finrank K (S.map f)

end Litt3.CartierAndSpin.Specifications

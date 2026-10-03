import Definitions.Deformations.WeightedGeneratorFiltration

namespace Litt3.Deformations

/-- The literal normal monomial filtration, with exponents below q
and scalar weight q-1. No normal-form or graded result is assumed. -/
noncomputable def normalGeneratorFiltration (R : Type*) [CommRing R]
    {A I : Type*} [CommRing A] [Algebra R A] [Fintype I]
    (q : ℕ) (p : A) (e : I → A) (d : ℕ) : Submodule R A :=
  Submodule.span R {x | ∃ j : ℕ, ∃ alpha : I → ℕ,
    (∀ i, alpha i < q) ∧
      d ≤ (q - 1) * j + generatorMonomialWeight alpha ∧
      x = p ^ j * generatorMonomial e alpha}

end Litt3.Deformations

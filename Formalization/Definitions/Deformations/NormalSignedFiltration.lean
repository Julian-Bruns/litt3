import Definitions.Deformations.SignedGeneratorFiltration

namespace Litt3.Deformations

/-- The literal original normal monomial form of the integral chart
carry filtration. Every coefficient and prime-power digit is retained. -/
noncomputable def normalSignedFiltration (R : Type*) [CommRing R]
    {A I : Type*} [CommRing A] [Algebra R A] [Fintype I]
    (q : ℕ) (p : A) (w : ℕ) (e : I → A) (d : ℤ) : Submodule R A :=
  Submodule.span R {x | ∃ j : ℕ, ∃ alpha : I → ℕ,
    (∀ i, alpha i < q) ∧
    (generatorMonomialWeight alpha : ℤ) ≤ d + (w : ℤ) * j ∧
      x = p ^ j * generatorMonomial e alpha}

end Litt3.Deformations

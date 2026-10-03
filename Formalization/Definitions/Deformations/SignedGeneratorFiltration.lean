import Definitions.Deformations.WeightedGeneratorFiltration
import Mathlib.Data.Int.Cast.Basic

namespace Litt3.Deformations

/-- The increasing integral degree filtration used for p-adic chart
carries: a scalar prime power lowers degree by its assigned weight.
Negative degrees and coefficient torsion are both retained. -/
noncomputable def signedGeneratorFiltration (R : Type*) [CommRing R]
    {A I : Type*} [CommRing A] [Algebra R A] [Fintype I]
    (p : A) (primeWeight : ℕ) (e : I → A) (d : ℤ) : Submodule R A :=
  Submodule.span R {x | ∃ j : ℕ, ∃ alpha : I → ℕ,
    (generatorMonomialWeight alpha : ℤ) ≤ d + (primeWeight : ℤ) * j ∧
      x = p ^ j * generatorMonomial e alpha}

end Litt3.Deformations

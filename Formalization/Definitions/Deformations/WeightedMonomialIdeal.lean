import Mathlib.RingTheory.MvPolynomial.Ideal

namespace Litt3.Deformations

variable (I : Type*) [Fintype I]

/-- The literal assigned weight of an unchanged original monomial. -/
noncomputable def originalMonomialWeight (w : I → ℕ) (a : I →₀ ℕ) : ℕ := ∑ i, w i * a i

variable (R : Type*) [CommRing R]

/-- The actual monomial ideal of original weight at least d. -/
noncomputable def weightedMonomialIdeal (w : I → ℕ) (d : ℕ) : Ideal (MvPolynomial I R) :=
  Ideal.span ((fun a : I →₀ ℕ => MvPolynomial.monomial a (1 : R)) ''
    {a | d ≤ originalMonomialWeight I w a})

end Litt3.Deformations

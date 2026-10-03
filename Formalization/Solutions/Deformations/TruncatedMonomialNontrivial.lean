import Solutions.Deformations.TruncatedMonomialBasis

namespace Litt3.Deformations

variable (R I : Type*) [CommRing R] [Nontrivial R]

/-- Positive original variable powers keep the actual unequal-power
quotient nontrivial over every nontrivial commutative coefficient ring. -/
theorem truncated_monomial_nontrivial (q : I → ℕ) (positive : ∀ i, 0 < q i) :
    Nontrivial (TruncatedMonomialAlgebra R I q) := by
  apply Ideal.Quotient.nontrivial_iff.mpr
  intro whole
  have member : (1 : MvPolynomial I R) ∈ truncatedMonomialIdeal R I q := by
    rw [whole]
    exact Submodule.mem_top
  have all := (truncated_monomial_ideal_membership R I q 1).mp member
  have atZero := all 0 (by simp)
  obtain ⟨i, bound⟩ := atZero
  have := positive i
  have zero : q i = 0 := by simpa only [Finsupp.zero_apply, Nat.le_zero] using bound
  omega

end Litt3.Deformations

import Solutions.Deformations.TruncatedMonomialBasis

namespace Litt3.Deformations

variable (R I : Type*) [CommRing R]

/-- Equality in the actual original unequal-power quotient is precisely
equality of all surviving original coefficients. -/
theorem truncated_monomial_quotient_eq_iff (q : I → ℕ) (f g : MvPolynomial I R) :
    Ideal.Quotient.mk (truncatedMonomialIdeal R I q) f =
        Ideal.Quotient.mk (truncatedMonomialIdeal R I q) g ↔
      ∀ a : I →₀ ℕ, (∀ i, a i < q i) → f.coeff a = g.coeff a := by
  classical
  rw [Ideal.Quotient.mk_eq_mk_iff_sub_mem, truncated_monomial_ideal_membership]
  constructor
  · intro member a survives
    apply sub_eq_zero.mp
    by_contra nonzero
    have support : a ∈ (f - g).support := by
      simpa only [MvPolynomial.mem_support_iff, MvPolynomial.coeff_sub] using nonzero
    obtain ⟨i, oversized⟩ := member a support
    exact Nat.not_le_of_lt (survives i) oversized
  · intro same a support
    by_contra noOversized
    have survives : ∀ i, a i < q i := fun i =>
      Nat.lt_of_not_ge (fun bound => noOversized ⟨i, bound⟩)
    have zero : (f - g).coeff a = 0 := by rw [MvPolynomial.coeff_sub, same a survives, sub_self]
    exact (MvPolynomial.mem_support_iff.mp support) zero

end Litt3.Deformations

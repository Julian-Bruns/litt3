import Solutions.Atlases.GroebnerStopping
import Mathlib.RingTheory.MvPolynomial.Ideal

namespace Litt3.Atlases

open MvPolynomial

variable {K σ : Type*} [Field K]

/-- The divisibility-defined standard exponents are exactly the
monomials outside the actual generated leading monomial ideal. -/
theorem standardMonomial_iff_not_mem_leadingIdeal (m : MonomialOrder σ)
    (G : Set (MvPolynomial σ K)) (d : σ →₀ ℕ) :
    d ∈ standardMonomials m G ↔ monomial d 1 ∉ leadingMonomialIdeal m G := by
  classical
  let degrees : Set (σ →₀ ℕ) := {a | ∃ g ∈ G, g ≠ 0 ∧ a = m.degree g}
  have he : leadingMonomialIdeal m G =
      Ideal.span ((fun a => monomial a (1 : K)) '' degrees) := by
    apply congrArg Ideal.span
    ext t
    constructor
    · rintro ⟨g, hg, hn, rfl⟩
      exact ⟨m.degree g, ⟨g, hg, hn, rfl⟩, rfl⟩
    · rintro ⟨a, ⟨g, hg, hn, rfl⟩, rfl⟩
      exact ⟨g, hg, hn, rfl⟩
  have hmem : monomial d (1 : K) ∈ leadingMonomialIdeal m G ↔
      ∃ g ∈ G, g ≠ 0 ∧ m.degree g ≤ d := by
    rw [he, MvPolynomial.mem_ideal_span_monomial_image]
    simp [degrees, and_assoc]
  rw [hmem]
  change (∀ g ∈ G, g ≠ 0 → ¬m.degree g ≤ d) ↔ _
  simp only [not_exists, not_and]

end Litt3.Atlases

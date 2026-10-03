import Theorems.Deformations.DeckOrderBounds
import Lean.Elab.Tactic.Omega

namespace Litt3.Deformations

variable {G : Type*} [Group G] [Finite G]

/-- Cauchy's theorem converts bounds on actual element
orders into a prime-to-p assertion for that actual finite
group. No containing group or Galois closure is involved. -/
theorem actual_finite_group_prime_to (p m : ℕ) [Fact p.Prime] :
    Specifications.ActualFiniteGroupPrimeTo (G := G) p m := by
  intro bounded less
  apply (Fact.out : p.Prime).coprime_iff_not_dvd.mpr
  intro divides
  obtain ⟨g, order⟩ := exists_prime_orderOf_dvd_card' (G := G) p divides
  have bound := bounded g 1 (by simpa only [pow_one] using order)
  rw [pow_one] at bound
  omega

end Litt3.Deformations

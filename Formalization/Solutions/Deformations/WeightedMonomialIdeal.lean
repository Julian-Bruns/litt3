import Definitions.Deformations.WeightedMonomialIdeal
import Mathlib.RingTheory.Ideal.Operations

namespace Litt3.Deformations

variable (I : Type*) [Fintype I]

theorem original_monomial_weight_monotone (w : I → ℕ) {a b : I →₀ ℕ} (bound : a ≤ b) :
    originalMonomialWeight I w a ≤ originalMonomialWeight I w b :=
  Finset.sum_le_sum (fun i _ => Nat.mul_le_mul_left (w i) (bound i))

theorem original_monomial_weight_add (w : I → ℕ) (a b : I →₀ ℕ) :
    originalMonomialWeight I w (a + b) = originalMonomialWeight I w a + originalMonomialWeight I w b := by
  simp only [originalMonomialWeight, Finsupp.add_apply, Nat.mul_add, Finset.sum_add_distrib]

variable (R : Type*) [CommRing R]

/-- Full actual monomial-ideal membership is exactly the stated
original weight condition on every surviving nonzero coefficient. -/
theorem weighted_monomial_ideal_membership (w : I → ℕ) (d : ℕ) (f : MvPolynomial I R) :
    f ∈ weightedMonomialIdeal I R w d ↔
      ∀ a ∈ f.support, d ≤ originalMonomialWeight I w a := by
  rw [weightedMonomialIdeal, MvPolynomial.mem_ideal_span_monomial_image]
  constructor
  · intro member a support
    obtain ⟨b, lower, upper⟩ := member a support
    exact lower.trans (original_monomial_weight_monotone I w upper)
  · intro member a support
    exact ⟨a, member a support, le_rfl⟩

/-- Actual multiplication of the complete weighted ideals preserves
the sum of the assigned original weights, despite coefficient cancellation. -/
theorem weighted_monomial_ideal_mul_le (w : I → ℕ) (d e : ℕ) :
    weightedMonomialIdeal I R w d * weightedMonomialIdeal I R w e ≤
      weightedMonomialIdeal I R w (d + e) := by
  classical
  apply Ideal.mul_le.mpr
  intro f first g second
  rw [weighted_monomial_ideal_membership] at first second ⊢
  intro a support
  obtain ⟨b, hb, c, hc, rfl⟩ := Finset.mem_add.mp (MvPolynomial.support_mul f g support)
  rw [original_monomial_weight_add]
  exact Nat.add_le_add (first b hb) (second c hc)

/-- All powers of an actual weight-d ideal lie in the precise
weight-dm ideal, uniformly in all assigned original weights. -/
theorem weighted_monomial_ideal_pow_le (w : I → ℕ) (d m : ℕ) :
    weightedMonomialIdeal I R w d ^ m ≤ weightedMonomialIdeal I R w (d * m) := by
  classical
  induction m with
  | zero =>
    intro f member
    rw [weighted_monomial_ideal_membership]
    intro a support
    simp
  | succ m ih =>
    rw [pow_succ, Nat.mul_succ]
    exact (Ideal.mul_mono ih le_rfl).trans (weighted_monomial_ideal_mul_le I R w (d * m) d)

end Litt3.Deformations

import Solutions.CartierAndSpin.CohortPowerSums

namespace Litt3.CartierAndSpin

open Finset Classical

variable {K ι : Type*} [Field K] [Fintype ι]

/-- Newton's induction through an arbitrary bound, separating only the
characteristic carry indices. Every intermediate e_k and P_k is constructed
from regular data; there is no Frobenius identity in the fraction field. -/
theorem newton_carry_membership (S : Subring K) (p N : ℕ) (u : ι → K)
    (hdivision : ∀ k, 0 < k → k ≤ N → ¬p ∣ k → (k : K) ≠ 0 ∧ (k : K)⁻¹ ∈ S)
    (hcarries : ∀ k, 0 < k → k ≤ N → p ∣ k → finiteElementarySymmetric u k ∈ S)
    (htraces : ∀ k, 0 < k → k ≤ N → ¬p ∣ k → finitePowerSum u k ∈ S) :
    ∀ k, k ≤ N → finiteElementarySymmetric u k ∈ S ∧ finitePowerSum u k ∈ S := by
  intro k
  induction k using Nat.strong_induction_on with
  | h k ih =>
    intro hkN
    by_cases hk0 : k = 0
    · subst k
      simp [finiteElementarySymmetric, finitePowerSum, MvPolynomial.esymm_zero]
    have hk : 0 < k := Nat.pos_of_ne_zero hk0
    have hpower_from_elementary (he : finiteElementarySymmetric u k ∈ S) :
        finitePowerSum u k ∈ S := by
      rw [finite_powerSum_newton_identity u k hk]
      apply S.sub_mem
      · exact S.mul_mem (S.mul_mem (S.pow_mem (S.neg_mem S.one_mem) _) (natCast_mem S k)) he
      · apply S.sum_mem
        intro a ha
        obtain ⟨ha, hinterval⟩ := mem_filter.mp ha
        have hsum : a.1 + a.2 = k := mem_antidiagonal.mp ha
        have hapos : 0 < a.1 := hinterval.1
        have hearlier := ih a.1 hinterval.2 (by omega)
        have hpearlier := ih a.2 (by omega) (by omega)
        exact S.mul_mem (S.mul_mem (S.pow_mem (S.neg_mem S.one_mem) _) hearlier.1) hpearlier.2
    by_cases hcarry : p ∣ k
    · have he := hcarries k hk hkN hcarry
      exact ⟨he, hpower_from_elementary he⟩
    · have hp := htraces k hk hkN hcarry
      have hrhs : (-1 : K) ^ (k + 1) *
          (∑ a ∈ antidiagonal k with a.1 < k,
            (-1 : K) ^ a.1 * finiteElementarySymmetric u a.1 * finitePowerSum u a.2) ∈ S := by
        apply S.mul_mem (S.pow_mem (S.neg_mem S.one_mem) _)
        apply S.sum_mem
        intro a ha
        obtain ⟨ha, halt⟩ := mem_filter.mp ha
        have hsum : a.1 + a.2 = k := mem_antidiagonal.mp ha
        have hearlier := ih a.1 halt (by omega)
        have hpower : finitePowerSum u a.2 ∈ S := by
          by_cases ha0 : a.1 = 0
          · have ha2 : a.2 = k := by omega
            simpa only [ha2] using hp
          · exact (ih a.2 (by omega) (by omega)).2
        exact S.mul_mem (S.mul_mem (S.pow_mem (S.neg_mem S.one_mem) _) hearlier.1) hpower
      obtain ⟨hkcast, hkinverse⟩ := hdivision k hk hkN hcarry
      have he : finiteElementarySymmetric u k ∈ S := by
        have hprod := S.mul_mem hkinverse hrhs
        rw [← finite_newton_identity u k, ← mul_assoc, inv_mul_cancel₀ hkcast, one_mul] at hprod
        exact hprod
      exact ⟨he, hp⟩

end Litt3.CartierAndSpin

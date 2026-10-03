import Solutions.Deformations.TruncatedWittPowerResidue

set_option maxHeartbeats 800000

namespace Litt3.Deformations

variable (p N : ℕ) [Fact p.Prime] (positive : 0 < N)
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

/-- Exact vanishing criterion for a genuine nonterminal prime-power
initial layer of the actual truncated Witt coefficient ring. -/
theorem truncated_witt_initial_layer_zero (j : ℕ) (bound : j < N)
    (a : TruncatedWittVector p N k) :
    (p : TruncatedWittVector p N k) ^ (j + 1) ∣
      (p : TruncatedWittVector p N k) ^ j * a ↔
        truncatedWittResidue p N positive k a = 0 := by
  constructor
  · rintro ⟨c, relation⟩
    have congruence : (p : TruncatedWittVector p N k) ^ j * a -
        (p : TruncatedWittVector p N k) ^ j * 0 =
        (p : TruncatedWittVector p N k) ^ (j + 1) * c := by
      simpa only [mul_zero, sub_zero] using relation
    simpa only [map_zero] using
      truncated_witt_power_residue_congruence p N positive k j bound a 0 c congruence
  · intro residueZero
    obtain ⟨c, relation⟩ := (truncated_witt_residue_kernel p N positive k a).mp residueZero
    refine ⟨c, ?_⟩
    have actual : a = (p : TruncatedWittVector p N k) * c := by
      have scalar := truncated_witt_scalar_power_smul p N 1 k c
      simp only [pow_one] at scalar
      exact relation.symm.trans scalar
    rw [actual, ← mul_assoc, ← pow_succ]

include positive in
/-- Actual Teichmüller initial representatives are uniquely determined
by their residue, with no cancellation of a zero-divisor prime power. -/
theorem truncated_witt_teichmuller_initial_equal (j : ℕ) (bound : j < N)
    (a b : k) :
    (p : TruncatedWittVector p N k) ^ (j + 1) ∣
      (p : TruncatedWittVector p N k) ^ j * WittVector.truncate N (WittVector.teichmuller p a) -
        (p : TruncatedWittVector p N k) ^ j * WittVector.truncate N (WittVector.teichmuller p b) ↔
      a = b := by
  rw [← mul_sub, truncated_witt_initial_layer_zero p N positive k j bound,
    map_sub, truncated_witt_residue_truncate, truncated_witt_residue_truncate,
    WittVector.teichmuller_coeff_zero, WittVector.teichmuller_coeff_zero, sub_eq_zero]

end Litt3.Deformations

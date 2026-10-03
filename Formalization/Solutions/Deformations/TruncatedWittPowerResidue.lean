import Solutions.Deformations.TruncatedWittResidue

set_option maxHeartbeats 800000

namespace Litt3.Deformations

variable (p N : ℕ) [Fact p.Prime] (positive : 0 < N)
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

/-- Equal actual nonterminal prime-power multiples have equal actual
residue coefficients, even though the multiples need not cancel. -/
theorem truncated_witt_power_residue_equal (j : ℕ) (bound : j < N)
    (a b : TruncatedWittVector p N k)
    (same : (p : TruncatedWittVector p N k) ^ j * a =
      (p : TruncatedWittVector p N k) ^ j * b) :
    truncatedWittResidue p N positive k a = truncatedWittResidue p N positive k b := by
  have annihilated : (p : ZMod (p ^ N)) ^ j • (a - b) = 0 := by
    rw [truncated_witt_scalar_power_smul, mul_sub, same, sub_self]
  have divisible := truncated_witt_nonterminal_annihilator p N positive k j bound (a - b) annihilated
  have zero := (truncated_witt_residue_kernel p N positive k (a - b)).mpr divisible
  rw [map_sub] at zero
  exact sub_eq_zero.mp zero

/-- Changing a representative by one further actual prime-power
multiple preserves its literal initial residue at the selected level. -/
theorem truncated_witt_power_residue_congruence (j : ℕ) (bound : j < N)
    (a b c : TruncatedWittVector p N k)
    (same : (p : TruncatedWittVector p N k) ^ j * a -
        (p : TruncatedWittVector p N k) ^ j * b =
      (p : TruncatedWittVector p N k) ^ (j + 1) * c) :
    truncatedWittResidue p N positive k a = truncatedWittResidue p N positive k b := by
  have relation : (p : TruncatedWittVector p N k) ^ j * a =
      (p : TruncatedWittVector p N k) ^ j * (b + (p : TruncatedWittVector p N k) * c) := by
    rw [mul_add, ← mul_assoc, ← pow_succ]
    exact (eq_add_of_sub_eq same).trans (add_comm _ _)
  have residues := truncated_witt_power_residue_equal p N positive k j bound a _ relation
  rw [map_add, map_mul, map_natCast, CharP.cast_eq_zero k p, zero_mul, add_zero] at residues
  exact residues

/-- Literal Teichmüller replacement preserves every nonterminal
initial prime-power class by an actual next-level multiple. -/
theorem truncated_witt_teichmuller_initial_replacement (j : ℕ)
    (a : TruncatedWittVector p N k) :
    ∃ c : TruncatedWittVector p N k,
      (p : TruncatedWittVector p N k) ^ j * a -
        (p : TruncatedWittVector p N k) ^ j *
          WittVector.truncate N (WittVector.teichmuller p (truncatedWittResidue p N positive k a)) =
      (p : TruncatedWittVector p N k) ^ (j + 1) * c := by
  have zero : truncatedWittResidue p N positive k
      (a - WittVector.truncate N (WittVector.teichmuller p (truncatedWittResidue p N positive k a))) = 0 := by
    rw [map_sub, truncated_witt_residue_truncate, WittVector.teichmuller_coeff_zero, sub_self]
  obtain ⟨c, relation⟩ := (truncated_witt_residue_kernel p N positive k _).mp zero
  refine ⟨c, ?_⟩
  have primeRelation : a - WittVector.truncate N
      (WittVector.teichmuller p (truncatedWittResidue p N positive k a)) =
      (p : TruncatedWittVector p N k) * c := by
    have scalar := truncated_witt_scalar_power_smul p N 1 k c
    simp only [pow_one] at scalar
    exact relation.symm.trans scalar
  rw [← mul_sub, primeRelation, ← mul_assoc, ← pow_succ]

end Litt3.Deformations

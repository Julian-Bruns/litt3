import Solutions.Deformations.PreparedCyclicLogNorm

namespace Litt3.Deformations

variable {R B : Type*} [CommRing R] [Ring B] [Algebra R B]

/-- The literal full cyclic group relation is augmentation times the
full integral norm polynomial, over arbitrary coefficient rings and
arbitrary noncommutative endomorphism algebras. -/
theorem integral_cyclic_relation_norm (p a : ℕ) (x : B) :
    (1 + x) ^ (p ^ a) - 1 = x * integralCyclicNormValue (R := R) p a x := by
  classical
  have expansion := (Commute.one_right x).add_pow (p ^ a)
  simp only [one_pow, mul_one] at expansion
  rw [add_comm] at expansion
  rw [expansion, Finset.sum_range_succ', pow_zero, Nat.choose_zero_right, Nat.cast_one, one_mul]
  rw [add_sub_cancel_right]
  unfold integralCyclicNormValue
  rw [Finset.mul_sum]
  symm
  apply Finset.sum_bij (fun j _ => j - 1)
  · intro j member
    simp only [Finset.mem_Icc] at member
    simp only [Finset.mem_range]
    omega
  · intro j member k member' same
    simp only [Finset.mem_Icc] at member member'
    omega
  · intro i member
    simp only [Finset.mem_range] at member
    exact ⟨i + 1, by simp only [Finset.mem_Icc]; omega, by omega⟩
  · intro j member
    obtain ⟨positive, upper⟩ := Finset.mem_Icc.mp member
    have index : j - 1 + 1 = j := by omega
    rw [index, Algebra.smul_def, map_natCast, ← mul_assoc,
      ← (Nat.cast_commute ((p ^ a).choose j) x).eq, mul_assoc,
      ← pow_succ', Nat.sub_add_cancel positive]
    exact (Nat.cast_commute ((p ^ a).choose j) (x ^ j)).eq

end Litt3.Deformations

import Mathlib.LinearAlgebra.FiniteDimensional.Lemmas
import Mathlib.Algebra.Module.Submodule.RestrictScalars
import Mathlib.RingTheory.Ideal.Operations
import Mathlib.RingTheory.Artinian.Ring
import Mathlib.Tactic

namespace Litt3.Atlases

variable {K V : Type*} [DivisionRing K] [AddCommGroup V] [Module K V]
  [FiniteDimensional K V]

/-- An exact descending chain has a consecutive plateau by the ambient
dimension. This uses dimensions only, with no basis or matrix computation. -/
theorem descending_submodule_chain_plateau (S : ℕ → Submodule K V)
    (descending : ∀ n, S (n + 1) ≤ S n) :
    ∃ n, n ≤ Module.finrank K V ∧ S (n + 1) = S n := by
  by_contra h
  push_neg at h
  have hbound : ∀ n, n ≤ Module.finrank K V + 1 →
      Module.finrank K (S n) + n ≤ Module.finrank K V := by
    intro n hn
    induction n with
    | zero => simpa only [add_zero] using (S 0).finrank_le
    | succ n ih =>
        have hneq := h n (by omega)
        have hstrict : S (n + 1) < S n :=
          lt_of_le_of_ne (descending n) hneq
        have hdim := Submodule.finrank_lt_finrank_of_lt hstrict
        have hprior := ih (by omega)
        omega
  have hd := hbound (Module.finrank K V + 1) le_rfl
  omega

section Ideals

variable {k A : Type*} [Field k] [CommRing A] [Algebra k A]
  [FiniteDimensional k A]

/-- A plateau in actual ideal powers propagates by multiplication. -/
theorem ideal_power_plateau_constant (I : Ideal A) (n : ℕ)
    (h : I ^ (n + 1) = I ^ n) (m : ℕ) : I ^ (n + m) = I ^ n := by
  induction m with
  | zero => simp only [add_zero]
  | succ m ih =>
      rw [Nat.add_succ, pow_succ, ih, ← pow_succ, h]

/-- Every nilpotent ideal in an actual finite algebra has nilpotence
index at most the algebra dimension, including the zero algebra. -/
theorem nilpotent_ideal_pow_finrank (I : Ideal A) (nilpotent : IsNilpotent I) :
    I ^ Module.finrank k A = ⊥ := by
  let S : ℕ → Submodule k A := fun n => (I ^ n).restrictScalars k
  have hdesc : ∀ n, S (n + 1) ≤ S n := fun n =>
    Ideal.pow_le_pow_right (Nat.le_succ n)
  obtain ⟨n, hn, hS⟩ := descending_submodule_chain_plateau S hdesc
  have hplateau : I ^ (n + 1) = I ^ n :=
    (Submodule.restrictScalars_injective k A A) hS
  obtain ⟨r, hr⟩ := nilpotent
  have hrbot : I ^ r = ⊥ := hr
  have hzero : I ^ (n + r) = ⊥ :=
    le_bot_iff.mp (hrbot ▸ Ideal.pow_le_pow_right (Nat.le_add_left r n))
  have hnzero : I ^ n = ⊥ :=
    (ideal_power_plateau_constant I n hplateau r).symm.trans hzero
  exact le_bot_iff.mp (hnzero ▸ Ideal.pow_le_pow_right hn)

/-- The exact nilradical power certificate for every finite algebra,
with arbitrary characteristic and no perfectness assumption. -/
theorem nilradical_pow_finrank :
    (nilradical A) ^ Module.finrank k A = ⊥ := by
  letI : IsArtinianRing A := isArtinian_of_tower k inferInstance
  exact nilpotent_ideal_pow_finrank _ IsArtinianRing.isNilpotent_nilradical

end Ideals
end Litt3.Atlases

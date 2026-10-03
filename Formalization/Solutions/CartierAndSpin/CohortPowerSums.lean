import Theorems.CartierAndSpin.CohortPowerSums
import Mathlib.Algebra.CharP.Basic
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

open Finset

variable {K ι : Type*} [Fintype ι]

section Ring

variable [CommRing K]

theorem finiteElementarySymmetric_card (u : ι → K) :
    finiteElementarySymmetric u (Fintype.card ι) = ∏ i, u i := by
  classical
  simp only [finiteElementarySymmetric, MvPolynomial.esymm, map_sum, map_prod,
    MvPolynomial.eval_X]
  rw [← Finset.card_univ (α := ι), powersetCard_self]
  simp

/-- Newton's identity evaluated at the actual family. It is valid over every
commutative ring, including mixed characteristic. -/
theorem finite_newton_identity (u : ι → K) (k : ℕ) :
    (k : K) * finiteElementarySymmetric u k = (-1) ^ (k + 1) *
      ∑ a ∈ antidiagonal k with a.1 < k,
        (-1) ^ a.1 * finiteElementarySymmetric u a.1 * finitePowerSum u a.2 := by
  classical
  have h := congrArg (MvPolynomial.eval u) (MvPolynomial.mul_esymm_eq_sum ι K k)
  simpa [finiteElementarySymmetric, finitePowerSum, MvPolynomial.psum] using h

/-- The reverse Newton recurrence solves for the actual power sum, without
dividing by k. This is the recurrence used at characteristic carry indices. -/
theorem finite_powerSum_newton_identity (u : ι → K) (k : ℕ) (hk : 0 < k) :
    finitePowerSum u k = (-1) ^ (k + 1) * (k : K) * finiteElementarySymmetric u k -
      ∑ a ∈ antidiagonal k with a.1 ∈ Set.Ioo 0 k,
        (-1) ^ a.1 * finiteElementarySymmetric u a.1 * finitePowerSum u a.2 := by
  classical
  have h := congrArg (MvPolynomial.eval u)
    (MvPolynomial.psum_eq_mul_esymm_sub_sum ι K k hk)
  simpa [finiteElementarySymmetric, finitePowerSum, MvPolynomial.psum] using h

/-- Vanishing power sums kill k times the kth elementary symmetric function;
there is no assumption that any integer is invertible here. -/
theorem finiteElementarySymmetric_mul_eq_zero_of_powerSums (u : ι → K) (k : ℕ)
    (hpowers : ∀ l, 0 < l → l ≤ k → finitePowerSum u l = 0) :
    (k : K) * finiteElementarySymmetric u k = 0 := by
  classical
  rw [finite_newton_identity]
  suffices (∑ a ∈ antidiagonal k with a.1 < k,
      (-1 : K) ^ a.1 * finiteElementarySymmetric u a.1 * finitePowerSum u a.2) = 0 by
    rw [this, mul_zero]
  apply sum_eq_zero
  intro a ha
  have hsum : a.1 + a.2 = k := (mem_antidiagonal.mp (mem_filter.mp ha).1)
  have hlt : a.1 < k := (mem_filter.mp ha).2
  rw [hpowers a.2 (by omega) (by omega), mul_zero]

theorem newtonCohortObstruction [IsDomain K] (u : ι → K) :
    Specifications.NewtonCohortObstruction u := by
  intro hvalues hcard hpowers
  have hzero := finiteElementarySymmetric_mul_eq_zero_of_powerSums u
    (Fintype.card ι) hpowers
  rw [finiteElementarySymmetric_card] at hzero
  exact (mul_ne_zero hcard (Finset.prod_ne_zero_iff.mpr fun i _ => hvalues i)) hzero

end Ring

section Field

variable [Field K]

/-- The characteristic-p specialization needs only the actual cohort size
to be strictly less than p. No perfection assumption on the field is used. -/
theorem characteristic_cohort_powerSums_cannot_vanish
    (p : ℕ) [CharP K p] (u : ι → K) (hpositive : 0 < Fintype.card ι)
    (hsmall : Fintype.card ι < p) (hvalues : ∀ i, u i ≠ 0)
    (hpowers : ∀ k, 0 < k → k ≤ Fintype.card ι → finitePowerSum u k = 0) : False := by
  apply newtonCohortObstruction u hvalues ?_ hpowers
  rw [Ne, CharP.cast_eq_zero_iff K p]
  exact Nat.not_dvd_of_pos_of_lt hpositive hsmall

end Field

end Litt3.CartierAndSpin

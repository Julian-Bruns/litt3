import Theorems.Deformations.TruncatedValuation
import Solutions.Deformations.TruncatedRestriction

namespace Litt3.Deformations

open Polynomial

variable {k : Type*} [CommRing k]

theorem truncated_parameter_pow_nonzero [Nontrivial k] (N j : ℕ) (bound : j < N) :
    truncatedParameter k N ^ j ≠ 0 := by
  intro h
  change AdjoinRoot.mk ((X : Polynomial k) ^ N) X ^ j = 0 at h
  rw [← map_pow, AdjoinRoot.mk_eq_zero] at h
  have hc := X_pow_dvd_iff.mp h j bound
  exact one_ne_zero (by simpa only [coeff_X_pow_self] using hc)

/-- Every nonzero actual quotient element has a genuine
parameter-power times unit normal form. -/
theorem truncated_scalar_valuation {K : Type*} [Field K] (N : ℕ) :
    Specifications.TruncatedScalarValuation (k := K) N := by
  intro x hx
  obtain ⟨P, rfl⟩ := AdjoinRoot.mk_surjective (g := (X : Polynomial K) ^ N) x
  have hP : P ≠ 0 := by
    intro h
    apply hx
    rw [h, map_zero]
  let j := P.natTrailingDegree
  have hdiv : (X : Polynomial K) ^ j ∣ P := by
    apply X_pow_dvd_iff.mpr
    intro d hd
    exact coeff_eq_zero_of_lt_natTrailingDegree hd
  have hj : j < N := by
    by_contra h
    have hN : (X : Polynomial K) ^ N ∣ P := by
      apply X_pow_dvd_iff.mpr
      intro d hd
      exact coeff_eq_zero_of_lt_natTrailingDegree (lt_of_lt_of_le hd (Nat.le_of_not_gt h))
    exact hx (AdjoinRoot.mk_eq_zero.mpr hN)
  obtain ⟨Q, hQ⟩ := hdiv
  have hc : Q.coeff 0 ≠ 0 := by
    have h := coeff_natTrailingDegree_ne_zero.mpr hP
    change P.coeff j ≠ 0 at h
    rw [hQ] at h
    have heq : (X ^ j * Q).coeff j = Q.coeff 0 := by
      simpa only [zero_add] using (coeff_X_pow_mul Q j 0)
    rwa [heq] at h
  have hres : truncatedResidue K N (lt_of_le_of_lt (Nat.zero_le j) hj)
      (AdjoinRoot.mk ((X : Polynomial K) ^ N) Q) = Q.coeff 0 := by
    simp [truncatedResidue]
  have hu : IsUnit (AdjoinRoot.mk ((X : Polynomial K) ^ N) Q) := by
    apply (truncated_unit_criterion N (lt_of_le_of_lt (Nat.zero_le j) hj) _).mpr
    rw [hres]
    exact isUnit_iff_ne_zero.mpr hc
  refine ⟨j, hj, hu.unit, ?_⟩
  rw [hu.unit_spec, hQ, map_mul, map_pow, AdjoinRoot.mk_X]
  rfl

end Litt3.Deformations

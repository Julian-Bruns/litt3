import Theorems.CartierAndSpin.TraceOmissionWitness
import Solutions.CartierAndSpin.TraceOmissionPolynomial
import Solutions.CartierAndSpin.LocalNewtonCarries
import Mathlib.RingTheory.Valuation.Integers

namespace Litt3.CartierAndSpin

open Finset IsLocalRing Classical

section Field

variable {K Γ : Type*} [Field K] [LinearOrderedCommGroupWithZero Γ]

theorem primitive_root_valuation_eq_one (valuation : Valuation K Γ) (q : ℕ) (hq : 0 < q)
    (zeta : K) (hzeta : IsPrimitiveRoot zeta q) : valuation zeta = 1 := by
  apply (pow_eq_one_iff_of_nonneg (zero_le' : (0 : Γ) ≤ valuation zeta) hq.ne').mp
  rw [← map_pow, hzeta.pow_eq_one, valuation.map_one]

theorem traceOmissionTuple_norm_value (valuation : Valuation K Γ) (p q m : ℕ)
    (hq : 0 < q) (zeta t : K) (hzeta : IsPrimitiveRoot zeta q) (ht : t ≠ 0) :
    valuation (∏ j, traceOmissionTuple p q m zeta t j) = 1 := by
  have hzeta_value := primitive_root_valuation_eq_one valuation q hq zeta hzeta
  have ht_value : valuation t ≠ 0 := valuation.ne_zero_iff.mpr ht
  rw [map_prod]
  simp [traceOmissionTuple, Fintype.prod_sum_type, hzeta_value, ← pow_mul,
    Nat.mul_comm p q, ht_value]

theorem nat_not_dvd_below_twice_of_ne (q k : ℕ) (hk : 0 < k)
    (hkbound : k < 2 * q) (hne : k ≠ q) : ¬q ∣ k := by
  rintro ⟨a, ha⟩
  have halt : a < 2 := Nat.lt_of_mul_lt_mul_left (by
    rw [← ha, Nat.mul_comm q 2]
    exact hkbound)
  have hane : a ≠ 0 := by
    intro hz
    rw [hz, mul_zero] at ha
    omega
  have haone : a = 1 := by omega
  apply hne
  rw [ha, haone, mul_one]

end Field

variable {R K Γ : Type*} [CommRing R] [IsLocalRing R] [Field K] [Algebra R K]
  [LinearOrderedCommGroupWithZero Γ]

/-- Every listed higher trace is individually indispensable. This is a
fully explicit actual root-orbit tuple in any equal-characteristic integer
valuation ring with an actual pole and the requisite primitive root. -/
theorem higher_trace_omission_integrality_counterexample (valuation : Valuation K Γ)
    (hv : valuation.Integers R) (p r i : ℕ) [CharP K p] [CharP (ResidueField R) p]
    (hp : 0 < p) (hrp : r < p) (hi : 0 < i) (hir : i ≤ r)
    (zeta t : K) (hzeta : IsPrimitiveRoot zeta (p + i)) (hpole : 1 < valuation t) :
    Specifications.OmittedHigherTraceWitness (R := R)
      (traceOmissionTuple p (p + i) (r - i) zeta t) p r i := by
  letI : Fact p.Prime := ⟨CharP.char_prime_of_ne_zero K hp.ne'⟩
  let q := p + i
  let m := r - i
  let u := traceOmissionTuple p q m zeta t
  have hq : 0 < q := by omega
  have hqp : p < q := by omega
  have hmp : m < p := by omega
  have ht : t ≠ 0 := valuation.ne_zero_iff.mp (ne_of_gt (zero_lt_one.trans hpole))
  have hvalues : ∀ j, u j ≠ 0 := by
    intro j
    rcases j with j | (j | j)
    · exact mul_ne_zero (pow_ne_zero _ (hzeta.ne_zero hq.ne')) (pow_ne_zero _ ht)
    · exact pow_ne_zero _ (inv_ne_zero ht)
    · exact one_ne_zero
  have hnorm_value := traceOmissionTuple_norm_value valuation p q m hq zeta t hzeta ht
  obtain ⟨normR, hnormR⟩ := hv.exists_of_le_one hnorm_value.le
  have hnormunit : IsUnit normR := hv.isUnit_of_one' (by rw [hnormR]; exact hnorm_value)
  have hcast_q_unit : IsUnit (q : R) := by
    apply (local_natCast_isUnit_iff_not_dvd p q).mpr
    have hi_lt : i < p := hir.trans_lt hrp
    intro hdiv
    exact Nat.not_dvd_of_pos_of_lt hi hi_lt ((Nat.dvd_add_iff_right (dvd_refl p)).mpr hdiv)
  have hcast_q_value : valuation (q : K) = 1 := by
    simpa only [map_natCast] using hv.one_of_isUnit hcast_q_unit
  have hinverse_le : (valuation t)⁻¹ ≤ 1 := (inv_lt_one_of_one_lt₀ hpole).le
  have hcarry_identity := traceOmissionTuple_carry_identity p q m hqp hmp zeta t hzeta
  have hcarry_value := congrArg valuation hcarry_identity
  simp only [map_mul, map_pow, valuation.map_neg, valuation.map_one, one_pow, one_mul,
    valuation.map_inv] at hcarry_value
  have hcarry_integral : finiteElementarySymmetric u p ∈ (algebraMap R K).range := by
    apply hv.exists_of_le_one
    rw [hcarry_value]
    exact pow_le_one₀ zero_le' (pow_le_one₀ zero_le' hinverse_le)
  have hbad_main : 1 < valuation ((q : K) * (t ^ p) ^ q) := by
    rw [map_mul, hcast_q_value, one_mul, map_pow, map_pow, ← pow_mul]
    exact one_lt_pow₀ hpole (Nat.mul_ne_zero hp.ne' hq.ne')
  have hconstant_le : valuation (m : K) ≤ 1 := by
    simpa only [map_natCast] using hv.map_le_one (m : R)
  have hbad : finitePowerSum u q ∉ (algebraMap R K).range := by
    have hpower : finitePowerSum u q = (q : K) * (t ^ p) ^ q + (m : K) := by
      simp only [u, traceOmissionTuple_power_sum p q m zeta t hzeta q, if_pos (dvd_refl q)]
    have hbad_value : 1 < valuation (finitePowerSum u q) := by
      rw [hpower, valuation.map_add_eq_of_lt_left (hconstant_le.trans_lt hbad_main)]
      exact hbad_main
    rintro ⟨a, ha⟩
    rw [← ha] at hbad_value
    exact hbad_value.not_ge (hv.map_le_one a)
  have hregular : ∀ k, ¬q ∣ k → finitePowerSum u k ∈ (algebraMap R K).range := by
    intro k hdiv
    simp only [u, traceOmissionTuple_power_sum p q m zeta t hzeta k, if_neg hdiv, zero_add]
    exact ⟨(m : R), map_natCast (algebraMap R K) m⟩
  have hreciprocal : ∀ k, ¬q ∣ k →
      finitePowerSum (fun j => (u j)⁻¹) k ∈ (algebraMap R K).range := by
    intro k hdiv
    simp only [u, traceOmissionTuple_reciprocal_power_sum p q m zeta t hzeta k,
      if_neg hdiv, zero_add]
    exact ⟨(m : R), map_natCast (algebraMap R K) m⟩
  refine ⟨?_, hvalues, ⟨normR, hnormunit, hnormR⟩, ?_, ?_, hcarry_integral, ?_, hbad⟩
  · simp only [Fintype.card_sum, Fintype.card_fin]
    omega
  · intro k hk hkp
    exact hregular k (Nat.not_dvd_of_pos_of_lt hk (hkp.trans hqp))
  · intro k hk hkp
    exact hreciprocal k (Nat.not_dvd_of_pos_of_lt hk (hkp.trans hqp))
  · intro j hj hjr hji
    apply hregular
    apply nat_not_dvd_below_twice_of_ne q (p + j) (by omega) (by omega)
    dsimp only [q]
    omega

end Litt3.CartierAndSpin

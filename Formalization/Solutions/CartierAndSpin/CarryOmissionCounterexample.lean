import Definitions.CartierAndSpin.NewtonSharpness
import Solutions.CartierAndSpin.MaximalSymmetricValue

namespace Litt3.CartierAndSpin

open Finset Classical

variable {R K Γ : Type*} [CommRing R] [Field K] [Algebra R K]
  [LinearOrderedCommGroupWithZero Γ]

theorem carryOmissionTuple_power_sum (p r : ℕ) [CharP K p] (t : K) (k : ℕ) :
    finitePowerSum (carryOmissionTuple p r t) k = (r : K) := by
  simp [finitePowerSum, carryOmissionTuple, Fintype.sum_sum_type,
    nsmul_eq_mul, CharP.cast_eq_zero]

theorem carryOmissionTuple_reciprocal_power_sum (p r : ℕ) [CharP K p] (t : K) (k : ℕ) :
    finitePowerSum (fun i => (carryOmissionTuple p r t i)⁻¹) k = (r : K) := by
  simp [finitePowerSum, carryOmissionTuple, Fintype.sum_sum_type,
    nsmul_eq_mul, CharP.cast_eq_zero]

theorem carryOmissionTuple_norm (p r : ℕ) (t : K) (ht : t ≠ 0) :
    ∏ i, carryOmissionTuple p r t i = 1 := by
  simp [carryOmissionTuple, Fintype.prod_sum_type, ht]

/-- The actual carry omission example has unit norm and every forward and
reciprocal power trace regular, while e_p fails actual integral descent.
The number of extra unit entries is unrestricted. -/
theorem carry_omission_integrality_counterexample (valuation : Valuation K Γ)
    (hv : valuation.Integers R) (p r : ℕ) [CharP K p] (hp : 0 < p)
    (t : K) (hpole : 1 < valuation t) :
    (∏ i, carryOmissionTuple p r t i = 1) ∧
    (∀ k, finitePowerSum (carryOmissionTuple p r t) k ∈ (algebraMap R K).range) ∧
    (∀ k, finitePowerSum (fun i => (carryOmissionTuple p r t i)⁻¹) k ∈
      (algebraMap R K).range) ∧
    finiteElementarySymmetric (carryOmissionTuple p r t) p ∉ (algebraMap R K).range := by
  have ht : t ≠ 0 := valuation.ne_zero_iff.mp (ne_of_gt (zero_lt_one.trans hpole))
  have hinverse_lt : valuation t⁻¹ < 1 := by
    rw [valuation.map_inv]
    exact inv_lt_one₀ (zero_lt_one.trans hpole) |>.mpr hpole
  have hinverse_ne : valuation t⁻¹ ≠ valuation t := ne_of_lt (hinverse_lt.trans hpole)
  have hinverse_value_ne : (valuation t)⁻¹ ≠ valuation t := by
    simpa only [valuation.map_inv] using hinverse_ne
  have hone_ne : (1 : Γ) ≠ valuation t := ne_of_lt hpole
  let i₀ : Fin p ⊕ (Fin p ⊕ Fin r) := Sum.inl ⟨0, hp⟩
  have hvalues : ∀ i, carryOmissionTuple p r t i ≠ 0 := by
    intro i
    rcases i with i | (i | i)
    · exact ht
    · exact inv_ne_zero ht
    · exact one_ne_zero
  have hmax : ∀ i, valuation (carryOmissionTuple p r t i) ≤
      valuation (carryOmissionTuple p r t i₀) := by
    intro i
    rcases i with i | (i | i)
    · exact le_rfl
    · exact (hinverse_lt.trans hpole).le
    · simpa only [carryOmissionTuple, Sum.elim_inr, Sum.elim_inl, valuation.map_one]
        using hpole.le
  have hcohort : (univ.filter fun i => valuation (carryOmissionTuple p r t i) =
      valuation (carryOmissionTuple p r t i₀)).card = p := by
    have hfilter : (univ.filter fun i => valuation (carryOmissionTuple p r t i) =
        valuation (carryOmissionTuple p r t i₀)) =
        univ.map (⟨Sum.inl, Sum.inl_injective⟩ : Fin p ↪ Fin p ⊕ (Fin p ⊕ Fin r)) := by
      ext i
      rcases i with i | (i | i)
      · simp [carryOmissionTuple, i₀]
      · simp [carryOmissionTuple, i₀, hinverse_value_ne]
      · simp [carryOmissionTuple, i₀, hone_ne]
    rw [hfilter, card_map, card_univ, Fintype.card_fin]
  have hnonregular := maximal_pole_cohort_symmetric_coefficient_nonregular valuation
    (carryOmissionTuple p r t) i₀ hvalues hmax hpole
  rw [hcohort] at hnonregular
  refine ⟨carryOmissionTuple_norm p r t ht, ?_, ?_, ?_⟩
  · intro k
    rw [carryOmissionTuple_power_sum]
    exact ⟨(r : R), map_natCast (algebraMap R K) r⟩
  · intro k
    rw [carryOmissionTuple_reciprocal_power_sum]
    exact ⟨(r : R), map_natCast (algebraMap R K) r⟩
  · rintro ⟨a, ha⟩
    rw [← ha] at hnonregular
    exact hnonregular.not_ge (hv.map_le_one a)

end Litt3.CartierAndSpin

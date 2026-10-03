import Solutions.CartierAndSpin.LocalNewtonCarries
import Solutions.CartierAndSpin.ReciprocalElementary
import Solutions.CartierAndSpin.ReciprocalBoundaryConclusion

namespace Litt3.CartierAndSpin

open Finset IsLocalRing Classical

variable {R K Γ ι : Type*} [CommRing R] [IsLocalRing R] [Field K]
  [Algebra R K] [LinearOrderedCommGroupWithZero Γ] [Fintype ι]

/-- All characteristic carries in arbitrary degree. The input characteristic
belongs only to the residue field; the actual fraction field can be of
characteristic zero. The proof uses Newton induction, actual reciprocal
coefficients, and unique dominance of the maximal-pole product. -/
theorem all_newton_carries_force_units (v : Valuation K Γ) (hv : v.Integers R)
    (p : ℕ) [CharP (ResidueField R) p] (hp : 0 < p) (u : ι → K)
    (hdegree : p ≤ Fintype.card ι)
    (hnorm : v (∏ i, u i) = 1)
    (hforward : ∀ k, 0 < k → k < p → finitePowerSum u k ∈ (algebraMap R K).range)
    (hreciprocal : ∀ k, 0 < k → k < p →
      finitePowerSum (fun i => (u i)⁻¹) k ∈ (algebraMap R K).range)
    (hcarries : ∀ k, 0 < k → k ≤ Fintype.card ι - p → p ∣ k →
      finiteElementarySymmetric u k ∈ (algebraMap R K).range)
    (hextra : ∀ k, p ≤ k → k ≤ Fintype.card ι - p → ¬p ∣ k →
      finitePowerSum u k ∈ (algebraMap R K).range) :
    Specifications.TupleDescendsAsUnits (R := R) u := by
  let f := algebraMap R K
  have hlow (tuple : ι → K)
      (htrace : ∀ k, 0 < k → k < p → finitePowerSum tuple k ∈ f.range) :
      ∀ k, k < p → finiteElementarySymmetric tuple k ∈ f.range := by
    have h := local_newton_carry_membership f p (p - 1) tuple (by
      intro k hk hkle hdiv
      exact False.elim (Nat.not_dvd_of_pos_of_lt hk (by omega) hdiv))
      (fun k hk hkle _ => htrace k hk (by omega))
    exact fun k hk => (h k (by omega)).1
  have hforwardlow := hlow u hforward
  have hreciprocallow := hlow (fun i => (u i)⁻¹) hreciprocal
  have hinduction := local_newton_carry_membership f p (Fintype.card ι - p) u
    hcarries (by
      intro k hk hkle hdiv
      by_cases hkp : k < p
      · exact hforward k hk hkp
      · exact hextra k (le_of_not_gt hkp) hkle hdiv)
  have hvalues : ∀ i, u i ≠ 0 := by
    intro i hzero
    have hproductzero : (∏ i, u i) = 0 := prod_eq_zero (mem_univ i) hzero
    simpa [hproductzero] using hnorm
  have hnormregular : (∏ i, u i) ∈ f.range := hv.exists_of_le_one hnorm.le
  have helementary : ∀ k, k ≤ Fintype.card ι → finiteElementarySymmetric u k ∈ f.range := by
    intro k hkn
    by_cases hkle : k ≤ Fintype.card ι - p
    · exact (hinduction k hkle).1
    have hcomp : Fintype.card ι - k < p := by omega
    have hcomp_le : Fintype.card ι - k ≤ Fintype.card ι := Nat.sub_le _ _
    have hrecip := hreciprocallow (Fintype.card ι - k) hcomp
    have hregular := f.range.mul_mem hnormregular hrecip
    rw [← finiteElementarySymmetric_reciprocal u hvalues _ hcomp_le, Nat.sub_sub_self hkn]
      at hregular
    exact hregular
  have hregular : ∀ i, v (u i) ≤ 1 := by
    intro i
    by_contra hipole
    have hpole : 1 < v (u i) := lt_of_not_ge hipole
    obtain ⟨i₀, _, hmax⟩ := univ.exists_max_image (fun i => v (u i)) ⟨i, mem_univ _⟩
    have hmaximum : ∀ j, v (u j) ≤ v (u i₀) := fun j => hmax j (mem_univ _)
    have hpole₀ : 1 < v (u i₀) := lt_of_lt_of_le hpole (hmaximum i)
    have hcarry_pole := maximal_pole_cohort_symmetric_coefficient_nonregular
      v u i₀ hvalues hmaximum hpole₀
    obtain ⟨b, hb⟩ := helementary
      (univ.filter fun i => v (u i) = v (u i₀)).card
      ((card_filter_le _ _).trans_eq card_univ)
    have hle := hv.map_le_one b
    rw [hb] at hle
    exact hcarry_pole.not_ge hle
  exact valuation_tuple_units_of_regular_entries_unit_norm v hv u hregular hnorm

end Litt3.CartierAndSpin

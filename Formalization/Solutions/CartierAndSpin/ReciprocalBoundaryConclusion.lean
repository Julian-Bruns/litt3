import Theorems.CartierAndSpin.ReciprocalTraceBoundary
import Solutions.CartierAndSpin.ReciprocalTraceBoundary
import Solutions.CartierAndSpin.BoundaryLeadingResidues

namespace Litt3.CartierAndSpin

open Finset IsLocalRing Classical

variable {R K Γ ι : Type*} [CommRing R] [IsLocalRing R] [Field K]
  [Algebra R K] [LinearOrderedCommGroupWithZero Γ] [Fintype ι]

omit [IsLocalRing R] in
theorem valuation_tuple_units_of_regular_entries_unit_norm (v : Valuation K Γ)
    (hv : v.Integers R) (u : ι → K) (hregular : ∀ i, v (u i) ≤ 1)
    (hnorm : v (∏ i, u i) = 1) : Specifications.TupleDescendsAsUnits (R := R) u := by
  have hprod : (∏ i, v (u i)) = 1 := by simpa only [map_prod] using hnorm
  have hunit_values : ∀ i, v (u i) = 1 :=
    fun i => (prod_eq_one_iff_of_le_one' (fun i _ => hregular i)).mp hprod i (mem_univ _)
  intro i
  obtain ⟨b, hb⟩ := hv.exists_of_le_one (hregular i)
  exact ⟨b, hv.isUnit_of_one' (by rw [hb]; exact hunit_values i), hb⟩

/-- The entire reciprocal source clause, generalized to arbitrary valuation
rings. No leading coefficients, cohort partition, or carry pole is assumed. -/
theorem reciprocalTraceBoundaryOutcome (v : Valuation K Γ) (hv : v.Integers R)
    (p : ℕ) [CharP (ResidueField R) p] (hp : 0 < p) (u : ι → K)
    (hdegree : Fintype.card ι ≤ 2 * p) (hnorm : v (∏ i, u i) = 1)
    (hforward : ∀ k, 0 < k → k < p → v (finitePowerSum u k) ≤ 1)
    (hreciprocal : ∀ k, 0 < k → k < p →
      v (finitePowerSum (fun i => (u i)⁻¹) k) ≤ 1) :
    Specifications.ReciprocalTraceBoundaryOutcome (R := R) v u p := by
  by_cases hregular : ∀ i, v (u i) ≤ 1
  · exact Or.inl (valuation_tuple_units_of_regular_entries_unit_norm v hv u hregular hnorm)
  have hexists : ∃ i, 1 < v (u i) := by
    simpa only [not_forall, not_le] using hregular
  obtain ⟨i, hipole⟩ := hexists
  have hboundary : Fintype.card ι = 2 * p := by
    by_contra hne
    have hlt : Fintype.card ι < 2 * p := lt_of_le_of_ne hdegree hne
    obtain ⟨b, hunit, hb⟩ := reciprocal_power_traces_force_units_below_twice_characteristic
      v hv p u hlt hnorm hforward hreciprocal i
    have hone : v (u i) = 1 := by rw [← hb]; exact hv.one_of_isUnit hunit
    exact hipole.ne' hone
  obtain ⟨i₀, j₀, hpole₀, hpoleinverse, hmaximum, hmaximuminverse,
      hpcard, hzcard, hpartition, hreciprocal_values⟩ :=
    reciprocal_trace_boundary_pole_zero_partition v hv p hp u hboundary hnorm
      hforward hreciprocal i hipole
  have hpole_leading := maximal_p_cohort_actual_leading_residues v hv p hp u i₀
    hpole₀ hmaximum hpcard hforward
  have hzero_leading := maximal_p_cohort_actual_leading_residues v hv p hp
    (fun i => (u i)⁻¹) j₀ hpoleinverse hmaximuminverse hzcard hreciprocal
  have hvalues : ∀ i, u i ≠ 0 := by
    intro i hzero
    have hproductzero : (∏ i, u i) = 0 := prod_eq_zero (mem_univ i) hzero
    simpa [hproductzero] using hnorm
  have hcarry : v (finiteElementarySymmetric u p) = v (u i₀) ^ p := by
    rw [← hpcard]
    exact maximal_cohort_elementarySymmetric_value v u i₀ hvalues hmaximum
  have hcarry_pole : 1 < v (finiteElementarySymmetric u p) := by
    rw [hcarry]
    exact one_lt_pow₀ hpole₀ hp.ne'
  exact Or.inr ⟨hboundary, i₀, j₀, hpole₀, hpoleinverse, hpcard, hzcard,
    hpartition, hreciprocal_values, hpole_leading, hzero_leading, hcarry, hcarry_pole⟩

theorem reciprocal_power_traces_and_carry_force_units (v : Valuation K Γ)
    (hv : v.Integers R) (p : ℕ) [CharP (ResidueField R) p] (hp : 0 < p)
    (u : ι → K) (hdegree : Fintype.card ι ≤ 2 * p) (hnorm : v (∏ i, u i) = 1)
    (hforward : ∀ k, 0 < k → k < p → v (finitePowerSum u k) ≤ 1)
    (hreciprocal : ∀ k, 0 < k → k < p →
      v (finitePowerSum (fun i => (u i)⁻¹) k) ≤ 1)
    (hcarry : v (finiteElementarySymmetric u p) ≤ 1) :
    Specifications.TupleDescendsAsUnits (R := R) u := by
  rcases reciprocalTraceBoundaryOutcome v hv p hp u hdegree hnorm hforward hreciprocal with
    hunits | ⟨_, i₀, j₀, _, _, _, _, _, _, _, _, _, hpole⟩
  · exact hunits
  · exact False.elim (hpole.not_ge hcarry)

end Litt3.CartierAndSpin

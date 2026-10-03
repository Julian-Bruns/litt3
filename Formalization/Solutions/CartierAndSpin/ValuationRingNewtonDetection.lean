import Solutions.CartierAndSpin.ValuationRingIntegrality
import Solutions.CartierAndSpin.ReciprocalBoundaryConclusion
import Solutions.CartierAndSpin.NewtonCarryCriterion

namespace Litt3.CartierAndSpin

open IsLocalRing

variable {R K ι : Type*} [CommRing R] [IsDomain R] [ValuationRing R]
  [Field K] [Algebra R K] [IsFractionRing R K] [Fintype ι]

/-- Actual unit norm, rather than a separately assumed valuation equation,
supplies the canonical valuation norm hypothesis. -/
theorem valuationRing_unit_norm_value (u : ι → K)
    (hnorm : ∃ b : R, IsUnit b ∧ algebraMap R K b = ∏ i, u i) :
    (ValuationRing.valuation R K) (∏ i, u i) = 1 := by
  obtain ⟨b, hbunit, hb⟩ := hnorm
  rw [← hb]
  exact valuationRing_valuation_integers.one_of_isUnit hbunit

/-- The entire reciprocal conclusion from actual R-membership and unit
norm inputs, with the actual canonical fraction-field valuation. -/
theorem valuationRing_reciprocalTraceBoundaryOutcome (p : ℕ) [CharP (ResidueField R) p]
    (hp : 0 < p) (u : ι → K) (hdegree : Fintype.card ι ≤ 2 * p)
    (hnorm : ∃ b : R, IsUnit b ∧ algebraMap R K b = ∏ i, u i)
    (hforward : ∀ k, 0 < k → k < p → finitePowerSum u k ∈ (algebraMap R K).range)
    (hreciprocal : ∀ k, 0 < k → k < p →
      finitePowerSum (fun i => (u i)⁻¹) k ∈ (algebraMap R K).range) :
    Specifications.ReciprocalTraceBoundaryOutcome (R := R) (ValuationRing.valuation R K) u p := by
  apply reciprocalTraceBoundaryOutcome (ValuationRing.valuation R K)
    valuationRing_valuation_integers p hp u hdegree (valuationRing_unit_norm_value u hnorm)
  · intro k hk hkp
    obtain ⟨b, hb⟩ := hforward k hk hkp
    rw [← hb]
    exact valuationRing_valuation_integers.map_le_one b
  · intro k hk hkp
    obtain ⟨b, hb⟩ := hreciprocal k hk hkp
    rw [← hb]
    exact valuationRing_valuation_integers.map_le_one b

/-- The arbitrary-degree iff using only the source's actual membership
and actual unit-norm inputs. This includes actual DVRs in mixed characteristic. -/
theorem valuationRing_newtonCarry_unit_iff_conditions (p : ℕ) [CharP (ResidueField R) p]
    (hp : 0 < p) (u : ι → K) (hdegree : p ≤ Fintype.card ι)
    (hnorm : ∃ b : R, IsUnit b ∧ algebraMap R K b = ∏ i, u i)
    (hforward : ∀ k, 0 < k → k < p → finitePowerSum u k ∈ (algebraMap R K).range)
    (hreciprocal : ∀ k, 0 < k → k < p →
      finitePowerSum (fun i => (u i)⁻¹) k ∈ (algebraMap R K).range) :
    Specifications.TupleDescendsAsUnits (R := R) u ↔
      Specifications.NewtonCarryConditions (R := R) u p :=
  newtonCarry_unit_iff_conditions (ValuationRing.valuation R K) valuationRing_valuation_integers
    p hp u hdegree (valuationRing_unit_norm_value u hnorm) hforward hreciprocal

theorem valuationRing_newtonCarry_unit_iff_short_conditions (p r : ℕ)
    [CharP (ResidueField R) p] (hp : 0 < p) (hrp : r < p) (u : ι → K)
    (hdegree : Fintype.card ι = 2 * p + r)
    (hnorm : ∃ b : R, IsUnit b ∧ algebraMap R K b = ∏ i, u i)
    (hforward : ∀ k, 0 < k → k < p → finitePowerSum u k ∈ (algebraMap R K).range)
    (hreciprocal : ∀ k, 0 < k → k < p →
      finitePowerSum (fun i => (u i)⁻¹) k ∈ (algebraMap R K).range) :
    Specifications.TupleDescendsAsUnits (R := R) u ↔
      (finiteElementarySymmetric u p ∈ (algebraMap R K).range ∧
        ∀ i, 0 < i → i ≤ r → finitePowerSum u (p + i) ∈ (algebraMap R K).range) :=
  newtonCarry_unit_iff_short_conditions (ValuationRing.valuation R K) valuationRing_valuation_integers
    p r hp hrp u hdegree (valuationRing_unit_norm_value u hnorm) hforward hreciprocal

/-- The exact degree-eleven/residue-characteristic-five specialization. -/
theorem valuationRing_degree_eleven_char_five_unit_iff [CharP (ResidueField R) 5]
    (u : ι → K) (hdegree : Fintype.card ι = 11)
    (hnorm : ∃ b : R, IsUnit b ∧ algebraMap R K b = ∏ i, u i)
    (hforward : ∀ k, 0 < k → k < 5 → finitePowerSum u k ∈ (algebraMap R K).range)
    (hreciprocal : ∀ k, 0 < k → k < 5 →
      finitePowerSum (fun i => (u i)⁻¹) k ∈ (algebraMap R K).range) :
    Specifications.TupleDescendsAsUnits (R := R) u ↔
      (finiteElementarySymmetric u 5 ∈ (algebraMap R K).range ∧
        finitePowerSum u 6 ∈ (algebraMap R K).range) := by
  have hcriterion := valuationRing_newtonCarry_unit_iff_short_conditions 5 1 (by decide)
    (by decide) u (by omega) hnorm hforward hreciprocal
  apply hcriterion.trans
  constructor
  · rintro ⟨he, hpowers⟩
    exact ⟨he, hpowers 1 (by decide) (by decide)⟩
  · rintro ⟨he, hpower⟩
    refine ⟨he, ?_⟩
    intro i hi hi1
    have hieq : i = 1 := by omega
    subst i
    exact hpower

end Litt3.CartierAndSpin

import Solutions.CartierAndSpin.ValuationMaximalCohorts
import Solutions.CartierAndSpin.CharacteristicBoundaryCohort

namespace Litt3.CartierAndSpin

open Finset IsLocalRing Classical

variable {R K Γ ι : Type*} [CommRing R] [IsLocalRing R] [Field K]
  [Algebra R K] [LinearOrderedCommGroupWithZero Γ] [Fintype ι]

/-- If exactly p branches have maximal pole order, regular first p−1 traces
force all their actual normalized leading residues to be one. Scaling and
integer representatives are constructed; no perfect residue field or
supplied leading-coefficient expansion is assumed. -/
theorem maximal_p_cohort_actual_leading_residues (v : Valuation K Γ)
    (hv : v.Integers R) (p : ℕ) [CharP (ResidueField R) p] (hp : 0 < p)
    (u : ι → K) (i₀ : ι) (hpole : 1 < v (u i₀))
    (hmaximum : ∀ i, v (u i) ≤ v (u i₀))
    (hcard : (univ.filter fun i => v (u i) = v (u i₀)).card = p)
    (hmoments : ∀ k, 0 < k → k < p → v (finitePowerSum u k) ≤ 1) :
    ∃ b : ι → R,
      (∀ i, algebraMap R K (b i) = u i / u i₀) ∧
      (∀ i, residue R (b i) = if v (u i) = v (u i₀) then 1 else 0) := by
  haveI : Fact p.Prime := ⟨CharP.char_prime_of_ne_zero (ResidueField R) hp.ne'⟩
  have hpositive := zero_lt_one.trans hpole
  have hscaled_exists : ∀ i, ∃ b : R, algebraMap R K b = u i / u i₀ := by
    intro i
    apply hv.exists_of_le_one
    rw [v.map_div]
    exact (div_le_one₀ hpositive).mpr (hmaximum i)
  choose b hb using hscaled_exists
  have hsupport : ∀ i, residue R (b i) ≠ 0 ↔ v (u i) = v (u i₀) :=
    fun i => scaled_residue_nonzero_iff_maximal_value v hv (b i) (u i) (u i₀)
      hpositive.ne' (hb i)
  let family := fun i : {i // residue R (b i) ≠ 0} => residue R (b i)
  have hfamilycard : Fintype.card {i // residue R (b i) ≠ 0} = p := by
    rw [Fintype.card_subtype]
    simpa only [hsupport] using hcard
  have hfamilymoments : ∀ k, 0 < k → k < p → finitePowerSum family k = 0 := by
    intro k hk hkp
    have hmoment := regular_moment_scaled_residue_zero v hv (fun _ => 1) b u (u i₀)
      hpole hb 0 k hk (by simpa [finiteWeightedPowerSum, finitePowerSum] using hmoments k hk hkp)
    rw [finiteWeightedPowerSum_restrict_nonzero _ _ 0 k hk] at hmoment
    simpa [finiteWeightedPowerSum, finitePowerSum, family] using hmoment
  have hequal := characteristic_boundary_cohort_entries_equal p family hfamilycard hfamilymoments
  have hu₀ : u i₀ ≠ 0 := v.ne_zero_iff.mp hpositive.ne'
  have hb₀ : b i₀ = 1 := hv.hom_inj (by simpa [hu₀] using hb i₀)
  refine ⟨b, hb, ?_⟩
  intro i
  by_cases hi : v (u i) = v (u i₀)
  · rw [if_pos hi]
    have h := hequal ⟨i, (hsupport i).mpr hi⟩ ⟨i₀, (hsupport i₀).mpr rfl⟩
    simpa only [family, hb₀, map_one] using h
  · rw [if_neg hi]
    exact not_ne_iff.mp (fun h => hi ((hsupport i).mp h))

end Litt3.CartierAndSpin

import Solutions.CartierAndSpin.ValuationLeadingMoments
import Mathlib.Algebra.Order.BigOperators.Group.Finset

namespace Litt3.CartierAndSpin

open Finset IsLocalRing Classical

variable {R K Γ ι : Type*} [CommRing R] [IsLocalRing R] [Field K]
  [Algebra R K] [LinearOrderedCommGroupWithZero Γ] [Fintype ι]

/-- Regular power traces below the residue characteristic force every
nonempty maximal-pole cohort to have at least p entries. The count is the
actual maximal-value fiber, without a supplied leading-coefficient model. -/
theorem regularPowerSums_maximal_pole_cohort_card_ge (v : Valuation K Γ)
    (hv : v.Integers R) (p : ℕ) [CharP (ResidueField R) p]
    (u : ι → K) (i₀ : ι) (hpole : 1 < v (u i₀))
    (hmaximum : ∀ i, v (u i) ≤ v (u i₀))
    (hmoments : ∀ k, 0 < k → k < p → v (finitePowerSum u k) ≤ 1) :
    p ≤ (univ.filter fun i => v (u i) = v (u i₀)).card := by
  by_contra hnot
  have hsmall : (univ.filter fun i => v (u i) = v (u i₀)).card < p :=
    lt_of_not_ge hnot
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
  have hcard : Fintype.card {i // residue R (b i) ≠ 0} =
      (univ.filter fun i => v (u i) = v (u i₀)).card := by
    rw [Fintype.card_subtype]
    simp only [hsupport]
  have hnonempty : 0 < Fintype.card {i // residue R (b i) ≠ 0} :=
    Fintype.card_pos_iff.mpr ⟨⟨i₀, (hsupport i₀).mpr rfl⟩⟩
  apply characteristic_cohort_powerSums_cannot_vanish p family hnonempty
    (by rw [hcard]; exact hsmall) (fun i => i.property)
  intro k hk hkle
  have hkp : k < p := lt_of_le_of_lt hkle (by rw [hcard]; exact hsmall)
  have hmoment := regular_moment_scaled_residue_zero v hv (fun _ => 1) b u (u i₀)
    hpole hb 0 k hk (by simpa [finiteWeightedPowerSum, finitePowerSum] using hmoments k hk hkp)
  rw [finiteWeightedPowerSum_restrict_nonzero _ _ 0 k hk] at hmoment
  simpa [finiteWeightedPowerSum, finitePowerSum, family] using hmoment

/-- A unit product together with a pole forces an actual zero branch.
Only the ordered value group is used in this step. -/
theorem unit_norm_and_pole_force_zero (v : Valuation K Γ) (u : ι → K)
    (hnorm : v (∏ i, u i) = 1) (i₀ : ι) (hpole : 1 < v (u i₀)) :
    ∃ i, v (u i) < 1 := by
  by_contra hnozero
  have hnonnegative : ∀ i, 1 ≤ v (u i) := fun i =>
    le_of_not_gt (not_exists.mp hnozero i)
  have hprod : (∏ i, v (u i)) = 1 := by simpa only [map_prod] using hnorm
  have hall := (prod_eq_one_iff_of_one_le' (fun i _ => hnonnegative i)).mp hprod
  exact hpole.ne' (hall i₀ (mem_univ _))

end Litt3.CartierAndSpin

import Theorems.CartierAndSpin.ValuationIntegrality
import Solutions.CartierAndSpin.ValuationLeadingMoments

namespace Litt3.CartierAndSpin

open Finset IsLocalRing Classical

variable {R K Γ ι : Type*} [CommRing R] [IsLocalRing R] [Field K]
  [Algebra R K] [LinearOrderedCommGroupWithZero Γ] [Fintype ι]

/-- Weighted trace integrality, generalized from DVRs to arbitrary valuation
rings. The proof chooses an actual largest valued entry and constructs the
scaled representatives and residue coefficients. -/
theorem weightedPowerTraceIntegrality (v : Valuation K Γ) (hv : v.Integers R)
    (p : ℕ) [CharP (ResidueField R) p] (a : ι → R) (u : ι → K)
    (d r : ℕ) (hrp : r < p) :
    Specifications.WeightedPowerTraceIntegrality v a u d r := by
  intro hcohorts hmoments i
  apply hv.exists_of_le_one
  by_contra hpole
  have hipole : 1 < v (u i) := lt_of_not_ge hpole
  obtain ⟨i₀, _, hmax⟩ := univ.exists_max_image (fun i => v (u i)) ⟨i, mem_univ _⟩
  have hmaximum : ∀ j, v (u j) ≤ v (u i₀) := fun j => hmax j (mem_univ _)
  have hpole₀ : 1 < v (u i₀) := lt_of_lt_of_le hipole (hmaximum i)
  have hvalnonzero : v (u i₀) ≠ 0 := ne_of_gt (zero_lt_one.trans hpole₀)
  have hu₀ : u i₀ ≠ 0 := v.ne_zero_iff.mp hvalnonzero
  have hscaled_exists : ∀ j, ∃ b : R, algebraMap R K b = u j / u i₀ := by
    intro j
    apply hv.exists_of_le_one
    rw [v.map_div]
    exact (div_le_one₀ (zero_lt_one.trans hpole₀)).mpr (hmaximum j)
  choose b hb using hscaled_exists
  have hsupport : ∀ j, residue R (b j) ≠ 0 ↔ v (u j) = v (u i₀) :=
    fun j => scaled_residue_nonzero_iff_maximal_value v hv (b j) (u j) (u i₀)
      hvalnonzero (hb j)
  obtain ⟨hclasses, hsizes⟩ := hcohorts i₀ hpole₀ hmaximum
  have hclasses' : ((univ.filter fun j => residue R (b j) ≠ 0).image
      (fun j => residue R (a j))).card ≤ d := by
    simpa only [hsupport] using hclasses
  have hsizes' : ∀ c : ResidueField R,
      (univ.filter fun j => residue R (b j) ≠ 0 ∧ residue R (a j) = c).card ≤ r := by
    simpa only [hsupport] using hsizes
  have hzero := finiteWeightedPowerSums_force_zero_of_support_counts p
    (fun j => residue R (a j)) (fun j => residue R (b j))
    hclasses' hsizes' hrp (by
      intro j hj k hk hkr
      exact regular_moment_scaled_residue_zero v hv a b u (u i₀) hpole₀ hb j k hk
        (hmoments j hj k hk hkr))
  have hb₀ : b i₀ = 1 := hv.hom_inj (by simpa [hu₀] using hb i₀)
  have hone : (1 : ResidueField R) = 0 := by simpa [hb₀] using hzero i₀
  exact one_ne_zero hone

end Litt3.CartierAndSpin

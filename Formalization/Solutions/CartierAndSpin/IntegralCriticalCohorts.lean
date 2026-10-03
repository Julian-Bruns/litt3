import Solutions.CartierAndSpin.IntegralFirstTraces
import Solutions.CartierAndSpin.CriticalResidueCohorts
import Solutions.CartierAndSpin.ValuationIntegrality

namespace Litt3.CartierAndSpin

open Finset Polynomial IsLocalRing Classical

variable {R K Γ ι : Type*} [CommRing R] [IsLocalRing R] [Nontrivial R] [Field K]
  [Algebra R K] [LinearOrderedCommGroupWithZero Γ] [Fintype ι]

theorem valuation_quotient_integral_of_unit_denominator (v : Valuation K Γ)
    (hv : v.Integers R) (a b : R) (hb : IsUnit b) :
    v (algebraMap R K a / algebraMap R K b) ≤ 1 := by
  rw [v.map_div, hv.one_of_isUnit hb, div_one]
  exact hv.map_le_one a

/-- For an actual integral split model with P'=r*phi*D, unit r and unit
phi at the roots, the nonzero reduction of D controls the actual maximal
pole cohorts. Its leading coefficient need not be a unit, and roots of
the reduction of D may be repeated. -/
theorem integral_critical_maximal_cohorts_bounded (v : Valuation K Γ)
    (hv : v.Integers R) (w : ι → R) (r : R) (phi D U : R[X])
    (hr : IsUnit r) (hphi_units : ∀ i, IsUnit (phi.eval (w i)))
    (hderivative : (finiteRootPolynomial w).derivative = C r * phi * D)
    (hD : D.map (residue R) ≠ 0) :
    MaximalPoleCohortsBounded v w
      (fun i => U.eval₂ (algebraMap R K) (algebraMap R K (w i)) /
        D.eval₂ (algebraMap R K) (algebraMap R K (w i)))
      (D.map (residue R)).natDegree ((D.map (residue R)).natDegree + 1) := by
  let node := fun i => residue R (w i)
  let u := fun i => U.eval₂ (algebraMap R K) (algebraMap R K (w i)) /
    D.eval₂ (algebraMap R K) (algebraMap R K (w i))
  have hpole_critical : ∀ i, 1 < v (u i) → (D.map (residue R)).eval (node i) = 0 := by
    intro i hpole
    have hnotunit : ¬IsUnit (D.eval (w i)) := by
      intro hunit
      have hle := valuation_quotient_integral_of_unit_denominator v hv
        (U.eval (w i)) (D.eval (w i)) hunit
      dsimp only [u] at hpole
      simp only [eval₂_at_apply] at hpole
      exact hpole.not_ge hle
    have hresidue : residue R (D.eval (w i)) = 0 :=
      not_ne_iff.mp (fun h => hnotunit ((residue_ne_zero_iff_isUnit _).mp h))
    simpa only [node, eval_map_apply] using hresidue
  have hcohort_size : ∀ c : ResidueField R,
      (univ.filter fun i => node i = c).card ≤ (D.map (residue R)).natDegree + 1 := by
    intro c
    by_cases hnonempty : (univ.filter fun i => node i = c).Nonempty
    · obtain ⟨i, hi⟩ := hnonempty
      have hc : node i = c := (mem_filter.mp hi).2
      have hphi_eval : ((C r * phi).map (residue R)).eval c ≠ 0 := by
        rw [← hc]
        change ((C r * phi).map (residue R)).eval (residue R (w i)) ≠ 0
        rw [eval_map_apply, eval_mul, eval_C, map_mul]
        exact mul_ne_zero ((residue_ne_zero_iff_isUnit r).mpr hr)
          ((residue_ne_zero_iff_isUnit _).mpr (hphi_units i))
      apply critical_residue_cohort_card_le node 1 c
        ((finiteRootPolynomial w).map (residue R))
        ((C r * phi).map (residue R)) (D.map (residue R)) one_ne_zero ?_ ?_ hD hphi_eval
      · simp only [finiteRootPolynomial_map, C_1, one_mul]
        rfl
      · rw [derivative_map, hderivative, Polynomial.map_mul]
    · have hempty : (univ.filter fun i => node i = c) = ∅ := not_nonempty_iff_eq_empty.mp hnonempty
      simp [hempty]
  intro i₀ hpole₀ hmaximum
  let cohort := univ.filter fun i => v (u i) = v (u i₀)
  have hroot_subset : cohort.image node ⊆ (D.map (residue R)).roots.toFinset := by
    intro c hc
    obtain ⟨i, hi, rfl⟩ := mem_image.mp hc
    apply Multiset.mem_toFinset.mpr
    apply (mem_roots hD).mpr
    apply hpole_critical i
    simpa only [(mem_filter.mp hi).2] using hpole₀
  constructor
  · exact (card_le_card hroot_subset).trans
      ((Multiset.toFinset_card_le (D.map (residue R)).roots).trans
        (card_roots' (D.map (residue R))))
  · intro c
    apply le_trans (card_le_card (show
      (univ.filter fun i => v (u i) = v (u i₀) ∧ residue R (w i) = c) ⊆
        univ.filter fun i => node i = c from fun i hi =>
          mem_filter.mpr ⟨mem_univ _, (mem_filter.mp hi).2.2⟩))
    exact hcohort_size c

end Litt3.CartierAndSpin

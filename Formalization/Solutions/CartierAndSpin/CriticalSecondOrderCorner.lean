import Solutions.CartierAndSpin.SelectedCriticalContactCalculus

namespace Litt3.CartierAndSpin

open Polynomial Finset

variable {k : Type*} [Field k]

/-- The integral second-order corner improves the nominal zero order
to a genuine zero in the residue field. The proof uses the exact source
coefficient and the actual equation, not an assumed initial-form degree. -/
theorem critical_second_order_corner_positive
    (F U D V Q : (LaurentSeries k)[X]) (s : ℕ) (hs : 3 ≤ s)
    (hidentity : U ^ 2 - F * Q = D * V)
    (hFreg : ∀ j, (0 : WithTop ℤ) ≤ (F.coeff j).orderTop)
    (hUreg : ∀ j, (0 : WithTop ℤ) ≤ (U.coeff j).orderTop)
    (hDreg : ∀ j, (0 : WithTop ℤ) ≤ (D.coeff j).orderTop)
    (hVreg : ∀ j, (0 : WithTop ℤ) ≤ (V.coeff j).orderTop)
    (hQreg : ∀ j, (0 : WithTop ℤ) ≤ (Q.coeff j).orderTop)
    (hFexact : (F.coeff s).orderTop = 0)
    (hF : ∀ j : ℕ, ((2 * (s : ℤ) - 2 * (j : ℤ) : ℤ) : WithTop ℤ) ≤ (F.coeff j).orderTop)
    (hU : ∀ j : ℕ, ((2 * (s : ℤ) - 3 - 2 * (j : ℤ) : ℤ) : WithTop ℤ) ≤ (U.coeff j).orderTop)
    (hD : ∀ j : ℕ, ((2 * (s : ℤ) - 5 - 2 * (j : ℤ) : ℤ) : WithTop ℤ) ≤ (D.coeff j).orderTop)
    (hV : ∀ j : ℕ, ((2 * (s : ℤ) - 1 - 2 * (j : ℤ) : ℤ) : WithTop ℤ) ≤ (V.coeff j).orderTop)
    (hQ : ∀ j : ℕ, ((2 * (s : ℤ) - 6 - 2 * (j : ℤ) : ℤ) : WithTop ℤ) ≤ (Q.coeff j).orderTop) :
    (1 : WithTop ℤ) ≤ (Q.coeff (s - 3)).orderTop := by
  classical
  let N := 2 * s - 3
  have hN : (N : ℤ) = 2 * (s : ℤ) - 3 := by dsimp [N]; omega
  have hsmall (i j : ℕ) (hij : i + j = N) :
      (i : ℤ) + (j : ℤ) = 2 * (s : ℤ) - 3 := by
    have hcast : (i : ℤ) + (j : ℤ) = (N : ℤ) := by exact_mod_cast hij
    omega
  have hUU : (1 : WithTop ℤ) ≤ ((U ^ 2).coeff N).orderTop := by
    rw [pow_two, coeff_mul]
    apply laurent_orderTop_sum_bound
    intro ij hij
    have hsum := hsmall ij.1 ij.2 (mem_antidiagonal.mp hij)
    by_cases hi : (ij.1 : ℤ) ≤ (s : ℤ) - 2
    · have hpos : (1 : WithTop ℤ) ≤ (U.coeff ij.1).orderTop :=
        le_trans (WithTop.coe_le_coe.mpr (by omega)) (hU ij.1)
      simpa only [add_zero] using laurent_orderTop_mul_bound _ _ 1 0 hpos (hUreg ij.2)
    · have hpos : (1 : WithTop ℤ) ≤ (U.coeff ij.2).orderTop :=
        le_trans (WithTop.coe_le_coe.mpr (by omega)) (hU ij.2)
      simpa only [zero_add] using laurent_orderTop_mul_bound _ _ 0 1 (hUreg ij.1) hpos
  have hDV : (1 : WithTop ℤ) ≤ ((D * V).coeff N).orderTop := by
    rw [coeff_mul]
    apply laurent_orderTop_sum_bound
    intro ij hij
    have hsum := hsmall ij.1 ij.2 (mem_antidiagonal.mp hij)
    by_cases hi : (ij.1 : ℤ) ≤ (s : ℤ) - 3
    · have hpos : (1 : WithTop ℤ) ≤ (D.coeff ij.1).orderTop :=
        le_trans (WithTop.coe_le_coe.mpr (by omega)) (hD ij.1)
      simpa only [add_zero] using laurent_orderTop_mul_bound _ _ 1 0 hpos (hVreg ij.2)
    · have hpos : (1 : WithTop ℤ) ≤ (V.coeff ij.2).orderTop :=
        le_trans (WithTop.coe_le_coe.mpr (by omega)) (hV ij.2)
      simpa only [zero_add] using laurent_orderTop_mul_bound _ _ 0 1 (hDreg ij.1) hpos
  have hproduct : F * Q = U ^ 2 - D * V := by linear_combination -hidentity
  have hP : (1 : WithTop ℤ) ≤ ((F * Q).coeff N).orderTop := by
    rw [hproduct, coeff_sub]
    exact le_trans (le_min hUU hDV) HahnSeries.min_orderTop_le_orderTop_sub
  by_contra hnot
  have hQzero : (Q.coeff (s - 3)).orderTop = 0 := by
    by_cases hz : Q.coeff (s - 3) = 0
    · simp [hz] at hnot
    rw [← HahnSeries.order_eq_orderTop_of_ne_zero hz] at hnot ⊢
    have hreg := hQreg (s - 3)
    rw [← HahnSeries.order_eq_orderTop_of_ne_zero hz] at hreg
    have hnonneg := WithTop.coe_le_coe.mp hreg
    have hlt : (Q.coeff (s - 3)).order < 1 := by
      exact WithTop.coe_lt_coe.mp (lt_of_not_ge hnot)
    have ho : (Q.coeff (s - 3)).order = 0 := by omega
    simp [ho]
  have hmem : (s, s - 3) ∈ antidiagonal N := by
    apply mem_antidiagonal.mpr
    dsimp [N]
    omega
  have hcentral : (F.coeff s * Q.coeff (s - 3)).orderTop = 0 := by
    change (HahnSeries.addVal ℤ k) (_ * _) = 0
    rw [(HahnSeries.addVal ℤ k).map_mul]
    change (F.coeff s).orderTop + (Q.coeff (s - 3)).orderTop = 0
    rw [hFexact, hQzero, zero_add]
  have htail : (1 : WithTop ℤ) ≤
      (∑ ij ∈ (antidiagonal N).erase (s, s - 3), F.coeff ij.1 * Q.coeff ij.2).orderTop := by
    apply laurent_orderTop_sum_bound
    intro ij hij
    have hsum := hsmall ij.1 ij.2 (mem_antidiagonal.mp (mem_of_mem_erase hij))
    have hne : ij ≠ (s, s - 3) := ne_of_mem_erase hij
    have hi_ne : ij.1 ≠ s := by
      intro hi
      apply hne
      apply Prod.ext hi
      omega
    by_cases hi : ij.1 < s
    · have hpos : (1 : WithTop ℤ) ≤ (F.coeff ij.1).orderTop :=
        le_trans (WithTop.coe_le_coe.mpr (by omega)) (hF ij.1)
      simpa only [add_zero] using laurent_orderTop_mul_bound _ _ 1 0 hpos (hQreg ij.2)
    · have hpos : (1 : WithTop ℤ) ≤ (Q.coeff ij.2).orderTop :=
        le_trans (WithTop.coe_le_coe.mpr (by omega)) (hQ ij.2)
      simpa only [zero_add] using laurent_orderTop_mul_bound _ _ 0 1 (hFreg ij.1) hpos
  have hPzero : ((F * Q).coeff N).orderTop = 0 := by
    rw [coeff_mul, ← add_sum_erase _ _ hmem, HahnSeries.orderTop_add_eq_left]
    · exact hcentral
    · rw [hcentral]
      exact lt_of_lt_of_le (by norm_num) htail
  rw [hPzero] at hP
  change ((1 : ℤ) : WithTop ℤ) ≤ ((0 : ℤ) : WithTop ℤ) at hP
  have hfalse := WithTop.coe_le_coe.mp hP
  omega

end Litt3.CartierAndSpin

import Solutions.CartierAndSpin.SkewKernel
import Mathlib.LinearAlgebra.Matrix.ToLin
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

open Module LinearMap

variable {K : Type*} [Field K]

theorem alternatingThreeMatrix_kernel_eq_span (a b c : K)
    (hne : a ≠ 0 ∨ b ≠ 0 ∨ c ≠ 0) :
    LinearMap.ker (alternatingThreeMatrix a b c).mulVecLin =
      Submodule.span K ({alternatingThreeKernelVector a b c} : Set (Fin 3 → K)) := by
  apply le_antisymm
  · intro x hx
    have hm : (alternatingThreeMatrix a b c).mulVec x = 0 := hx
    have h0 := congrFun hm 0
    have h1 := congrFun hm 1
    have h2 := congrFun hm 2
    simp only [Matrix.mulVec, dotProduct, Fin.sum_univ_three] at h0 h1 h2
    change (0 * x 0 + a * x 1) + b * x 2 = 0 at h0
    change ((-a) * x 0 + 0 * x 1) + c * x 2 = 0 at h1
    change ((-b) * x 0 + (-c) * x 1) + 0 * x 2 = 0 at h2
    rw [Submodule.mem_span_singleton]
    by_cases hc : c ≠ 0
    · refine ⟨x 0 / c, ?_⟩
      ext i
      fin_cases i
      · change (x 0 / c) * c = x 0
        exact div_mul_cancel₀ _ hc
      · change (x 0 / c) * (-b) = x 1
        field_simp
        linear_combination h2
      · change (x 0 / c) * a = x 2
        field_simp
        linear_combination -h1
    · by_cases hb : b ≠ 0
      · refine ⟨-x 1 / b, ?_⟩
        ext i
        fin_cases i
        · change (-x 1 / b) * c = x 0
          field_simp
          linear_combination h2
        · change (-x 1 / b) * (-b) = x 1
          field_simp
        · change (-x 1 / b) * a = x 2
          field_simp
          linear_combination -h0
      · have ha : a ≠ 0 := hne.resolve_right (not_or.mpr ⟨hb, hc⟩)
        refine ⟨x 2 / a, ?_⟩
        ext i
        fin_cases i
        · change (x 2 / a) * c = x 0
          field_simp
          linear_combination h1
        · change (x 2 / a) * (-b) = x 1
          field_simp
          linear_combination -h0
        · change (x 2 / a) * a = x 2
          exact div_mul_cancel₀ _ ha
  · apply Submodule.span_le.mpr
    rintro x (rfl : x = alternatingThreeKernelVector a b c)
    exact alternatingThreeKernelVector_mem_kernel a b c

theorem alternatingThreeKernelVector_ne_zero (a b c : K)
    (hne : a ≠ 0 ∨ b ≠ 0 ∨ c ≠ 0) : alternatingThreeKernelVector a b c ≠ 0 := by
  intro hzero
  have ha : a = 0 := congrFun hzero 2
  have hc : c = 0 := congrFun hzero 0
  have hb' : -b = 0 := congrFun hzero 1
  have hb : b = 0 := neg_eq_zero.mp hb'
  exact hne.elim (fun h => h ha) (fun h => h.elim (fun h => h hb) (fun h => h hc))

theorem alternatingThreeMatrix_finrank_kernel (a b c : K)
    (hne : a ≠ 0 ∨ b ≠ 0 ∨ c ≠ 0) :
    finrank K (LinearMap.ker (alternatingThreeMatrix a b c).mulVecLin) = 1 := by
  rw [alternatingThreeMatrix_kernel_eq_span a b c hne]
  exact finrank_span_singleton (alternatingThreeKernelVector_ne_zero a b c hne)

theorem alternatingThreeMatrix_finrank_range (a b c : K)
    (hne : a ≠ 0 ∨ b ≠ 0 ∨ c ≠ 0) :
    finrank K (LinearMap.range (alternatingThreeMatrix a b c).mulVecLin) = 2 := by
  have h := (alternatingThreeMatrix a b c).mulVecLin.finrank_range_add_finrank_ker
  rw [alternatingThreeMatrix_finrank_kernel a b c hne, finrank_pi, Fintype.card_fin] at h
  omega

end Litt3.CartierAndSpin

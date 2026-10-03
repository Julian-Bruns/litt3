import Definitions.CartierAndSpin.KummerMatrices
import Solutions.CartierAndSpin.AlternatingThreeRank

namespace Litt3.CartierAndSpin

set_option maxHeartbeats 1000000

open Module LinearMap
open scoped Matrix

variable {K : Type*} [Field K]

theorem alternatingThreeMatrix_smul (m a b c : K) :
    alternatingThreeMatrix (m*a) (m*b) (m*c) = m • alternatingThreeMatrix a b c := by
  ext i j
  fin_cases i <;> fin_cases j
  · change 0 = m * (0)
    ring
  · change m * a = m * (a)
    ring
  · change m * b = m * (b)
    ring
  · change -(m * a) = m * (-a)
    ring
  · change 0 = m * (0)
    ring
  · change m * c = m * (c)
    ring
  · change -(m * b) = m * (-b)
    ring
  · change -(m * c) = m * (-c)
    ring
  · change 0 = m * (0)
    ring

theorem kummer_pairing_matrix_skew (m : K) (M : Matrix (Fin 3) (Fin 3) K) :
    kummerTracePairingMatrix m * M - Mᵀ * kummerTracePairingMatrix m =
      alternatingThreeMatrix (m * (M 2 1 - M 1 0)) (m * (M 2 2 - M 0 0))
        (m * (M 1 2 - M 0 1)) := by
  ext i j
  simp only [Matrix.sub_apply, Matrix.mul_apply, Fin.sum_univ_three, Matrix.transpose_apply]
  fin_cases i <;> fin_cases j
  · change ((0 * M 0 0 + 0 * M 1 0) + m * M 2 0) - ((M 0 0 * 0 + M 1 0 * 0) + M 2 0 * m) = 0
    ring
  · change ((0 * M 0 1 + 0 * M 1 1) + m * M 2 1) - ((M 0 0 * 0 + M 1 0 * m) + M 2 0 * 0) = m * (M 2 1 - M 1 0)
    ring
  · change ((0 * M 0 2 + 0 * M 1 2) + m * M 2 2) - ((M 0 0 * m + M 1 0 * 0) + M 2 0 * 0) = m * (M 2 2 - M 0 0)
    ring
  · change ((0 * M 0 0 + m * M 1 0) + 0 * M 2 0) - ((M 0 1 * 0 + M 1 1 * 0) + M 2 1 * m) = -(m * (M 2 1 - M 1 0))
    ring
  · change ((0 * M 0 1 + m * M 1 1) + 0 * M 2 1) - ((M 0 1 * 0 + M 1 1 * m) + M 2 1 * 0) = 0
    ring
  · change ((0 * M 0 2 + m * M 1 2) + 0 * M 2 2) - ((M 0 1 * m + M 1 1 * 0) + M 2 1 * 0) = m * (M 1 2 - M 0 1)
    ring
  · change ((m * M 0 0 + 0 * M 1 0) + 0 * M 2 0) - ((M 0 2 * 0 + M 1 2 * 0) + M 2 2 * m) = -(m * (M 2 2 - M 0 0))
    ring
  · change ((m * M 0 1 + 0 * M 1 1) + 0 * M 2 1) - ((M 0 2 * 0 + M 1 2 * m) + M 2 2 * 0) = -(m * (M 1 2 - M 0 1))
    ring
  · change ((m * M 0 2 + 0 * M 1 2) + 0 * M 2 2) - ((M 0 2 * m + M 1 2 * 0) + M 2 2 * 0) = 0
    ring

theorem kummer_skew_kernel_coordinates (m : K) (M : Matrix (Fin 3) (Fin 3) K) :
    (kummerTracePairingMatrix m * M - Mᵀ * kummerTracePairingMatrix m).mulVec
      (kummerSkewKernelCoordinates M) = 0 := by
  rw [kummer_pairing_matrix_skew]
  have hkernel := alternatingThreeKernelVector_mem_kernel (M 2 1 - M 1 0)
    (M 2 2 - M 0 0) (M 1 2 - M 0 1)
  have hbase : alternatingThreeKernelVector (M 2 1 - M 1 0) (M 2 2 - M 0 0)
      (M 1 2 - M 0 1) = kummerSkewKernelCoordinates M := by
    ext i
    fin_cases i
    · rfl
    · change -(M 2 2 - M 0 0) = M 0 0 - M 2 2
      ring
    · rfl
  have hscale : alternatingThreeMatrix (m * (M 2 1 - M 1 0)) (m * (M 2 2 - M 0 0))
      (m * (M 1 2 - M 0 1)) = m • alternatingThreeMatrix (M 2 1 - M 1 0)
        (M 2 2 - M 0 0) (M 1 2 - M 0 1) := by
    exact alternatingThreeMatrix_smul m _ _ _
  rw [hscale, Matrix.smul_mulVec, ← hbase, hkernel, smul_zero]

theorem kummer_skew_kernel_coordinates_zero_iff (m : K) (hm : m ≠ 0)
    (M : Matrix (Fin 3) (Fin 3) K) :
    kummerSkewKernelCoordinates M = 0 ↔
      kummerTracePairingMatrix m * M - Mᵀ * kummerTracePairingMatrix m = 0 := by
  rw [kummer_pairing_matrix_skew]
  constructor
  · intro h
    have h0 : M 1 2 - M 0 1 = 0 := congrFun h 0
    have h1 : M 0 0 - M 2 2 = 0 := congrFun h 1
    have h2 : M 2 1 - M 1 0 = 0 := congrFun h 2
    have h1' : M 2 2 - M 0 0 = 0 := by linear_combination -h1
    ext i j
    fin_cases i <;> fin_cases j
    all_goals dsimp only [alternatingThreeMatrix]
    all_goals simp only [h0, h1', h2, mul_zero, neg_zero, Matrix.zero_apply]
    all_goals rfl
  · intro h
    have h0 := congrArg (fun A : Matrix (Fin 3) (Fin 3) K => A 1 2) h
    have h1 := congrArg (fun A : Matrix (Fin 3) (Fin 3) K => A 0 2) h
    have h2 := congrArg (fun A : Matrix (Fin 3) (Fin 3) K => A 0 1) h
    change m * (M 1 2 - M 0 1) = 0 at h0
    change m * (M 2 2 - M 0 0) = 0 at h1
    change m * (M 2 1 - M 1 0) = 0 at h2
    have h0' := (mul_eq_zero.mp h0).resolve_left hm
    have h1' := (mul_eq_zero.mp h1).resolve_left hm
    have h2' := (mul_eq_zero.mp h2).resolve_left hm
    ext i
    fin_cases i
    · exact h0'
    · change M 0 0 - M 2 2 = 0
      linear_combination -h1'
    · exact h2'

end Litt3.CartierAndSpin

import Theorems.Deformations.TruncatedCongruenceLifting
import Solutions.Deformations.TruncatedMatrixLifting

namespace Litt3.Deformations

variable {k : Type*} [CommRing k]

theorem truncated_power_equality_iff_restriction (N e : ℕ) (bound : e ≤ N)
    (x y : TruncatedCoefficientRing k N) :
    truncatedParameter k N ^ e * x = truncatedParameter k N ^ e * y ↔
      truncatedRestriction k N (N - e) (Nat.sub_le _ _) x =
        truncatedRestriction k N (N - e) (Nat.sub_le _ _) y := by
  constructor
  · exact truncated_power_cancellation N e bound x y
  · intro h
    have hm : x - y ∈ LinearMap.ker
        (truncatedRestriction k N (N - e) (Nat.sub_le _ _)).toLinearMap := by
      change truncatedRestriction k N (N - e) (Nat.sub_le _ _) (x - y) = 0
      rw [map_sub, h, sub_self]
    rw [truncated_restriction_kernel] at hm
    have hr : x - y ∈ LinearMap.range (truncatedPowerMultiplication k N (N - e)) := hm
    rw [← truncated_kernel_power_shape N e bound] at hr
    apply sub_eq_zero.mp
    change truncatedParameter k N ^ e * (x - y) = 0 at hr
    simpa only [mul_sub] using hr

theorem truncated_matrix_power_equality_iff_restriction {ι κ : Type*}
    (N e : ℕ) (bound : e ≤ N) (A D : Matrix ι κ (TruncatedCoefficientRing k N)) :
    truncatedParameter k N ^ e • A = truncatedParameter k N ^ e • D ↔
      truncatedMatrixRestriction k N (N - e) (Nat.sub_le _ _) A =
        truncatedMatrixRestriction k N (N - e) (Nat.sub_le _ _) D := by
  constructor
  · intro h
    ext i j
    exact (truncated_power_equality_iff_restriction N e bound (A i j) (D i j)).mp
      (congrArg (fun M : Matrix ι κ (TruncatedCoefficientRing k N) => M i j) h)
  · intro h
    ext i j
    exact (truncated_power_equality_iff_restriction N e bound (A i j) (D i j)).mpr
      (congrArg (fun M : Matrix ι κ (TruncatedCoefficientRing k (N - e)) => M i j) h)

theorem truncated_matrix_restriction_conjTranspose {ι κ : Type*}
    (N j : ℕ) (bound : j ≤ N) (P : Matrix ι κ (TruncatedCoefficientRing k N)) :
    truncatedMatrixRestriction k N j bound P.conjTranspose =
      (truncatedMatrixRestriction k N j bound P).conjTranspose := by
  ext i j'
  exact truncated_restriction_star N j bound (P j' i)

/-- The full lifted congruence identity is exact, because the
short congruence error is annihilated by the actual parameter power. -/
theorem truncated_congruence_lifting {ι : Type*} [Fintype ι] [DecidableEq ι]
    (N e : ℕ) (less : e < N) (A D : Matrix ι ι (TruncatedCoefficientRing k N)) :
    Specifications.TruncatedCongruenceLifting N e A D := by
  intro S hS shortCongruence
  obtain ⟨P, hP, reduction⟩ := truncated_matrix_unit_lifting N (N - e)
    (Nat.sub_le _ _) (Nat.sub_pos_of_lt less) S hS
  have reduction' : truncatedMatrixRestriction k N (N - e) (Nat.sub_le _ _) P = S := reduction
  refine ⟨P, hP, reduction', ?_⟩
  have short : truncatedMatrixRestriction k N (N - e) (Nat.sub_le _ _)
      (P.conjTranspose * A * P) =
        truncatedMatrixRestriction k N (N - e) (Nat.sub_le _ _) D := by
    change (truncatedRestriction k N (N - e) (Nat.sub_le _ _)).toRingHom.mapMatrix
      (P.conjTranspose * A * P) = _
    rw [map_mul, map_mul]
    change truncatedMatrixRestriction k N (N - e) (Nat.sub_le _ _) P.conjTranspose *
      truncatedMatrixRestriction k N (N - e) (Nat.sub_le _ _) A *
      truncatedMatrixRestriction k N (N - e) (Nat.sub_le _ _) P = _
    rw [truncated_matrix_restriction_conjTranspose, reduction']
    exact shortCongruence
  have exactPower := (truncated_matrix_power_equality_iff_restriction N e (Nat.le_of_lt less)
    (P.conjTranspose * A * P) D).mpr short
  change P.conjTranspose * (truncatedParameter k N ^ e • A) * P = _
  rw [Matrix.mul_smul, Matrix.smul_mul]
  exact exactPower

end Litt3.Deformations

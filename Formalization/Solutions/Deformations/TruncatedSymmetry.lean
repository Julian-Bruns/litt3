import Theorems.Deformations.TruncatedSymmetry
import Solutions.Deformations.TruncatedRestriction
import Solutions.Deformations.TruncatedReflection
import Mathlib.Tactic.Ring

namespace Litt3.Deformations

set_option maxRecDepth 2048

open Polynomial

variable {k : Type*} [CommRing k]

@[simp] theorem truncated_restriction_constant (N j : ℕ) (bound : j ≤ N) (c : k) :
    truncatedRestriction k N j bound (AdjoinRoot.of ((X : Polynomial k) ^ N) c) =
      AdjoinRoot.of ((X : Polynomial k) ^ j) c := by
  simpa only [← AdjoinRoot.algebraMap_eq] using
    (truncatedRestriction k N j bound).commutes c

/-- Actual quotient reduction commutes with the actual reflection. -/
theorem truncated_restriction_reflection (N j : ℕ) (bound : j ≤ N)
    (x : TruncatedCoefficientRing k N) :
    truncatedRestriction k N j bound (truncatedReflection k N x) =
      truncatedReflection k j (truncatedRestriction k N j bound x) := by
  have h : (truncatedRestriction k N j bound).toRingHom.comp (truncatedReflection k N) =
      (truncatedReflection k j).comp (truncatedRestriction k N j bound).toRingHom := by
    apply AdjoinRoot.ringHom_ext
    · ext c
      simp only [RingHom.comp_apply, truncated_reflection_constant,
        AlgHom.toRingHom_eq_coe, RingHom.coe_coe, truncated_restriction_constant]
    · change truncatedRestriction k N j bound
        (truncatedReflection k N (truncatedParameter k N)) =
          truncatedReflection k j (truncatedRestriction k N j bound (truncatedParameter k N))
      simp only [truncated_reflection_parameter, map_neg, truncated_restriction_parameter]
  exact DFunLike.congr_fun h x

@[simp] theorem truncated_restriction_star (N j : ℕ) (bound : j ≤ N)
    (x : TruncatedCoefficientRing k N) :
    truncatedRestriction k N j bound (star x) =
      star (truncatedRestriction k N j bound x) :=
  truncated_restriction_reflection N j bound x

/-- Cancellation after dividing by z^e takes place at length
N-e, including coefficient rings with zero divisors. -/
theorem truncated_power_cancellation (N e : ℕ) (bound : e ≤ N) :
    Specifications.TruncatedPowerCancellation (k := k) N e := by
  intro x y h
  apply sub_eq_zero.mp
  rw [← map_sub]
  have hm : x - y ∈ LinearMap.ker (truncatedPowerMultiplication k N e) := by
    change truncatedParameter k N ^ e * (x - y) = 0
    rw [mul_sub, h, sub_self]
  rw [truncated_kernel_power_shape N e bound] at hm
  have hk := truncated_restriction_kernel (k := k) N (N - e) (Nat.sub_le _ _)
  unfold Specifications.TruncatedRestrictionKernel at hk
  have hr : x - y ∈ LinearMap.range (truncatedPowerCoefficientMap k N (N - e)) := hm
  rw [← hk] at hr
  exact hr

/-- Dividing an actual reflected relation by z^e produces its
correct signed reflected relation in the actual shorter quotient. -/
theorem truncated_divided_reflected_relation (N e : ℕ) (bound : e ≤ N)
    (x y ε : TruncatedCoefficientRing k N)
    (relation : star (truncatedParameter k N ^ e * x) =
      ε * (truncatedParameter k N ^ e * y)) :
    star (truncatedRestriction k N (N - e) (Nat.sub_le _ _) x) =
      (-1 : TruncatedCoefficientRing k (N - e)) ^ e *
        truncatedRestriction k N (N - e) (Nat.sub_le _ _) ε *
        truncatedRestriction k N (N - e) (Nat.sub_le _ _) y := by
  have hsign : (-1 : TruncatedCoefficientRing k N) ^ e * (-1) ^ e = 1 := by
    rw [← mul_pow]
    simp only [neg_mul_neg, one_mul, one_pow]
  have hs : star x * ((-1 : TruncatedCoefficientRing k N) ^ e *
      truncatedParameter k N ^ e) = ε * (truncatedParameter k N ^ e * y) := by
    rw [star_mul, star_pow, truncated_star_parameter,
      neg_pow (truncatedParameter k N) e] at relation
    exact relation
  have hc : truncatedParameter k N ^ e * star x =
      truncatedParameter k N ^ e * (((-1 : TruncatedCoefficientRing k N) ^ e * ε) * y) := by
    calc
      _ = (((-1 : TruncatedCoefficientRing k N) ^ e * (-1) ^ e) *
        (truncatedParameter k N ^ e * star x)) := by rw [hsign, one_mul]
      _ = (-1 : TruncatedCoefficientRing k N) ^ e *
        (star x * ((-1) ^ e * truncatedParameter k N ^ e)) := by ring
      _ = (-1 : TruncatedCoefficientRing k N) ^ e *
        (ε * (truncatedParameter k N ^ e * y)) := by rw [hs]
      _ = _ := by ring
  have h := truncated_power_cancellation N e bound (star x)
    (((-1 : TruncatedCoefficientRing k N) ^ e * ε) * y) hc
  simpa only [truncated_restriction_star, map_mul, map_pow, map_neg, map_one] using h

/-- The full matrix identity after division, rather than only a
leading-coefficient parity assertion. No matrix invertibility or
field hypothesis is needed. -/
theorem truncated_divided_matrix_symmetry {ι : Type*}
    (N e : ℕ) (bound : e ≤ N) (ε : TruncatedCoefficientRing k N)
    (B : Matrix ι ι (TruncatedCoefficientRing k N))
    (relation : (truncatedParameter k N ^ e • B).conjTranspose =
      ε • (truncatedParameter k N ^ e • B)) :
    (truncatedMatrixRestriction k N (N - e) (Nat.sub_le _ _) B).conjTranspose =
      ((-1 : TruncatedCoefficientRing k (N - e)) ^ e *
        truncatedRestriction k N (N - e) (Nat.sub_le _ _) ε) •
          truncatedMatrixRestriction k N (N - e) (Nat.sub_le _ _) B := by
  ext i j
  have h := congrArg (fun A => A i j) relation
  change star (truncatedParameter k N ^ e * B j i) =
    ε * (truncatedParameter k N ^ e * B i j) at h
  exact truncated_divided_reflected_relation N e bound (B j i) (B i j) ε h

end Litt3.Deformations

import Theorems.Deformations.TruncatedReflection

namespace Litt3.Deformations

open Polynomial

variable {k : Type*} [CommRing k]

@[simp] theorem truncated_reflection_constant (N : ℕ) (c : k) :
    truncatedReflection k N (AdjoinRoot.of ((X : Polynomial k) ^ N) c) =
      AdjoinRoot.of ((X : Polynomial k) ^ N) c := by
  simp only [truncatedReflection, AdjoinRoot.lift_of]

@[simp] theorem truncated_reflection_parameter (N : ℕ) :
    truncatedReflection k N (truncatedParameter k N) = -truncatedParameter k N := by
  simp only [truncatedReflection, truncatedParameter, AdjoinRoot.lift_root]

/-- Reflection is an involution of the actual quotient ring, at
every truncation length and over every commutative coefficient ring. -/
theorem truncated_reflection_involution (N : ℕ) :
    Specifications.TruncatedReflectionInvolution (k := k) N := by
  intro x
  induction x using AdjoinRoot.induction_on ((X : Polynomial k) ^ N) with
  | ih P =>
    induction P using Polynomial.induction_on' with
    | add P Q hP hQ =>
      simp only [map_add, hP, hQ]
    | monomial n c =>
      rw [← C_mul_X_pow_eq_monomial]
      simp only [map_mul, map_pow, AdjoinRoot.mk_C, AdjoinRoot.mk_X]
      change truncatedReflection k N
        (truncatedReflection k N (AdjoinRoot.of ((X : Polynomial k) ^ N) c)) *
          truncatedReflection k N (truncatedReflection k N (truncatedParameter k N)) ^ n =
        AdjoinRoot.of ((X : Polynomial k) ^ N) c * truncatedParameter k N ^ n
      simp only [truncated_reflection_constant,
        truncated_reflection_parameter, map_neg, neg_neg]

noncomputable def truncatedReflectionEquiv (N : ℕ) :
    TruncatedCoefficientRing k N ≃+* TruncatedCoefficientRing k N :=
  RingEquiv.ofBijective (truncatedReflection k N)
    (truncated_reflection_involution N).bijective

/-- This concrete star structure is exactly the reflection used
by cyclic leading forms; it fixes coefficients and negates z. -/
noncomputable instance truncatedStarRing (N : ℕ) :
    StarRing (TruncatedCoefficientRing k N) where
  star := truncatedReflection k N
  star_involutive := truncated_reflection_involution N
  star_mul x y := by rw [map_mul, mul_comm]
  star_add x y := map_add _ x y

@[simp] theorem truncated_star_parameter (N : ℕ) :
    star (truncatedParameter k N) = -truncatedParameter k N :=
  truncated_reflection_parameter N

@[simp] theorem truncated_star_constant (N : ℕ) (c : k) :
    star (AdjoinRoot.of ((X : Polynomial k) ^ N) c) =
      AdjoinRoot.of ((X : Polynomial k) ^ N) c := truncated_reflection_constant N c

end Litt3.Deformations

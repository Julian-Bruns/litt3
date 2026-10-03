import Solutions.CartierAndSpin.PrimitiveQuotientIntegrality
import Mathlib.RingTheory.DiscreteValuationRing.Basic

namespace Litt3.CartierAndSpin

open Polynomial

variable {R K : Type*} [CommRing R]

/-- A single actual unit coefficient certifies primitive content over
every commutative ring, without a leading-unit hypothesis. -/
theorem polynomial_isPrimitive_of_unit_coefficient (F : R[X]) (j : ℕ)
    (hunit : IsUnit (F.coeff j)) : F.IsPrimitive := by
  intro r hdiv
  obtain ⟨Q, hQ⟩ := hdiv
  have hproduct : IsUnit (r * Q.coeff j) := by
    rwa [hQ, coeff_C_mul] at hunit
  exact isUnit_of_mul_isUnit_left hproduct

section GCD

variable [IsDomain R] [NormalizedGCDMonoid R]
  [Field K] [Algebra R K] [IsFractionRing R K]

/-- The critical quotient descends to the original ring from the exact
integral polynomial identity and primitive source content. Neither a
leading coefficient of F nor of D needs to be a unit. -/
theorem primitive_critical_quotient_is_integral (F D U V2 : R[X])
    (hF : F.IsPrimitive) (Q : K[X])
    (hidentity : (U.map (algebraMap R K)) ^ 2 - F.map (algebraMap R K) * Q =
      D.map (algebraMap R K) * V2.map (algebraMap R K)) :
    ∃ Q0 : R[X], Q0.map (algebraMap R K) = Q ∧ U ^ 2 - F * Q0 = D * V2 := by
  have hproduct : F.map (algebraMap R K) * Q =
      (U ^ 2 - D * V2).map (algebraMap R K) := by
    rw [Polynomial.map_sub, Polynomial.map_pow, Polynomial.map_mul]
    linear_combination -hidentity
  obtain ⟨Q0, hQ0⟩ := primitive_fraction_quotient_is_integral F (U ^ 2 - D * V2) hF Q hproduct
  refine ⟨Q0, hQ0, ?_⟩
  apply Polynomial.map_injective (algebraMap R K) (IsFractionRing.injective R K)
  simpa only [Polynomial.map_sub, Polynomial.map_pow, Polynomial.map_mul, hQ0] using hidentity

end GCD

/-- Literal local-DVR specialization: primitive content is certified by
any unit coefficient, even if the leading coefficient vanishes in the
residue field. -/
theorem dvr_critical_quotient_is_integral [IsDomain R] [IsDiscreteValuationRing R]
    [Field K] [Algebra R K] [IsFractionRing R K]
    (F D U V2 : R[X]) (j : ℕ) (hunit : IsUnit (F.coeff j)) (Q : K[X])
    (hidentity : (U.map (algebraMap R K)) ^ 2 - F.map (algebraMap R K) * Q =
      D.map (algebraMap R K) * V2.map (algebraMap R K)) :
    ∃ Q0 : R[X], Q0.map (algebraMap R K) = Q ∧ U ^ 2 - F * Q0 = D * V2 := by
  letI : NormalizedGCDMonoid R := Classical.arbitrary _
  exact primitive_critical_quotient_is_integral F D U V2
    (polynomial_isPrimitive_of_unit_coefficient F j hunit) Q hidentity

end Litt3.CartierAndSpin

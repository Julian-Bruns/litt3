import Mathlib.RingTheory.Polynomial.GaussLemma
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

open Polynomial

variable {R K : Type*} [CommRing R] [IsDomain R] [NormalizedGCDMonoid R]
  [Field K] [Algebra R K] [IsFractionRing R K]

/-- A primitive polynomial divides every integral numerator over its
actual fraction field exactly when it divides it over the original GCD
domain. The numerator need not be primitive. -/
theorem primitive_dvd_of_fraction_dvd (F P : R[X]) (hF : F.IsPrimitive)
    (hdiv : F.map (algebraMap R K) ∣ P.map (algebraMap R K)) : F ∣ P := by
  by_cases hP : P = 0
  · simp [hP]
  let c := algebraMap R K P.content
  have hc : c ≠ 0 := by
    simpa only [c, map_zero] using (IsFractionRing.injective R K).ne
      (content_eq_zero_iff.not.mpr hP)
  have hcontent : P.map (algebraMap R K) =
      C c * P.primPart.map (algebraMap R K) := by
    nth_rw 1 [P.eq_C_content_mul_primPart]
    rw [Polynomial.map_mul, map_C]
  obtain ⟨T, hT⟩ := hdiv
  have hprimitive : F.map (algebraMap R K) ∣ P.primPart.map (algebraMap R K) := by
    refine ⟨T * C c⁻¹, ?_⟩
    calc
      P.primPart.map (algebraMap R K) = C c⁻¹ * P.map (algebraMap R K) := by
        rw [hcontent, ← mul_assoc, ← C_mul, inv_mul_cancel₀ hc, C_1, one_mul]
      _ = F.map (algebraMap R K) * (T * C c⁻¹) := by rw [hT]; ring
  exact (hF.dvd_of_fraction_map_dvd_fraction_map
    (K := K) P.isPrimitive_primPart hprimitive).trans P.primPart_dvd

/-- Primitive content makes the exact fraction-field quotient an actual
polynomial over the original ring. Its leading coefficient may be a
nonunit, and the source need not be monic or separable. -/
theorem primitive_fraction_quotient_is_integral (F P : R[X]) (hF : F.IsPrimitive)
    (Q : K[X]) (hidentity : F.map (algebraMap R K) * Q = P.map (algebraMap R K)) :
    ∃ Q0 : R[X], Q0.map (algebraMap R K) = Q := by
  have hdiv : F ∣ P := primitive_dvd_of_fraction_dvd F P hF ⟨Q, hidentity.symm⟩
  obtain ⟨Q0, hQ0⟩ := hdiv
  refine ⟨Q0, ?_⟩
  have hFmap : F.map (algebraMap R K) ≠ 0 := by
    intro hzero
    apply hF.ne_zero
    apply Polynomial.map_injective (algebraMap R K) (IsFractionRing.injective R K)
    simpa only [Polynomial.map_zero] using hzero
  apply mul_left_cancel₀ hFmap
  rw [← Polynomial.map_mul, ← hQ0, hidentity]

end Litt3.CartierAndSpin

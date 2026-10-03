import Definitions.CartierAndSpin.CriticalQuadratic
import Solutions.CartierAndSpin.CriticalTraceTranslation

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K]

theorem quotient_numerator_translation_value (F D U : K[X])
    (DUnit : (AdjoinRoot F)ˣ) (hD : (DUnit : AdjoinRoot F) = AdjoinRoot.mk F D)
    (z : K) :
    AdjoinRoot.mk F (U - C z * D) * (↑DUnit⁻¹ : AdjoinRoot F) =
      AdjoinRoot.mk F U * (↑DUnit⁻¹ : AdjoinRoot F) - algebraMap K (AdjoinRoot F) z := by
  rw [map_sub, map_mul, AdjoinRoot.mk_C, ← hD]
  calc
    (AdjoinRoot.mk F U - algebraMap K (AdjoinRoot F) z * (DUnit : AdjoinRoot F)) *
        (↑DUnit⁻¹ : AdjoinRoot F) =
        AdjoinRoot.mk F U * (↑DUnit⁻¹ : AdjoinRoot F) -
          algebraMap K (AdjoinRoot F) z *
            ((DUnit : AdjoinRoot F) * (↑DUnit⁻¹ : AdjoinRoot F)) := by ring
    _ = _ := by rw [Units.mul_inv, mul_one]

/-- The explicit critical quadratic is unchanged by the actual numerator
translation, as a consequence of the five proved trace invariants. -/
theorem critical_quadratic_translation_of_trace_outcome (F D U : K[X]) (leading : K)
    (phiUnit DUnit : (AdjoinRoot F)ˣ)
    (hD : (DUnit : AdjoinRoot F) = AdjoinRoot.mk F D)
    (houtcome : Specifications.CriticalTraceTranslationOutcome F U phiUnit DUnit)
    (z : K) :
    criticalQuadraticTrace leading D (AdjoinRoot.root F)
      (AdjoinRoot.mk F (U - C z * D) * (↑DUnit⁻¹ : AdjoinRoot F)) phiUnit =
    criticalQuadraticTrace leading D (AdjoinRoot.root F)
      (AdjoinRoot.mk F U * (↑DUnit⁻¹ : AdjoinRoot F)) phiUnit := by
  obtain ⟨hrho, _hmfive, hmu⟩ := houtcome z
  rw [quotient_numerator_translation_value F D U DUnit hD z]
  unfold criticalQuadraticTrace criticalQuadraticFromMoments
  dsimp only
  rw [hrho, hmu 0 (by decide), hmu 1 (by decide), hmu 2 (by decide)]

/-- The actual critical numerator resultant with formal degrees 3 and 5,
and the actual D/Q resultant with formal degrees 3 and 2, are unchanged.
No squarefreeness or actual-degree equality is required for D or U. -/
theorem critical_quadratic_resultants_translation_of_trace_outcome
    (F D U : K[X]) (leading : K) (hDdegree : D.natDegree ≤ 3)
    (phiUnit DUnit : (AdjoinRoot F)ˣ)
    (hD : (DUnit : AdjoinRoot F) = AdjoinRoot.mk F D)
    (houtcome : Specifications.CriticalTraceTranslationOutcome F U phiUnit DUnit)
    (z : K) :
    Polynomial.resultant D (U - C z * D) 3 5 = Polynomial.resultant D U 3 5 ∧
      Polynomial.resultant D
        (criticalQuadraticTrace leading D (AdjoinRoot.root F)
          (AdjoinRoot.mk F (U - C z * D) * (↑DUnit⁻¹ : AdjoinRoot F)) phiUnit) 3 2 =
        Polynomial.resultant D
          (criticalQuadraticTrace leading D (AdjoinRoot.root F)
            (AdjoinRoot.mk F U * (↑DUnit⁻¹ : AdjoinRoot F)) phiUnit) 3 2 := by
  refine ⟨criticalResultantTranslationInvariant D U 3 5 hDdegree (by decide) z, ?_⟩
  rw [critical_quadratic_translation_of_trace_outcome F D U leading
    phiUnit DUnit hD houtcome z]

theorem algebra_critical_quadratic_translation {A : Type*} [CommRing A] [Algebra K A]
    (leading : K) (D : K[X]) (w u : A) (phiUnit : Aˣ)
    (houtcome : Specifications.AlgebraCriticalTraceTranslationOutcome (K := K) w u phiUnit)
    (z : K) :
    criticalQuadraticTrace leading D w (u - algebraMap K A z) phiUnit =
      criticalQuadraticTrace leading D w u phiUnit := by
  obtain ⟨hrho, _hmfive, hmu⟩ := houtcome z
  unfold criticalQuadraticTrace criticalQuadraticFromMoments
  dsimp only
  rw [hrho, hmu 0 (by decide), hmu 1 (by decide), hmu 2 (by decide)]

end Litt3.CartierAndSpin

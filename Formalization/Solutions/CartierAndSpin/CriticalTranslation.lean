import Theorems.CartierAndSpin.CriticalTranslation
import Solutions.CartierAndSpin.WeightedMoments
import Mathlib.Tactic.Ring

/-!
# Critical numerator translation

General commutative-ring statements underpinning
`annihilator_critical_translation_invariance`. Formal resultant degrees are
retained, including numerator degree drops and repeated denominator roots.
Trace-dual interpolation supplying the vanishing moments and the selected
divisor obstruction are separate geometric components.
-/

namespace Litt3.CartierAndSpin

open Polynomial

variable {R : Type*} [CommRing R]

theorem criticalResultantTranslationInvariant (D U : R[X]) (m n : ℕ) :
    Specifications.CriticalResultantTranslationInvariant D U m n := by
  intro hD hmn z
  have htranslate : U - Polynomial.C z * D = U + D * Polynomial.C (-z) := by
    simp only [map_neg]
    ring
  rw [htranslate]
  apply Polynomial.resultant_add_mul_right
  · simpa only [Polynomial.natDegree_C, zero_add] using hmn
  · exact hD

theorem criticalSquareTranslation (F Q D U V : R) :
    Specifications.CriticalSquareTranslation F Q D U V := by
  intro h z
  calc
    (U - z * D) ^ 2 - F * Q =
        (U ^ 2 - F * Q) - 2 * z * D * U + z ^ 2 * D ^ 2 := by ring
    _ = D * (V - 2 * z * U + z ^ 2 * D) := by rw [h]; ring

/-- Exact mixed weighted-sum cancellation for each quadratic critical trace.
The two lower moments are explicit algebraic hypotheses, not an assumed
translation-invariance conclusion. -/
theorem weighted_square_translation_invariant {ι : Type*}
    (s : Finset ι) (weight value : ι → R) (z : R)
    (hzero : weightedMoment s weight value 0 = 0)
    (hone : weightedMoment s weight value 1 = 0) :
    weightedMoment s weight (fun i => value i - z) 2 =
      weightedMoment s weight value 2 := by
  simpa only [sub_eq_add_neg] using
    weightedMoment_two_translation_invariant s weight value (-z) hzero hone

end Litt3.CartierAndSpin

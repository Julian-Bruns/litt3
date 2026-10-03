import Solutions.CartierAndSpin.LinearMoments
import Solutions.CartierAndSpin.TraceEnergy
import Theorems.CartierAndSpin.UnsplitMomentTranslation
import Mathlib.Algebra.CharP.Lemmas

namespace Litt3.CartierAndSpin

open Polynomial Finset

variable {R K : Type*} [CommRing R] [Field K] [Algebra R K]

/-- The source itself supplies the two zero moments, and all derivative
moments in the original actual quotient obey the full translation law.
No splitting, connectedness or odd-characteristic assumption is needed. -/
theorem sourceTraceZeroMomentTranslations (D : Derivation R K K)
    (F H : K[X]) (p : ℕ) [CharP K p] (q tau : K) :
    Specifications.SourceTraceZeroMomentTranslations D F H p q tau := by
  intro hp hdegree htau hseparable hsource htraceZero
  have hF : F ≠ 0 := by
    intro hzero
    rw [hzero, Polynomial.natDegree_zero] at hdegree
    omega
  have hFdegree : F.degree ≠ 0 := by
    intro hzero
    have hnat : F.natDegree = 0 := Polynomial.natDegree_eq_of_degree_eq_some (n := 0) hzero
    omega
  letI : Nontrivial (AdjoinRoot F) := AdjoinRoot.nontrivial F hFdegree
  letI : CharP (AdjoinRoot F) p := charP_of_injective_algebraMap
    (algebraMap K (AdjoinRoot F)).injective p
  letI : Fact p.Prime := ⟨CharP.char_is_prime_of_two_le K p hp⟩
  obtain ⟨unit, hunit, hmoments⟩ := source_coefficient_moments F H p q tau
    hp hdegree htau hseparable hsource
  obtain ⟨E, compatible⟩ := separable_polynomial_quotient_derivation_exists D F hseparable
  let basis := (AdjoinRoot.powerBasis hF).basis
  have hunitDerivative := source_quotient_factor_derivation D F E compatible p q unit hunit
  have hzero : functionalMoment (Algebra.trace K (AdjoinRoot F)) (↑unit⁻¹ : AdjoinRoot F)
      (E (AdjoinRoot.root F)) 0 = 0 := by
    simpa only [functionalMoment, pow_zero, one_mul] using (hmoments 0 (by omega)).1
  have hone : functionalMoment (Algebra.trace K (AdjoinRoot F)) (↑unit⁻¹ : AdjoinRoot F)
      (E (AdjoinRoot.root F)) 1 = 0 := by
    have h := trace_first_differential_moment_equation D E compatible basis
      (AdjoinRoot.root F) unit q hunitDerivative 1 (hmoments 1 (by omega)).1
    rw [(hmoments 1 (by omega)).2, htraceZero] at h
    simpa only [functionalMoment, Nat.cast_one, one_mul, Nat.reduceSub,
      pow_zero, pow_one, mul_zero, zero_div] using h
  refine ⟨unit, E, hunit, compatible, hzero, hone, ?_⟩
  intro b
  have hdenominator : (AdjoinRoot.root F + algebraMap K (AdjoinRoot F) b) ^ p +
      algebraMap K (AdjoinRoot F) (q - b ^ p) = (unit : AdjoinRoot F) := by
    rw [hunit]
    change (AdjoinRoot.root F + algebraMap K (AdjoinRoot F) b) ^ p +
      algebraMap K (AdjoinRoot F) (q - b ^ p) =
      (AdjoinRoot.root F) ^ p + algebraMap K (AdjoinRoot F) q
    rw [add_pow_char, map_sub, map_pow]
    ring
  refine ⟨hdenominator, ?_, ?_, ?_⟩
  · intro n
    rw [map_add, compatible]
    exact functionalMoment_translate (Algebra.trace K (AdjoinRoot F))
      (↑unit⁻¹ : AdjoinRoot F) (E (AdjoinRoot.root F)) (D b) n
  · rw [map_add, compatible]
    exact functionalMoment_two_translation_invariant (Algebra.trace K (AdjoinRoot F))
      (↑unit⁻¹ : AdjoinRoot F) (E (AdjoinRoot.root F)) (D b) hzero hone
  · rw [map_add, compatible]
    exact functionalMomentDiscriminant_translation_invariant (Algebra.trace K (AdjoinRoot F))
      (↑unit⁻¹ : AdjoinRoot F) (E (AdjoinRoot.root F)) (D b) hzero hone

end Litt3.CartierAndSpin

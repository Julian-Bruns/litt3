import Definitions.Jacobians.DedekindDivisors
import Mathlib.RingTheory.DedekindDomain.Ideal.Lemmas
import Mathlib.RingTheory.Valuation.Integers

open scoped nonZeroDivisors WithZero
open IsDedekindDomain

namespace Litt3.Jacobians

variable {R K : Type*} [CommRing R] [IsDedekindDomain R]
  [Field K] [Algebra R K] [IsFractionRing R K]

/-- Every ORIGINAL Dedekind fraction has a numerator and denominator
coprime at a chosen actual prime. The multiplier is derived from genuine
fractional ideals, with no global PID or chosen-generator hypothesis. -/
theorem actual_dedekind_fraction_coprime_at
    (v : HeightOneSpectrum R) (x : K) :
    ∃ (a b : R), b ≠ 0 ∧
      algebraMap R K a / algebraMap R K b = x ∧
      (b ∈ v.asIdeal → a ∉ v.asIdeal) := by
  classical
  let f : Bool → K := fun i => if i then x else 1
  obtain ⟨c, hc, i, hi, hnot⟩ := Ideal.exist_integer_multiples_notMem
    (A := R) (K := K) v.isPrime.ne_top Finset.univ f
    (j := false) (Finset.mem_univ _) (by simp [f])
  obtain ⟨b, hb⟩ := hc false (Finset.mem_univ _)
  obtain ⟨a, ha⟩ := hc true (Finset.mem_univ _)
  have hb : algebraMap R K b = c := by simpa [f] using hb
  have ha : algebraMap R K a = c * x := by simpa [f] using ha
  have hc0 : c ≠ 0 := by
    intro hc0
    apply hnot
    simp only [hc0, zero_mul]
    exact FractionalIdeal.zero_mem _
  have hb0 : b ≠ 0 := by
    intro hb0
    apply hc0
    simpa only [hb0, map_zero] using hb.symm
  refine ⟨a, b, hb0, ?_, ?_⟩
  · rw [ha, hb, mul_div_cancel_left₀ x hc0]
  · intro hbmem hamem
    apply hnot
    cases i
    · simp only [f, Bool.false_eq_true, ↓reduceIte, mul_one]
      rw [← hb]
      exact FractionalIdeal.mem_coeIdeal_of_mem R⁰ hbmem
    · simp only [f, ↓reduceIte]
      rw [← ha]
      exact FractionalIdeal.mem_coeIdeal_of_mem R⁰ hamem

variable {S : Type*} [CommRing S] [IsDomain S]
  [Algebra R S] [Algebra S K] [IsScalarTower R S K] [IsFractionRing S K]

/-- The ACTUAL localization at the true prime is exactly the integers
of the true global normalized prime valuation in the ORIGINAL fraction
field, not an arbitrary valuation ring or a supplied integrality bridge. -/
theorem actual_dedekind_prime_localization_valuation_integers
    (v : HeightOneSpectrum R) [IsLocalization.AtPrime S v.asIdeal] :
    (v.valuation K).Integers S := by
  refine ⟨IsFractionRing.injective S K, ?_, ?_⟩
  · intro s
    obtain ⟨⟨a, b⟩, hs⟩ := IsLocalization.surj v.asIdeal.primeCompl s
    have hb0 : algebraMap R K b.val ≠ 0 :=
      (map_ne_zero_iff _ (IsFractionRing.injective R K)).mpr
        (nonZeroDivisors.ne_zero (v.asIdeal.primeCompl_le_nonZeroDivisors b.property))
    have hsk : algebraMap S K s = algebraMap R K a / algebraMap R K b.val := by
      apply (eq_div_iff hb0).mpr
      have h := congrArg (algebraMap S K) hs
      simpa only [map_mul, ← IsScalarTower.algebraMap_apply R S K] using h
    rw [hsk, map_div₀, HeightOneSpectrum.valuation_of_algebraMap,
      HeightOneSpectrum.valuation_of_algebraMap,
      v.intValuation_eq_one_iff.mpr b.property, div_one]
    exact v.intValuation_le_one _
  · intro x hx
    obtain ⟨a, b, hb0, hfrac, hcoprime⟩ := actual_dedekind_fraction_coprime_at v x
    have hb : b ∉ v.asIdeal :=
      (v.valuation_div_le_one_iff K a hb0 hcoprime).mp (hfrac ▸ hx)
    let d : v.asIdeal.primeCompl := ⟨b, hb⟩
    refine ⟨IsLocalization.mk' S a d, ?_⟩
    have hbK0 : algebraMap R K b ≠ 0 :=
      (map_ne_zero_iff _ (IsFractionRing.injective R K)).mpr hb0
    rw [← hfrac]
    apply (eq_div_iff hbK0).mpr
    have h := congrArg (algebraMap S K) (IsLocalization.mk'_spec S a d)
    simpa only [map_mul, ← IsScalarTower.algebraMap_apply R S K] using h

end Litt3.Jacobians

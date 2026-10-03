import Definitions.CartierAndSpin.WeightedMoments
import Theorems.CartierAndSpin.WeightedMoments
import Mathlib.Tactic.Ring
import Mathlib.Data.Nat.Choose.Sum

/-!
# Translation laws for weighted moments

These algebraic statements formalize the translation-invariant component of
`source_quadratic_calculus`. They apply to every finite family over an arbitrary
commutative ring, including the split-root description of separable trace.

The residue identities which supply vanishing of the zeroth and first moments
in the geometric source algebra are not formalized in this file.
-/

namespace Litt3.CartierAndSpin

open Finset

variable {R ι : Type*} [CommRing R]

/-- The complete binomial translation law, in arbitrary moment order. -/
theorem weightedMoment_translate (s : Finset ι) (weight value : ι → R)
    (b : R) (n : ℕ) :
    weightedMoment s weight (fun i => value i + b) n =
      ∑ j ∈ range (n + 1),
        (n.choose j : R) * b ^ (n - j) * weightedMoment s weight value j := by
  simp only [weightedMoment, add_pow, mul_sum]
  rw [sum_comm]
  apply sum_congr rfl
  intro j hj
  apply sum_congr rfl
  intro i hi
  ring

theorem weightedMoment_translate_two (s : Finset ι) (weight value : ι → R)
    (b : R) :
    weightedMoment s weight (fun i => value i + b) 2 =
      weightedMoment s weight value 2 +
      2 * b * weightedMoment s weight value 1 +
      b ^ 2 * weightedMoment s weight value 0 := by
  unfold weightedMoment
  calc
    ∑ i ∈ s, weight i * (value i + b) ^ 2 =
        ∑ i ∈ s, (weight i * value i ^ 2 +
          2 * b * (weight i * value i ^ 1) +
          b ^ 2 * (weight i * value i ^ 0)) := by
      apply sum_congr rfl
      intro i hi
      ring
    _ = _ := by
      simp only [sum_add_distrib, mul_sum]

theorem weightedMoment_translate_three (s : Finset ι) (weight value : ι → R)
    (b : R) :
    weightedMoment s weight (fun i => value i + b) 3 =
      weightedMoment s weight value 3 +
      3 * b * weightedMoment s weight value 2 +
      3 * b ^ 2 * weightedMoment s weight value 1 +
      b ^ 3 * weightedMoment s weight value 0 := by
  unfold weightedMoment
  calc
    ∑ i ∈ s, weight i * (value i + b) ^ 3 =
        ∑ i ∈ s, (weight i * value i ^ 3 +
          3 * b * (weight i * value i ^ 2) +
          3 * b ^ 2 * (weight i * value i ^ 1) +
          b ^ 3 * (weight i * value i ^ 0)) := by
      apply sum_congr rfl
      intro i hi
      ring
    _ = _ := by
      simp only [sum_add_distrib, mul_sum]

theorem weightedMoment_translate_four (s : Finset ι) (weight value : ι → R)
    (b : R) :
    weightedMoment s weight (fun i => value i + b) 4 =
      weightedMoment s weight value 4 +
      4 * b * weightedMoment s weight value 3 +
      6 * b ^ 2 * weightedMoment s weight value 2 +
      4 * b ^ 3 * weightedMoment s weight value 1 +
      b ^ 4 * weightedMoment s weight value 0 := by
  unfold weightedMoment
  calc
    ∑ i ∈ s, weight i * (value i + b) ^ 4 =
        ∑ i ∈ s, (weight i * value i ^ 4 +
          4 * b * (weight i * value i ^ 3) +
          6 * b ^ 2 * (weight i * value i ^ 2) +
          4 * b ^ 3 * (weight i * value i ^ 1) +
          b ^ 4 * (weight i * value i ^ 0)) := by
      apply sum_congr rfl
      intro i hi
      ring
    _ = _ := by
      simp only [sum_add_distrib, mul_sum]

/-- Vanishing of the first two weighted moments makes the quadratic moment
translation invariant. This requires no characteristic hypothesis. -/
theorem weightedMoment_two_translation_invariant
    (s : Finset ι) (weight value : ι → R) (b : R)
    (hzero : weightedMoment s weight value 0 = 0)
    (hone : weightedMoment s weight value 1 = 0) :
    weightedMoment s weight (fun i => value i + b) 2 =
      weightedMoment s weight value 2 := by
  rw [weightedMoment_translate_two, hzero, hone]
  ring

/-- The discriminant is translation invariant over every commutative ring.
The geometric result's odd-characteristic hypotheses are needed to derive
the vanishing moments, rather than for this algebraic cancellation. -/
theorem momentDiscriminant_translation_invariant
    (s : Finset ι) (weight value : ι → R) (b : R)
    (hzero : weightedMoment s weight value 0 = 0)
    (hone : weightedMoment s weight value 1 = 0) :
    momentDiscriminant s weight (fun i => value i + b) =
      momentDiscriminant s weight value := by
  unfold momentDiscriminant
  rw [weightedMoment_two_translation_invariant s weight value b hzero hone,
    weightedMoment_translate_three, weightedMoment_translate_four, hzero, hone]
  ring

theorem traceZeroMomentTranslationInvariant (s : Finset ι)
    (weight value : ι → R) :
    Specifications.TraceZeroMomentTranslationInvariant s weight value := by
  intro hzero hone b
  exact ⟨weightedMoment_two_translation_invariant s weight value b hzero hone,
    momentDiscriminant_translation_invariant s weight value b hzero hone⟩

end Litt3.CartierAndSpin

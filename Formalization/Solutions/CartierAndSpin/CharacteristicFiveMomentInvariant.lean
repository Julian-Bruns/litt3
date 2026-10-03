import Definitions.CartierAndSpin.CharacteristicFiveMomentInvariant
import Solutions.CartierAndSpin.LinearMoments
import Mathlib.Algebra.CharP.Basic
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

variable {K A : Type*} [Field K] [CharP K 5] [CommRing A] [Algebra K A]

theorem functional_discriminant_eq_three_five_invariant (linear : A →ₗ[K] K)
    (weight value : A) :
    functionalMomentDiscriminant linear weight value =
      3 * functionalMomentFiveInvariant linear weight value := by
  have hfive : (5 : K) = 0 := CharP.cast_eq_zero K 5
  unfold functionalMomentDiscriminant functionalMomentFiveInvariant
  linear_combination -(functionalMoment linear weight value 3 ^ 2) * hfive

theorem functional_five_invariant_translation (linear : A →ₗ[K] K)
    (weight value : A) (b : K)
    (hzero : functionalMoment linear weight value 0 = 0)
    (hone : functionalMoment linear weight value 1 = 0) :
    functionalMomentFiveInvariant linear weight (value + algebraMap K A b) =
      functionalMomentFiveInvariant linear weight value := by
  have hthree : (3 : K) ≠ 0 := by
    change ((3 : ℕ) : K) ≠ 0
    rw [Ne, CharP.cast_eq_zero_iff K 5]
    norm_num
  apply mul_left_cancel₀ hthree
  rw [← functional_discriminant_eq_three_five_invariant,
    ← functional_discriminant_eq_three_five_invariant]
  exact functionalMomentDiscriminant_translation_invariant linear weight value b hzero hone

end Litt3.CartierAndSpin

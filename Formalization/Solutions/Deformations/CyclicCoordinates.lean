import Theorems.Deformations.CyclicCoordinates
import Mathlib.Tactic.Ring

namespace Litt3.Deformations

variable {R : Type*} [CommRing R]

/-- A characteristic-p prime-power-order unit has nilpotent
augmentation coordinate. This uses Frobenius algebra, not a bounded
group-ring calculation. -/
theorem cyclic_augmentation_nilpotent (p a : ℕ) [Fact p.Prime]
    [CharP R p] (generator : Rˣ)
    (order_relation : generator ^ (p ^ a) = 1) :
    IsNilpotent (cyclicAugmentationCoordinate generator) := by
  refine ⟨p ^ a, ?_⟩
  unfold cyclicAugmentationCoordinate
  rw [sub_pow_char_pow]
  have hunit : (generator : R) ^ (p ^ a) = 1 :=
    congrArg (fun x : Rˣ => (x : R)) order_relation
  rw [hunit, one_pow, sub_self]

variable [Invertible (2 : R)]

/-- Exact coordinate conversion, valid before any truncation. -/
theorem cyclic_coordinate_factorization (generator : Rˣ) :
    cyclicSkewCoordinate generator = cyclicAugmentationCoordinate generator *
      cyclicCoordinateFactor generator := by
  have hunit : (generator : R) * (generator⁻¹ : Rˣ) = 1 :=
    generator.val_inv
  unfold cyclicSkewCoordinate cyclicAugmentationCoordinate cyclicCoordinateFactor
  calc
    ⅟ (2 : R) * ((generator : R) - (generator⁻¹ : Rˣ)) =
      ⅟ (2 : R) * (((generator : R) * (generator⁻¹ : Rˣ)) *
        (generator : R) - (generator⁻¹ : Rˣ)) := by rw [hunit, one_mul]
    _ = ((generator : R) - 1) *
      (⅟ (2 : R) * (generator⁻¹ : Rˣ) * ((generator : R) + 1)) := by ring

theorem cyclic_coordinate_factor_isUnit (generator : Rˣ)
    (nilpotent : IsNilpotent (cyclicAugmentationCoordinate generator)) :
    IsUnit (cyclicCoordinateFactor generator) := by
  have htwo : IsUnit (2 : R) := isUnit_of_invertible _
  have hsum : IsUnit ((generator : R) + 1) := by
    have H := nilpotent.isUnit_add_left_of_commute htwo (Commute.all _ _)
    have heq : (2 : R) + cyclicAugmentationCoordinate generator =
        (generator : R) + 1 := by
      unfold cyclicAugmentationCoordinate
      ring
    rwa [heq] at H
  exact (isUnit_of_invertible (⅟ (2 : R))).mul generator⁻¹.isUnit |>.mul hsum

/-- Every augmentation ideal power is retained under the actual
unit coordinate change. -/
theorem cyclic_coordinate_ideals_agree (generator : Rˣ)
    (nilpotent : IsNilpotent (cyclicAugmentationCoordinate generator)) :
    Specifications.CyclicCoordinateIdealsAgree generator := by
  intro n
  rw [cyclic_coordinate_factorization, mul_pow]
  exact Ideal.span_singleton_mul_right_unit
    ((cyclic_coordinate_factor_isUnit generator nilpotent).pow n) _

/-- The actual inversion involution sends the new coordinate to its
negative. The original augmentation coordinate need not have that
property. -/
theorem cyclic_skew_coordinate_involution (generator : Rˣ)
    (involution : R →+* R)
    (involutive : Function.Involutive involution)
    (generator_inverted : involution (generator : R) = (generator⁻¹ : Rˣ)) :
    involution (cyclicSkewCoordinate generator) =
      -cyclicSkewCoordinate generator := by
  have inverse_inverted : involution (generator⁻¹ : Rˣ) = (generator : R) := by
    rw [← generator_inverted]
    exact involutive (generator : R)
  have inverse_two_fixed : involution (⅟ (2 : R)) = ⅟ (2 : R) := by
    have hright : (2 : R) * involution (⅟ (2 : R)) = 1 := by
      calc
        (2 : R) * involution (⅟ (2 : R)) =
          involution ((2 : R) * ⅟ (2 : R)) := by
            simp only [map_mul, map_ofNat]
        _ = 1 := by rw [mul_invOf_self, map_one]
    exact (invOf_eq_right_inv hright).symm
  unfold cyclicSkewCoordinate
  rw [map_mul, map_sub, generator_inverted, inverse_inverted, inverse_two_fixed]
  ring

end Litt3.Deformations

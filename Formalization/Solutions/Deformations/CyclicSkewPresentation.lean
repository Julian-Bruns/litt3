import Theorems.Deformations.CyclicSkewPresentation
import Solutions.Deformations.TruncatedSkewCoordinate
import Solutions.Deformations.CyclicInversion
import Solutions.Deformations.TruncatedReflection

namespace Litt3.Deformations

open Polynomial

/-- Every ring map preserves the actual skew coordinate, with
the compatible actual unit map and inverse of two. -/
theorem map_cyclic_skew_coordinate {R S : Type*} [CommRing R] [CommRing S]
    [Invertible (2 : R)] [Invertible (2 : S)] (f : R →+* S) (u : Rˣ) :
    f (cyclicSkewCoordinate u) = cyclicSkewCoordinate (Units.map f.toMonoidHom u) := by
  have htwo : f (⅟ (2 : R)) = ⅟ (2 : S) := by
    apply (invOf_eq_right_inv ?_).symm
    calc
      (2 : S) * f (⅟ (2 : R)) = f ((2 : R) * ⅟ (2 : R)) := by
        simp only [map_mul, map_ofNat]
      _ = 1 := by rw [mul_invOf_self, map_one]
  unfold cyclicSkewCoordinate
  rw [map_mul, map_sub, htwo]
  rfl

variable {k : Type*} [Field k] [Invertible (2 : k)]

noncomputable def cyclicSkewAlgebraEquiv (p a : ℕ) [Fact p.Prime] [CharP k p] :
    TruncatedCoefficientRing k (p ^ a) ≃ₐ[k] CyclicGroupAlgebra k (p ^ a) :=
  (truncatedSkewCoordinateEquiv (K := k) (p ^ a)).trans
    (cyclicAugmentationAlgebraEquiv p a)

@[simp] theorem cyclic_skew_equiv_parameter (p a : ℕ) [Fact p.Prime] [CharP k p] :
    cyclicSkewAlgebraEquiv (k := k) p a (truncatedParameter k (p ^ a)) =
      cyclicSkewCoordinate (cyclicGroupGenerator k (p ^ a)) := by
  change cyclicAugmentationAlgebraEquiv p a
    (truncatedSkewCoordinateEquiv (K := k) (p ^ a) (truncatedParameter k (p ^ a))) = _
  rw [truncated_skew_equiv_parameter]
  change cyclicAugmentationPresentation k p a
    (cyclicSkewCoordinate (truncatedCyclicUnit (k := k) (p ^ a))) = _
  have hu : Units.map (cyclicAugmentationPresentation k p a).toMonoidHom
      (truncatedCyclicUnit (k := k) (p ^ a)) = cyclicGroupGenerator k (p ^ a) := by
    apply Units.ext
    change cyclicAugmentationPresentation k p a
      (truncatedCyclicUnit (k := k) (p ^ a) : TruncatedCoefficientRing k (p ^ a)) = _
    rw [truncated_cyclic_unit_value, map_add, map_one,
      cyclic_augmentation_presentation_parameter]
    ring
  have h := map_cyclic_skew_coordinate (cyclicAugmentationPresentation k p a).toRingHom
    (truncatedCyclicUnit (k := k) (p ^ a))
  rw [hu] at h
  exact h

omit [Invertible (2 : k)] in
@[simp] theorem cyclic_group_inversion_constant (N : ℕ) (c : k) :
    cyclicGroupInversion k N (algebraMap k (CyclicGroupAlgebra k N) c) =
      algebraMap k (CyclicGroupAlgebra k N) c := by
  change cyclicGroupInversion k N (AddMonoidAlgebra.single 0 c) =
    AddMonoidAlgebra.single 0 c
  rw [cyclic_group_inversion_single, neg_zero]

/-- The full actual quotient reflection is transported to the
full actual cyclic-group inversion; the identity holds on every
element, not only on the chosen coordinate. -/
theorem cyclic_skew_equiv_inversion (p a : ℕ) [Fact p.Prime] [CharP k p]
    (x : TruncatedCoefficientRing k (p ^ a)) :
    cyclicSkewAlgebraEquiv (k := k) p a (truncatedReflection k (p ^ a) x) =
      cyclicGroupInversion k (p ^ a) (cyclicSkewAlgebraEquiv (k := k) p a x) := by
  let e := cyclicSkewAlgebraEquiv (k := k) p a
  have h : e.toRingHom.comp (truncatedReflection k (p ^ a)) =
      (cyclicGroupInversion k (p ^ a)).comp e.toRingHom := by
    apply AdjoinRoot.ringHom_ext
    · apply RingHom.ext
      intro c
      change e (truncatedReflection k (p ^ a)
        (AdjoinRoot.of ((X : Polynomial k) ^ (p ^ a)) c)) =
          cyclicGroupInversion k (p ^ a) (e (AdjoinRoot.of ((X : Polynomial k) ^ (p ^ a)) c))
      rw [truncated_reflection_constant, ← AdjoinRoot.algebraMap_eq, e.commutes,
        cyclic_group_inversion_constant]
    · change e (truncatedReflection k (p ^ a) (truncatedParameter k (p ^ a))) =
        cyclicGroupInversion k (p ^ a) (e (truncatedParameter k (p ^ a)))
      rw [truncated_reflection_parameter, map_neg]
      change -(cyclicSkewAlgebraEquiv (k := k) p a (truncatedParameter k (p ^ a))) =
        cyclicGroupInversion k (p ^ a)
          (cyclicSkewAlgebraEquiv (k := k) p a (truncatedParameter k (p ^ a)))
      rw [cyclic_skew_equiv_parameter, cyclic_group_skew_inversion]
  exact DFunLike.congr_fun h x

theorem cyclic_skew_presentation_exists (p a : ℕ) [Fact p.Prime] [CharP k p] :
    Specifications.CyclicSkewPresentationExists (k := k) p a :=
  ⟨cyclicSkewAlgebraEquiv p a, cyclic_skew_equiv_parameter p a,
    cyclic_skew_equiv_inversion p a⟩

end Litt3.Deformations

import Theorems.Deformations.CyclicGroupAlgebra
import Solutions.Deformations.TruncatedCoefficientRing
import Mathlib.Algebra.Group.Subgroup.ZPowers.Basic
import Mathlib.Algebra.Group.TypeTags.Hom

namespace Litt3.Deformations

open Polynomial

variable {k : Type*} [CommRing k]

instance truncatedPositiveCharP (N p : ℕ) [NeZero N] [CharP k p] :
    CharP (TruncatedCoefficientRing k N) p := by
  apply charP_of_injective_algebraMap (R := k) (A := TruncatedCoefficientRing k N) (p := p)
  intro c d h
  have h' := congrArg (truncatedResidue k N (Nat.pos_of_ne_zero (NeZero.ne N))) h
  simpa only [AdjoinRoot.algebraMap_eq, truncated_residue_constant] using h'

/-- The genuine unit 1+z in the genuine truncated algebra. -/
noncomputable def truncatedCyclicUnit (N : ℕ) : (TruncatedCoefficientRing k N)ˣ :=
  ((truncated_parameter_nilpotent N).isUnit_one_add).unit

@[simp] theorem truncated_cyclic_unit_value (N : ℕ) :
    (truncatedCyclicUnit (k := k) N : TruncatedCoefficientRing k N) =
      1 + truncatedParameter k N :=
  ((truncated_parameter_nilpotent N).isUnit_one_add).unit_spec

theorem truncated_cyclic_unit_order (p a : ℕ) [Fact p.Prime] [CharP k p] :
    truncatedCyclicUnit (k := k) (p ^ a) ^ (p ^ a) = 1 := by
  haveI : NeZero (p ^ a) := ⟨pow_ne_zero a (Fact.out : Nat.Prime p).ne_zero⟩
  apply Units.ext
  change (truncatedCyclicUnit (k := k) (p ^ a) : TruncatedCoefficientRing k (p ^ a)) ^
    (p ^ a) = 1
  rw [truncated_cyclic_unit_value, add_pow_char_pow, one_pow,
    truncated_parameter_pow, add_zero]

/-- The actual cyclic group representation by the unit 1+z.
It is defined by the integer relation, including arbitrary coefficient rings. -/
noncomputable def truncatedCyclicGroupHom (p a : ℕ) [Fact p.Prime] [CharP k p] :
    Multiplicative (ZMod (p ^ a)) →* TruncatedCoefficientRing k (p ^ a) := by
  let u := truncatedCyclicUnit (k := k) (p ^ a)
  let f : ℤ →+ Additive (TruncatedCoefficientRing k (p ^ a))ˣ :=
    zmultiplesHom _ (Additive.ofMul u)
  have h : f (p ^ a : ℕ) = 0 := by
    change u ^ ((p ^ a : ℕ) : ℤ) = 1
    rw [zpow_natCast]
    exact truncated_cyclic_unit_order p a
  exact (Units.coeHom _).comp
    (AddMonoidHom.toMultiplicativeLeft (ZMod.lift (p ^ a) ⟨f, h⟩))

@[simp] theorem truncated_cyclic_group_hom_one (p a : ℕ) [Fact p.Prime] [CharP k p] :
    truncatedCyclicGroupHom (k := k) p a (Multiplicative.ofAdd (1 : ZMod (p ^ a))) =
      1 + truncatedParameter k (p ^ a) := by
  unfold truncatedCyclicGroupHom
  change (((Additive.toMul ((ZMod.lift (p ^ a)
    ⟨zmultiplesHom _ (Additive.ofMul (truncatedCyclicUnit (k := k) (p ^ a))), by
      change truncatedCyclicUnit (k := k) (p ^ a) ^ ((p ^ a : ℕ) : ℤ) = 1
      rw [zpow_natCast]
      exact truncated_cyclic_unit_order p a⟩)
      (1 : ZMod (p ^ a)))) : (TruncatedCoefficientRing k (p ^ a))ˣ) :
        TruncatedCoefficientRing k (p ^ a)) = _
  rw [show (1 : ZMod (p ^ a)) = ((1 : ℤ) : ZMod (p ^ a)) by simp,
    ZMod.lift_coe]
  simpa only [zmultiplesHom_apply, one_zsmul] using
    truncated_cyclic_unit_value (k := k) (p ^ a)

/-- The explicit inverse presentation homomorphism, induced by
the actual cyclic group representation. -/
noncomputable def cyclicAugmentationPresentationInverse (p a : ℕ)
    [Fact p.Prime] [CharP k p] :
    CyclicGroupAlgebra k (p ^ a) →ₐ[k] TruncatedCoefficientRing k (p ^ a) :=
  AddMonoidAlgebra.lift k (ZMod (p ^ a)) (TruncatedCoefficientRing k (p ^ a))
    (truncatedCyclicGroupHom p a)

@[simp] theorem cyclic_augmentation_presentation_parameter (p a : ℕ)
    [Fact p.Prime] [CharP k p] :
    cyclicAugmentationPresentation k p a (truncatedParameter k (p ^ a)) =
      (cyclicGroupGenerator k (p ^ a) : CyclicGroupAlgebra k (p ^ a)) - 1 := by
  exact AdjoinRoot.liftAlgHom_root _ _ _ _

@[simp] theorem cyclic_augmentation_inverse_generator (p a : ℕ)
    [Fact p.Prime] [CharP k p] :
    cyclicAugmentationPresentationInverse (k := k) p a
      (cyclicGroupGenerator k (p ^ a) : CyclicGroupAlgebra k (p ^ a)) =
        1 + truncatedParameter k (p ^ a) := by
  change AddMonoidAlgebra.lift _ _ _ _ (AddMonoidAlgebra.of' _ _ 1) = _
  rw [AddMonoidAlgebra.lift_of', truncated_cyclic_group_hom_one]

theorem cyclic_augmentation_inverse_comp (p a : ℕ) [Fact p.Prime] [CharP k p] :
    (cyclicAugmentationPresentationInverse (k := k) p a).comp
      (cyclicAugmentationPresentation k p a) =
        AlgHom.id k (TruncatedCoefficientRing k (p ^ a)) := by
  apply AdjoinRoot.algHom_ext
  change cyclicAugmentationPresentationInverse (k := k) p a
    (cyclicAugmentationPresentation k p a (truncatedParameter k (p ^ a))) =
      truncatedParameter k (p ^ a)
  rw [cyclic_augmentation_presentation_parameter, map_sub,
    cyclic_augmentation_inverse_generator, map_one, add_sub_cancel_left]

/-- Every actual group-algebra element is in the actual
augmentation presentation range, over any commutative coefficient ring. -/
theorem cyclic_augmentation_presentation_surjective (p a : ℕ)
    [Fact p.Prime] [CharP k p] :
    Function.Surjective (cyclicAugmentationPresentation k p a) := by
  haveI : NeZero (p ^ a) := ⟨pow_ne_zero a (Fact.out : Nat.Prime p).ne_zero⟩
  intro x
  induction x using AddMonoidAlgebra.induction_on with
  | hM g =>
    refine ⟨(1 + truncatedParameter k (p ^ a)) ^ g.val, ?_⟩
    rw [map_pow, map_add, map_one, cyclic_augmentation_presentation_parameter]
    have heq : (1 : CyclicGroupAlgebra k (p ^ a)) +
        ((cyclicGroupGenerator k (p ^ a) : CyclicGroupAlgebra k (p ^ a)) - 1) =
          cyclicGroupGenerator k (p ^ a) := by ring
    rw [heq]
    change AddMonoidAlgebra.single (1 : ZMod (p ^ a)) 1 ^ g.val =
      AddMonoidAlgebra.single g 1
    rw [AddMonoidAlgebra.single_pow, one_pow, Nat.smul_one_eq_cast,
      ZMod.natCast_zmod_val]
  | hadd x y hx hy =>
    obtain ⟨x', rfl⟩ := hx
    obtain ⟨y', rfl⟩ := hy
    exact ⟨x' + y', map_add _ x' y'⟩
  | hsmul c x hx =>
    obtain ⟨x', rfl⟩ := hx
    exact ⟨c • x', map_smul _ c x'⟩

theorem cyclic_augmentation_presentation_bijective (p a : ℕ)
    [Fact p.Prime] [CharP k p] :
    Specifications.CyclicAugmentationPresentationBijective (k := k) p a := by
  have hleft : Function.LeftInverse (cyclicAugmentationPresentationInverse (k := k) p a)
      (cyclicAugmentationPresentation k p a) := by
    intro x
    exact DFunLike.congr_fun (cyclic_augmentation_inverse_comp (k := k) p a) x
  exact ⟨hleft.injective, cyclic_augmentation_presentation_surjective p a⟩

/-- Genuine algebra identification of the cyclic group algebra
and the augmentation quotient. No field, perfectness or positive
exponent assumption is needed. -/
noncomputable def cyclicAugmentationAlgebraEquiv (p a : ℕ)
    [Fact p.Prime] [CharP k p] :
    TruncatedCoefficientRing k (p ^ a) ≃ₐ[k] CyclicGroupAlgebra k (p ^ a) :=
  AlgEquiv.ofBijective (cyclicAugmentationPresentation k p a)
    (cyclic_augmentation_presentation_bijective p a)

end Litt3.Deformations

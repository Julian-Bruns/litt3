import Solutions.Deformations.CyclicGroupAlgebra
import Mathlib.Algebra.Polynomial.Monic
import Mathlib.Algebra.Group.Commute.Units
import Mathlib.RingTheory.AdjoinRoot

namespace Litt3.Deformations

open Polynomial

variable {R : Type*} [CommRing R]

/-- The literal cyclic relation over an arbitrary coefficient ring,
including mixed characteristic. -/
noncomputable def integralCyclicRelation (q : ℕ) : R[X] := (1 + X) ^ q - 1

abbrev IntegralCyclicAlgebra (R : Type*) [CommRing R] (q : ℕ) :=
  AdjoinRoot (integralCyclicRelation (R := R) q)

noncomputable def integralCyclicParameter (q : ℕ) : IntegralCyclicAlgebra R q :=
  AdjoinRoot.root (integralCyclicRelation (R := R) q)

theorem integral_cyclic_root_relation (q : ℕ) :
    (1 + integralCyclicParameter (R := R) q) ^ q = 1 := by
  have root := AdjoinRoot.eval₂_root (integralCyclicRelation (R := R) q)
  simpa only [integralCyclicRelation, Polynomial.eval₂_sub, Polynomial.eval₂_pow,
    Polynomial.eval₂_add, Polynomial.eval₂_one, Polynomial.eval₂_X,
    integralCyclicParameter, sub_eq_zero] using root

noncomputable def integralCyclicUnit (q : ℕ) (positive : 0 < q) :
    (IntegralCyclicAlgebra R q)ˣ :=
  (IsUnit.of_pow_eq_one (integral_cyclic_root_relation q) (Nat.ne_of_gt positive)).unit

@[simp] theorem integral_cyclic_unit_value (q : ℕ) (positive : 0 < q) :
    (integralCyclicUnit (R := R) q positive : IntegralCyclicAlgebra R q) =
      1 + integralCyclicParameter (R := R) q :=
  (IsUnit.of_pow_eq_one (integral_cyclic_root_relation q) (Nat.ne_of_gt positive)).unit_spec

theorem integral_cyclic_unit_order (q : ℕ) (positive : 0 < q) :
    integralCyclicUnit (R := R) q positive ^ q = 1 := by
  apply Units.ext
  change (integralCyclicUnit (R := R) q positive : IntegralCyclicAlgebra R q) ^ q = 1
  rw [integral_cyclic_unit_value, integral_cyclic_root_relation]

noncomputable def integralCyclicGroupHom (q : ℕ) (positive : 0 < q) :
    Multiplicative (ZMod q) →* IntegralCyclicAlgebra R q := by
  let u := integralCyclicUnit (R := R) q positive
  let f : ℤ →+ Additive (IntegralCyclicAlgebra R q)ˣ := zmultiplesHom _ (Additive.ofMul u)
  have relation : f q = 0 := by
    change u ^ (q : ℤ) = 1
    rw [zpow_natCast]
    exact integral_cyclic_unit_order q positive
  exact (Units.coeHom _).comp
    (AddMonoidHom.toMultiplicativeLeft (ZMod.lift q ⟨f, relation⟩))

@[simp] theorem integral_cyclic_group_hom_one (q : ℕ) (positive : 0 < q) :
    integralCyclicGroupHom (R := R) q positive (Multiplicative.ofAdd (1 : ZMod q)) =
      1 + integralCyclicParameter (R := R) q := by
  unfold integralCyclicGroupHom
  change (((Additive.toMul ((ZMod.lift q
    ⟨zmultiplesHom _ (Additive.ofMul (integralCyclicUnit (R := R) q positive)), by
      change integralCyclicUnit (R := R) q positive ^ (q : ℤ) = 1
      rw [zpow_natCast]
      exact integral_cyclic_unit_order q positive⟩)
    (1 : ZMod q))) : (IntegralCyclicAlgebra R q)ˣ) : IntegralCyclicAlgebra R q) = _
  rw [show (1 : ZMod q) = ((1 : ℤ) : ZMod q) by simp, ZMod.lift_coe]
  simpa only [zmultiplesHom_apply, one_zsmul] using
    integral_cyclic_unit_value (R := R) q positive

theorem cyclic_group_generator_power (q : ℕ) :
    (cyclicGroupGenerator R q : CyclicGroupAlgebra R q) ^ q = 1 := by
  change AddMonoidAlgebra.single (1 : ZMod q) 1 ^ q = 1
  rw [AddMonoidAlgebra.single_pow]
  simp only [one_pow, Nat.smul_one_eq_cast, ZMod.natCast_self]
  rfl

/-- Literal original augmentation presentation into the actual group
algebra, valid over every commutative ring without characteristic assumptions. -/
noncomputable def integralCyclicPresentation (q : ℕ) :
    IntegralCyclicAlgebra R q →ₐ[R] CyclicGroupAlgebra R q :=
  AdjoinRoot.liftAlgHom (integralCyclicRelation (R := R) q)
    (Algebra.ofId R (CyclicGroupAlgebra R q))
    ((cyclicGroupGenerator R q : CyclicGroupAlgebra R q) - 1) (by
      simp only [integralCyclicRelation, Polynomial.eval₂_sub, Polynomial.eval₂_pow,
        Polynomial.eval₂_add, Polynomial.eval₂_one, Polynomial.eval₂_X]
      rw [show (1 : CyclicGroupAlgebra R q) +
        ((cyclicGroupGenerator R q : CyclicGroupAlgebra R q) - 1) =
          cyclicGroupGenerator R q by ring, cyclic_group_generator_power, sub_self])

noncomputable def integralCyclicPresentationInverse (q : ℕ) (positive : 0 < q) :
    CyclicGroupAlgebra R q →ₐ[R] IntegralCyclicAlgebra R q :=
  AddMonoidAlgebra.lift R (ZMod q) _ (integralCyclicGroupHom q positive)

@[simp] theorem integral_cyclic_presentation_parameter (q : ℕ) :
    integralCyclicPresentation (R := R) q (integralCyclicParameter (R := R) q) =
      (cyclicGroupGenerator R q : CyclicGroupAlgebra R q) - 1 :=
  AdjoinRoot.liftAlgHom_root _ _ _ _

@[simp] theorem integral_cyclic_inverse_generator (q : ℕ) (positive : 0 < q) :
    integralCyclicPresentationInverse (R := R) q positive
      (cyclicGroupGenerator R q : CyclicGroupAlgebra R q) =
        1 + integralCyclicParameter (R := R) q := by
  change AddMonoidAlgebra.lift _ _ _ _ (AddMonoidAlgebra.of' _ _ 1) = _
  rw [AddMonoidAlgebra.lift_of', integral_cyclic_group_hom_one]

theorem integral_cyclic_inverse_comp (q : ℕ) (positive : 0 < q) :
    (integralCyclicPresentationInverse (R := R) q positive).comp
      (integralCyclicPresentation (R := R) q) = AlgHom.id R (IntegralCyclicAlgebra R q) := by
  apply AdjoinRoot.algHom_ext
  change integralCyclicPresentationInverse (R := R) q positive
    (integralCyclicPresentation (R := R) q (integralCyclicParameter (R := R) q)) =
      integralCyclicParameter (R := R) q
  rw [integral_cyclic_presentation_parameter, map_sub, integral_cyclic_inverse_generator,
    map_one, add_sub_cancel_left]

theorem integral_cyclic_presentation_surjective (q : ℕ) (positive : 0 < q) :
    Function.Surjective (integralCyclicPresentation (R := R) q) := by
  haveI : NeZero q := ⟨Nat.ne_of_gt positive⟩
  intro x
  induction x using AddMonoidAlgebra.induction_on with
  | hM g =>
    refine ⟨(1 + integralCyclicParameter (R := R) q) ^ g.val, ?_⟩
    rw [map_pow, map_add, map_one, integral_cyclic_presentation_parameter]
    rw [show (1 : CyclicGroupAlgebra R q) +
      ((cyclicGroupGenerator R q : CyclicGroupAlgebra R q) - 1) =
        cyclicGroupGenerator R q by ring]
    change AddMonoidAlgebra.single (1 : ZMod q) 1 ^ g.val = AddMonoidAlgebra.single g 1
    rw [AddMonoidAlgebra.single_pow, one_pow, Nat.smul_one_eq_cast, ZMod.natCast_zmod_val]
  | hadd x y hx hy =>
    obtain ⟨x', rfl⟩ := hx
    obtain ⟨y', rfl⟩ := hy
    exact ⟨x' + y', map_add _ x' y'⟩
  | hsmul c x hx =>
    obtain ⟨x', rfl⟩ := hx
    exact ⟨c • x', map_smul _ c x'⟩

/-- Actual cyclic group algebra equals the literal original relation
quotient, including mixed-characteristic Witt coefficient rings. -/
noncomputable def integralCyclicAlgebraEquiv (q : ℕ) (positive : 0 < q) :
    IntegralCyclicAlgebra R q ≃ₐ[R] CyclicGroupAlgebra R q := by
  have left : Function.LeftInverse (integralCyclicPresentationInverse (R := R) q positive)
      (integralCyclicPresentation (R := R) q) := by
    intro x
    exact DFunLike.congr_fun (integral_cyclic_inverse_comp q positive) x
  exact AlgEquiv.ofBijective (integralCyclicPresentation q)
    ⟨left.injective, integral_cyclic_presentation_surjective q positive⟩

end Litt3.Deformations

import Solutions.Deformations.ElementaryDeckOperators

namespace Litt3.Deformations

open scoped BigOperators

variable {R G : Type*} [CommRing R] [AddMonoid G]

/-- Actual coefficient-sum augmentation of the additive group algebra. -/
noncomputable def additiveGroupAlgebraAugmentation : AddMonoidAlgebra R G →ₐ[R] R :=
  AddMonoidAlgebra.lift R G R 1

@[simp] theorem additive_group_augmentation_single (g : G) (c : R) :
    additiveGroupAlgebraAugmentation (AddMonoidAlgebra.single g c) = c := by
  simp [additiveGroupAlgebraAugmentation]

variable [Nontrivial R]

@[simp] theorem elementary_augmentation_parameter_aug (q r : ℕ) (i : Fin r) :
    additiveGroupAlgebraAugmentation (elementaryAugmentationParameter (R := R) q r i) = 0 := by
  simp [elementaryAugmentationParameter]

def elementaryZeroNormalExponent (q : ℕ) (positive : 0 < q) (r : ℕ) : Fin r → Fin q :=
  fun _ => ⟨0, positive⟩

theorem elementary_augmentation_basis_aug (q : ℕ) (positive : 0 < q) (r : ℕ)
    (alpha : Fin r → Fin q) :
    additiveGroupAlgebraAugmentation (elementaryAugmentationBasis (R := R) q positive r alpha) =
      if alpha = elementaryZeroNormalExponent q positive r then 1 else 0 := by
  classical
  rw [elementary_augmentation_basis_apply, map_prod]
  simp only [map_pow, elementary_augmentation_parameter_aug]
  by_cases zero : alpha = elementaryZeroNormalExponent q positive r
  · subst alpha
    simp [elementaryZeroNormalExponent]
  · rw [if_neg zero]
    obtain ⟨i, nonzero⟩ : ∃ i, (alpha i).val ≠ 0 := by
      by_contra absent
      push_neg at absent
      apply zero
      funext i
      exact Fin.ext (absent i)
    exact Finset.prod_eq_zero (Finset.mem_univ i) (zero_pow nonzero)

/-- Augmentation reads the actual original zero-exponent normal coordinate. -/
theorem elementary_augmentation_normal_coordinate (q : ℕ) (positive : 0 < q) (r : ℕ)
    (x : AddMonoidAlgebra R (Fin r → ZMod q)) :
    additiveGroupAlgebraAugmentation x =
      (elementaryAugmentationBasis (R := R) q positive r).repr x (elementaryZeroNormalExponent q positive r) := by
  classical
  let B := elementaryAugmentationBasis (R := R) q positive r
  have coordinate : (additiveGroupAlgebraAugmentation : AddMonoidAlgebra R (Fin r → ZMod q) →ₐ[R] R).toLinearMap =
      B.coord (elementaryZeroNormalExponent q positive r) := by
    apply B.ext
    intro alpha
    change additiveGroupAlgebraAugmentation (B alpha) =
      B.coord (elementaryZeroNormalExponent q positive r) (B alpha)
    rw [elementary_augmentation_basis_aug]
    simp [Module.Basis.coord_apply, Finsupp.single_apply, eq_comm]
  exact LinearMap.congr_fun coordinate x

/-- Deck equivariance alone makes the augmented operator depend precisely on
its action on the original constant coefficient; coefficient linearity is unnecessary. -/
theorem elementary_deck_operator_aug_constant (q : ℕ) (positive : 0 < q) (r : ℕ)
    (L : AddMonoidAlgebra R (Fin r → ZMod q) →+ AddMonoidAlgebra R (Fin r → ZMod q))
    (equivariant : ElementaryDeckEquivariant q r L)
    (x : AddMonoidAlgebra R (Fin r → ZMod q)) :
    additiveGroupAlgebraAugmentation (L x) =
      additiveGroupAlgebraAugmentation
        (L (algebraMap R (AddMonoidAlgebra R (Fin r → ZMod q))
          (additiveGroupAlgebraAugmentation x))) := by
  classical
  rw [elementary_deck_operator_normal_coordinates q positive r L equivariant x, map_sum]
  simp_rw [map_mul, elementary_augmentation_basis_aug]
  simp only [ite_mul, one_mul, zero_mul]
  rw [Finset.sum_ite_eq', if_pos (Finset.mem_univ (elementaryZeroNormalExponent q positive r)),
    elementary_augmentation_normal_coordinate q positive r x]

end Litt3.Deformations

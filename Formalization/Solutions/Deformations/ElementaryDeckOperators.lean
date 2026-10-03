import Solutions.Deformations.ElementaryAugmentationBasis
import Mathlib.Algebra.BigOperators.Group.Finset.Defs

namespace Litt3.Deformations

variable {R : Type*} [CommRing R] [Nontrivial R]

/-- Literal deck equivariance for the actual original group algebra. -/
def ElementaryDeckEquivariant (q r : ℕ)
    (L : AddMonoidAlgebra R (Fin r → ZMod q) →+ AddMonoidAlgebra R (Fin r → ZMod q)) : Prop :=
  ∀ g x, L (AddMonoidAlgebra.single g 1 * x) = AddMonoidAlgebra.single g 1 * L x

theorem elementary_deck_augmentation_commute (q r : ℕ)
    (L : AddMonoidAlgebra R (Fin r → ZMod q) →+ AddMonoidAlgebra R (Fin r → ZMod q))
    (equivariant : ElementaryDeckEquivariant q r L) (i : Fin r)
    (x : AddMonoidAlgebra R (Fin r → ZMod q)) :
    L (elementaryAugmentationParameter (R := R) q r i * x) =
      elementaryAugmentationParameter (R := R) q r i * L x := by
  simp only [elementaryAugmentationParameter, sub_mul, one_mul, map_sub]
  rw [equivariant]

theorem elementary_deck_augmentation_power_commute (q r : ℕ)
    (L : AddMonoidAlgebra R (Fin r → ZMod q) →+ AddMonoidAlgebra R (Fin r → ZMod q))
    (equivariant : ElementaryDeckEquivariant q r L) (i : Fin r) (n : ℕ)
    (x : AddMonoidAlgebra R (Fin r → ZMod q)) :
    L (elementaryAugmentationParameter (R := R) q r i ^ n * x) =
      elementaryAugmentationParameter (R := R) q r i ^ n * L x := by
  induction n generalizing x with
  | zero => simp
  | succ n induction =>
    rw [pow_succ, mul_assoc, induction, elementary_deck_augmentation_commute q r L equivariant,
      mul_assoc]

theorem elementary_deck_monomial_commute (q r : ℕ)
    (L : AddMonoidAlgebra R (Fin r → ZMod q) →+ AddMonoidAlgebra R (Fin r → ZMod q))
    (equivariant : ElementaryDeckEquivariant q r L) (alpha : Fin r → ℕ)
    (x : AddMonoidAlgebra R (Fin r → ZMod q)) :
    L ((∏ i, elementaryAugmentationParameter (R := R) q r i ^ alpha i) * x) =
      (∏ i, elementaryAugmentationParameter (R := R) q r i ^ alpha i) * L x := by
  classical
  have finite (s : Finset (Fin r)) :
      ∀ x, L ((∏ i ∈ s, elementaryAugmentationParameter (R := R) q r i ^ alpha i) * x) =
        (∏ i ∈ s, elementaryAugmentationParameter (R := R) q r i ^ alpha i) * L x := by
    induction s using Finset.induction_on with
    | empty => intro x; simp
    | @insert i s member induction =>
      intro x
      rw [Finset.prod_insert member, mul_assoc,
        elementary_deck_augmentation_power_commute q r L equivariant,
        induction, ← mul_assoc]
  exact finite Finset.univ x

/-- Every additive deck-equivariant operator is reconstructed on the
literal original normal basis from its actual coefficient action.
No coefficient-ring linearity or commuting coefficient maps is assumed. -/
theorem elementary_deck_operator_normal_coordinates (q : ℕ) (positive : 0 < q) (r : ℕ)
    (L : AddMonoidAlgebra R (Fin r → ZMod q) →+ AddMonoidAlgebra R (Fin r → ZMod q))
    (equivariant : ElementaryDeckEquivariant q r L)
    (x : AddMonoidAlgebra R (Fin r → ZMod q)) :
    L x = ∑ alpha : Fin r → Fin q,
      elementaryAugmentationBasis (R := R) q positive r alpha *
        L (algebraMap R (AddMonoidAlgebra R (Fin r → ZMod q))
          ((elementaryAugmentationBasis (R := R) q positive r).repr x alpha)) := by
  classical
  let basis := elementaryAugmentationBasis (R := R) q positive r
  conv_lhs => rw [← basis.sum_repr x]
  rw [map_sum]
  apply Finset.sum_congr rfl
  intro alpha _
  rw [Algebra.smul_def, mul_comm,
    elementary_augmentation_basis_apply,
    elementary_deck_monomial_commute q r L equivariant]

end Litt3.Deformations

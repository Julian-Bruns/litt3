import Solutions.Deformations.ElementaryFiveInitialRelation
import Solutions.Deformations.WeightedCongruenceProducts
import Solutions.Deformations.WeightedRootNormalProduct

namespace Litt3.Deformations

open scoped BigOperators

variable {R : Type*} [CommRing R] [Nontrivial R]

theorem elementary_five_normal_power_initial_product (r : ℕ) (i : Fin r) (a b : Fin 5) :
    elementaryAugmentationParameter (R := R) 5 r i ^ a.val *
        elementaryAugmentationParameter (R := R) 5 r i ^ b.val -
      (-(5 : AddMonoidAlgebra R (Fin r → ZMod 5))) ^ rootNormalCarry 5 a b *
        elementaryAugmentationParameter (R := R) 5 r i ^
          (rootNormalProductExponent 5 (by omega) a b).val ∈
      weightedGeneratorFiltration R (5 : AddMonoidAlgebra R (Fin r → ZMod 5)) 4
        (elementaryAugmentationParameter (R := R) 5 r) (a.val + b.val + 1) := by
  let e := elementaryAugmentationParameter (R := R) 5 r i
  rw [← pow_add]
  unfold rootNormalCarry rootNormalProductExponent
  split_ifs with small
  · simp only [Fin.val_mk, pow_zero, one_mul, sub_self]
    exact Submodule.zero_mem _
  · simp only [Fin.val_mk, pow_one]
    have splitPower : a.val + b.val = 5 + (a.val + b.val - 5) := by omega
    have splitRest : a.val + b.val - (5 - 1) = 1 + (a.val + b.val - 5) := by omega
    have identity : e ^ (a.val + b.val) - (-(5 : AddMonoidAlgebra R (Fin r → ZMod 5))) *
        e ^ (a.val + b.val - (5 - 1)) =
      e ^ (a.val + b.val - 5) * (e ^ 5 + (5 : AddMonoidAlgebra R (Fin r → ZMod 5)) * e) := by
      rw [splitRest]
      conv_lhs => lhs; rw [splitPower, pow_add]
      rw [pow_add, pow_one]
      ring
    change e ^ (a.val + b.val) - _ ∈ _
    rw [identity]
    have higher := weighted_generator_filtration_multiplicative (R := R)
      (5 : AddMonoidAlgebra R (Fin r → ZMod 5)) 4
      (elementaryAugmentationParameter (R := R) 5 r)
      (a.val + b.val - 5) 6 _ _
      (elementary_five_parameter_power_member (R := R) r i (a.val + b.val - 5))
      (elementary_five_initial_relation (R := R) r i)
    have sameWeight : a.val + b.val - 5 + 6 = a.val + b.val + 1 := by omega
    simpa only [sameWeight] using higher

/-- Full original normal multiplication in the actual integral group
algebra agrees, to its actual initial weight, with the literal parameter
model and its exact unchanged-coordinate carries. -/
theorem elementary_five_normal_basis_initial_product (r : ℕ)
    (alpha beta : Fin r → Fin 5) :
    elementaryAugmentationBasis (R := R) 5 (by omega) r alpha *
        elementaryAugmentationBasis (R := R) 5 (by omega) r beta -
      (-(5 : R)) ^ (∑ i, rootNormalCarry 5 (alpha i) (beta i)) •
        elementaryAugmentationBasis (R := R) 5 (by omega) r
          (fun i => rootNormalProductExponent 5 (by omega) (alpha i) (beta i)) ∈
      weightedGeneratorFiltration R (5 : AddMonoidAlgebra R (Fin r → ZMod 5)) 4
        (elementaryAugmentationParameter (R := R) 5 r)
        ((∑ i, (alpha i).val) + (∑ i, (beta i).val) + 1) := by
  classical
  let e := elementaryAugmentationParameter (R := R) 5 r
  let F := weightedGeneratorFiltration R (5 : AddMonoidAlgebra R (Fin r → ZMod 5)) 4 e
  let x := fun i => e i ^ (alpha i).val * e i ^ (beta i).val
  let y := fun i => (-(5 : AddMonoidAlgebra R (Fin r → ZMod 5))) ^
    rootNormalCarry 5 (alpha i) (beta i) *
      e i ^ (rootNormalProductExponent 5 (by omega) (alpha i) (beta i)).val
  have xMember : ∀ i, x i ∈ F ((alpha i).val + (beta i).val) := by
    intro i
    exact weighted_generator_filtration_multiplicative _ _ _ _ _ _ _
      (elementary_five_parameter_power_member r i (alpha i).val)
      (elementary_five_parameter_power_member r i (beta i).val)
  have congruence : ∀ i, x i - y i ∈ F ((alpha i).val + (beta i).val + 1) := by
    intro i
    exact elementary_five_normal_power_initial_product r i (alpha i) (beta i)
  have yMember : ∀ i, y i ∈ F ((alpha i).val + (beta i).val) := by
    intro i
    have higher := weighted_generator_filtration_antitone (R := R)
      (5 : AddMonoidAlgebra R (Fin r → ZMod 5)) 4 e
      (show (alpha i).val + (beta i).val ≤ (alpha i).val + (beta i).val + 1 by omega)
      (congruence i)
    have difference := Submodule.sub_mem _ (xMember i) higher
    simpa only [sub_sub_cancel] using difference
  have product := weighted_generator_product_congruence (R := R)
    (5 : AddMonoidAlgebra R (Fin r → ZMod 5)) 4 e Finset.univ x y
    (fun i => (alpha i).val + (beta i).val)
    (fun i _ => xMember i) (fun i _ => yMember i) (fun i _ => congruence i)
  dsimp only [x, y] at product
  rw [Finset.prod_mul_distrib, Finset.prod_mul_distrib, Finset.prod_pow_eq_pow_sum,
    Finset.sum_add_distrib] at product
  simpa only [elementary_augmentation_basis_apply, Algebra.smul_def, map_pow, map_neg,
    map_ofNat, e] using product

end Litt3.Deformations

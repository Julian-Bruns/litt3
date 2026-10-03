import Solutions.Deformations.ElementaryPrimeInitialRelation
import Solutions.Deformations.WeightedCongruenceProducts
import Solutions.Deformations.WeightedRootNormalProduct

namespace Litt3.Deformations

open scoped BigOperators

variable {R : Type*} [CommRing R] [Nontrivial R]
variable (p : ℕ) [Fact p.Prime]

theorem elementary_prime_normal_power_initial_product (r : ℕ) (i : Fin r) (a b : Fin p) :
    elementaryAugmentationParameter (R := R) p r i ^ a.val *
        elementaryAugmentationParameter (R := R) p r i ^ b.val -
      (-(p : AddMonoidAlgebra R (Fin r → ZMod p))) ^ rootNormalCarry p a b *
        elementaryAugmentationParameter (R := R) p r i ^
          (rootNormalProductExponent p (by have := (Fact.out : p.Prime).two_le; omega) a b).val ∈
      weightedGeneratorFiltration R (p : AddMonoidAlgebra R (Fin r → ZMod p)) (p - 1)
        (elementaryAugmentationParameter (R := R) p r) (a.val + b.val + 1) := by
  let e := elementaryAugmentationParameter (R := R) p r i
  rw [← pow_add]
  unfold rootNormalCarry rootNormalProductExponent
  split_ifs with small
  · simp only [Fin.val_mk, pow_zero, one_mul, sub_self]
    exact Submodule.zero_mem _
  · simp only [Fin.val_mk, pow_one]
    have splitPower : a.val + b.val = p + (a.val + b.val - p) := by omega
    have splitRest : a.val + b.val - (p - 1) = 1 + (a.val + b.val - p) := by omega
    have identity : e ^ (a.val + b.val) - (-(p : AddMonoidAlgebra R (Fin r → ZMod p))) *
        e ^ (a.val + b.val - (p - 1)) =
      e ^ (a.val + b.val - p) * (e ^ p + (p : AddMonoidAlgebra R (Fin r → ZMod p)) * e) := by
      rw [splitRest]
      conv_lhs => lhs; rw [splitPower, pow_add]
      rw [pow_add, pow_one]
      ring
    change e ^ (a.val + b.val) - _ ∈ _
    rw [identity]
    have higher := weighted_generator_filtration_multiplicative (R := R)
      (p : AddMonoidAlgebra R (Fin r → ZMod p)) (p - 1)
      (elementaryAugmentationParameter (R := R) p r)
      (a.val + b.val - p) (p + 1) _ _
      (elementary_prime_parameter_power_member (R := R) p r i (a.val + b.val - p))
      (elementary_prime_initial_relation (R := R) p r i)
    have sameWeight : a.val + b.val - p + (p + 1) = a.val + b.val + 1 := by omega
    simpa only [sameWeight] using higher

/-- Full original normal multiplication in the actual integral group
algebra agrees, to its actual initial weight, with the literal parameter
model and its exact unchanged-coordinate carries. -/
theorem elementary_prime_normal_basis_initial_product (r : ℕ)
    (alpha beta : Fin r → Fin p) :
    elementaryAugmentationBasis (R := R) p (by have := (Fact.out : p.Prime).two_le; omega) r alpha *
        elementaryAugmentationBasis (R := R) p (by have := (Fact.out : p.Prime).two_le; omega) r beta -
      (-(p : R)) ^ (∑ i, rootNormalCarry p (alpha i) (beta i)) •
        elementaryAugmentationBasis (R := R) p (by have := (Fact.out : p.Prime).two_le; omega) r
          (fun i => rootNormalProductExponent p (by have := (Fact.out : p.Prime).two_le; omega) (alpha i) (beta i)) ∈
      weightedGeneratorFiltration R (p : AddMonoidAlgebra R (Fin r → ZMod p)) (p - 1)
        (elementaryAugmentationParameter (R := R) p r)
        ((∑ i, (alpha i).val) + (∑ i, (beta i).val) + 1) := by
  classical
  let e := elementaryAugmentationParameter (R := R) p r
  let F := weightedGeneratorFiltration R (p : AddMonoidAlgebra R (Fin r → ZMod p)) (p - 1) e
  let x := fun i => e i ^ (alpha i).val * e i ^ (beta i).val
  let y := fun i => (-(p : AddMonoidAlgebra R (Fin r → ZMod p))) ^
    rootNormalCarry p (alpha i) (beta i) *
      e i ^ (rootNormalProductExponent p (by have := (Fact.out : p.Prime).two_le; omega) (alpha i) (beta i)).val
  have xMember : ∀ i, x i ∈ F ((alpha i).val + (beta i).val) := by
    intro i
    exact weighted_generator_filtration_multiplicative _ _ _ _ _ _ _
      (elementary_prime_parameter_power_member p r i (alpha i).val)
      (elementary_prime_parameter_power_member p r i (beta i).val)
  have congruence : ∀ i, x i - y i ∈ F ((alpha i).val + (beta i).val + 1) := by
    intro i
    exact elementary_prime_normal_power_initial_product p r i (alpha i) (beta i)
  have yMember : ∀ i, y i ∈ F ((alpha i).val + (beta i).val) := by
    intro i
    have higher := weighted_generator_filtration_antitone (R := R)
      (p : AddMonoidAlgebra R (Fin r → ZMod p)) (p - 1) e
      (show (alpha i).val + (beta i).val ≤ (alpha i).val + (beta i).val + 1 by omega)
      (congruence i)
    have difference := Submodule.sub_mem _ (xMember i) higher
    simpa only [sub_sub_cancel] using difference
  have product := weighted_generator_product_congruence (R := R)
    (p : AddMonoidAlgebra R (Fin r → ZMod p)) (p - 1) e Finset.univ x y
    (fun i => (alpha i).val + (beta i).val)
    (fun i _ => xMember i) (fun i _ => yMember i) (fun i _ => congruence i)
  dsimp only [x, y] at product
  rw [Finset.prod_mul_distrib, Finset.prod_mul_distrib, Finset.prod_pow_eq_pow_sum,
    Finset.sum_add_distrib] at product
  simpa only [elementary_augmentation_basis_apply, Algebra.smul_def, map_pow, map_neg,
    map_natCast, e] using product

end Litt3.Deformations

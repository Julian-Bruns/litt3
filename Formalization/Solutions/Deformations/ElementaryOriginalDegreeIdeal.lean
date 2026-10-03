import Definitions.Deformations.ElementaryOriginalDegreeIdeal
import Solutions.Deformations.ElementaryAugmentationDegreeSpan
import Solutions.Deformations.AugmentationBasisKernel

namespace Litt3.Deformations

open scoped BigOperators

variable {R : Type*} [CommRing R] [Nontrivial R]
variable (p : ℕ) [Fact p.Prime] [CharP R p]

/-- The actual degree-one ideal is precisely the genuine augmentation
kernel, derived from the unchanged original monomial basis. -/
theorem elementary_original_degree_one_augmentation (r : ℕ) :
    elementaryOriginalDegreeIdeal R p r 1 = elementaryOriginalAugmentationIdeal R p r := by
  classical
  let B := elementaryAugmentationBasis (R := R) p (Fact.out : p.Prime).pos r
  let z := elementaryZeroNormalExponent p (Fact.out : p.Prime).pos r
  let aug := (additiveGroupAlgebraAugmentation (R := R) (G := Fin r → ZMod p)).toLinearMap
  have kernel := augmentation_basis_kernel B z aug
    (by exact elementary_augmentation_basis_aug p (Fact.out : p.Prime).pos r z |>.trans (if_pos rfl))
    (by intro alpha different; exact elementary_augmentation_basis_aug p (Fact.out : p.Prime).pos r alpha |>.trans (if_neg different))
  unfold Specifications.AugmentationBasisKernel at kernel
  have indices : {alpha : Fin r → Fin p | alpha ≠ z} =
      {alpha : Fin r → Fin p | 1 ≤ ∑ i, (alpha i).val} := by
    ext alpha
    constructor
    · intro different
      by_contra small
      change ¬ 1 ≤ ∑ i, (alpha i).val at small
      have zero : (∑ i, (alpha i).val) = 0 := by omega
      apply different
      funext i
      apply Fin.ext
      have bound := Finset.single_le_sum (fun j _ => Nat.zero_le (alpha j).val) (Finset.mem_univ i)
      change (alpha i).val = 0
      omega
    · intro high same
      subst alpha
      simp [z, elementaryZeroNormalExponent] at high
  rw [indices] at kernel
  have comparison : elementaryNormalWeightFiltration R p (Fact.out : p.Prime).pos r 1 =
      LinearMap.ker aug := by
    rw [elementary_normal_weight_characteristic_degree]
    exact kernel.symm
  ext x
  change x ∈ elementaryNormalWeightFiltration R p (Fact.out : p.Prime).pos r 1 ↔
    additiveGroupAlgebraAugmentation x = 0
  rw [comparison]
  rfl

/-- Every original normal monomial belongs to the exact corresponding
power of the actual augmentation ideal. -/
theorem elementary_original_monomial_augmentation_power (r : ℕ) (alpha : Fin r → Fin p) :
    elementaryAugmentationBasis (R := R) p (Fact.out : p.Prime).pos r alpha ∈
      elementaryOriginalAugmentationIdeal R p r ^ (∑ i, (alpha i).val) := by
  classical
  let J := elementaryOriginalAugmentationIdeal R p r
  have generator (i : Fin r) : elementaryAugmentationParameter (R := R) p r i ∈ J :=
    elementary_augmentation_parameter_aug p r i
  have product (s : Finset (Fin r)) :
      (∏ i ∈ s, elementaryAugmentationParameter (R := R) p r i ^ (alpha i).val) ∈
        J ^ (∑ i ∈ s, (alpha i).val) := by
    induction s using Finset.induction_on with
    | empty => simp
    | @insert i s absent induction =>
      rw [Finset.prod_insert absent, Finset.sum_insert absent, pow_add]
      exact Ideal.mul_mem_mul (Ideal.pow_mem_pow (generator i) (alpha i).val) induction
  simpa only [elementary_augmentation_basis_apply] using product Finset.univ

/-- All powers of the literal original augmentation ideal are exactly
the actual total-degree ideals, at every prime and over arbitrary
nontrivial commutative characteristic-p coefficients. -/
theorem elementary_original_augmentation_power_degree (r d : ℕ) :
    elementaryOriginalAugmentationIdeal R p r ^ d = elementaryOriginalDegreeIdeal R p r d := by
  have lower : elementaryOriginalAugmentationIdeal R p r ^ d ≤
      elementaryOriginalDegreeIdeal R p r d := by
    induction d with
    | zero =>
      intro x _
      change x ∈ elementaryNormalWeightFiltration R p (Fact.out : p.Prime).pos r 0
      rw [elementary_normal_weight_initial]
      exact Submodule.mem_top
    | succ d induction =>
      rw [pow_succ]
      apply Ideal.mul_le.mpr
      intro x hx y hy
      have hx := induction hx
      have hy : y ∈ elementaryOriginalDegreeIdeal R p r 1 := by
        rwa [elementary_original_degree_one_augmentation]
      exact elementary_prime_normal_weight_mul (R := R) p (Fact.out : p.Prime) r d 1 x y hx hy
  apply le_antisymm lower
  intro x member
  have span : elementaryAugmentationDegreeSpan R p (Fact.out : p.Prime).pos r d ≤
      (elementaryOriginalAugmentationIdeal R p r ^ d).restrictScalars R := by
    apply Submodule.span_le.mpr
    rintro _ ⟨alpha, high, rfl⟩
    exact Ideal.pow_le_pow_right high (elementary_original_monomial_augmentation_power (R := R) p r alpha)
  apply span
  change x ∈ elementaryNormalWeightFiltration R p (Fact.out : p.Prime).pos r d at member
  rwa [elementary_normal_weight_characteristic_degree] at member

end Litt3.Deformations

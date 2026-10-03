import Solutions.Deformations.ElementaryOriginalDegreeIdeal
import Solutions.Deformations.BoundedMonomialTopPairing
import Mathlib.RingTheory.Ideal.Colon

namespace Litt3.Deformations

open scoped BigOperators

variable {R : Type*} [CommRing R] [Nontrivial R]
variable (p : ℕ) [Fact p.Prime] [CharP R p]

theorem elementary_original_parameter_characteristic_nilpotent (r : ℕ) (i : Fin r) :
    elementaryAugmentationParameter (R := R) p r i ^ p = 0 := by
  have scalarZero : (p : AddMonoidAlgebra R (Fin r → ZMod p)) = 0 := by
    simpa only [map_natCast, map_zero] using
      congrArg (algebraMap R (AddMonoidAlgebra R (Fin r → ZMod p))) (CharP.cast_eq_zero R p)
  rw [elementary_original_prime_relation_sum p (Fact.out : p.Prime),
    scalarZero, zero_mul]

/-- Exact original augmentation-power annihilators, derived by multiplying
with actual complementary original monomials and extracting their top
coordinate. The coefficient ring may be nonreduced; no pairing or ideal
presentation is supplied as a hypothesis. -/
theorem elementary_original_augmentation_annihilator (r s : ℕ)
    (bound : s ≤ (p - 1) * r + 1) :
    (elementaryOriginalAugmentationIdeal R p r ^ s).annihilator =
      elementaryOriginalAugmentationIdeal R p r ^ ((p - 1) * r + 1 - s) := by
  classical
  let J := elementaryOriginalAugmentationIdeal R p r
  let B := elementaryAugmentationBasis (R := R) p (Fact.out : p.Prime).pos r
  let E := elementaryAugmentationParameter (R := R) p r
  let d := (p - 1) * r + 1 - s
  have formula (alpha : Fin r → Fin p) : B alpha = ∏ i, E i ^ (alpha i).val :=
    elementary_augmentation_basis_apply p (Fact.out : p.Prime).pos r alpha
  have nilpotent (i : Fin r) : E i ^ p = 0 :=
    elementary_original_parameter_characteristic_nilpotent (R := R) p r i
  have index : d + s = (p - 1) * r + 1 := by dsimp only [d]; omega
  apply le_antisymm
  · intro x annihilates
    rw [elementary_original_augmentation_power_degree]
    change x ∈ elementaryNormalWeightFiltration R p (Fact.out : p.Prime).pos r d
    rw [elementary_normal_weight_characteristic_degree]
    change x ∈ Submodule.span R (B '' {alpha | d ≤ ∑ i, (alpha i).val})
    apply B.mem_span_image.mpr
    intro alpha support
    by_contra low
    change ¬ d ≤ ∑ i, (alpha i).val at low
    let beta := boundedComplementExponent p (Fact.out : p.Prime).pos alpha
    have degrees : (∑ i, (alpha i).val) + (∑ i, (beta i).val) = (p - 1) * r := by
      simpa only [Fintype.card_fin] using bounded_complement_degree p (Fact.out : p.Prime).pos alpha
    have betaMember : B beta ∈ J ^ s :=
      Ideal.pow_le_pow_right (by omega)
        (elementary_original_monomial_augmentation_power (R := R) p r beta)
    have zero : x * B beta = 0 := by
      simpa only [smul_eq_mul] using (Submodule.mem_annihilator.mp annihilates) (B beta) betaMember
    have pairing := bounded_monomial_top_coordinate_pairing p (Fact.out : p.Prime).pos
      E B formula nilpotent alpha x
    have coordinate : B.repr x alpha = 0 := by
      rw [zero, map_zero] at pairing
      exact pairing.symm
    exact (Finsupp.mem_support_iff.mp support) coordinate
  · intro x member
    apply Submodule.mem_annihilator.mpr
    intro y yMember
    have xMember := member
    rw [elementary_original_augmentation_power_degree] at xMember yMember
    have product := elementary_prime_normal_weight_mul (R := R) p (Fact.out : p.Prime)
      r d s x y xMember yMember
    rw [index] at product
    have cutoff : elementaryNormalWeightFiltration R p (Fact.out : p.Prime).pos r
        ((p - 1) * r + 1) = ⊥ := by
      apply elementary_prime_normal_weight_cutoff p (Fact.out : p.Prime) r 1 (by omega)
        (by simp [CharP.cast_eq_zero R p])
      simp
    rw [cutoff, Submodule.mem_bot] at product
    exact product

end Litt3.Deformations

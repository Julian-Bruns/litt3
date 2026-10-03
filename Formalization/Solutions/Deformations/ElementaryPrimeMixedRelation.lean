import Solutions.Deformations.ElementaryMixedRelation
import Solutions.Deformations.WeightedNormalReduction
import Solutions.Deformations.ElementaryNormalWeights
import Mathlib.Algebra.CharP.Lemmas

namespace Litt3.Deformations

open scoped BigOperators

variable {R : Type*} [CommRing R] [Nontrivial R]

/-- Exact integer coefficients of every original prime-cycle relation;
division here is certified prime binomial divisibility, not ring division. -/
def originalPrimeRelationCoefficients (p : ℕ) : Fin (p - 1) → R :=
  fun l => -((p.choose (l.val + 1) / p : ℕ) : R)

/-- Symbolic integral relation for the unchanged original prime-cycle
augmentation generator, uniformly at every prime. -/
theorem original_prime_cycle_relation (p : ℕ) (prime : p.Prime) :
    let e : CyclicGroupAlgebra R p := cyclicGroupGenerator R p - 1
    e ^ p = (p : CyclicGroupAlgebra R p) *
      ∑ l : Fin (p - 1), originalPrimeRelationCoefficients (R := R) p l •
        e ^ (l.val + 1) := by
  let e : CyclicGroupAlgebra R p := cyclicGroupGenerator R p - 1
  change e ^ p = _
  have order : (e + 1) ^ p = 1 := by
    simpa only [e, sub_add_cancel] using cyclic_group_generator_power (R := R) p
  have expansion := (Commute.all e (1 : CyclicGroupAlgebra R p)).add_pow_prime_eq' prime
  simp only [one_pow, mul_one] at expansion
  have sumEquality : (∑ l : Fin (p - 1),
      ((p.choose (l.val + 1) / p : ℕ) : CyclicGroupAlgebra R p) * e ^ (l.val + 1)) =
      ∑ j ∈ Finset.Ioo 0 p, e ^ j * ((p.choose j / p : ℕ) : CyclicGroupAlgebra R p) := by
    rw [← Finset.Ico_succ_left_eq_Ioo, Finset.sum_Ico_eq_sum_range]
    rw [Fin.sum_univ_eq_sum_range (fun l =>
      ((p.choose (l + 1) / p : ℕ) : CyclicGroupAlgebra R p) * e ^ (l + 1)) (p - 1)]
    apply Finset.sum_congr rfl
    intro j _
    change ((p.choose (j + 1) / p : ℕ) : CyclicGroupAlgebra R p) * e ^ (j + 1) =
      e ^ (1 + j) * ((p.choose (1 + j) / p : ℕ) : CyclicGroupAlgebra R p)
    simp only [Nat.add_comm, mul_comm]
  have negativeSum : (∑ l : Fin (p - 1), originalPrimeRelationCoefficients (R := R) p l •
      e ^ (l.val + 1)) = -(∑ j ∈ Finset.Ioo 0 p,
        e ^ j * ((p.choose j / p : ℕ) : CyclicGroupAlgebra R p)) := by
    rw [← sumEquality, ← Finset.sum_neg_distrib]
    apply Finset.sum_congr rfl
    intro l _
    simp only [originalPrimeRelationCoefficients, Algebra.smul_def,
      map_neg, map_natCast, neg_mul]
  rw [negativeSum]
  linear_combination order - expansion

theorem elementary_original_prime_relation_sum (p : ℕ) (prime : p.Prime)
    (r : ℕ) (i : Fin r) :
    elementaryAugmentationParameter (R := R) p r i ^ p =
      (p : AddMonoidAlgebra R (Fin r → ZMod p)) *
        ∑ l : Fin (p - 1), originalPrimeRelationCoefficients (R := R) p l •
          elementaryAugmentationParameter (R := R) p r i ^ (l.val + 1) := by
  have relation := original_prime_cycle_relation (R := R) p prime
  dsimp only at relation
  have mapped := congrArg (elementaryCoordinateMap (R := R) p r i) relation
  simpa only [map_pow, map_mul, map_sum, map_smul, map_natCast,
    elementary_coordinate_parameter] using mapped

/-- Actual generated and original-normal filtrations agree at every
prime, using the full literal mixed-characteristic relation. -/
theorem elementary_prime_normal_weights_eq (p : ℕ) (prime : p.Prime) (r d : ℕ) :
    elementaryNormalWeightFiltration R p prime.pos r d =
      weightedGeneratorFiltration R (p : AddMonoidAlgebra R (Fin r → ZMod p)) (p - 1)
        (elementaryAugmentationParameter (R := R) p r) d := by
  rw [elementary_normal_weights_eq]
  exact (weighted_generator_normal_form p prime.pos _ _
    (fun _ => originalPrimeRelationCoefficients (R := R) p)
    (elementary_original_prime_relation_sum (R := R) p prime r) d).symm

end Litt3.Deformations

import Solutions.Deformations.ElementaryPrimeNormalInitialProduct

set_option maxRecDepth 2000

namespace Litt3.Deformations

open scoped BigOperators

variable {R : Type*} [CommRing R] [Nontrivial R]
variable (p : ℕ) [Fact p.Prime]

/-- Literal prime powers and every original carry give the actual
weighted multiplication law, modulo exactly the next source weight. -/
theorem elementary_prime_weighted_normal_initial_product (r j l : ℕ)
    (alpha beta : Fin r → Fin p) :
    ((p : R) ^ j • elementaryAugmentationBasis p (by have := (Fact.out : p.Prime).two_le; omega) r alpha) *
        ((p : R) ^ l • elementaryAugmentationBasis p (by have := (Fact.out : p.Prime).two_le; omega) r beta) -
      (-1 : R) ^ (∑ i, rootNormalCarry p (alpha i) (beta i)) •
        ((p : R) ^ (j + l + ∑ i, rootNormalCarry p (alpha i) (beta i)) •
          elementaryAugmentationBasis p (by have := (Fact.out : p.Prime).two_le; omega) r
            (fun i => rootNormalProductExponent p (by have := (Fact.out : p.Prime).two_le; omega) (alpha i) (beta i))) ∈
      elementaryNormalWeightFiltration R p (by have := (Fact.out : p.Prime).two_le; omega) r
        (((p - 1) * j + ∑ i, (alpha i).val) + ((p - 1) * l + ∑ i, (beta i).val) + 1) := by
  let A := AddMonoidAlgebra R (Fin r → ZMod p)
  let e := elementaryAugmentationParameter (R := R) p r
  let t := ∑ i, rootNormalCarry p (alpha i) (beta i)
  let gamma := fun i => rootNormalProductExponent p (by have := (Fact.out : p.Prime).two_le; omega) (alpha i) (beta i)
  let B := elementaryAugmentationBasis (R := R) p (by have := (Fact.out : p.Prime).two_le; omega) r
  have normal := elementary_prime_normal_basis_initial_product (R := R) p r alpha beta
  have prime : (p : A) ^ (j + l) ∈ weightedGeneratorFiltration R (p : A) (p - 1) e ((p - 1) * (j + l)) := by
    simpa only [generatorMonomial, generatorMonomialWeight, pow_zero, Finset.prod_const_one,
      Finset.sum_const_zero, Nat.add_zero, mul_one] using
      weighted_generator_member (R := R) (p : A) (p - 1) e ((p - 1) * (j + l)) (j + l) (fun _ => 0)
        (by simp only [generatorMonomialWeight, Finset.sum_const_zero, Nat.add_zero, le_refl])
  have product := weighted_generator_filtration_multiplicative (R := R) (p : A) (p - 1) e
    ((p - 1) * (j + l)) ((∑ i, (alpha i).val) + (∑ i, (beta i).val) + 1)
    ((p : A) ^ (j + l)) _ prime normal
  have identity : ((p : R) ^ j • B alpha) * ((p : R) ^ l • B beta) -
      (-1 : R) ^ t • ((p : R) ^ (j + l + t) • B gamma) =
    (p : A) ^ (j + l) * (B alpha * B beta - (-(p : R)) ^ t • B gamma) := by
    have carryScalar : (-(p : R)) ^ t = (-1 : R) ^ t * (p : R) ^ t := by
      rw [neg_eq_neg_one_mul, mul_pow]
    rw [carryScalar]
    simp only [Algebra.smul_def, map_pow, map_mul, map_neg, map_natCast, map_one, pow_add]
    ring
  rw [elementary_prime_normal_weights_eq p (Fact.out : p.Prime)]
  change ((p : R) ^ j • B alpha) * ((p : R) ^ l • B beta) -
    (-1 : R) ^ t • ((p : R) ^ (j + l + t) • B gamma) ∈ _
  rw [identity]
  have index : (p - 1) * (j + l) + ((∑ i, (alpha i).val) + (∑ i, (beta i).val) + 1) =
      (((p - 1) * j + ∑ i, (alpha i).val) + ((p - 1) * l + ∑ i, (beta i).val) + 1) := by ring
  simpa only [index] using product

end Litt3.Deformations

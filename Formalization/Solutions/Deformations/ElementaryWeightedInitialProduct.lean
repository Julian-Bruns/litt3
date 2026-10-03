import Solutions.Deformations.ElementaryNormalInitialProduct

set_option maxRecDepth 2000

namespace Litt3.Deformations

open scoped BigOperators

variable {R : Type*} [CommRing R] [Nontrivial R]

/-- Literal prime powers and every original carry give the actual
weighted multiplication law, modulo exactly the next source weight. -/
theorem elementary_five_weighted_normal_initial_product (r j l : ℕ)
    (alpha beta : Fin r → Fin 5) :
    ((5 : R) ^ j • elementaryAugmentationBasis 5 (by omega) r alpha) *
        ((5 : R) ^ l • elementaryAugmentationBasis 5 (by omega) r beta) -
      (-1 : R) ^ (∑ i, rootNormalCarry 5 (alpha i) (beta i)) •
        ((5 : R) ^ (j + l + ∑ i, rootNormalCarry 5 (alpha i) (beta i)) •
          elementaryAugmentationBasis 5 (by omega) r
            (fun i => rootNormalProductExponent 5 (by omega) (alpha i) (beta i))) ∈
      elementaryNormalWeightFiltration R 5 (by omega) r
        ((4 * j + ∑ i, (alpha i).val) + (4 * l + ∑ i, (beta i).val) + 1) := by
  let A := AddMonoidAlgebra R (Fin r → ZMod 5)
  let e := elementaryAugmentationParameter (R := R) 5 r
  let t := ∑ i, rootNormalCarry 5 (alpha i) (beta i)
  let gamma := fun i => rootNormalProductExponent 5 (by omega) (alpha i) (beta i)
  let B := elementaryAugmentationBasis (R := R) 5 (by omega) r
  have normal := elementary_five_normal_basis_initial_product (R := R) r alpha beta
  have prime : (5 : A) ^ (j + l) ∈ weightedGeneratorFiltration R (5 : A) 4 e (4 * (j + l)) := by
    simpa only [generatorMonomial, generatorMonomialWeight, pow_zero, Finset.prod_const_one,
      Finset.sum_const_zero, Nat.add_zero, mul_one] using
      weighted_generator_member (R := R) (5 : A) 4 e (4 * (j + l)) (j + l) (fun _ => 0)
        (by simp only [generatorMonomialWeight, Finset.sum_const_zero, Nat.add_zero, le_refl])
  have product := weighted_generator_filtration_multiplicative (R := R) (5 : A) 4 e
    (4 * (j + l)) ((∑ i, (alpha i).val) + (∑ i, (beta i).val) + 1)
    ((5 : A) ^ (j + l)) _ prime normal
  have identity : ((5 : R) ^ j • B alpha) * ((5 : R) ^ l • B beta) -
      (-1 : R) ^ t • ((5 : R) ^ (j + l + t) • B gamma) =
    (5 : A) ^ (j + l) * (B alpha * B beta - (-(5 : R)) ^ t • B gamma) := by
    have carryScalar : (-(5 : R)) ^ t = (-1 : R) ^ t * (5 : R) ^ t := by
      rw [neg_eq_neg_one_mul, mul_pow]
    rw [carryScalar]
    simp only [Algebra.smul_def, map_pow, map_mul, map_neg, map_ofNat, map_one, pow_add]
    ring
  rw [elementary_five_normal_weights_eq]
  change ((5 : R) ^ j • B alpha) * ((5 : R) ^ l • B beta) -
    (-1 : R) ^ t • ((5 : R) ^ (j + l + t) • B gamma) ∈ _
  rw [identity]
  have index : 4 * (j + l) + ((∑ i, (alpha i).val) + (∑ i, (beta i).val) + 1) =
      ((4 * j + ∑ i, (alpha i).val) + (4 * l + ∑ i, (beta i).val) + 1) := by omega
  simpa only [index] using product

end Litt3.Deformations

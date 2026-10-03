import Solutions.Deformations.ElementaryOriginalIntegralNorm
import Solutions.Deformations.ElementaryPrimeInitialRelation
import Solutions.Deformations.ElementaryPrimeWeightStructure
import Solutions.Deformations.GroupCoefficientKernel
import Solutions.Deformations.ElementaryWeightStructure

set_option maxHeartbeats 2000000

namespace Litt3.Deformations

open scoped BigOperators

variable (p N : ℕ) [Fact p.Prime] [Fact (0 < N)]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Nontrivial (TruncatedWittVector p N k) :=
  truncated_witt_nontrivial p N (Fact.out : 0 < N) k

/-- Each literal integral coordinate norm has its full assigned original
weight. Prime-divisible lower coefficients are derived from actual reduction. -/
theorem elementary_prime_witt_coordinate_norm_weight (r : ℕ) (i : Fin r) :
    elementaryOriginalCoordinateNorm (R := TruncatedWittVector p N k) p r i ∈
      elementaryNormalWeightFiltration (TruncatedWittVector p N k)
        p (Fact.out : p.Prime).pos r (p - 1) := by
  let R := TruncatedWittVector p N k
  let A := AddMonoidAlgebra R (Fin r → ZMod p)
  let phi := truncatedWittResidue p N (Fact.out : 0 < N) k
  let reduce := AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod p) phi
  let n := elementaryOriginalCoordinateNorm (R := R) p r i
  let e := elementaryAugmentationParameter (R := R) p r i
  have equality : reduce n = reduce (e ^ (p - 1)) := by
    dsimp only [reduce, n, elementaryOriginalCoordinateNorm]
    rw [map_sum, map_pow, group_coefficient_map_parameter]
    simp only [map_pow, AddMonoidAlgebra.mapRangeRingHom_single, map_one]
    exact (prime_norm_polynomial p k (AddMonoidAlgebra k (Fin r → ZMod p))
      (AddMonoidAlgebra.single (Pi.single i (1 : ZMod p)) (1 : k))).symm
  obtain ⟨z, relation⟩ := (truncated_witt_group_residue_kernel p N (Fact.out : 0 < N) k
    (Fin r → ZMod p) (n - e ^ (p - 1))).mp (by rw [map_sub, equality, sub_self])
  have difference : n - e ^ (p - 1) ∈
      elementaryNormalWeightFiltration R p (Fact.out : p.Prime).pos r (p - 1) := by
    have initial : z ∈ elementaryNormalWeightFiltration R p (Fact.out : p.Prime).pos r 0 := by
      rw [elementary_normal_weight_initial]
      exact Submodule.mem_top
    rw [elementary_prime_normal_weights_eq p (Fact.out : p.Prime)] at initial
    rw [← relation, elementary_prime_normal_weights_eq p (Fact.out : p.Prime)]
    simpa only [Nat.add_zero] using weighted_generator_prime_mul (R := R) (p : A)
      (p - 1) (elementaryAugmentationParameter (R := R) p r) 0 z initial
  have power : e ^ (p - 1) ∈
      elementaryNormalWeightFiltration R p (Fact.out : p.Prime).pos r (p - 1) := by
    rw [elementary_prime_normal_weights_eq p (Fact.out : p.Prime)]
    exact elementary_prime_parameter_power_member (R := R) p r i (p - 1)
  have sum := Submodule.add_mem _ difference power
  simpa only [sub_add_cancel] using sum

/-- The entire literal original norm has first weight at least (p-1)r,
at every positive actual Witt precision. -/
theorem elementary_prime_witt_integral_norm_weight (r : ℕ) :
    elementaryOriginalNorm (R := TruncatedWittVector p N k) p r ∈
      elementaryNormalWeightFiltration (TruncatedWittVector p N k)
        p (Fact.out : p.Prime).pos r ((p - 1) * r) := by
  classical
  let R := TruncatedWittVector p N k
  have product (s : Finset (Fin r)) :
      (∏ i ∈ s, elementaryOriginalCoordinateNorm (R := R) p r i) ∈
        elementaryNormalWeightFiltration R p (Fact.out : p.Prime).pos r ((p - 1) * s.card) := by
    induction s using Finset.induction_on with
    | empty =>
      simp only [Finset.prod_empty, Finset.card_empty, Nat.mul_zero,
        elementary_normal_weight_initial]
      exact Submodule.mem_top
    | @insert i s absent induction =>
      rw [Finset.prod_insert absent, Finset.card_insert_of_notMem absent, Nat.mul_add, Nat.mul_one]
      simpa only [Nat.add_comm] using elementary_prime_normal_weight_mul (R := R) p
        (Fact.out : p.Prime) r (p - 1) ((p - 1) * s.card) _ _
          (elementary_prime_witt_coordinate_norm_weight p N k r i) induction
  have full := product Finset.univ
  simpa only [Finset.card_univ, Fintype.card_fin, elementary_original_norm_product] using full

end Litt3.Deformations

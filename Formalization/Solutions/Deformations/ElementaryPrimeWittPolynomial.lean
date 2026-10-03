import Definitions.Deformations.ElementaryPrimeWittOperator
import Solutions.Deformations.ElementaryPrimeWeightStructure
import Solutions.Deformations.PolynomialCoefficientLift
import Solutions.Deformations.GroupCoefficientFrobenius
import Solutions.Deformations.GroupNormalFiltration

namespace Litt3.Deformations

open scoped BigOperators

variable (p N : ℕ) [Fact p.Prime] [Fact (0 < N)]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Nontrivial (TruncatedWittVector p N k) :=
  truncated_witt_nontrivial p N (Fact.out : 0 < N) k

theorem elementary_prime_witt_polynomial_reduction (r : ℕ) (f : MvPolynomial (Fin r) k) :
    AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod p)
      (truncatedWittResidue p N (Fact.out : 0 < N) k)
        (elementaryPrimeWittPolynomialLift p N k r f) =
      f.eval₂ (algebraMap k (AddMonoidAlgebra k (Fin r → ZMod p)))
        (elementaryAugmentationParameter (R := k) p r) := by
  apply polynomial_coefficient_lift_group_reduction
  intro c
  rw [truncated_witt_residue_truncate, WittVector.teichmuller_coeff_zero]

theorem elementary_prime_witt_polynomial_weight (r d : ℕ) (f : MvPolynomial (Fin r) k)
    (degrees : ∀ alpha, f.coeff alpha ≠ 0 → d ≤ ∑ i, alpha i) :
    elementaryPrimeWittPolynomialLift p N k r f ∈
      elementaryNormalWeightFiltration (TruncatedWittVector p N k) p
        (Fact.out : p.Prime).pos r d := by
  rw [elementary_prime_normal_weights_eq p (Fact.out : p.Prime)]
  exact polynomial_coefficient_lift_weight _ _ _ _ f d degrees

theorem elementary_prime_witt_homogeneous_weight (r d : ℕ) (f : MvPolynomial (Fin r) k)
    (homogeneous : f.IsHomogeneous d) :
    elementaryPrimeWittPolynomialLift p N k r f ∈
      elementaryNormalWeightFiltration (TruncatedWittVector p N k) p
        (Fact.out : p.Prime).pos r d := by
  apply elementary_prime_witt_polynomial_weight p N k r d
  intro alpha nonzero
  have weight := homogeneous nonzero
  change (Finsupp.weight (fun _ : Fin r => (1 : ℕ))) alpha = d at weight
  rw [← Finsupp.degree_eq_weight_one, Finsupp.degree_eq_sum] at weight
  exact weight.ge

theorem elementary_prime_witt_frobenius_weight (r d : ℕ)
    (x : AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p))
    (member : x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p N k) p
      (Fact.out : p.Prime).pos r d) :
    elementaryWittFrobenius p N r k x ∈ elementaryNormalWeightFiltration
      (TruncatedWittVector p N k) p (Fact.out : p.Prime).pos r d :=
  group_coefficient_map_normal_weight
    (truncatedWittEquiv p N (_root_.frobeniusEquiv k p)).toRingHom p
      (Fact.out : p.Prime).pos r d x member

theorem elementary_prime_witt_inverse_frobenius_weight (r d : ℕ)
    (x : AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p))
    (member : x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p N k) p
      (Fact.out : p.Prime).pos r d) :
    (elementaryWittFrobenius p N r k).symm x ∈ elementaryNormalWeightFiltration
      (TruncatedWittVector p N k) p (Fact.out : p.Prime).pos r d :=
  group_coefficient_map_normal_weight
    (truncatedWittEquiv p N (_root_.frobeniusEquiv k p)).symm.toRingHom p
      (Fact.out : p.Prime).pos r d x member

end Litt3.Deformations

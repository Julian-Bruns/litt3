import Solutions.Deformations.ElementaryPrimeWittFinalIntegralNorm
import Solutions.Deformations.ElementaryPrimeWittRefinedTailAbsorption
import Solutions.Deformations.ElementaryPrimeWittHighResidue
import Solutions.Deformations.ElementaryOriginalNormCoefficientMap
import Solutions.Deformations.ElementaryPrimeWittNormLine

namespace Litt3.Deformations

variable (p r a : ℕ) [Fact p.Prime]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Fact (0 < r + 1) := ⟨by omega⟩
local instance : Nontrivial (TruncatedWittVector p (r + 1) k) :=
  truncated_witt_nontrivial p (r + 1) (by omega) k

/-- Every leading original norm coefficient is realized by a full actual
solution. The additional correction lies strictly above the norm weight,
so its construction preserves the prescribed reduction. -/
theorem elementary_prime_witt_norm_leading_realization
    (large : 2 < p) (principalPositive : 0 < a) (degreeBound : a + 1 ≤ p - 1)
    (positive : 0 < r)
    (L : AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p) →+
      AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p))
    (q : MvPolynomial (Fin r) k)
    (reduction : ElementaryPrimeWittReduction p (r + 1) k r a L q)
    (anisotropic : ∀ v : Fin r → ZMod p, v ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl p) k (v i)) ≠ 0)
    (eta : TruncatedWittVector p (r + 1) k)
    (divisible : truncatedWittResidue p (r + 1) (by omega) k eta = 0)
    (c : k) :
    ∃ x : AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p),
      L x = eta • elementaryOriginalNorm (R := TruncatedWittVector p (r + 1) k) p r ∧
      AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod p)
        (truncatedWittResidue p (r + 1) (by omega) k) x =
          c • elementaryOriginalNorm (R := k) p r := by
  let R := TruncatedWittVector p (r + 1) k
  let A := AddMonoidAlgebra R (Fin r → ZMod p)
  let phi := truncatedWittResidue p (r + 1) (by omega) k
  let reduce := AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod p) phi
  obtain ⟨delta, deltaResidue⟩ := truncated_witt_residue_surjective p (r + 1) (by omega) k c
  let x0 : A := delta • elementaryOriginalNorm (R := R) p r
  let beta : R := additiveGroupAlgebraAugmentation (L (algebraMap R A delta))
  have normImage : L x0 = beta • elementaryOriginalNorm (R := R) p r :=
    elementary_deck_operator_norm p r L reduction.1 delta
  have x0Member : x0 ∈ elementaryNormalWeightFiltration R p (Fact.out : p.Prime).pos r ((p - 1) * r) :=
    Submodule.smul_mem _ delta (elementary_prime_witt_integral_norm_weight p (r + 1) k r)
  obtain ⟨imageMember, _⟩ := elementary_prime_witt_operator_initial p (r + 1) k r
    ((p - 1) * r) a degreeBound L q reduction ⟨x0, x0Member⟩
  have imageZero : reduce (L x0) = 0 := elementary_prime_witt_high_residue_zero p (r + 1) k r
    ((p - 1) * r + a) (by omega) (L x0) imageMember
  have betaZero : phi beta = 0 := by
    rw [normImage, group_coefficient_original_scaled_norm] at imageZero
    have coefficient := congrArg (fun z : AddMonoidAlgebra k (Fin r → ZMod p) => z 0) imageZero
    simpa only [AddMonoidAlgebra.coeff_smul, smul_eq_mul, elementary_original_norm_coefficient,
      mul_one, Finsupp.zero_apply] using coefficient
  have differenceZero : phi (eta - beta) = 0 := by rw [map_sub, divisible, betaZero, sub_self]
  have residual : eta • elementaryOriginalNorm (R := R) p r - L x0 =
      (eta - beta) • elementaryOriginalNorm (R := R) p r := by
    rw [normImage, sub_smul]
  have first : p - 1 ≤ (p - 1) * r := Nat.le_mul_of_pos_right (p - 1) positive
  obtain ⟨h, hMember, hImage⟩ := elementary_prime_witt_refined_tail_absorption p r a k
    principalPositive degreeBound L q reduction anisotropic ((p - 1) * r + (p - 1))
      (by omega) (by omega) (eta • elementaryOriginalNorm (R := R) p r - L x0)
      (by
        rw [residual]
        exact elementary_prime_witt_divisible_norm_weight p (r + 1) k r
          (eta - beta) differenceZero)
  have hZero : reduce h = 0 := elementary_prime_witt_high_residue_zero p (r + 1) k r
    ((p - 1) * r + (p - 1) - a) (by omega) h hMember
  refine ⟨x0 + h, ?_, ?_⟩
  · rw [map_add, hImage]
    abel
  · rw [map_add, hZero, add_zero]
    rw [group_coefficient_original_scaled_norm, deltaResidue]

end Litt3.Deformations

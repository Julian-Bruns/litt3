import Solutions.Deformations.ElementaryPrimeWittFinalPreimage
import Solutions.Deformations.ElementaryPrimeWittAugmentedOperator
import Solutions.Deformations.ElementaryPrimeWittDivisibleNormWeight
import Solutions.Deformations.ElementaryPrimeWittTailAbsorption

namespace Litt3.Deformations

variable (p r a : ℕ) [Fact p.Prime]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Fact (0 < r + 1) := ⟨by omega⟩
local instance : Nontrivial (TruncatedWittVector p (r + 1) k) :=
  truncated_witt_nontrivial p (r + 1) (by omega) k

/-- The literal final integral norm equation forces divisibility of its
coefficient and the exact full original norm weight of every solution. -/
theorem elementary_prime_witt_final_integral_norm_necessary
    (large : 2 < p) (principalPositive : 0 < a) (degreeBound : a + 1 ≤ p - 1)
    (positive : 0 < r)
    (L : AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p) →+
      AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p))
    (q : MvPolynomial (Fin r) k)
    (reduction : ElementaryPrimeWittReduction p (r + 1) k r a L q)
    (anisotropic : ∀ v : Fin r → ZMod p, v ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl p) k (v i)) ≠ 0)
    (eta : TruncatedWittVector p (r + 1) k)
    (x : AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p))
    (equation : L x = eta • elementaryOriginalNorm (R := TruncatedWittVector p (r + 1) k) p r) :
    truncatedWittResidue p (r + 1) (by omega) k eta = 0 ∧
      x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p (r + 1) k)
        p (Fact.out : p.Prime).pos r ((p - 1) * r) := by
  let R := TruncatedWittVector p (r + 1) k
  have first : p - 1 ≤ (p - 1) * r := Nat.le_mul_of_pos_right (p - 1) positive
  have image : L x ∈ elementaryNormalWeightFiltration R p (Fact.out : p.Prime).pos r ((p - 1) * r) := by
    rw [equation]
    exact Submodule.smul_mem _ eta (elementary_prime_witt_integral_norm_weight p (r + 1) k r)
  have source := elementary_prime_witt_final_preimage_bound p r a k large principalPositive
    degreeBound ((p - 1) * r) ((p - 1) * r - a) (by omega) (by omega)
    L q reduction anisotropic x image
  have augmentedZero := elementary_prime_witt_augmented_operator_zero p r a k large
    principalPositive degreeBound positive L q reduction x source
  have normZero : (p : R) ^ r * eta = 0 := by
    have augmented := congrArg (additiveGroupAlgebraAugmentation (R := R)) equation
    rw [augmentedZero, map_smul, elementary_original_norm_aug, smul_eq_mul] at augmented
    simpa only [mul_comm] using augmented.symm
  have scalarZero : (p : ZMod (p ^ (r + 1))) ^ r • eta = 0 := by
    rw [truncated_witt_scalar_power_smul]
    exact normZero
  obtain ⟨z, relation⟩ := truncated_witt_nonterminal_annihilator p (r + 1) (by omega)
    k r (by omega) eta scalarZero
  have residueZero : truncatedWittResidue p (r + 1) (by omega) k eta = 0 :=
    (truncated_witt_residue_kernel p (r + 1) (by omega) k eta).mpr ⟨z, relation⟩
  refine ⟨residueZero, ?_⟩
  apply elementary_prime_witt_final_preimage_bound p r a k large principalPositive
    degreeBound ((p - 1) * r + (p - 1)) ((p - 1) * r) le_rfl (by omega)
    L q reduction anisotropic x
  rw [equation]
  exact elementary_prime_witt_divisible_norm_weight p (r + 1) k r eta residueZero

/-- Solubility of the entire original final norm equation is exactly
residue-zero of the actual Witt coefficient. -/
theorem elementary_prime_witt_final_integral_norm_iff
    (large : 2 < p) (principalPositive : 0 < a) (degreeBound : a + 1 ≤ p - 1)
    (positive : 0 < r)
    (L : AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p) →+
      AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p))
    (q : MvPolynomial (Fin r) k)
    (reduction : ElementaryPrimeWittReduction p (r + 1) k r a L q)
    (anisotropic : ∀ v : Fin r → ZMod p, v ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl p) k (v i)) ≠ 0)
    (eta : TruncatedWittVector p (r + 1) k) :
    (∃ x, L x = eta • elementaryOriginalNorm (R := TruncatedWittVector p (r + 1) k) p r) ↔
      truncatedWittResidue p (r + 1) (by omega) k eta = 0 := by
  constructor
  · rintro ⟨x, equation⟩
    exact (elementary_prime_witt_final_integral_norm_necessary p r a k large
      principalPositive degreeBound positive L q reduction anisotropic eta x equation).1
  · intro divisible
    obtain ⟨x, _, equation⟩ := elementary_prime_witt_tail_absorption p r a k
      principalPositive degreeBound positive L q reduction anisotropic
        (eta • elementaryOriginalNorm (R := TruncatedWittVector p (r + 1) k) p r)
        (elementary_normal_weight_antitone (R := TruncatedWittVector p (r + 1) k)
          p (Fact.out : p.Prime).pos r (by omega)
          (elementary_prime_witt_divisible_norm_weight p (r + 1) k r eta divisible))
    exact ⟨x, equation⟩

end Litt3.Deformations

import Solutions.Deformations.ElementaryPrimeWittIntegralNormWeight
import Solutions.Deformations.ElementaryPrimeWittPrecisionPreimage
import Solutions.Deformations.ElementaryWeightAugmentationZero

namespace Litt3.Deformations

variable (p r : ℕ) [Fact p.Prime] [Fact (0 < r)]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Nontrivial (TruncatedWittVector p r k) :=
  truncated_witt_nontrivial p r (Fact.out : 0 < r) k

/-- At precision r, a literal integral norm target forces the exact
original source weight and vanishing of the full integral augmentation. -/
theorem elementary_prime_witt_integral_norm_preimage
    (large : 2 < p) (a : ℕ) (principalPositive : 0 < a) (degreeBound : a + 1 ≤ p - 1)
    (L : AddMonoidAlgebra (TruncatedWittVector p r k) (Fin r → ZMod p) →+
      AddMonoidAlgebra (TruncatedWittVector p r k) (Fin r → ZMod p))
    (q : MvPolynomial (Fin r) k)
    (reduction : ElementaryPrimeWittReduction p r k r a L q)
    (anisotropic : ∀ v : Fin r → ZMod p, v ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl p) k (v i)) ≠ 0)
    (x : AddMonoidAlgebra (TruncatedWittVector p r k) (Fin r → ZMod p))
    (eta : TruncatedWittVector p r k)
    (equation : L x = eta • elementaryOriginalNorm (R := TruncatedWittVector p r k) p r) :
    x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p r k)
      p (Fact.out : p.Prime).pos r ((p - 1) * r - a) ∧
      additiveGroupAlgebraAugmentation x = 0 := by
  have first : p - 1 ≤ (p - 1) * r :=
    Nat.le_mul_of_pos_right (p - 1) (Fact.out : 0 < r)
  have image : L x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p r k)
      p (Fact.out : p.Prime).pos r ((p - 1) * r) := by
    rw [equation]
    exact Submodule.smul_mem _ eta (elementary_prime_witt_integral_norm_weight p r k r)
  have source := elementary_prime_witt_precision_preimage_bound p r k large r a
    ((p - 1) * r) ((p - 1) * r - a) le_rfl principalPositive degreeBound
    (by omega) (by omega) L q reduction anisotropic x image
  refine ⟨source, ?_⟩
  have split : (p - 1) * r = (p - 1) * (r - 1) + (p - 1) := by
    calc
      _ = (p - 1) * ((r - 1) + 1) := by rw [Nat.sub_add_cancel (Fact.out : 0 < r)]
      _ = _ := by rw [Nat.mul_add, Nat.mul_one]
  exact elementary_weight_augmentation_zero p r (by omega) (Fact.out : 0 < r)
    (truncated_witt_top_power_zero p r k) r ((p - 1) * r - a) (by omega) x source

end Litt3.Deformations

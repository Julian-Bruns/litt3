import Solutions.Deformations.ElementaryPrimeWittIntegralNormPreimage
import Solutions.Deformations.ElementaryPrimeWittDivisibleNormWeight

namespace Litt3.Deformations

variable (p r : ℕ) [Fact p.Prime] [Fact (0 < r)]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Nontrivial (TruncatedWittVector p r k) :=
  truncated_witt_nontrivial p r (Fact.out : 0 < r) k

/-- At precision r, divisibility of the actual integral norm coefficient
forces the extra source weight, uniformly in the rank and principal degree. -/
theorem elementary_prime_witt_divisible_norm_preimage
    (large : 2 < p) (a : ℕ) (principalPositive : 0 < a) (degreeBound : a + 1 ≤ p - 1)
    (L : AddMonoidAlgebra (TruncatedWittVector p r k) (Fin r → ZMod p) →+
      AddMonoidAlgebra (TruncatedWittVector p r k) (Fin r → ZMod p))
    (q : MvPolynomial (Fin r) k)
    (reduction : ElementaryPrimeWittReduction p r k r a L q)
    (anisotropic : ∀ v : Fin r → ZMod p, v ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl p) k (v i)) ≠ 0)
    (x : AddMonoidAlgebra (TruncatedWittVector p r k) (Fin r → ZMod p))
    (eta : TruncatedWittVector p r k)
    (divisible : truncatedWittResidue p r (Fact.out : 0 < r) k eta = 0)
    (equation : L x = eta • elementaryOriginalNorm (R := TruncatedWittVector p r k) p r) :
    x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p r k)
      p (Fact.out : p.Prime).pos r ((p - 1) * r - a + 1) := by
  have first : p - 1 ≤ (p - 1) * r :=
    Nat.le_mul_of_pos_right (p - 1) (Fact.out : 0 < r)
  have image : L x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p r k)
      p (Fact.out : p.Prime).pos r ((p - 1) * r + (p - 1)) := by
    rw [equation]
    exact elementary_prime_witt_divisible_norm_weight p r k r eta divisible
  exact elementary_prime_witt_precision_preimage_bound p r k large r a
    ((p - 1) * r + (p - 1)) ((p - 1) * r - a + 1) le_rfl
    principalPositive degreeBound le_rfl (by omega) L q reduction anisotropic x image

end Litt3.Deformations

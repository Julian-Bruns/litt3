import Solutions.Deformations.ElementaryAugmentationAnnihilator
import Solutions.Deformations.ElementaryCoefficientWeights
import Solutions.Deformations.ElementaryPrimeWittDivisibleNormPreimage

namespace Litt3.Deformations

variable {R S : Type*} [CommRing R] [Nontrivial R] [CommRing S] [Nontrivial S]

/-- Literal coefficient reduction sends the entire original normal weight
to the corresponding genuine augmentation-ideal power in characteristic p. -/
theorem group_coefficient_original_augmentation_power (p : ℕ) [Fact p.Prime] [CharP S p]
    (phi : R →+* S) (r d : ℕ) (x : AddMonoidAlgebra R (Fin r → ZMod p))
    (member : x ∈ elementaryNormalWeightFiltration R p (Fact.out : p.Prime).pos r d) :
    AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod p) phi x ∈
      elementaryOriginalAugmentationIdeal S p r ^ d := by
  rw [elementary_original_augmentation_power_degree]
  exact group_coefficient_original_weight_preserves phi p (Fact.out : p.Prime).pos
    (Fact.out : p.Prime).one_lt r d x member

section Witt

variable (p r : ℕ) [Fact p.Prime] [Fact (0 < r)]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Nontrivial (TruncatedWittVector p r k) :=
  truncated_witt_nontrivial p r (Fact.out : 0 < r) k

/-- At the literal rank precision, every full integral norm solution has
actual leading reduction in the exact augmentation-power annihilator. -/
theorem elementary_prime_witt_norm_leading_annihilator
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
    AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod p)
      (truncatedWittResidue p r (Fact.out : 0 < r) k) x ∈
        (elementaryOriginalAugmentationIdeal k p r ^ (a + 1)).annihilator := by
  have first : p - 1 ≤ (p - 1) * r := Nat.le_mul_of_pos_right (p - 1) (Fact.out : 0 < r)
  rw [elementary_original_augmentation_annihilator p r (a + 1) (by omega),
    show (p - 1) * r + 1 - (a + 1) = (p - 1) * r - a by omega]
  exact group_coefficient_original_augmentation_power p
    (truncatedWittResidue p r (Fact.out : 0 < r) k) r ((p - 1) * r - a) x
      (elementary_prime_witt_integral_norm_preimage p r k large a principalPositive
        degreeBound L q reduction anisotropic x eta equation).1

/-- Divisible norm coefficients give the precise improved annihilator
level of the literal original leading reduction. -/
theorem elementary_prime_witt_divisible_norm_leading_annihilator
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
    AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod p)
      (truncatedWittResidue p r (Fact.out : 0 < r) k) x ∈
        (elementaryOriginalAugmentationIdeal k p r ^ a).annihilator := by
  have first : p - 1 ≤ (p - 1) * r := Nat.le_mul_of_pos_right (p - 1) (Fact.out : 0 < r)
  rw [elementary_original_augmentation_annihilator p r a (by omega),
    show (p - 1) * r + 1 - a = (p - 1) * r - a + 1 by omega]
  exact group_coefficient_original_augmentation_power p
    (truncatedWittResidue p r (Fact.out : 0 < r) k) r ((p - 1) * r - a + 1) x
      (elementary_prime_witt_divisible_norm_preimage p r k large a principalPositive
        degreeBound L q reduction anisotropic x eta divisible equation)

end Witt

end Litt3.Deformations

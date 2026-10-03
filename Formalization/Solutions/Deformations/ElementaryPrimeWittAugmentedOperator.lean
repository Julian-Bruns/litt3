import Solutions.Deformations.ElementaryWeightAugmentationDivisibility
import Solutions.Deformations.ElementaryPrimeWittOperatorInitial
import Solutions.Deformations.TruncatedWittMaps

namespace Litt3.Deformations

variable (p r a : ℕ) [Fact p.Prime]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Fact (0 < r + 1) := ⟨by omega⟩
local instance : Nontrivial (TruncatedWittVector p (r + 1) k) :=
  truncated_witt_nontrivial p (r + 1) (by omega) k

/-- At final precision, deck equivariance and the positive original
principal degree kill the augmented image of every possible norm preimage.
Only additivity, rather than coefficient linearity, is used. -/
theorem elementary_prime_witt_augmented_operator_zero
    (large : 2 < p) (principalPositive : 0 < a) (degreeBound : a + 1 ≤ p - 1)
    (positive : 0 < r)
    (L : AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p) →+
      AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p))
    (q : MvPolynomial (Fin r) k)
    (reduction : ElementaryPrimeWittReduction p (r + 1) k r a L q)
    (x : AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p))
    (member : x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p (r + 1) k)
      p (Fact.out : p.Prime).pos r ((p - 1) * r - a)) :
    additiveGroupAlgebraAugmentation (L x) = 0 := by
  let R := TruncatedWittVector p (r + 1) k
  let A := AddMonoidAlgebra R (Fin r → ZMod p)
  have split : (p - 1) * r = (p - 1) * (r - 1) + (p - 1) := by
    calc
      _ = (p - 1) * ((r - 1) + 1) := by rw [Nat.sub_add_cancel positive]
      _ = _ := by rw [Nat.mul_add, Nat.mul_one]
  have bound : r ≤ basisWeightExponent (p - 1) ((p - 1) * r - a) 0 := by
    by_contra absent
    have small : basisWeightExponent (p - 1) ((p - 1) * r - a) 0 ≤ r - 1 := by omega
    have weighted := (basis_weight_exponent_le (p - 1) ((p - 1) * r - a) 0 (r - 1)
      (by omega)).mp small
    omega
  have augmented := elementary_weight_augmentation_divisibility (R := R) p (by omega)
    r ((p - 1) * r - a) x member
  obtain ⟨eta, augmented⟩ := (pow_dvd_pow (p : R) bound).trans augmented
  have constantMember : (algebraMap R A eta) ∈
      elementaryNormalWeightFiltration R p (Fact.out : p.Prime).pos r 0 := by
    rw [elementary_normal_weight_initial]
    exact Submodule.mem_top
  obtain ⟨imageMember, _⟩ := elementary_prime_witt_operator_initial p (r + 1) k r 0 a
    degreeBound L q reduction ⟨algebraMap R A eta, constantMember⟩
  have imageDivisible := elementary_weight_augmentation_divisibility (R := R) p (by omega)
    r a (L (algebraMap R A eta)) (by simpa using imageMember)
  have first : 1 ≤ basisWeightExponent (p - 1) a 0 := by
    by_contra absent
    have weighted := (basis_weight_exponent_le (p - 1) a 0 0 (by omega)).mp (by omega)
    omega
  obtain ⟨coefficient, imageDivisible⟩ := (pow_dvd_pow (p : R) first).trans imageDivisible
  simp only [pow_one] at imageDivisible
  have constantEquality : algebraMap R A (additiveGroupAlgebraAugmentation x) =
      (p ^ r : ℕ) • algebraMap R A eta := by
    rw [augmented, map_mul, map_pow, map_natCast, nsmul_eq_mul, Nat.cast_pow]
  rw [elementary_deck_operator_aug_constant p (Fact.out : p.Prime).pos r L reduction.1 x,
    constantEquality, map_nsmul, map_nsmul, nsmul_eq_mul, Nat.cast_pow, imageDivisible]
  rw [← mul_assoc, ← pow_succ, truncated_witt_top_power_zero p (r + 1) k, zero_mul]

end Litt3.Deformations

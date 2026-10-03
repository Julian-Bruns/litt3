import Solutions.Deformations.ElementaryPrimeNearTopDivision
import Solutions.Deformations.WeightedRootHomogeneousOrigin

namespace Litt3.Deformations

open scoped WeightedRootPolynomialScalars

variable (p : ℕ) [Fact p.Prime]
variable (k : Type*) [Field k] [CharP k p]

/-- Actual division at the critical homogeneous target, uniformly in the
prime and principal degree, before parameter truncation. -/
theorem elementary_prime_critical_homogeneous_division
    (r a : ℕ) (positive : 0 < r) (principalLower : 2 ≤ a)
    (principalUpper : a + 1 ≤ p - 1)
    (q : MvPolynomial (Fin r) k) (principal : q.IsHomogeneous a)
    (anisotropic : ∀ v : Fin r → ZMod p, v ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl p) k (v i)) ≠ 0)
    (Z : weightedRootProduct (Polynomial k) p Polynomial.X r)
    (homogeneous : Z ∈ weightedRootHomogeneousComponent k p
      (Fact.out : p.Prime).one_lt r ((p - 1) * r + a - 1)) :
    ∃ x : weightedRootProduct (Polynomial k) p Polynomial.X r,
      x ∈ weightedRootHomogeneousComponent k p (Fact.out : p.Prime).one_lt r
        ((p - 1) * r - 1) ∧
      weightedRootPolynomialEvaluation p Polynomial.X r
        (MvPolynomial.map Polynomial.C q) * x = Z := by
  have weightPositive : 0 < p - 1 := by have := (Fact.out : p.Prime).two_le; omega
  have topPositive : 0 < (p - 1) * r := Nat.mul_pos weightPositive positive
  have sourceDegree : (p - 1) * r + a - 1 - a = (p - 1) * r - 1 := by omega
  have sourceSplit : (p - 1) * r - 1 =
      (p - 1) * (r - 1) + (p - 1 - 1) := by
    have split : r = (r - 1) + 1 := by omega
    conv_lhs => rw [split, Nat.mul_add, Nat.mul_one]
    omega
  have sourceNonzero : ((p - 1) * r - 1) % (p - 1) ≠ 0 := by
    simp only [sourceSplit, Nat.add_mod, Nat.mul_mod_right, zero_add, Nat.mod_mod]
    rw [Nat.mod_eq_of_lt (show p - 1 - 1 < p - 1 by omega)]
    omega
  have targetResidue : ((p - 1) * r + a - 1) % (p - 1) = a - 1 := by
    rw [show (p - 1) * r + a - 1 = (p - 1) * r + (a - 1) by omega,
      Nat.add_mod, Nat.mul_mod_right, zero_add, Nat.mod_mod,
      Nat.mod_eq_of_lt (show a - 1 < p - 1 by omega)]
  have origin := weighted_root_homogeneous_origin_zero k p
    (Fact.out : p.Prime).one_lt r ((p - 1) * r + a - 1)
    (by rw [targetResidue]; omega) Z homogeneous
  obtain ⟨x, member, equality⟩ := elementary_prime_near_top_homogeneous_division p k
    r ((p - 1) * r + a - 1) a (by omega) (by rw [sourceDegree])
    (by rw [sourceDegree]; exact sourceNonzero) q principal anisotropic Z homogeneous origin
  exact ⟨x, by simpa only [sourceDegree] using member, equality⟩

end Litt3.Deformations

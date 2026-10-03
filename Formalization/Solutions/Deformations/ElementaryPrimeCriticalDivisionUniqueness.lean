import Solutions.Deformations.ElementaryPrimeCriticalHomogeneousDivision
import Solutions.Deformations.PrimeWeightedPolynomialMoments

namespace Litt3.Deformations

open scoped WeightedRootPolynomialScalars

variable (p : ℕ) [Fact p.Prime]
variable (k : Type*) [Field k] [CharP k p]

/-- Every actual critical homogeneous target has a unique literal
homogeneous principal preimage, derived from the full low-weight kernel. -/
theorem elementary_prime_critical_homogeneous_division_unique
    (large : 2 < p) (r a : ℕ) (positive : 0 < r)
    (principalLower : 2 ≤ a) (principalUpper : a + 1 ≤ p - 1)
    (q : MvPolynomial (Fin r) k) (principal : q.IsHomogeneous a)
    (anisotropic : ∀ v : Fin r → ZMod p, v ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl p) k (v i)) ≠ 0)
    (Z : weightedRootProduct (Polynomial k) p Polynomial.X r)
    (homogeneous : Z ∈ weightedRootHomogeneousComponent k p
      (Fact.out : p.Prime).one_lt r ((p - 1) * r + a - 1)) :
    ∃! H : weightedRootProduct (Polynomial k) p Polynomial.X r,
      H ∈ weightedRootHomogeneousComponent k p (Fact.out : p.Prime).one_lt r
        ((p - 1) * r - 1) ∧
      weightedRootPolynomialEvaluation p Polynomial.X r
        (MvPolynomial.map Polynomial.C q) * H = Z := by
  obtain ⟨H, member, image⟩ := elementary_prime_critical_homogeneous_division p k
    r a positive principalLower principalUpper q principal anisotropic Z homogeneous
  refine ⟨H, ⟨member, image⟩, ?_⟩
  rintro T ⟨tMember, tImage⟩
  have topPositive : 0 < (p - 1) * r :=
    Nat.mul_pos (by have := (Fact.out : p.Prime).two_le; omega) positive
  apply sub_eq_zero.mp
  apply elementary_prime_homogeneous_low_kernel p k large r ((p - 1) * r - 1)
    (by omega) q anisotropic (T - H)
      ((weightedRootHomogeneousComponent k p (Fact.out : p.Prime).one_lt r
        ((p - 1) * r - 1)).sub_mem tMember member)
  rw [mul_sub, tImage, image, sub_self]

end Litt3.Deformations

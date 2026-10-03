import Definitions.Deformations.ElementaryPrimeCriticalTheta
import Solutions.Deformations.ElementaryPrimeActualCriticalDetectors
import Solutions.Deformations.ElementaryPrimeCriticalParameterDivisibility
import Solutions.Deformations.ElementaryPrimeCriticalHomogeneousDivision

namespace Litt3.Deformations

open scoped BigOperators LinearAlgebra.Projectivization WeightedRootPolynomialScalars

variable (p : ℕ) [Fact p.Prime]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

theorem elementary_prime_actual_critical_detector_frobenius (large : 2 < p)
    (r : ℕ) [Fintype (ℙ (ZMod p) (Fin r → ZMod p))] (positive : 0 < r)
    (q : MvPolynomial (Fin r) k)
    (anisotropic : ∀ v : Fin r → ZMod p, v ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl p) k (v i)) ≠ 0)
    (x Z : weightedRootProduct (Polynomial k) p Polynomial.X r)
    (homogeneous : x ∈ weightedRootHomogeneousComponent k p
      (Fact.out : p.Prime).one_lt r ((p - 1) * r - 1))
    (preimage : weightedRootPolynomialEvaluation p Polynomial.X r
      (MvPolynomial.map Polynomial.C q) * x = Z) (i : Fin r) :
    elementaryPrimeCriticalTheta p k r q Z i =
      (_root_.frobeniusEquiv k p).symm
        ((weightedRootPolynomialBasis k p (Fact.out : p.Prime).one_lt r).repr x
          (0, primeDetectorExponent p large i)) := by
  unfold elementaryPrimeCriticalTheta
  rw [elementary_prime_actual_critical_detector p k large (ZMod.castHom (dvd_refl p) k)
    r positive q anisotropic x Z homogeneous preimage i]
  have sign : (-1 : k) ^ (r + 1) * (-1 : k) ^ (r + 1) = 1 := by
    rw [← pow_add, show r + 1 + (r + 1) = 2 * (r + 1) by omega, pow_mul]
    simp
  rw [← mul_assoc, sign, one_mul]

/-- Full original critical parameter obstruction, at arbitrary admissible
prime and principal degree, with actual homogeneous division constructed. -/
theorem elementary_prime_actual_critical_obstruction (large : 2 < p)
    (r a : ℕ) [Fintype (ℙ (ZMod p) (Fin r → ZMod p))] (positive : 0 < r)
    (principalLower : 2 ≤ a) (principalUpper : a + 1 ≤ p - 1)
    (q : MvPolynomial (Fin r) k) (principal : q.IsHomogeneous a)
    (anisotropic : ∀ v : Fin r → ZMod p, v ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl p) k (v i)) ≠ 0)
    (Z : weightedRootProduct (Polynomial k) p Polynomial.X r)
    (homogeneous : Z ∈ weightedRootHomogeneousComponent k p
      (Fact.out : p.Prime).one_lt r ((p - 1) * r + a - 1)) :
    (∀ i : Fin r, elementaryPrimeCriticalTheta p k r q Z i = 0) ↔
      ∃ x : weightedRootProduct (Polynomial k) p Polynomial.X r,
        x ∈ weightedRootHomogeneousComponent k p (Fact.out : p.Prime).one_lt r
          ((p - 1) * r - 1) ∧
        (∃ y : weightedRootProduct (Polynomial k) p Polynomial.X r,
          x = (Polynomial.X : Polynomial k) • y) ∧
        weightedRootPolynomialEvaluation p Polynomial.X r
          (MvPolynomial.map Polynomial.C q) * x = Z := by
  constructor
  · intro vanishing
    obtain ⟨x, member, preimage⟩ := elementary_prime_critical_homogeneous_division p k r a
      positive principalLower principalUpper q principal anisotropic Z homogeneous
    refine ⟨x, member, ?_, preimage⟩
    apply (elementary_prime_critical_parameter_divisibility p k large r positive x member).mpr
    intro i
    apply (_root_.frobeniusEquiv k p).symm.injective
    rw [map_zero]
    exact (elementary_prime_actual_critical_detector_frobenius p k large r positive q anisotropic
      x Z member preimage i).symm.trans (vanishing i)
  · rintro ⟨x, member, divisible, preimage⟩ i
    rw [elementary_prime_actual_critical_detector_frobenius p k large r positive q anisotropic
      x Z member preimage i]
    rw [(elementary_prime_critical_parameter_divisibility p k large r positive x member).mp divisible i, map_zero]

end Litt3.Deformations

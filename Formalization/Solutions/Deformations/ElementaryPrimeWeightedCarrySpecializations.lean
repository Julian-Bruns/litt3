import Solutions.Deformations.ElementaryPrimeWeightedCarry
import Mathlib.Algebra.Ring.Parity

namespace Litt3.Deformations

open scoped BigOperators LinearAlgebra.Projectivization

section Signs

variable (p : ℕ) [Fact p.Prime]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]
variable (r : ℕ) [Fintype (ℙ (ZMod p) (Fin r → ZMod p))]

/-- The exact full-sum detector sign for every even elementary rank. -/
theorem elementary_prime_critical_detector_even_sign (even : Even r)
    (q : MvPolynomial (Fin r) k)
    (Z : weightedRootProduct (Polynomial k) p Polynomial.X r) (i : Fin r) :
    elementaryPrimeCriticalTheta p k r q Z i =
      (_root_.frobeniusEquiv k p).symm
        (-(∑ P : ℙ (ZMod p) (Fin r → ZMod p),
          ZMod.castHom (dvd_refl p) k (P.rep i) *
            primeWeightedPolynomialFunction p k (ZMod.castHom (dvd_refl p) k) r Z P.rep /
              q.eval (fun j => ZMod.castHom (dvd_refl p) k (P.rep j)))) := by
  unfold elementaryPrimeCriticalTheta
  rw [pow_succ, even.neg_one_pow, one_mul, neg_one_mul]

/-- Every odd rank has positive sign; inverse Frobenius remains outside
the entire actual projective sum. -/
theorem elementary_prime_critical_detector_odd_sign (odd : Odd r)
    (q : MvPolynomial (Fin r) k)
    (Z : weightedRootProduct (Polynomial k) p Polynomial.X r) (i : Fin r) :
    elementaryPrimeCriticalTheta p k r q Z i =
      (_root_.frobeniusEquiv k p).symm
        (∑ P : ℙ (ZMod p) (Fin r → ZMod p),
          ZMod.castHom (dvd_refl p) k (P.rep i) *
            primeWeightedPolynomialFunction p k (ZMod.castHom (dvd_refl p) k) r Z P.rep /
              q.eval (fun j => ZMod.castHom (dvd_refl p) k (P.rep j))) := by
  unfold elementaryPrimeCriticalTheta
  rw [pow_succ, odd.neg_one_pow, neg_mul_neg, one_mul, one_mul]

end Signs

section Five

local instance : Fact (Nat.Prime 5) := ⟨by norm_num⟩

variable (k : Type*) [Field k] [CharP k 5] [PerfectRing k 5]

/-- The entire original quadratic theorem for every positive elementary
rank is a literal specialization of the generic-prime clause bundle. -/
theorem elementary_prime_weighted_carry_five (r : ℕ) (positive : 0 < r)
    [Fintype (ℙ (ZMod 5) (Fin r → ZMod 5))] :
    ElementaryPrimeWeightedCarryResult 5 k r 2 (by norm_num) positive :=
  elementary_prime_weighted_carry 5 k r 2 (by norm_num) positive (by omega) (by norm_num)

/-- The numerical rank-three weights are exactly the generic formulas;
these are arithmetic identities, with no finite-algebra enumeration. -/
theorem elementary_prime_weighted_carry_rank_three_weights :
    (5 - 1) * 2 - 2 + 1 = (7 : ℕ) ∧
    (5 - 1) * 3 - 2 + 1 = (11 : ℕ) ∧
    (5 - 1) * 3 = (12 : ℕ) ∧
    (5 - 1) * 3 + 2 = (14 : ℕ) ∧
    (5 - 1) * 3 + 2 - 1 = (13 : ℕ) := by
  norm_num

/-- Full rank-three quadratic theorem, with its actual original Witt
operator and grading, before evaluating the displayed weight identities. -/
theorem elementary_prime_weighted_carry_rank_three
    [Fintype (ℙ (ZMod 5) (Fin 3 → ZMod 5))] :
    ElementaryPrimeWeightedCarryResult 5 k 3 2 (by norm_num) (by omega) :=
  elementary_prime_weighted_carry_five k 3 (by omega)

/-- In rank three the whole-sum detector has the positive sign claimed
in the source, on exactly the original prime-field projective directions. -/
theorem elementary_prime_weighted_carry_rank_three_detector
    [Fintype (ℙ (ZMod 5) (Fin 3 → ZMod 5))]
    (q : MvPolynomial (Fin 3) k)
    (Z : weightedRootProduct (Polynomial k) 5 Polynomial.X 3) (i : Fin 3) :
    elementaryPrimeCriticalTheta 5 k 3 q Z i =
      (_root_.frobeniusEquiv k 5).symm
        (∑ P : ℙ (ZMod 5) (Fin 3 → ZMod 5),
          ZMod.castHom (dvd_refl 5) k (P.rep i) *
            primeWeightedPolynomialFunction 5 k (ZMod.castHom (dvd_refl 5) k) 3 Z P.rep /
              q.eval (fun j => ZMod.castHom (dvd_refl 5) k (P.rep j))) :=
  elementary_prime_critical_detector_odd_sign 5 k 3 (by decide) q Z i

end Five

end Litt3.Deformations

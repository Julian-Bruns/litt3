import Solutions.Deformations.TruncatedMonomialCoefficients
import Solutions.Deformations.TruncatedMonomialNilpotence
import Solutions.Deformations.GeneratorIdealFrobenius
import Mathlib.Algebra.CharP.Algebra

namespace Litt3.Deformations

variable (R I : Type*) [CommRing R]

/-- Positive original variable powers keep every coefficient of the
base ring faithfully embedded, even over a nonreduced coefficient ring. -/
theorem truncated_monomial_coefficient_injective (q : I → ℕ) (positive : ∀ i, 0 < q i) :
    Function.Injective (algebraMap R (TruncatedMonomialAlgebra R I q)) := by
  classical
  intro a b same
  change Ideal.Quotient.mk (truncatedMonomialIdeal R I q) (MvPolynomial.C a) =
    Ideal.Quotient.mk (truncatedMonomialIdeal R I q) (MvPolynomial.C b) at same
  have coefficient := (truncated_monomial_quotient_eq_iff R I q _ _).mp same 0
    (by simpa only [Finsupp.zero_apply] using positive)
  simpa only [MvPolynomial.coeff_C, if_pos rfl] using coefficient

/-- Every element of the actual original augmentation ideal is killed
by a common prime-power exponent above all the original truncation
exponents. This is true for the entire ideal, rather than only its
generators, because the actual iterated Frobenius is a ring map. -/
theorem truncated_monomial_augmentation_frobenius (p : ℕ) [Fact p.Prime] [CharP R p]
    (q : I → ℕ) (positive : ∀ i, 0 < q i) (n : ℕ)
    (bounds : ∀ i, q i ≤ p ^ n) (x : TruncatedMonomialAlgebra R I q)
    (member : x ∈ truncatedMonomialAugmentationIdeal R I q) : x ^ (p ^ n) = 0 := by
  letI : CharP (TruncatedMonomialAlgebra R I q) p :=
    charP_of_injective_algebraMap (truncated_monomial_coefficient_injective R I q positive) p
  exact generator_ideal_frobenius_pow_zero p (truncatedMonomialParameter R I q) n
    (fun i => pow_eq_zero_of_le (bounds i) (truncated_monomial_parameter_pow R I q i)) x member

end Litt3.Deformations

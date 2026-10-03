import Solutions.Deformations.QuadraticPolynomialTranslation
import Solutions.Deformations.SplitQuadraticAlgebra
import Mathlib.Algebra.CharP.Lemmas

namespace Litt3.Deformations

variable {A : Type*} [CommRing A] (p : ℕ) [Fact p.Prime] [CharP A p]

/-- An actual nilpotent translation preserves the literal original
Frobenius power relation in the coefficient polynomial algebra. -/
theorem polynomial_translation_frobenius_power (n : ℕ) (t : A) (nilpotent : t ^ (p ^ n) = 0) :
    Polynomial.algEquivAevalXAddC (-t) (Polynomial.X ^ (p ^ n)) =
      (Polynomial.X : Polynomial A) ^ (p ^ n) := by
  rw [map_pow]
  have parameter : Polynomial.algEquivAevalXAddC (-t) Polynomial.X =
      Polynomial.X - Polynomial.C t := by
    simp [Polynomial.algEquivAevalXAddC, Polynomial.algEquivOfCompEqX, sub_eq_add_neg]
  rw [parameter, sub_pow_char_pow, ← map_pow, nilpotent, map_zero, sub_zero]

/-- Completing the square in the actual coefficient polynomial ring
proves that the original Frobenius relation is redundant. Both the
translation cutoff and the completed remainder cutoff are retained
as explicit actual element facts. -/
theorem quadratic_linear_frobenius_relation_redundant (n m : ℕ) (exponent : p ^ n = 2 * m + 1)
    (a b t : A) (half : a = 2 * t) (translation : t ^ (p ^ n) = 0)
    (remainder : (b - t ^ 2) ^ m = 0) :
    Ideal.span ({quadraticLinearPolynomial a b, Polynomial.X ^ (p ^ n)} : Set (Polynomial A)) =
      Ideal.span ({quadraticLinearPolynomial a b} : Set (Polynomial A)) := by
  let e := Polynomial.algEquivAevalXAddC (-t)
  have mapped : (Ideal.span ({quadraticLinearPolynomial a b, Polynomial.X ^ (p ^ n)} :
      Set (Polynomial A))).map (e : Polynomial A →+* Polynomial A) =
      (Ideal.span ({quadraticLinearPolynomial a b} : Set (Polynomial A))).map
        (e : Polynomial A →+* Polynomial A) := by
    rw [Ideal.map_span, Ideal.map_span, Set.image_insert_eq, Set.image_singleton, Set.image_singleton]
    change Ideal.span ({e (quadraticLinearPolynomial a b), e (Polynomial.X ^ (p ^ n))} :
      Set (Polynomial A)) = Ideal.span ({e (quadraticLinearPolynomial a b)} : Set (Polynomial A))
    rw [quadratic_polynomial_translation a b t half, polynomial_translation_frobenius_power p n t translation,
      exponent]
    exact split_quadratic_odd_relation_ideal (b - t ^ 2) m remainder
  rw [← AlgEquiv.toRingEquiv_toRingHom] at mapped
  rw [Ideal.map_comap_of_equiv, Ideal.map_comap_of_equiv] at mapped
  exact (Ideal.comap_injective_of_surjective e.toRingEquiv.symm e.symm.surjective) mapped

end Litt3.Deformations

import Mathlib.FieldTheory.Minpoly.Field

namespace Litt3.CartierAndSpin

open Polynomial

variable {K A : Type*} [Field K] [Ring A] [Algebra K A]

/-- Actual evaluation is injective on polynomials of degree strictly
below the TRUE minimal polynomial. No supplied coefficient rank or
matrix certificate is used. -/
theorem actual_minpoly_bounded_evaluation_injective
    (T : A) (P Q : K[X])
    (hP : P.natDegree < (minpoly K T).natDegree)
    (hQ : Q.natDegree < (minpoly K T).natDegree)
    (heval : aeval T P = aeval T Q) : P = Q := by
  apply sub_eq_zero.mp
  by_contra hne
  have hdiv : minpoly K T ∣ P - Q := minpoly.dvd K T (by
    rw [map_sub, heval, sub_self])
  have hle := Polynomial.natDegree_le_of_dvd hdiv hne
  have hlt : (P - Q).natDegree < (minpoly K T).natDegree :=
    (Polynomial.natDegree_sub_le P Q).trans_lt (max_lt hP hQ)
  exact (not_le_of_gt hlt) hle

/-- Every actual integral polynomial value has one and only one
representative below the true minimal-polynomial degree. The remainder
is literal monic division, over arbitrary noncommutative target algebras. -/
theorem actual_integral_polynomial_value_unique_remainder
    [Nontrivial A] (T : A) (hintegral : IsIntegral K T) (P : K[X]) :
    ∃! Q : K[X], Q.natDegree < (minpoly K T).natDegree ∧ aeval T Q = aeval T P := by
  have hdegree : (P %ₘ minpoly K T).natDegree < (minpoly K T).natDegree :=
    Polynomial.natDegree_modByMonic_lt P (minpoly.monic hintegral) (minpoly.ne_one K T)
  have heval : aeval T (P %ₘ minpoly K T) = aeval T P :=
    Polynomial.aeval_modByMonic_eq_self_of_root (minpoly.monic hintegral) (minpoly.aeval K T)
  refine ⟨P %ₘ minpoly K T, ⟨hdegree, heval⟩, ?_⟩
  intro Q hQ
  exact actual_minpoly_bounded_evaluation_injective T Q (P %ₘ minpoly K T)
    hQ.1 hdegree (hQ.2.trans heval.symm)

end Litt3.CartierAndSpin

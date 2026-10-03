import Definitions.CartierAndSpin.MonomialFunctionFields
import Mathlib.RingTheory.Polynomial.Eisenstein.Basic
import Mathlib.RingTheory.Polynomial.GaussLemma
import Mathlib.RingTheory.Polynomial.UniqueFactorization

namespace Litt3.CartierAndSpin

open Polynomial

variable {k : Type*} [Field k]

/-- V^n-U is Eisenstein at the actual principal prime (U), in every
characteristic and every positive degree. -/
theorem monomial_parameter_eisenstein (n : ℕ) (hn : 0 < n) :
    (monomialParameterPolynomial (k := k) n).IsEisensteinAt
      (Ideal.span ({(X : k[X])} : Set k[X])) := by
  have hprime : (Ideal.span ({(X : k[X])} : Set k[X])).IsPrime :=
    (Ideal.span_singleton_prime Polynomial.X_ne_zero).mpr Polynomial.prime_X
  have hmonic : (monomialParameterPolynomial (k := k) n).Monic :=
    Polynomial.monic_X_pow_sub_C _ hn.ne'
  have hdegree : (monomialParameterPolynomial (k := k) n).natDegree = n :=
    Polynomial.natDegree_X_pow_sub_C
  apply hmonic.isEisensteinAt_of_mem_of_notMem hprime.ne_top
  · intro i hi
    rw [hdegree] at hi
    rw [Ideal.mem_span_singleton]
    simp only [monomialParameterPolynomial, Polynomial.coeff_sub,
      Polynomial.coeff_X_pow, Polynomial.coeff_C, if_neg (show i ≠ n by omega)]
    split_ifs <;> simp
  · rw [Ideal.span_singleton_pow, Ideal.mem_span_singleton, Polynomial.X_pow_dvd_iff]
    intro h
    have hc := h 1 (by omega)
    simp [monomialParameterPolynomial, hn.ne] at hc

theorem monomial_parameter_irreducible (n : ℕ) (hn : 0 < n) :
    Irreducible (monomialParameterPolynomial (k := k) n) := by
  have hprime : (Ideal.span ({(X : k[X])} : Set k[X])).IsPrime :=
    (Ideal.span_singleton_prime Polynomial.X_ne_zero).mpr Polynomial.prime_X
  have hmonic : (monomialParameterPolynomial (k := k) n).Monic :=
    Polynomial.monic_X_pow_sub_C _ hn.ne'
  exact (monomial_parameter_eisenstein n hn).irreducible hprime hmonic.isPrimitive
    (by rw [monomialParameterPolynomial, Polynomial.natDegree_X_pow_sub_C]; omega)

theorem monomial_parameter_fraction_irreducible
    {T : Type*} [Field T] [Algebra k[X] T] [IsFractionRing k[X] T]
    (n : ℕ) (hn : 0 < n) :
    Irreducible ((monomialParameterPolynomial (k := k) n).map (algebraMap k[X] T)) := by
  have hmonic : (monomialParameterPolynomial (k := k) n).Monic :=
    Polynomial.monic_X_pow_sub_C _ hn.ne'
  exact (hmonic.isPrimitive.irreducible_iff_irreducible_map_fraction_map (K := T)).mp
    (monomial_parameter_irreducible n hn)

end Litt3.CartierAndSpin

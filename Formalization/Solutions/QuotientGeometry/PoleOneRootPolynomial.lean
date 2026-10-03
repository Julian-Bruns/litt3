import Definitions.QuotientGeometry.PoleOneRootPolynomial
import Mathlib.RingTheory.Polynomial.Eisenstein.Basic
import Mathlib.RingTheory.Polynomial.GaussLemma

namespace Litt3.QuotientGeometry

theorem pole_one_reciprocal_monic_degree
    {k : Type*} [Field k] (n : ℕ) (hn : 1 < n) (a : k) :
    (poleOneReciprocalPolynomial n a).Monic ∧
      (poleOneReciprocalPolynomial n a).natDegree = n := by
  let c : PowerSeries k := PowerSeries.C a⁻¹ * PowerSeries.X
  have hdegree : (Polynomial.C c * Polynomial.X ^ (n - 1) - Polynomial.C c).degree <
      (n : WithBot ℕ) := by
    apply lt_of_le_of_lt (Polynomial.degree_sub_le _ _) (max_lt ?_ ?_)
    · exact lt_of_le_of_lt (Polynomial.degree_C_mul_X_pow_le _ _) (by exact_mod_cast (by omega : n - 1 < n))
    · exact lt_of_le_of_lt Polynomial.degree_C_le (by exact_mod_cast (by omega : 0 < n))
  have heq : poleOneReciprocalPolynomial n a =
      Polynomial.X ^ n + (Polynomial.C c * Polynomial.X ^ (n - 1) - Polynomial.C c) := by
    simp only [poleOneReciprocalPolynomial, c]
    ring
  rw [heq]
  refine ⟨Polynomial.monic_X_pow_add hdegree, ?_⟩
  apply Polynomial.natDegree_eq_of_degree_eq_some
  rw [Polynomial.degree_add_eq_left_of_degree_lt (by simpa using hdegree), Polynomial.degree_X_pow]

theorem pole_one_reciprocal_eisenstein
    {k : Type*} [Field k] (n : ℕ) (hn : 1 < n) (a : k) (ha : a ≠ 0) :
    (poleOneReciprocalPolynomial n a).IsEisensteinAt
      (Ideal.span ({PowerSeries.X} : Set (PowerSeries k))) := by
  have hprime : (Ideal.span ({PowerSeries.X} : Set (PowerSeries k))).IsPrime :=
    (Ideal.span_singleton_prime PowerSeries.X_ne_zero).mpr PowerSeries.X_prime
  obtain ⟨hmonic, hdegree⟩ := pole_one_reciprocal_monic_degree n hn a
  apply hmonic.isEisensteinAt_of_mem_of_notMem hprime.ne_top
  · intro i hi
    rw [hdegree] at hi
    rw [Ideal.mem_span_singleton, PowerSeries.X_dvd_iff]
    simp only [poleOneReciprocalPolynomial, Polynomial.coeff_sub, Polynomial.coeff_add,
      Polynomial.coeff_X_pow, Polynomial.coeff_C_mul_X_pow, Polynomial.coeff_C,
      if_neg (show i ≠ n by omega)]
    split_ifs <;> simp
  · rw [Ideal.span_singleton_pow, Ideal.mem_span_singleton, PowerSeries.X_pow_dvd_iff]
    intro h
    have hc := h 1 (by omega)
    simp only [poleOneReciprocalPolynomial, Polynomial.coeff_sub, Polynomial.coeff_add,
      Polynomial.coeff_X_pow, Polynomial.coeff_C_mul_X_pow, Polynomial.coeff_C,
      if_neg (show (0 : ℕ) ≠ n by omega),
      if_neg (show (0 : ℕ) ≠ n - 1 by omega), if_pos rfl,
      zero_add, zero_sub, map_neg] at hc
    simpa [ha] using hc

theorem pole_one_reciprocal_irreducible
    {k : Type*} [Field k] (n : ℕ) (hn : 1 < n) (a : k) (ha : a ≠ 0) :
    Irreducible (poleOneReciprocalPolynomial n a) := by
  have hprime : (Ideal.span ({PowerSeries.X} : Set (PowerSeries k))).IsPrime :=
    (Ideal.span_singleton_prime PowerSeries.X_ne_zero).mpr PowerSeries.X_prime
  obtain ⟨hmonic, hdegree⟩ := pole_one_reciprocal_monic_degree n hn a
  exact (pole_one_reciprocal_eisenstein n hn a ha).irreducible hprime hmonic.isPrimitive
    (by rw [hdegree]; omega)

theorem pole_one_reciprocal_fraction_irreducible
    {k : Type*} [Field k] (n : ℕ) (hn : 1 < n) (a : k) (ha : a ≠ 0) :
    Irreducible ((poleOneReciprocalPolynomial n a).map
      (algebraMap (PowerSeries k) (LaurentSeries k))) := by
  exact ((pole_one_reciprocal_monic_degree n hn a).1.irreducible_iff_irreducible_map_fraction_map
    (K := LaurentSeries k)).mp (pole_one_reciprocal_irreducible n hn a ha)

end Litt3.QuotientGeometry

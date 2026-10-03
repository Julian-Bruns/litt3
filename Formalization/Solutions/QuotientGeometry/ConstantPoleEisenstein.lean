import Definitions.QuotientGeometry.ConstantPolePolynomial
import Solutions.QuotientGeometry.ReverseIrreducibility
import Mathlib.RingTheory.Polynomial.Eisenstein.Basic
import Mathlib.RingTheory.Polynomial.GaussLemma

namespace Litt3.QuotientGeometry

theorem constant_polynomial_reverse_degree_lt
    {k : Type*} [Field k] (g : Polynomial k) (hg : 0 < g.natDegree) (hzero : g.coeff 0 = 0) :
    g.reverse.natDegree < g.natDegree := by
  have hnonzero : g ≠ 0 := by intro h; simp [h] at hg
  have htrail : g.natTrailingDegree ≠ 0 := by
    intro h
    rcases Polynomial.natTrailingDegree_eq_zero.mp h with hz | hc
    · exact hnonzero hz
    · exact hc hzero
  have h := Polynomial.natDegree_eq_reverse_natDegree_add_natTrailingDegree g
  omega

theorem constant_pole_reciprocal_monic_degree
    {k : Type*} [Field k] (g : Polynomial k) (hg : 0 < g.natDegree) (hzero : g.coeff 0 = 0) :
    (constantPoleReciprocal g).Monic ∧ (constantPoleReciprocal g).natDegree = g.natDegree := by
  have hreverse := constant_polynomial_reverse_degree_lt g hg hzero
  have hlower : (Polynomial.C (PowerSeries.X : PowerSeries k) *
      g.reverse.map PowerSeries.C).degree < (g.natDegree : WithBot ℕ) := by
    rw [Polynomial.degree_C_mul PowerSeries.X_ne_zero]
    apply lt_of_le_of_lt (Polynomial.degree_map_le) ?_
    apply lt_of_le_of_lt (Polynomial.degree_le_natDegree) ?_
    exact_mod_cast hreverse
  refine ⟨Polynomial.monic_X_pow_sub hlower, Polynomial.natDegree_eq_of_degree_eq_some ?_⟩
  rw [constantPoleReciprocal, Polynomial.degree_sub_eq_left_of_degree_lt
    (by simpa using hlower), Polynomial.degree_X_pow]

theorem constant_pole_reciprocal_eisenstein
    {k : Type*} [Field k] (g : Polynomial k) (hg : 0 < g.natDegree) (hzero : g.coeff 0 = 0) :
    (constantPoleReciprocal g).IsEisensteinAt
      (Ideal.span ({PowerSeries.X} : Set (PowerSeries k))) := by
  have hprime : (Ideal.span ({PowerSeries.X} : Set (PowerSeries k))).IsPrime :=
    (Ideal.span_singleton_prime PowerSeries.X_ne_zero).mpr PowerSeries.X_prime
  obtain ⟨hmonic, hdegree⟩ := constant_pole_reciprocal_monic_degree g hg hzero
  apply hmonic.isEisensteinAt_of_mem_of_notMem hprime.ne_top
  · intro i hi
    rw [hdegree] at hi
    rw [Ideal.mem_span_singleton, PowerSeries.X_dvd_iff]
    simp [constantPoleReciprocal, Polynomial.coeff_C_mul, show i ≠ g.natDegree by omega]
  · rw [Ideal.span_singleton_pow, Ideal.mem_span_singleton, PowerSeries.X_pow_dvd_iff]
    intro h
    have hc := h 1 (by omega)
    have hnonzero : g ≠ 0 := by intro hz; simp [hz] at hg
    have hleading := Polynomial.leadingCoeff_ne_zero.mpr hnonzero
    apply hleading
    simpa [constantPoleReciprocal, Polynomial.coeff_C_mul,
      Polynomial.coeff_zero_reverse, show (0 : ℕ) ≠ g.natDegree by omega] using hc

theorem constant_pole_reciprocal_irreducible
    {k : Type*} [Field k] (g : Polynomial k) (hg : 0 < g.natDegree) (hzero : g.coeff 0 = 0) :
    Irreducible (constantPoleReciprocal g) := by
  have hprime : (Ideal.span ({PowerSeries.X} : Set (PowerSeries k))).IsPrime :=
    (Ideal.span_singleton_prime PowerSeries.X_ne_zero).mpr PowerSeries.X_prime
  obtain ⟨hmonic, hdegree⟩ := constant_pole_reciprocal_monic_degree g hg hzero
  exact (constant_pole_reciprocal_eisenstein g hg hzero).irreducible hprime hmonic.isPrimitive
    (by rw [hdegree]; omega)

theorem constant_pole_reciprocal_fraction_irreducible
    {k : Type*} [Field k] (g : Polynomial k) (hg : 0 < g.natDegree) (hzero : g.coeff 0 = 0) :
    Irreducible ((constantPoleReciprocal g).map
      (algebraMap (PowerSeries k) (LaurentSeries k))) :=
  ((constant_pole_reciprocal_monic_degree g hg hzero).1.irreducible_iff_irreducible_map_fraction_map
    (K := LaurentSeries k)).mp (constant_pole_reciprocal_irreducible g hg hzero)

end Litt3.QuotientGeometry

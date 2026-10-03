import Definitions.QuotientGeometry.PoleOneArtinSchreier
import Solutions.QuotientGeometry.PoleOneRootPolynomial
import Solutions.QuotientGeometry.ReverseIrreducibility

namespace Litt3.QuotientGeometry

theorem pole_one_artin_schreier_monic_degree
    {k : Type*} [Field k] (n : ℕ) (hn : 1 < n) (a : k) :
    (poleOneArtinSchreierPolynomial n a).Monic ∧
      (poleOneArtinSchreierPolynomial n a).natDegree = n := by
  let A : LaurentSeries k := HahnSeries.single (-1) a
  have hlower : (Polynomial.X + Polynomial.C A).degree < (n : WithBot ℕ) := by
    exact lt_of_le_of_lt (Polynomial.degree_add_le _ _) (max_lt
      (by simpa using (show (1 : WithBot ℕ) < n by exact_mod_cast hn))
      (lt_of_le_of_lt Polynomial.degree_C_le (by exact_mod_cast (by omega : 0 < n))))
  have heq : poleOneArtinSchreierPolynomial n a = Polynomial.X ^ n -
      (Polynomial.X + Polynomial.C A) := by simp only [poleOneArtinSchreierPolynomial, A]; ring
  rw [heq]
  refine ⟨Polynomial.monic_X_pow_sub hlower, Polynomial.natDegree_eq_of_degree_eq_some ?_⟩
  rw [Polynomial.degree_sub_eq_left_of_degree_lt (by simpa using hlower), Polynomial.degree_X_pow]

theorem pole_one_artin_schreier_reverse
    {k : Type*} [Field k] (n : ℕ) (hn : 1 < n) (a : k) (ha : a ≠ 0) :
    (poleOneArtinSchreierPolynomial n a).reverse =
      Polynomial.C (-HahnSeries.single (-1) a) *
        (poleOneReciprocalPolynomial n a).map (algebraMap (PowerSeries k) (LaurentSeries k)) := by
  let A : LaurentSeries k := HahnSeries.single (-1) a
  let c : LaurentSeries k := HahnSeries.C a⁻¹ * HahnSeries.single 1 1
  have hAc : A * c = 1 := by
    simp [A, c, HahnSeries.C_apply, HahnSeries.single_mul_single, ha]
  have hcmap : algebraMap (PowerSeries k) (LaurentSeries k)
      (PowerSeries.C a⁻¹ * PowerSeries.X) = c := by
    change ((PowerSeries.C a⁻¹ * PowerSeries.X : PowerSeries k) : LaurentSeries k) = c
    rw [PowerSeries.coe_mul, PowerSeries.coe_C, PowerSeries.coe_X]
  have hreflectX : Polynomial.reflect n (Polynomial.X : Polynomial (LaurentSeries k)) =
      Polynomial.X ^ (n - 1) := by
    simpa only [pow_one, Polynomial.revAt_le (by omega : 1 ≤ n)] using
      (Polynomial.reflect_monomial n 1 (R := LaurentSeries k))
  rw [Polynomial.reverse, (pole_one_artin_schreier_monic_degree n hn a).2]
  simp only [poleOneArtinSchreierPolynomial, Polynomial.reflect_sub,
    hreflectX, Polynomial.reflect_monomial, Polynomial.revAt_le (Nat.le_refl n),
    Nat.sub_self, pow_zero, Polynomial.reflect_C,
    poleOneReciprocalPolynomial, Polynomial.map_sub, Polynomial.map_add, Polynomial.map_mul,
    Polynomial.map_pow, Polynomial.map_X, Polynomial.map_C, hcmap]
  change 1 - Polynomial.X ^ (n - 1) - Polynomial.C A * Polynomial.X ^ n =
    Polynomial.C (-A) * (Polynomial.X ^ n + Polynomial.C c * Polynomial.X ^ (n - 1) - Polynomial.C c)
  rw [Polynomial.C_neg]
  have hpoly : Polynomial.C A * Polynomial.C c = 1 := by rw [← map_mul, hAc, map_one]
  calc
    _ = -Polynomial.C A * Polynomial.X ^ n -
      (Polynomial.C A * Polynomial.C c) * Polynomial.X ^ (n - 1) +
      Polynomial.C A * Polynomial.C c := by rw [hpoly]; ring
    _ = _ := by ring

/-- A nonzero actual pole-one coefficient gives an irreducible polynomial
over k((t)), in every characteristic and for every degree greater than one.
In characteristic p this constructs genuine Artin--Schreier fields. -/
theorem pole_one_artin_schreier_irreducible
    {k : Type*} [Field k] (n : ℕ) (hn : 1 < n) (a : k) (ha : a ≠ 0) :
    Irreducible (poleOneArtinSchreierPolynomial n a) := by
  have hA : (HahnSeries.single (-1) a : LaurentSeries k) ≠ 0 := HahnSeries.single_ne_zero ha
  apply polynomial_irreducible_of_reverse
  · simp [poleOneArtinSchreierPolynomial, show (0 : ℕ) ≠ n by omega, hA]
  · rw [pole_one_artin_schreier_reverse n hn a ha, mul_comm]
    apply (irreducible_mul_isUnit (Polynomial.isUnit_C.mpr
      (isUnit_iff_ne_zero.mpr (neg_ne_zero.mpr hA)))).mpr
    exact pole_one_reciprocal_fraction_irreducible n hn a ha

end Litt3.QuotientGeometry

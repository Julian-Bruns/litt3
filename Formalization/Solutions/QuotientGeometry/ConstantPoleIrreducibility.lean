import Solutions.QuotientGeometry.ConstantPoleEisenstein

namespace Litt3.QuotientGeometry

theorem constant_pole_polynomial_degree
    {k : Type*} [Field k] (g : Polynomial k) (hg : 0 < g.natDegree) :
    (constantPolePolynomial g).natDegree = g.natDegree := by
  have hnonzero : g ≠ 0 := by intro h; simp [h] at hg
  have hmap : (g.map (HahnSeries.C : k →+* LaurentSeries k)).degree = g.degree :=
    Polynomial.degree_map_eq_of_injective
      (f := (HahnSeries.C : k →+* LaurentSeries k)) HahnSeries.C_injective g
  have hlower : (Polynomial.C (HahnSeries.single (-1) (1 : k) : LaurentSeries k)).degree <
      (g.map (HahnSeries.C : k →+* LaurentSeries k)).degree := by
    rw [hmap, Polynomial.degree_eq_natDegree hnonzero]
    exact lt_of_le_of_lt Polynomial.degree_C_le (by exact_mod_cast hg)
  apply Polynomial.natDegree_eq_of_degree_eq_some
  rw [constantPolePolynomial, Polynomial.degree_sub_eq_left_of_degree_lt hlower,
    hmap, Polynomial.degree_eq_natDegree hnonzero]

theorem constant_pole_polynomial_reverse
    {k : Type*} [Field k] (g : Polynomial k) (hg : 0 < g.natDegree) :
    (constantPolePolynomial g).reverse =
      Polynomial.C (-HahnSeries.single (-1) (1 : k) : LaurentSeries k) *
        (constantPoleReciprocal g).map (algebraMap (PowerSeries k) (LaurentSeries k)) := by
  let v : LaurentSeries k := HahnSeries.single (-1) 1
  let x : LaurentSeries k := HahnSeries.single 1 1
  have hvx : v * x = 1 := by simp [v, x, HahnSeries.single_mul_single]
  have hmapX : algebraMap (PowerSeries k) (LaurentSeries k) PowerSeries.X = x := PowerSeries.coe_X
  have hmapC : (algebraMap (PowerSeries k) (LaurentSeries k)).comp PowerSeries.C = HahnSeries.C := by
    apply RingHom.ext
    intro a
    exact PowerSeries.coe_C a
  rw [Polynomial.reverse, constant_pole_polynomial_degree g hg]
  simp only [constantPolePolynomial, Polynomial.reflect_sub, Polynomial.reflect_map,
    Polynomial.reflect_C, constantPoleReciprocal, Polynomial.map_sub, Polynomial.map_pow,
    Polynomial.map_X, Polynomial.map_mul, Polynomial.map_C, Polynomial.map_map, hmapX, hmapC]
  change g.reverse.map HahnSeries.C - Polynomial.C v * Polynomial.X ^ g.natDegree =
    Polynomial.C (-v) * (Polynomial.X ^ g.natDegree - Polynomial.C x * g.reverse.map HahnSeries.C)
  rw [Polynomial.C_neg]
  have hpoly : Polynomial.C v * Polynomial.C x = 1 := by rw [← map_mul, hvx, map_one]
  calc
    _ = -Polynomial.C v * Polynomial.X ^ g.natDegree +
      (Polynomial.C v * Polynomial.C x) * g.reverse.map HahnSeries.C := by rw [hpoly]; ring
    _ = _ := by ring

/-- A constant polynomial of positive degree with zero constant term,
minus the actual downstairs pole parameter, is irreducible over the
whole Laurent field in every characteristic. -/
theorem constant_pole_polynomial_irreducible
    {k : Type*} [Field k] (g : Polynomial k) (hg : 0 < g.natDegree) (hzero : g.coeff 0 = 0) :
    Irreducible (constantPolePolynomial g) := by
  have hv : (HahnSeries.single (-1) (1 : k) : LaurentSeries k) ≠ 0 :=
    HahnSeries.single_ne_zero one_ne_zero
  apply polynomial_irreducible_of_reverse
  · simpa [constantPolePolynomial, hzero] using neg_ne_zero.mpr hv
  · rw [constant_pole_polynomial_reverse g hg, mul_comm]
    apply (irreducible_mul_isUnit (Polynomial.isUnit_C.mpr
      (isUnit_iff_ne_zero.mpr (neg_ne_zero.mpr hv)))).mpr
    exact constant_pole_reciprocal_fraction_irreducible g hg hzero

end Litt3.QuotientGeometry

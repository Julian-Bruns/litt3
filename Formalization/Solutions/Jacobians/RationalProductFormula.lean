import Theorems.Jacobians.RationalProductFormula
import Solutions.Jacobians.RationalLinearPlaces

namespace Litt3.Jacobians

open scoped Classical

theorem rational_polynomial_unit_mul
    {K : Type*} [Field K] (p q : Polynomial K) (hp : p ≠ 0) (hq : q ≠ 0) :
    rationalPolynomialUnit (p * q) (mul_ne_zero hp hq) =
      rationalPolynomialUnit p hp * rationalPolynomialUnit q hq := by
  apply Units.ext
  exact map_mul (algebraMap (Polynomial K) (RatFunc K)) p q

theorem rational_constant_principal_divisor_zero
    {K : Type*} [Field K] (c : K) (hc : c ≠ 0) :
    principalDivisorMap (rationalProjectiveValuationDivisorSystem K)
      (Additive.ofMul (rationalPolynomialUnit (Polynomial.C c) (by simpa using hc))) = 0 := by
  ext p
  rw [principal_divisor_coefficient]
  cases p with
  | none =>
    change valuationOrder (rationalInfinityValuation K)
      (Additive.ofMul (rationalPolynomialUnit (Polynomial.C c) _)) = 0
    rw [rational_infinity_order]
    change -(algebraMap (Polynomial K) (RatFunc K) (Polynomial.C c)).intDegree = 0
    rw [RatFunc.intDegree_polynomial]
    simp
  | some v =>
    apply valuation_order_eq_zero_of_value_one
    change v.valuation (RatFunc K) (algebraMap (Polynomial K) (RatFunc K) (Polynomial.C c)) = 1
    rw [IsDedekindDomain.HeightOneSpectrum.valuation_of_algebraMap,
      IsDedekindDomain.HeightOneSpectrum.intValuation_eq_one_iff]
    intro hmem
    exact v.isPrime.ne_top (Ideal.eq_top_of_isUnit_mem v.asIdeal hmem
      (Polynomial.isUnit_C.mpr (isUnit_iff_ne_zero.mpr hc)))

theorem rational_constant_principal_degree_zero
    {K : Type*} [Field K] (c : K) (hc : c ≠ 0) :
    rationalPrincipalDegree K
      (Additive.ofMul (rationalPolynomialUnit (Polynomial.C c) (by simpa using hc))) = 0 := by
  change divisorDegree (principalDivisorMap _ _) = 0
  rw [rational_constant_principal_divisor_zero c hc, map_zero]

theorem rational_linear_principal_degree_zero
    {K : Type*} [Field K] (c : K) :
    rationalPrincipalDegree K
      (Additive.ofMul (rationalPolynomialUnit (Polynomial.X - Polynomial.C c)
        (Polynomial.X_sub_C_ne_zero c))) = 0 := by
  change divisorDegree (principalDivisorMap _ _) = 0
  rw [rational_linear_principal_divisor]
  simp

theorem rational_polynomial_principal_degree_mul
    {K : Type*} [Field K] (p q : Polynomial K) (hp : p ≠ 0) (hq : q ≠ 0) :
    rationalPrincipalDegree K (Additive.ofMul (rationalPolynomialUnit (p * q) (mul_ne_zero hp hq))) =
      rationalPrincipalDegree K (Additive.ofMul (rationalPolynomialUnit p hp)) +
        rationalPrincipalDegree K (Additive.ofMul (rationalPolynomialUnit q hq)) := by
  rw [rational_polynomial_unit_mul p q hp hq, ofMul_mul, map_add]

theorem rational_split_product_principal_degree_zero
    {K : Type*} [Field K] (s : Multiset K) :
    rationalPrincipalDegree K (Additive.ofMul
      (rationalPolynomialUnit ((s.map fun c => Polynomial.X - Polynomial.C c).prod)
        (Polynomial.monic_multisetProd_X_sub_C s).ne_zero)) = 0 := by
  induction s using Multiset.induction_on with
  | empty =>
    simpa using rational_constant_principal_degree_zero (K := K) 1 one_ne_zero
  | cons c s ih =>
    simp only [Multiset.map_cons, Multiset.prod_cons]
    rw [rational_polynomial_principal_degree_mul _ _ (Polynomial.X_sub_C_ne_zero c)
      (Polynomial.monic_multisetProd_X_sub_C s).ne_zero,
      rational_linear_principal_degree_zero, zero_add]
    exact ih

/-- Over algebraically closed constants, every polynomial factor is
constant or linear; its actual full principal divisor has degree zero. -/
theorem rational_polynomial_principal_degree_zero
    {K : Type*} [Field K] [IsAlgClosed K] (p : Polynomial K) (hp : p ≠ 0) :
    rationalPrincipalDegree K (Additive.ofMul (rationalPolynomialUnit p hp)) = 0 := by
  have hfactor := Polynomial.C_leadingCoeff_mul_prod_multiset_X_sub_C
    (IsAlgClosed.card_roots_eq_natDegree (p := p))
  have hpLC : p.leadingCoeff ≠ 0 := Polynomial.leadingCoeff_ne_zero.mpr hp
  have hprod := rational_polynomial_principal_degree_mul
    (Polynomial.C p.leadingCoeff) ((p.roots.map fun c => Polynomial.X - Polynomial.C c).prod)
    (by simpa using hpLC) (Polynomial.monic_multisetProd_X_sub_C p.roots).ne_zero
  have hunit : rationalPolynomialUnit
      (Polynomial.C p.leadingCoeff * (p.roots.map fun c => Polynomial.X - Polynomial.C c).prod)
      (mul_ne_zero (by simpa using hpLC) (Polynomial.monic_multisetProd_X_sub_C p.roots).ne_zero) =
      rationalPolynomialUnit p hp := by
    apply Units.ext
    exact congrArg (algebraMap (Polynomial K) (RatFunc K)) hfactor
  rw [hunit, rational_constant_principal_degree_zero _ hpLC,
    rational_split_product_principal_degree_zero, add_zero] at hprod
  exact hprod

/-- The complete product formula for the actual adic places of K(t),
including infinity, follows without a computation or a supplied formula. -/
theorem rational_product_formula
    {K : Type*} [Field K] [IsAlgClosed K] (f : Additive (RatFunc K)ˣ) :
    rationalPrincipalDegree K f = 0 := by
  obtain ⟨p, q, hq, hpq⟩ := IsFractionRing.div_surjective (A := Polynomial K) f.toMul.val
  have hp : p ≠ 0 := by
    intro hp
    apply f.toMul.ne_zero
    rw [← hpq, hp, map_zero, zero_div]
  have hq' : q ≠ 0 := nonZeroDivisors.ne_zero hq
  have hf : f = Additive.ofMul (rationalPolynomialUnit p hp) -
      Additive.ofMul (rationalPolynomialUnit q hq') := by
    apply Additive.toMul.injective
    rw [toMul_sub]
    apply Units.ext
    simpa using hpq.symm
  rw [hf, map_sub, rational_polynomial_principal_degree_zero,
    rational_polynomial_principal_degree_zero, sub_self]

theorem rational_product_formula_target : RationalProductFormula := by
  intro K instK instClosed f
  exact rational_product_formula f

end Litt3.Jacobians

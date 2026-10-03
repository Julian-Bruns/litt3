import Definitions.Jacobians.RationalLinearPlaces
import Solutions.Jacobians.RationalDivisors

namespace Litt3.Jacobians

open scoped WithZero Classical

theorem rational_linear_place_injective
    {K : Type*} [Field K] : Function.Injective (rationalLinearPlace K) := by
  intro a b hab
  have hideal := congrArg IsDedekindDomain.HeightOneSpectrum.asIdeal hab
  have hdvd : Polynomial.X - Polynomial.C a ∣ Polynomial.X - Polynomial.C b := by
    apply Ideal.mem_span_singleton.mp
    rw [show Ideal.span {Polynomial.X - Polynomial.C a} =
      Ideal.span {Polynomial.X - Polynomial.C b} from hideal]
    exact Ideal.mem_span_singleton_self _
  have heval := Polynomial.eval_eq_zero_of_dvd_of_eval_eq_zero hdvd
    (by simp : Polynomial.eval a (Polynomial.X - Polynomial.C a) = 0)
  simpa only [Polynomial.eval_sub, Polynomial.eval_X, Polynomial.eval_C, sub_eq_zero] using heval

theorem rational_linear_place_value
    {K : Type*} [Field K] (c : K)
    (v : IsDedekindDomain.HeightOneSpectrum (Polynomial K)) :
    v.intValuation (Polynomial.X - Polynomial.C c) =
      if v = rationalLinearPlace K c then WithZero.exp (-1 : ℤ) else 1 := by
  split_ifs with hvc
  · subst v
    exact (rationalLinearPlace K c).intValuation_singleton
      (Polynomial.X_sub_C_ne_zero c) rfl
  · apply IsDedekindDomain.HeightOneSpectrum.intValuation_eq_one_iff.mpr
    intro hc
    have hle : (rationalLinearPlace K c).asIdeal ≤ v.asIdeal :=
      Ideal.span_le.mpr (Set.singleton_subset_iff.mpr hc)
    have hideal := (rationalLinearPlace K c).isPrime.isMaximal
      (rationalLinearPlace K c).ne_bot |>.eq_of_le v.isPrime.ne_top hle
    exact hvc (IsDedekindDomain.HeightOneSpectrum.ext hideal.symm)

theorem rational_linear_principal_divisor
    {K : Type*} [Field K] (c : K) :
    principalDivisorMap (rationalProjectiveValuationDivisorSystem K)
      (Additive.ofMul (rationalPolynomialUnit (Polynomial.X - Polynomial.C c)
        (Polynomial.X_sub_C_ne_zero c))) =
      pointDivisor (some (rationalLinearPlace K c)) - pointDivisor none := by
  ext p
  cases p with
  | none =>
    rw [principal_divisor_coefficient]
    change valuationOrder (rationalInfinityValuation K) (Additive.ofMul
      (rationalPolynomialUnit (Polynomial.X - Polynomial.C c) _)) = _
    rw [rational_infinity_order]
    change -(algebraMap (Polynomial K) (RatFunc K) (Polynomial.X - Polynomial.C c)).intDegree = _
    rw [RatFunc.intDegree_polynomial]
    simp [pointDivisor]
  | some v =>
    rw [principal_divisor_coefficient]
    change valuationOrder (v.valuation (RatFunc K)) (Additive.ofMul
      (rationalPolynomialUnit (Polynomial.X - Polynomial.C c) _)) = _
    by_cases hvc : v = rationalLinearPlace K c
    · subst v
      rw [valuation_order_of_value_exp _ _ (-1) (by
        change (rationalLinearPlace K c).valuation (RatFunc K)
          (algebraMap (Polynomial K) (RatFunc K) (Polynomial.X - Polynomial.C c)) = _
        rw [IsDedekindDomain.HeightOneSpectrum.valuation_of_algebraMap,
          rational_linear_place_value, if_pos rfl])]
      simp [pointDivisor]
    · rw [valuation_order_eq_zero_of_value_one _ _ (by
        change v.valuation (RatFunc K)
          (algebraMap (Polynomial K) (RatFunc K) (Polynomial.X - Polynomial.C c)) = _
        rw [IsDedekindDomain.HeightOneSpectrum.valuation_of_algebraMap,
          rational_linear_place_value, if_neg hvc])]
      simp [pointDivisor, hvc]

end Litt3.Jacobians

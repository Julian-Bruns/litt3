import Definitions.Jacobians.RationalInfinityValuation
import Mathlib.FieldTheory.IsAlgClosed.Basic

namespace Litt3.Jacobians

noncomputable def rationalLinearPlace
    (K : Type*) [Field K] (c : K) : IsDedekindDomain.HeightOneSpectrum (Polynomial K) where
  asIdeal := Ideal.span {Polynomial.X - Polynomial.C c}
  isPrime := (Ideal.span_singleton_prime (Polynomial.X_sub_C_ne_zero c)).mpr
    (Polynomial.irreducible_X_sub_C c).prime
  ne_bot := by
    intro h
    exact Polynomial.X_sub_C_ne_zero c (Ideal.span_singleton_eq_bot.mp h)

noncomputable def rationalPolynomialUnit
    {K : Type*} [Field K] (p : Polynomial K) (hp : p ≠ 0) : (RatFunc K)ˣ :=
  Units.mk0 (algebraMap (Polynomial K) (RatFunc K) p)
    ((map_ne_zero_iff _ (IsFractionRing.injective (Polynomial K) (RatFunc K))).mpr hp)

end Litt3.Jacobians

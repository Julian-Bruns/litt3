import Definitions.Jacobians.DedekindDivisors
import Solutions.Jacobians.ValuationDivisorClasses
import Mathlib.Tactic

namespace Litt3.Jacobians

open scoped WithZero Classical
open IsDedekindDomain

/-- For an actual nonzero element of a Dedekind domain, the principal
divisor coefficient is its prime-ideal factor exponent. The convention
agrees with order one for a local uniformizer. -/
theorem dedekind_principal_divisor_coefficient_of_ring_element
    {R K : Type*} [CommRing R] [IsDedekindDomain R]
    [Field K] [Algebra R K] [IsFractionRing R K]
    (x : R) (hx : x ≠ 0) (v : HeightOneSpectrum R) :
    principalDivisorMap (dedekindValuationDivisorSystem R K)
      (Additive.ofMul (Units.mk0 (algebraMap R K x)
        (by simpa only [map_zero] using (IsFractionRing.injective R K).ne hx))) v =
      ((Associates.mk v.asIdeal).count
        (Associates.mk (Ideal.span {x} : Ideal R)).factors : ℤ) := by
  rw [principal_divisor_coefficient]
  apply Eq.trans (valuation_order_of_value_exp (v.valuation K) _ _ ?_)
  · exact neg_neg _
  · change v.valuation K (algebraMap R K x) = WithZero.exp _
    rw [HeightOneSpectrum.valuation_of_algebraMap,
      HeightOneSpectrum.intValuation_if_neg v hx]

/-- This torsion criterion now uses the actual canonical Dedekind adic
valuations, rather than a supplied abstract principal-divisor map. -/
theorem dedekind_divisor_class_torsion_iff_principal_multiple
    {R K : Type*} [CommRing R] [IsDedekindDomain R]
    [Field K] [Algebra R K] [IsFractionRing R K]
    (D : Divisor (HeightOneSpectrum R)) (n : ℕ) :
    n • divisorClassMap (dedekindValuationDivisorSystem R K) D = 0 ↔
      ∃ f : Additive Kˣ,
        principalDivisorMap (dedekindValuationDivisorSystem R K) f = n • D :=
  divisor_class_torsion_iff_principal_multiple _ D n

end Litt3.Jacobians

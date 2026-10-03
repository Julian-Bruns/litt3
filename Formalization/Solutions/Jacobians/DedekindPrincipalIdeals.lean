import Solutions.Jacobians.DedekindDivisorIdealMaps
import Solutions.Jacobians.DedekindDivisorClasses

open scoped nonZeroDivisors Classical
open IsDedekindDomain

namespace Litt3.Jacobians

variable (R K : Type*) [CommRing R] [IsDedekindDomain R]
  [Field K] [Algebra R K] [IsFractionRing R K]

/-- The genuine normalized adic principal divisor is EXACTLY the actual
prime-count divisor of the literal principal fractional ideal. -/
theorem dedekindIdealDivisorMap_principal (f : Additive Kˣ) :
    dedekindIdealDivisorMap R K (Additive.ofMul (toPrincipalIdeal R K f.toMul)) =
      principalDivisorMap (dedekindValuationDivisorSystem R K) f := by
  obtain ⟨n, d, hnd⟩ := IsLocalization.exists_mk'_eq R⁰ f.toMul.val
  have hn : n ≠ 0 := by
    intro hn
    apply f.toMul.ne_zero
    rw [← hnd, hn, IsFractionRing.mk'_eq_div, map_zero, zero_div]
  have hd : (d : R) ≠ 0 := nonZeroDivisors.coe_ne_zero d
  let un : Kˣ := Units.mk0 (algebraMap R K n)
    (by simpa only [map_zero] using (IsFractionRing.injective R K).ne hn)
  let ud : Kˣ := Units.mk0 (algebraMap R K (d : R))
    (by simpa only [map_zero] using (IsFractionRing.injective R K).ne hd)
  have hf : f = Additive.ofMul un - Additive.ofMul ud := by
    apply Additive.toMul.injective
    apply Units.ext
    change f.toMul.val = algebraMap R K n * (algebraMap R K (d : R))⁻¹
    rw [← hnd, IsFractionRing.mk'_eq_div, div_eq_mul_inv]
  have hI : FractionalIdeal.spanSingleton R⁰ f.toMul.val =
      FractionalIdeal.spanSingleton R⁰ ((algebraMap R K) (d : R))⁻¹ *
        (Ideal.span {n} : Ideal R) := by
    rw [FractionalIdeal.coeIdeal_span_singleton,
      FractionalIdeal.spanSingleton_mul_spanSingleton]
    apply congrArg (FractionalIdeal.spanSingleton R⁰)
    rw [← hnd, IsFractionRing.mk'_eq_div, div_eq_mul_inv, mul_comm]
  ext v
  rw [dedekindIdealDivisorMap_coefficient]
  change FractionalIdeal.count K v (toPrincipalIdeal R K f.toMul).val = _
  rw [coe_toPrincipalIdeal]
  rw [FractionalIdeal.count_well_defined K v
    (FractionalIdeal.spanSingleton_ne_zero_iff.mpr f.toMul.ne_zero) hI]
  rw [hf, map_sub, Finsupp.sub_apply]
  rw [dedekind_principal_divisor_coefficient_of_ring_element n hn v,
    dedekind_principal_divisor_coefficient_of_ring_element (d : R) hd v]

theorem dedekindDivisorIdealMap_principal (f : Additive Kˣ) :
    dedekindDivisorIdealMap R K
      (principalDivisorMap (dedekindValuationDivisorSystem R K) f) =
        Additive.ofMul (toPrincipalIdeal R K f.toMul) := by
  rw [← dedekindIdealDivisorMap_principal]
  exact dedekindDivisorIdealMap_idealDivisor R K _

end Litt3.Jacobians

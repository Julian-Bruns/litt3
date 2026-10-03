import Definitions.Jacobians.DedekindDivisors
import Solutions.Jacobians.ActualClassGroupPicard
import Mathlib.RingTheory.DedekindDomain.Factorization

open scoped nonZeroDivisors Classical
open IsDedekindDomain

namespace Litt3.Jacobians

variable (R K : Type*) [CommRing R] [IsDedekindDomain R]
  [Field K] [Algebra R K] [IsFractionRing R K]

noncomputable def dedekindPrimeFractionalIdealUnit (v : HeightOneSpectrum R) :
    (FractionalIdeal R⁰ K)ˣ :=
  Units.mk0 (v.asIdeal : FractionalIdeal R⁰ K)
    (FractionalIdeal.coeIdeal_ne_zero.mpr v.ne_bot)

/-- Literal finite prime-ideal factorization of an actual affine divisor.
A positive prime divisor maps to its actual prime-ideal module. -/
noncomputable def dedekindDivisorIdealMap :
    Divisor (HeightOneSpectrum R) →+ Additive (FractionalIdeal R⁰ K)ˣ where
  toFun D := Additive.ofMul (D.prod fun v n => dedekindPrimeFractionalIdealUnit R K v ^ n)
  map_zero' := by simp
  map_add' D E := by
    change (D + E).prod (fun v n => dedekindPrimeFractionalIdealUnit R K v ^ n) =
      D.prod (fun v n => dedekindPrimeFractionalIdealUnit R K v ^ n) *
      E.prod (fun v n => dedekindPrimeFractionalIdealUnit R K v ^ n)
    exact Finsupp.prod_add_index' (fun _ => zpow_zero _) (fun _ _ _ => zpow_add _ _ _)

theorem dedekindDivisorIdealMap_value (D : Divisor (HeightOneSpectrum R)) :
    ((dedekindDivisorIdealMap R K D).toMul : FractionalIdeal R⁰ K) =
      D.prod (fun v n => (v.asIdeal : FractionalIdeal R⁰ K) ^ n) := by
  simp [dedekindDivisorIdealMap, Finsupp.prod, dedekindPrimeFractionalIdealUnit,
    ← map_prod (Units.coeHom (FractionalIdeal R⁰ K))]

noncomputable def dedekindIdealDivisorMap :
    Additive (FractionalIdeal R⁰ K)ˣ →+ Divisor (HeightOneSpectrum R) where
  toFun I := Finsupp.ofSupportFinite (fun v => FractionalIdeal.count K v I.toMul.val)
    (by simpa only [Function.support] using
      Filter.eventually_cofinite.mp (FractionalIdeal.finite_factors I.toMul.val))
  map_zero' := by
    ext v
    exact FractionalIdeal.count_one K v
  map_add' I J := by
    ext v
    exact FractionalIdeal.count_mul K v I.toMul.ne_zero J.toMul.ne_zero

theorem dedekindIdealDivisorMap_coefficient
    (I : Additive (FractionalIdeal R⁰ K)ˣ) (v : HeightOneSpectrum R) :
    dedekindIdealDivisorMap R K I v = FractionalIdeal.count K v I.toMul.val := rfl

theorem dedekindIdealDivisorMap_divisorIdeal (D : Divisor (HeightOneSpectrum R)) :
    dedekindIdealDivisorMap R K (dedekindDivisorIdealMap R K D) = D := by
  ext v
  rw [dedekindIdealDivisorMap_coefficient, dedekindDivisorIdealMap_value]
  exact FractionalIdeal.count_finsuppProd K v D

theorem dedekindDivisorIdealMap_idealDivisor
    (I : Additive (FractionalIdeal R⁰ K)ˣ) :
    dedekindDivisorIdealMap R K (dedekindIdealDivisorMap R K I) = I := by
  apply Additive.toMul.injective
  apply Units.ext
  rw [dedekindDivisorIdealMap_value]
  have hfactor := FractionalIdeal.finprod_heightOneSpectrum_factorization' K I.toMul.ne_zero
  rw [← hfactor]
  rw [Finsupp.prod]
  apply (finprod_eq_finset_prod_of_mulSupport_subset
    (fun v : HeightOneSpectrum R => (v.asIdeal : FractionalIdeal R⁰ K) ^
      FractionalIdeal.count K v I.toMul.val) ?_).symm
  intro v hv
  by_contra hnot
  have hz := Finsupp.notMem_support_iff.mp hnot
  change FractionalIdeal.count K v I.toMul.val = 0 at hz
  simp only [Function.mem_mulSupport, hz, zpow_zero, ne_eq, not_true_eq_false] at hv

/-- EVERY genuine affine divisor and EVERY invertible fractional ideal correspond.
Both maps use the actual Dedekind prime ideals and their genuine integer counts. -/
noncomputable def actualDedekindDivisorIdealEquiv :
    Divisor (HeightOneSpectrum R) ≃+ Additive (FractionalIdeal R⁰ K)ˣ where
  toFun := dedekindDivisorIdealMap R K
  invFun := dedekindIdealDivisorMap R K
  left_inv := dedekindIdealDivisorMap_divisorIdeal R K
  right_inv := dedekindDivisorIdealMap_idealDivisor R K
  map_add' := map_add (dedekindDivisorIdealMap R K)

end Litt3.Jacobians

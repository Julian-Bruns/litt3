import Definitions.CartierAndSpin.NewtonSharpness
import Solutions.CartierAndSpin.PrimitiveRootPowerSums
import Solutions.CartierAndSpin.BlockPolynomialCoefficients
import Mathlib.Algebra.CharP.Lemmas

namespace Litt3.CartierAndSpin

open Finset Polynomial Classical

variable {K : Type*} [Field K]

theorem traceOmissionTuple_power_sum (p q m : ℕ) [CharP K p] (zeta t : K)
    (hzeta : IsPrimitiveRoot zeta q) (k : ℕ) :
    finitePowerSum (traceOmissionTuple p q m zeta t) k =
      (if q ∣ k then (q : K) * (t ^ p) ^ k else 0) + (m : K) := by
  have hsum := primitive_root_scaled_power_sum q zeta (t ^ p) hzeta k
  simpa [finitePowerSum, traceOmissionTuple, Fintype.sum_sum_type,
    nsmul_eq_mul, CharP.cast_eq_zero] using congrArg (fun x : K => x + (m : K)) hsum

theorem traceOmissionTuple_reciprocal_power_sum (p q m : ℕ) [CharP K p] (zeta t : K)
    (hzeta : IsPrimitiveRoot zeta q) (k : ℕ) :
    finitePowerSum (fun i => (traceOmissionTuple p q m zeta t i)⁻¹) k =
      (if q ∣ k then (q : K) * ((t⁻¹) ^ p) ^ k else 0) + (m : K) := by
  have hsum := primitive_root_scaled_power_sum q zeta⁻¹ ((t⁻¹) ^ p) hzeta.inv k
  simpa [finitePowerSum, traceOmissionTuple, Fintype.sum_sum_type,
    nsmul_eq_mul, CharP.cast_eq_zero, mul_inv_rev, inv_pow, mul_comm, mul_pow] using
      congrArg (fun x : K => x + (m : K)) hsum

theorem finiteRootPolynomial_constant_characteristic (p : ℕ) [CharP K p] [Fact p.Prime]
    (a : K) :
    finiteRootPolynomial (fun _ : Fin p => a) = X ^ p - C (a ^ p) := by
  simp only [finiteRootPolynomial, prod_const, card_univ, Fintype.card_fin,
    sub_pow_char, ← C_pow]

theorem traceOmissionTuple_root_polynomial (p q m : ℕ) [CharP K p] [Fact p.Prime]
    (hq : 0 < q) (zeta t : K) (hzeta : IsPrimitiveRoot zeta q) :
    finiteRootPolynomial (traceOmissionTuple p q m zeta t) =
      (X ^ q - C ((t ^ p) ^ q)) * (X ^ p - C (((t⁻¹) ^ q) ^ p)) * (X - 1) ^ m := by
  have hfirst := finiteRootPolynomial_primitive_root_orbit q hq zeta (t ^ p) hzeta
  have hsecond := finiteRootPolynomial_constant_characteristic p ((t⁻¹) ^ q)
  simp only [finiteRootPolynomial, traceOmissionTuple, Fintype.prod_sum_type,
    Sum.elim_inl, Sum.elim_inr] at *
  rw [hfirst, hsecond]
  simp only [prod_const, card_univ, Fintype.card_fin, C_1]
  ring

/-- The actual p-th elementary function in this root-orbit counterexample
is the zero-block coefficient up to a sign, so it is integral. -/
theorem traceOmissionTuple_carry_identity (p q m : ℕ) [CharP K p] [Fact p.Prime]
    (hqp : p < q) (hmp : m < p) (zeta t : K) (hzeta : IsPrimitiveRoot zeta q) :
    (-1 : K) ^ p * finiteElementarySymmetric (traceOmissionTuple p q m zeta t) p =
      -((t⁻¹) ^ q) ^ p := by
  let A : K[X] := (X - 1) ^ m
  have hA : A.Monic := (monic_X_sub_C (1 : K)).pow m
  have hdegree : A.natDegree = m := by
    simp only [A, natDegree_pow, ← C_1, natDegree_X_sub_C, mul_one]
  have hcoefficient := two_block_polynomial_carry_coefficient p q m hqp hmp
    ((t ^ p) ^ q) (((t⁻¹) ^ q) ^ p) A hA hdegree
  have hcard : Fintype.card (Fin q ⊕ (Fin p ⊕ Fin m)) = q + p + m := by simp; omega
  have hVieta := finiteRootPolynomial_coeff_of_le (traceOmissionTuple p q m zeta t)
    (q + m) (by rw [hcard]; omega)
  have hindex : Fintype.card (Fin q ⊕ (Fin p ⊕ Fin m)) - (q + m) = p := by
    rw [hcard]
    omega
  rw [hindex, traceOmissionTuple_root_polynomial p q m (by omega) zeta t hzeta] at hVieta
  exact hVieta.symm.trans hcoefficient

end Litt3.CartierAndSpin

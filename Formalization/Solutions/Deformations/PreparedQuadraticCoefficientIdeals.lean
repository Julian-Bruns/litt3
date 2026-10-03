import Solutions.Deformations.PreparedQuadraticConstantOrder
import Solutions.Deformations.QuadraticFrobeniusRedundancy

set_option synthInstance.maxHeartbeats 100000
set_option maxHeartbeats 800000

namespace Litt3.Deformations

variable {A : Type*} [CommRing A]

/-- Actual unit-factor preparation preserves the first coefficient ideal
when the original constant coefficient belongs to a smaller ideal. -/
theorem prepared_polynomial_linear_mem (I J : Ideal A) (included : I ≤ J)
    (g : PowerSeries A) (f : Polynomial A) (h : PowerSeries A) (unit : IsUnit h)
    (equation : g = (f : PowerSeries A) * h)
    (constant : PowerSeries.constantCoeff g ∈ I) (linear : PowerSeries.coeff 1 g ∈ J) :
    f.coeff 1 ∈ J := by
  have preparedConstant := prepared_polynomial_constant_mem I g f h unit equation constant
  obtain ⟨u, value⟩ := PowerSeries.isUnit_iff_constantCoeff.mp unit
  have coefficient : PowerSeries.coeff 1 g =
      f.coeff 1 * (u : A) + PowerSeries.coeff 1 h * f.coeff 0 := by
    rw [equation, PowerSeries.coeff_one_mul, value, Polynomial.coeff_coe]
    rfl
  have product : f.coeff 1 * (u : A) ∈ J := by
    have subtract := J.sub_mem linear
      (J.mul_mem_left (PowerSeries.coeff 1 h) (included preparedConstant))
    simpa only [coefficient, add_sub_cancel_right] using subtract
  have multiplied := J.mul_mem_right ((u⁻¹ : Aˣ) : A) product
  simpa only [mul_assoc, Units.mul_inv, mul_one] using multiplied

variable [Invertible (2 : A)] (p : ℕ) [Fact p.Prime] [CharP A p]

/-- The smaller remainder ideal and larger first-coefficient ideal suffice
for original Frobenius redundancy. Nilpotence is needed only for elements
of the remainder ideal, over an arbitrary commutative coefficient ring. -/
theorem monic_quadratic_coefficient_ideals_frobenius_redundant
    (I J : Ideal A) (square : J ^ 2 ≤ I) (n m : ℕ)
    (exponent : p ^ n = 2 * m + 1) (cutoff : ∀ c ∈ I, c ^ m = 0)
    (f : Polynomial A) (monic : f.Monic) (degree : f.natDegree = 2)
    (linear : f.coeff 1 ∈ J) (constant : f.coeff 0 ∈ I) :
    Ideal.span ({f, Polynomial.X ^ (p ^ n)} : Set (Polynomial A)) =
      Ideal.span ({f} : Set (Polynomial A)) := by
  let a := f.coeff 1
  let b := f.coeff 0
  let t := ⅟(2 : A) * a
  have half : a = 2 * t := by
    dsimp only [t]
    rw [← mul_assoc, mul_invOf_self, one_mul]
  have tMember : t ∈ J := J.mul_mem_left _ linear
  have squareMember : t ^ 2 ∈ I := square (Ideal.pow_mem_pow tMember 2)
  have remainderMember : b - t ^ 2 ∈ I := I.sub_mem constant squareMember
  have remainder : (b - t ^ 2) ^ m = 0 := cutoff _ remainderMember
  have squareZero : (t ^ 2) ^ m = 0 := cutoff _ squareMember
  have translation : t ^ (p ^ n) = 0 := by
    rw [exponent, pow_succ, pow_mul, squareZero, zero_mul]
  rw [monic_degree_two_original_polynomial f monic degree]
  exact quadratic_linear_frobenius_relation_redundant p n m exponent a b t half
    translation remainder

variable [IsLocalRing A] [IsAdicComplete (IsLocalRing.maximalIdeal A) A]

/-- Genuine preparation transfers the two original coefficient ideals
and derives redundancy in the ORIGINAL series quotient. No completed
normal form or rank conclusion is an input. -/
theorem prepared_series_coefficient_ideals_frobenius_redundant
    (I J : Ideal A) (included : I ≤ J) (square : J ^ 2 ≤ I) (n m : ℕ)
    (exponent : p ^ n = 2 * m + 1) (cutoff : ∀ c ∈ I, c ^ m = 0)
    (g : PowerSeries A) (nonzero : g.map (IsLocalRing.residue A) ≠ 0)
    (order : (g.map (IsLocalRing.residue A)).order = 2)
    (constant : PowerSeries.constantCoeff g ∈ I) (linear : PowerSeries.coeff 1 g ∈ J) :
    Ideal.span ({g, PowerSeries.X ^ (p ^ n)} : Set (PowerSeries A)) =
      Ideal.span ({g} : Set (PowerSeries A)) := by
  obtain ⟨f, h, factorization⟩ := g.exists_isWeierstrassFactorization nonzero
  have degree : f.natDegree = 2 := by
    simpa only [order, ENat.toNat_ofNat] using factorization.natDegree_eq_toNat_order_map
  have preparedConstant := prepared_polynomial_constant_mem I g f h
    factorization.isUnit factorization.eq_mul constant
  have preparedLinear := prepared_polynomial_linear_mem I J included g f h
    factorization.isUnit factorization.eq_mul constant linear
  have relation := monic_quadratic_coefficient_ideals_frobenius_redundant p I J square
    n m exponent cutoff f factorization.isDistinguishedAt.monic degree
    preparedLinear preparedConstant
  have polynomialMember : (Polynomial.X : Polynomial A) ^ (p ^ n) ∈
      Ideal.span ({f} : Set (Polynomial A)) := by
    rw [← relation]
    exact Ideal.subset_span (by simp)
  have polynomialZero : Ideal.Quotient.mk (Ideal.span ({f} : Set (Polynomial A)))
      (Polynomial.X ^ (p ^ n)) = 0 := Ideal.Quotient.eq_zero_iff_mem.mpr polynomialMember
  have seriesZero : Ideal.Quotient.mk (Ideal.span ({g} : Set (PowerSeries A)))
      (PowerSeries.X ^ (p ^ n)) = 0 := by
    have mapped := congrArg factorization.algEquivQuotient polynomialZero
    simpa only [PowerSeries.IsWeierstrassFactorizationAt.algEquivQuotient_apply,
      Polynomial.IsDistinguishedAt.algEquivQuotient_apply, Ideal.quotient_map_mkₐ,
      Ideal.Quotient.mkₐ_eq_mk, Polynomial.coeToPowerSeries.algHom_apply,
      Algebra.algebraMap_self, PowerSeries.map_id, Polynomial.coe_pow,
      Polynomial.coe_X, Ideal.quotientEquivAlgOfEq_mk, map_zero] using mapped
  apply Ideal.span_pair_eq_span_left_iff_dvd.mpr
  exact Ideal.mem_span_singleton.mp (Ideal.Quotient.eq_zero_iff_mem.mp seriesZero)

end Litt3.Deformations

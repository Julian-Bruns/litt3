import Solutions.Deformations.QuadraticIdealFrobenius
import Solutions.Deformations.PreparedQuadraticConstantOrder

set_option synthInstance.maxHeartbeats 100000
set_option maxHeartbeats 800000

namespace Litt3.Deformations

variable {A : Type*} [CommRing A] [IsLocalRing A] [Invertible (2 : A)]
  [IsAdicComplete (IsLocalRing.maximalIdeal A) A]
  (p : ℕ) [Fact p.Prime] [CharP A p]

/-- For an arbitrary genuine series with quadratic residue order and
quadratic original constant term, actual Weierstrass preparation and
nilpotent square completion derive redundancy of the original Frobenius
power. No normal-form equation is assumed. -/
theorem prepared_series_quadratic_frobenius_redundant (n m : ℕ)
    (exponent : p ^ n = 2 * m + 1) (cutoff : IsLocalRing.maximalIdeal A ^ (2 * m) = ⊥)
    (g : PowerSeries A) (nonzero : g.map (IsLocalRing.residue A) ≠ 0)
    (order : (g.map (IsLocalRing.residue A)).order = 2)
    (constant : PowerSeries.constantCoeff g ∈ IsLocalRing.maximalIdeal A ^ 2) :
    Ideal.span ({g, PowerSeries.X ^ (p ^ n)} : Set (PowerSeries A)) =
      Ideal.span ({g} : Set (PowerSeries A)) := by
  obtain ⟨f, h, factorization⟩ := g.exists_isWeierstrassFactorization nonzero
  have degree : f.natDegree = 2 := by
    simpa only [order, ENat.toNat_ofNat] using factorization.natDegree_eq_toNat_order_map
  have linear : f.coeff 1 ∈ IsLocalRing.maximalIdeal A :=
    factorization.isDistinguishedAt.mem (by omega)
  have quadraticConstant : f.coeff 0 ∈ IsLocalRing.maximalIdeal A ^ 2 :=
    prepared_polynomial_constant_mem _ g f h factorization.isUnit factorization.eq_mul constant
  have relation := monic_quadratic_ideal_frobenius_redundant p (IsLocalRing.maximalIdeal A)
    n m exponent cutoff f factorization.isDistinguishedAt.monic degree linear quadraticConstant
  have polynomialMember : (Polynomial.X : Polynomial A) ^ (p ^ n) ∈ Ideal.span ({f} : Set (Polynomial A)) := by
    rw [← relation]
    exact Ideal.subset_span (by simp)
  have polynomialZero : Ideal.Quotient.mk (Ideal.span ({f} : Set (Polynomial A)))
      (Polynomial.X ^ (p ^ n)) = 0 := Ideal.Quotient.eq_zero_iff_mem.mpr polynomialMember
  have seriesZero : Ideal.Quotient.mk (Ideal.span ({g} : Set (PowerSeries A)))
      (PowerSeries.X ^ (p ^ n)) = 0 := by
    have mapped := congrArg factorization.algEquivQuotient polynomialZero
    simpa only [PowerSeries.IsWeierstrassFactorizationAt.algEquivQuotient_apply,
      Polynomial.IsDistinguishedAt.algEquivQuotient_apply, Ideal.quotient_map_mkₐ,
      Ideal.Quotient.mkₐ_eq_mk,
      Polynomial.coeToPowerSeries.algHom_apply, Algebra.algebraMap_self, PowerSeries.map_id,
      Polynomial.coe_pow, Polynomial.coe_X, Ideal.quotientEquivAlgOfEq_mk, map_zero] using mapped
  apply Ideal.span_pair_eq_span_left_iff_dvd.mpr
  exact Ideal.mem_span_singleton.mp (Ideal.Quotient.eq_zero_iff_mem.mp seriesZero)

end Litt3.Deformations

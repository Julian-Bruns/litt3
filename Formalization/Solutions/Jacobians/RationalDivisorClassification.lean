import Theorems.Jacobians.RationalDivisorClassification
import Solutions.Jacobians.RationalProductFormula
import Solutions.Jacobians.RationalPlaceClassification

namespace Litt3.Jacobians

open scoped Classical

theorem rational_point_divisor_class_eq_infinity
    {K : Type*} [Field K] [IsAlgClosed K] (p : RationalProjectivePlaces K) :
    divisorClassMap (rationalProjectiveValuationDivisorSystem K) (pointDivisor p) =
      divisorClassMap (rationalProjectiveValuationDivisorSystem K) (pointDivisor none) := by
  cases p with
  | none => rfl
  | some v =>
    obtain ⟨c, rfl⟩ := rational_linear_place_surjective (K := K) v
    apply sub_eq_zero.mp
    rw [← map_sub]
    apply (divisor_class_zero_iff_principal _ _).mpr
    exact ⟨Additive.ofMul (rationalPolynomialUnit (Polynomial.X - Polynomial.C c)
      (Polynomial.X_sub_C_ne_zero c)), rational_linear_principal_divisor c⟩

theorem integer_single_eq_zsmul_point
    {P : Type*} (p : P) (n : ℤ) : Finsupp.single p n = n • pointDivisor p := by
  ext q
  by_cases hq : q = p
  · subst q
    simp [pointDivisor]
  · simp [pointDivisor, hq]

/-- The class of every actual rational-function divisor is its degree
times the class of the point at infinity. -/
theorem rational_divisor_class_eq_degree_infinity
    {K : Type*} [Field K] [IsAlgClosed K] (D : Divisor (RationalProjectivePlaces K)) :
    divisorClassMap (rationalProjectiveValuationDivisorSystem K) D =
      divisorDegree D • divisorClassMap (rationalProjectiveValuationDivisorSystem K)
        (pointDivisor none) := by
  induction D using Finsupp.induction_linear with
  | zero => simp
  | add D E hD hE =>
    rw [map_add, hD, hE, map_add, add_zsmul]
  | single p n =>
    rw [integer_single_eq_zsmul_point, map_zsmul, rational_point_divisor_class_eq_infinity,
      map_zsmul, point_divisor_degree]
    simp

theorem rational_divisor_degree_zero_iff_principal
    {K : Type*} [Field K] [IsAlgClosed K] (D : Divisor (RationalProjectivePlaces K)) :
    divisorDegree D = 0 ↔ ∃ f : Additive (RatFunc K)ˣ,
      principalDivisorMap (rationalProjectiveValuationDivisorSystem K) f = D := by
  constructor
  · intro hdegree
    apply (divisor_class_zero_iff_principal _ D).mp
    rw [rational_divisor_class_eq_degree_infinity, hdegree, zero_zsmul]
  · rintro ⟨f, rfl⟩
    exact rational_product_formula f

theorem rational_degree_zero_divisors_principal_target : RationalDegreeZeroDivisorsPrincipal := by
  intro K instK instClosed D
  exact rational_divisor_degree_zero_iff_principal D

theorem rational_principal_divisors_eq_degree_kernel
    {K : Type*} [Field K] [IsAlgClosed K] :
    principalDivisors (rationalProjectiveValuationDivisorSystem K) =
      (divisorDegree : Divisor (RationalProjectivePlaces K) →+ ℤ).ker := by
  ext D
  simp only [principalDivisors, AddMonoidHom.mem_range, AddMonoidHom.mem_ker]
  exact (rational_divisor_degree_zero_iff_principal D).symm

theorem divisor_degree_surjective
    {P : Type*} (p : P) : Function.Surjective (divisorDegree : Divisor P →+ ℤ) := by
  intro n
  exact ⟨n • pointDivisor p, by simp⟩

/-- The genuine full rational divisor-class quotient is the integers,
through degree. The identification with the Scheme Picard group remains
a separate geometric construction. -/
noncomputable def rationalDivisorClassDegreeEquiv
    (K : Type*) [Field K] [IsAlgClosed K] :
    DivisorClassGroup (rationalProjectiveValuationDivisorSystem K) ≃+ ℤ :=
  (QuotientAddGroup.quotientAddEquivOfEq rational_principal_divisors_eq_degree_kernel).trans
    (QuotientAddGroup.quotientKerEquivOfSurjective divisorDegree
      (divisor_degree_surjective (none : RationalProjectivePlaces K)))

theorem rational_divisor_class_degree_representative
    {K : Type*} [Field K] [IsAlgClosed K] (D : Divisor (RationalProjectivePlaces K)) :
    rationalDivisorClassDegreeEquiv K
      (divisorClassMap (rationalProjectiveValuationDivisorSystem K) D) = divisorDegree D := rfl

end Litt3.Jacobians

import Theorems.Jacobians.RationalDivisors
import Solutions.Jacobians.DedekindDivisorClasses

namespace Litt3.Jacobians

theorem rational_principal_divisor_at_infinity
    {K : Type*} [Field K] (r : (RatFunc K)ˣ) :
    principalDivisorMap (rationalProjectiveValuationDivisorSystem K) (Additive.ofMul r) none =
      ((r.val.denom.natDegree : ℤ) - (r.val.num.natDegree : ℤ)) := by
  rw [principal_divisor_coefficient]
  change valuationOrder (rationalInfinityValuation K) (Additive.ofMul r) = _
  rw [rational_infinity_order, RatFunc.intDegree]
  exact neg_sub _ _

theorem rational_principal_divisor_infinity_order_target :
    Targets.RationalPrincipalDivisorInfinityOrder := by
  intro K instK r
  exact rational_principal_divisor_at_infinity r

theorem rational_projective_divisor_class_torsion_iff_principal_multiple
    {K : Type*} [Field K] (D : Divisor (RationalProjectivePlaces K)) (n : ℕ) :
    n • divisorClassMap (rationalProjectiveValuationDivisorSystem K) D = 0 ↔
      ∃ f : Additive (RatFunc K)ˣ,
        principalDivisorMap (rationalProjectiveValuationDivisorSystem K) f = n • D :=
  divisor_class_torsion_iff_principal_multiple _ D n

end Litt3.Jacobians

import Solutions.Jacobians.DivisorSheafRationalMultiplication
import Solutions.SharedTensors.DivisorSectionOrders
import Solutions.Jacobians.ValuationDivisorClasses

open CategoryTheory AlgebraicGeometry
open scoped WithZero

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u}) [IsIntegral X] [ClosedPointDVRStalks X] [FinitePrincipalSupport X]

/-- The actual normalized principal-divisor coefficient gives the
literal original field-unit valuation, with its exact sign convention. -/
theorem actual_principal_divisor_valuation_exp
    (f : X.functionFieldˣ) (x : Litt3.SharedTensors.ClosedPoint X) :
    closedPointValuation X x f.val = WithZero.exp
      (-principalDivisorMap (schemeDivisorSystem X) (Additive.ofMul f) x) := by
  rw [principal_divisor_coefficient]
  exact Litt3.SharedTensors.valuation_value_eq_exp_neg_order (closedPointValuation X x)
    (Additive.ofMul f)

/-- Multiplication by the actual rational function lowers the O(D)
bound by its actual normalized principal divisor. -/
theorem actual_principal_divisor_sheaf_bound
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X))
    (f : X.functionFieldˣ) (x : Litt3.SharedTensors.ClosedPoint X) :
    closedPointValuation X x f.val * WithZero.exp (D x) =
      WithZero.exp ((D - principalDivisorMap (schemeDivisorSystem X) (Additive.ofMul f)) x) := by
  rw [actual_principal_divisor_valuation_exp, Finsupp.sub_apply, ← WithZero.exp_add]
  congr 1
  omega

/-- The inverse actual rational function restores the same original
divisor bound, with no residue or completion input. -/
theorem actual_principal_divisor_inverse_sheaf_bound
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X))
    (f : X.functionFieldˣ) (x : Litt3.SharedTensors.ClosedPoint X) :
    closedPointValuation X x f⁻¹.val *
        WithZero.exp ((D - principalDivisorMap (schemeDivisorSystem X) (Additive.ofMul f)) x) =
      WithZero.exp (D x) := by
  rw [Units.val_inv_eq_inv_val, map_inv₀, actual_principal_divisor_valuation_exp,
    ← WithZero.exp_neg, neg_neg, Finsupp.sub_apply, ← WithZero.exp_add]
  congr 1
  omega

end Litt3.Jacobians

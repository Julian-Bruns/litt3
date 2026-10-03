import Solutions.Jacobians.PrincipalDivisorSheafValuations

open CategoryTheory Opposite AlgebraicGeometry
open scoped WithZero

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u}) [IsIntegral X] [ClosedPointDVRStalks X] [FinitePrincipalSupport X]

/-- The genuine global divisor SHEAF shift by an actual principal
divisor, induced by literal multiplication by the ORIGINAL field unit.
The inverse is literal multiplication by the inverse ORIGINAL field unit. -/
noncomputable def actualPrincipalDivisorSheafShiftIso
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X)) (f : X.functionFieldˣ) :
    actualSchemeDivisorSheaf X D ≅
      actualSchemeDivisorSheaf X
        (D - principalDivisorMap (schemeDivisorSystem X) (Additive.ofMul f)) where
  hom := actualDivisorSheafRationalMultiply X D
    (D - principalDivisorMap (schemeDivisorSystem X) (Additive.ofMul f)) f.val
    (fun x => le_of_eq (actual_principal_divisor_sheaf_bound X D f x))
  inv := actualDivisorSheafRationalMultiply X
    (D - principalDivisorMap (schemeDivisorSystem X) (Additive.ofMul f)) D f⁻¹.val
    (fun x => le_of_eq (actual_principal_divisor_inverse_sheaf_bound X D f x))
  hom_inv_id := by
    apply SheafOfModules.hom_ext
    apply PresheafOfModules.hom_ext
    intro U
    apply ModuleCat.hom_ext
    apply DFunLike.ext
    intro a
    apply Subtype.ext
    change actualRationalFunctionScalar X f⁻¹.val U *
        (actualRationalFunctionScalar X f.val U *
          (show (actualSchemeRationalFunctionRingSheaf X).val.obj U from a.val)) = a.val
    rw [← mul_assoc, ← actualRationalFunctionScalar_mul, Units.inv_mul,
      actualRationalFunctionScalar_one, one_mul]
  inv_hom_id := by
    apply SheafOfModules.hom_ext
    apply PresheafOfModules.hom_ext
    intro U
    apply ModuleCat.hom_ext
    apply DFunLike.ext
    intro a
    apply Subtype.ext
    change actualRationalFunctionScalar X f.val U *
        (actualRationalFunctionScalar X f⁻¹.val U *
          (show (actualSchemeRationalFunctionRingSheaf X).val.obj U from a.val)) = a.val
    rw [← mul_assoc, ← actualRationalFunctionScalar_mul, Units.mul_inv,
      actualRationalFunctionScalar_one, one_mul]

end Litt3.Jacobians

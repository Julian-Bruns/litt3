import Solutions.Jacobians.SchemeDivisorSheaves
import Solutions.Jacobians.RationalFunctionSheafScalarAlgebra

open CategoryTheory Opposite AlgebraicGeometry
open scoped WithZero

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u}) [IsIntegral X] [ClosedPointDVRStalks X]

/-- A literal rational multiplier satisfying the true normalized
valuation bounds gives an actual morphism of the original divisor SHEAVES.
The hypothesis is a scalar valuation inequality, not a sheaf map or section
lifting assumption. Principal-divisor shifts derive it separately. -/
noncomputable def actualDivisorSheafRationalMultiply
    (D E : Divisor (Litt3.SharedTensors.ClosedPoint X)) (f : X.functionField)
    (hbound : ∀ x : Litt3.SharedTensors.ClosedPoint X,
      closedPointValuation X x f * WithZero.exp (D x) ≤ WithZero.exp (E x)) :
    actualSchemeDivisorSheaf X D ⟶ actualSchemeDivisorSheaf X E where
  val :=
    { app := fun U => ModuleCat.ofHom
        (X := (actualSchemeDivisorSheaf X D).val.obj U)
        (Y := (actualSchemeDivisorSheaf X E).val.obj U)
        { toFun := fun a => ⟨(actualRationalFunctionSheafMultiply X f).val.app U a.val, by
            intro x hx
            change closedPointValuation X x
              (actualRationalFunctionEvaluation X U.unop x.val hx
                (actualRationalFunctionScalar X f U *
                  (show (actualSchemeRationalFunctionRingSheaf X).val.obj U from a.val))) ≤ _
            rw [map_mul, actualRationalFunctionScalar_evaluation, map_mul]
            calc
              closedPointValuation X x f * closedPointValuation X x
                  (actualRationalFunctionEvaluation X U.unop x.val hx a.val) ≤
                closedPointValuation X x f * WithZero.exp (D x) :=
                mul_le_mul_left' (a.property x hx) _
              _ ≤ WithZero.exp (E x) := hbound x⟩
          map_add' := fun a b => Subtype.ext
            (((actualRationalFunctionSheafMultiply X f).val.app U).hom.map_add a.val b.val)
          map_smul' := fun r a => Subtype.ext
            (((actualRationalFunctionSheafMultiply X f).val.app U).hom.map_smul r a.val) }
      naturality := fun {U V} i => by
        apply ModuleCat.hom_ext
        apply DFunLike.ext
        intro a
        apply Subtype.ext
        exact CategoryTheory.congr_fun
          ((actualRationalFunctionSheafMultiply X f).val.naturality i) a.val }

end Litt3.Jacobians

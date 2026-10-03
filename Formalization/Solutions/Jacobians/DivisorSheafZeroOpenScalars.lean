import Solutions.Jacobians.DivisorSheafZeroOpenGenerators

open CategoryTheory Opposite AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  (X : Scheme.{u}) [IsIntegral X] [ClosedPointDVRStalks X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
  (D E : Divisor (Litt3.SharedTensors.ClosedPoint X)) (U : X.Opens)
  (hD : ∀ x : Litt3.SharedTensors.ClosedPoint X, x.val ∈ U → D x = 0)

include sX in
/-- On an ORIGINAL zero-coefficient open, ANY true divisor-sheaf
morphism acts on the ENTIRE actual original section space by multiplication
by the rational value of its image of the canonical original unit. No
surrogate vector-space map or scalar-action hypothesis is supplied. -/
theorem actualDivisorSheafHom_zero_open_scalar
    (h : actualSchemeDivisorSheaf X D ⟶ actualSchemeDivisorSheaf X E)
    (a : (actualSchemeDivisorSheaf X D).val.obj (op U)) (x : X) (hx : x ∈ U) :
    actualRationalFunctionEvaluation X U x hx ((h.val.app (op U)) a).val =
      actualRationalFunctionEvaluation X U x hx
        ((h.val.app (op U)) (actualDivisorSheafZeroOpenUnitSection X D U hD)).val *
      actualRationalFunctionEvaluation X U x hx a.val := by
  letI : Nonempty U := ⟨⟨x, hx⟩⟩
  obtain ⟨r, rfl⟩ := actualDivisorSheafZeroOpenUnitSection_generates X D U hD sX a
  rw [map_smul]
  change actualRationalFunctionEvaluation X U x hx
      (r • ((h.val.app (op U)) (actualDivisorSheafZeroOpenUnitSection X D U hD)).val) =
    actualRationalFunctionEvaluation X U x hx
      ((h.val.app (op U)) (actualDivisorSheafZeroOpenUnitSection X D U hD)).val *
    actualRationalFunctionEvaluation X U x hx
      (r • (actualDivisorSheafZeroOpenUnitSection X D U hD).val)
  rw [actualRationalFunctionEvaluation_smul, actualRationalFunctionEvaluation_smul,
    actualDivisorSheafZeroOpenUnitSection_value, mul_one, mul_comm]

/-- The canonical rational unit section on a nonempty original
zero-coefficient open is genuinely nonzero. -/
theorem actualDivisorSheafZeroOpenUnitSection_ne_zero (x : X) (hx : x ∈ U) :
    actualDivisorSheafZeroOpenUnitSection X D U hD ≠ 0 := by
  intro hz
  have h := congrArg (fun a : (actualSchemeDivisorSheaf X D).val.obj (op U) =>
    actualRationalFunctionEvaluation X U x hx a.val) hz
  change actualRationalFunctionEvaluation X U x hx
    (actualDivisorSheafZeroOpenUnitSection X D U hD).val =
      actualRationalFunctionEvaluation X U x hx 0 at h
  rw [actualDivisorSheafZeroOpenUnitSection_value, map_zero] at h
  exact one_ne_zero h

end Litt3.Jacobians

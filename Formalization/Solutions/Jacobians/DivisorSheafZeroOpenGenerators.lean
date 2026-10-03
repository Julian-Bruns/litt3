import Solutions.Jacobians.SmoothCurveDivisorSheaves

open CategoryTheory Opposite AlgebraicGeometry
open scoped WithZero

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u}) [IsIntegral X] [ClosedPointDVRStalks X]
  (D : Divisor (Litt3.SharedTensors.ClosedPoint X)) (U : X.Opens)
  (hD : ∀ x : Litt3.SharedTensors.ClosedPoint X, x.val ∈ U → D x = 0)

/-- The ORIGINAL rational unit section on an actual open where the
actual divisor vanishes. This includes the true empty-open convention. -/
noncomputable def actualDivisorSheafZeroOpenUnitSection :
    (actualSchemeDivisorSheaf X D).val.obj (op U) :=
  ⟨(1 : (actualSchemeRationalFunctionRingSheaf X).val.obj (op U)), by
    intro x hx
    change closedPointValuation X x
      (actualRationalFunctionEvaluation X U x.val hx 1) ≤ WithZero.exp (D x)
    rw [map_one, Valuation.map_one, hD x hx, WithZero.exp_zero]⟩

@[simp] theorem actualDivisorSheafZeroOpenUnitSection_value
    (x : X) (hx : x ∈ U) :
    actualRationalFunctionEvaluation X U x hx
      (actualDivisorSheafZeroOpenUnitSection X D U hD).val = 1 :=
  map_one _

/-- The actual unit section restricts as the actual unit section on
every smaller original open, without a chosen trivialization. -/
theorem actualDivisorSheafZeroOpenUnitSection_restriction
    {V : X.Opens} (i : V ⟶ U) :
    (actualSchemeDivisorSheaf X D).val.map i.op
      (actualDivisorSheafZeroOpenUnitSection X D U hD) =
    actualDivisorSheafZeroOpenUnitSection X D V (fun x hx => hD x (i.le hx)) := by
  apply Subtype.ext
  change ((actualSchemeRationalFunctionRingSheaf X).val.map i.op).hom 1 = 1
  exact map_one _

variable {k : Type u} [Field k] [IsAlgClosed k]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]

include sX in
/-- On ANY original open where D vanishes, every ACTUAL divisor
section is an ORIGINAL regular function times the actual rational unit.
Regularity and section-surjectivity are derived from the original curve. -/
theorem actualDivisorSheafZeroOpenUnitSection_generates
    (a : (actualSchemeDivisorSheaf X D).val.obj (op U)) :
    ∃ r : Γ(X, U), a = r • actualDivisorSheafZeroOpenUnitSection X D U hD := by
  let a0 : (actualSchemeDivisorSheaf X 0).val.obj (op U) :=
    ⟨a.val, by
      intro x hx
      have ha := a.property x hx
      simpa only [hD x hx, Finsupp.zero_apply] using ha⟩
  obtain ⟨r, hr⟩ := (actualStructureToZeroDivisorSheaf_app_bijective sX (op U)).2 a0
  refine ⟨r, ?_⟩
  apply Subtype.ext
  have hv := congrArg Subtype.val hr
  change (actualSchemeStructureToRationalFunctions X).val.app (op U) r = a.val at hv
  rw [← hv]
  change (actualSchemeStructureToRationalFunctions X).val.app (op U) r =
    (actualSchemeStructureToRationalFunctions X).val.app (op U) r *
      (1 : (actualSchemeRationalFunctionRingSheaf X).val.obj (op U))
  exact (mul_one _).symm

end Litt3.Jacobians

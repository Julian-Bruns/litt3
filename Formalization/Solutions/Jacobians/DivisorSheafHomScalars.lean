import Solutions.Jacobians.DivisorSheafZeroOpenScalars
import Solutions.Jacobians.RationalFunctionOpenValues
import Solutions.Jacobians.DivisorSupportOpens

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u}) [IsIntegral X] [ClosedPointDVRStalks X]
  (D E : Divisor (Litt3.SharedTensors.ClosedPoint X))

/-- Naturality of the ACTUAL sheaf map makes its actual unit-image
rational value identical on every original nonempty smaller open. -/
theorem actualDivisorSheafHomUnitValue_restriction
    (U : X.Opens) [Nonempty U]
    (hD : ∀ x : Litt3.SharedTensors.ClosedPoint X, x.val ∈ U → D x = 0)
    (h : actualSchemeDivisorSheaf X D ⟶ actualSchemeDivisorSheaf X E)
    {V : X.Opens} [Nonempty V] (i : V ⟶ U) :
    (actualSchemeRationalFunctionOpenIso X V).hom.hom
      ((h.val.app (op V))
        (actualDivisorSheafZeroOpenUnitSection X D V (fun x hx => hD x (i.le hx)))).val =
    (actualSchemeRationalFunctionOpenIso X U).hom.hom
      ((h.val.app (op U)) (actualDivisorSheafZeroOpenUnitSection X D U hD)).val := by
  have hn := CategoryTheory.congr_fun (h.val.naturality i.op)
    (actualDivisorSheafZeroOpenUnitSection X D U hD)
  change (h.val.app (op V))
      ((actualSchemeDivisorSheaf X D).val.map i.op
        (actualDivisorSheafZeroOpenUnitSection X D U hD)) =
    (actualSchemeDivisorSheaf X E).val.map i.op
      ((h.val.app (op U)) (actualDivisorSheafZeroOpenUnitSection X D U hD)) at hn
  rw [actualDivisorSheafZeroOpenUnitSection_restriction] at hn
  have hv := congrArg
    (fun a : (actualSchemeDivisorSheaf X E).val.obj (op V) =>
      (actualSchemeRationalFunctionOpenIso X V).hom.hom a.val) hn
  dsimp only at hv
  rw [actualDivisorSheafSectionValue_restriction] at hv
  exact hv

/-- The single ORIGINAL rational scalar determined by an ACTUAL
global divisor-sheaf morphism, using the derived actual support-complement
open and its canonical rational unit. -/
noncomputable def actualDivisorSheafHomScalar
    (h : actualSchemeDivisorSheaf X D ⟶ actualSchemeDivisorSheaf X E) : X.functionField := by
  let W := actualDivisorSupportComplement X D
  letI : Nonempty W := ⟨⟨genericPoint X, actualDivisorSupportComplement_generic X D⟩⟩
  exact (actualSchemeRationalFunctionOpenIso X W).hom.hom
    ((h.val.app (op W)) (actualDivisorSheafZeroOpenUnitSection X D W
      (actualDivisorSupportComplement_coefficient X D))).val

variable {k : Type u} [Field k] [IsAlgClosed k]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]

include sX in
/-- EVERY genuine divisor-sheaf morphism on an actual smooth curve
acts by ONE ORIGINAL rational scalar on the ENTIRE section space of
EVERY nonempty original open. The original restriction squares and full
field values are proved, rather than supplied as compatibility data. -/
theorem actualDivisorSheafHomScalar_on_open
    (h : actualSchemeDivisorSheaf X D ⟶ actualSchemeDivisorSheaf X E)
    (U : X.Opens) [Nonempty U]
    (a : (actualSchemeDivisorSheaf X D).val.obj (op U)) :
    (actualSchemeRationalFunctionOpenIso X U).hom.hom ((h.val.app (op U)) a).val =
      actualDivisorSheafHomScalar X D E h *
        (actualSchemeRationalFunctionOpenIso X U).hom.hom a.val := by
  let W := actualDivisorSupportComplement X D
  have hgW : genericPoint X ∈ W := actualDivisorSupportComplement_generic X D
  letI : Nonempty W := ⟨⟨genericPoint X, hgW⟩⟩
  have hgU : genericPoint X ∈ U :=
    ((genericPoint_spec X).mem_open_set_iff U.isOpen).mpr
      (by simpa using (inferInstance : Nonempty U))
  let V := U ⊓ W
  have hgV : genericPoint X ∈ V := ⟨hgU, hgW⟩
  letI : Nonempty V := ⟨⟨genericPoint X, hgV⟩⟩
  let i : V ⟶ U := homOfLE inf_le_left
  let j : V ⟶ W := homOfLE inf_le_right
  let hDW := actualDivisorSupportComplement_coefficient X D
  let hDV : ∀ x : Litt3.SharedTensors.ClosedPoint X, x.val ∈ V → D x = 0 :=
    fun x hx => hDW x (j.le hx)
  have hs := actualDivisorSheafHom_zero_open_scalar X sX D E V hDV h
    ((actualSchemeDivisorSheaf X D).val.map i.op a) (genericPoint X) hgV
  simp only [actualRationalFunctionEvaluation_eq_open] at hs
  rw [actualDivisorSheafHomUnitValue_restriction X D E W hDW h j,
    actualDivisorSheafSectionValue_restriction] at hs
  have hn := CategoryTheory.congr_fun (h.val.naturality i.op) a
  change (h.val.app (op V)) ((actualSchemeDivisorSheaf X D).val.map i.op a) =
    (actualSchemeDivisorSheaf X E).val.map i.op ((h.val.app (op U)) a) at hn
  have hv := congrArg
    (fun b : (actualSchemeDivisorSheaf X E).val.obj (op V) =>
      (actualSchemeRationalFunctionOpenIso X V).hom.hom b.val) hn
  dsimp only at hv
  rw [actualDivisorSheafSectionValue_restriction] at hv
  rw [hv] at hs
  exact hs

end Litt3.Jacobians

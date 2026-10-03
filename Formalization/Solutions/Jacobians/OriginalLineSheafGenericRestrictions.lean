import Solutions.Jacobians.OriginalLineSheafGenericValues

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u}) [IsIntegral X] (M : X.Modules)
  (hM : ActualOriginalLineSheaf X M)

/-- The constructed ORIGINAL rational values commute with EVERY
original restriction between nonempty opens. The full original generic
field is identical on both sides; no compatibility datum is supplied. -/
theorem actualOriginalLineSheafGenericValue_restriction
    {U V : X.Opens} [Nonempty U] [Nonempty V]
    (i : V ⟶ U) (a : M.val.obj (op U)) :
    actualOriginalLineSheafGenericValue X M hM V (M.val.map i.op a) =
      actualOriginalLineSheafGenericValue X M hM U a := by
  let W := actualOriginalLineSheafGenericOpen X M hM
  let U0 := U ⊓ W
  let V0 := V ⊓ W
  letI : Nonempty U0 := actualOriginalLineSheafGenericIntersection_nonempty X M hM U
  letI : Nonempty V0 := actualOriginalLineSheafGenericIntersection_nonempty X M hM V
  let e := actualOriginalLineSheafGenericFrame X M hM
  let iU0U : U0 ⟶ U := homOfLE inf_le_left
  let iU0W : U0 ⟶ W := homOfLE inf_le_right
  let iV0V : V0 ⟶ V := homOfLE inf_le_left
  let iV0W : V0 ⟶ W := homOfLE inf_le_right
  let j : V0 ⟶ U0 := homOfLE (inf_le_inf i.le le_rfl)
  let EU := actualOriginalLineFrameSectionEquiv X M W e U0 iU0W
  let EV := actualOriginalLineFrameSectionEquiv X M W e V0 iV0W
  have hcomp : M.val.map iV0V.op (M.val.map i.op a) =
      M.val.map j.op (M.val.map iU0U.op a) := by
    change M.val.presheaf.map iV0V.op (M.val.presheaf.map i.op a) =
      M.val.presheaf.map j.op (M.val.presheaf.map iU0U.op a)
    simp only [← ConcreteCategory.comp_apply, ← M.val.presheaf.map_comp]
    rfl
  change algebraMap Γ(X, V0) X.functionField (EV (M.val.map iV0V.op (M.val.map i.op a))) =
    algebraMap Γ(X, U0) X.functionField (EU (M.val.map iU0U.op a))
  rw [hcomp, actualOriginalLineFrameSectionEquiv_restriction]
  exact RingHom.congr_fun
    (Litt3.SharedTensors.actual_section_restriction_function_field
      (X := X) (U := U0) (V := V0) j.le) _

end Litt3.Jacobians

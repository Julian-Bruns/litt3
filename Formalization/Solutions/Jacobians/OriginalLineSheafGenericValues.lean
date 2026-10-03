import Solutions.Jacobians.OriginalLineSheafRestrictionInjectivity
import Solutions.SharedTensors.IntegralSchemeGlobalFunctions

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u}) [IsIntegral X] (M : X.Modules)
  (hM : ActualOriginalLineSheaf X M)

/-- The generic neighborhood is chosen from ACTUAL local freeness,
rather than supplied as a rational frame or divisor presentation. -/
noncomputable def actualOriginalLineSheafGenericOpen : X.Opens :=
  Classical.choose (hM (genericPoint X))

theorem actualOriginalLineSheafGenericOpen_contains_generic :
    genericPoint X ∈ actualOriginalLineSheafGenericOpen X M hM :=
  (Classical.choose_spec (hM (genericPoint X))).1

noncomputable def actualOriginalLineSheafGenericFrame :
    M.over (actualOriginalLineSheafGenericOpen X M hM) ≅
      (SheafOfModules.unit X.ringCatSheaf).over
        (actualOriginalLineSheafGenericOpen X M hM) :=
  Classical.choice (Classical.choose_spec (hM (genericPoint X))).2

theorem actualOriginalLineSheafGenericIntersection_nonempty
    (U : X.Opens) [Nonempty U] :
    Nonempty (U ⊓ actualOriginalLineSheafGenericOpen X M hM : X.Opens) := by
  have hg : genericPoint X ∈ U :=
    ((genericPoint_spec X).mem_open_set_iff U.isOpen).mpr
      (by simpa using (inferInstance : Nonempty U))
  exact ⟨⟨genericPoint X, hg, actualOriginalLineSheafGenericOpen_contains_generic X M hM⟩⟩

/-- The ENTIRE original line-sheaf section module on EVERY nonempty
original open maps linearly to the ORIGINAL generic-stalk field. Its
scalar action is proved from actual original restriction/germ squares. -/
noncomputable def actualOriginalLineSheafGenericValue
    (U : X.Opens) [Nonempty U] :
    M.val.obj (op U) →ₗ[Γ(X, U)] X.functionField := by
  let W := actualOriginalLineSheafGenericOpen X M hM
  let V := U ⊓ W
  letI : Nonempty V := actualOriginalLineSheafGenericIntersection_nonempty X M hM U
  let e := actualOriginalLineSheafGenericFrame X M hM
  let iVU : V ⟶ U := homOfLE inf_le_left
  let iVW : V ⟶ W := homOfLE inf_le_right
  let E := actualOriginalLineFrameSectionEquiv X M W e V iVW
  refine
    { toFun := fun a => algebraMap Γ(X, V) X.functionField (E (M.val.map iVU.op a))
      map_add' := ?_
      map_smul' := ?_ }
  · intro a b
    rw [map_add, map_add, map_add]
  · intro r a
    rw [M.val.map_smul, E.map_smul, smul_eq_mul, map_mul]
    have hr := RingHom.congr_fun
      (Litt3.SharedTensors.actual_section_restriction_function_field
        (X := X) (U := U) (V := V) iVU.le) r
    change algebraMap Γ(X, V) X.functionField ((X.presheaf.map iVU.op) r) =
      algebraMap Γ(X, U) X.functionField r at hr
    change algebraMap Γ(X, V) X.functionField ((X.presheaf.map iVU.op) r) * _ =
      algebraMap Γ(X, U) X.functionField r * _
    rw [hr]

/-- The genuine rational value map is injective on the ENTIRE
original section module of EVERY nonempty original open. No torsion-free
or supplied generic-embedding hypothesis is assumed. -/
theorem actualOriginalLineSheafGenericValue_injective
    (U : X.Opens) [Nonempty U] :
    Function.Injective (actualOriginalLineSheafGenericValue X M hM U) := by
  let W := actualOriginalLineSheafGenericOpen X M hM
  let V := U ⊓ W
  letI : Nonempty V := actualOriginalLineSheafGenericIntersection_nonempty X M hM U
  let e := actualOriginalLineSheafGenericFrame X M hM
  let iVU : V ⟶ U := homOfLE inf_le_left
  let iVW : V ⟶ W := homOfLE inf_le_right
  let E := actualOriginalLineFrameSectionEquiv X M W e V iVW
  change Function.Injective
    (fun a => algebraMap Γ(X, V) X.functionField (E (M.val.map iVU.op a)))
  exact (X.germToFunctionField_injective V).comp
    (E.injective.comp (actualOriginalLineSheaf_restriction_injective X M hM iVU))

end Litt3.Jacobians

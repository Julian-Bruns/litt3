import Solutions.SharedTensors.IntegralSchemeGlobalFunctions

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.Jacobians

universe u
variable {X : Scheme.{u}} [IsIntegral X]

/-- On ANY nonempty original open of ANY integral Scheme, rational
functions are genuine structure-sheaf sections precisely when they belong
to every ORIGINAL stalk on that open. This uses genuine original sheaf
gluing, without identifying a restricted scheme's function field. -/
theorem actual_function_field_regular_on_open_iff_section
    (U : X.Opens) [Nonempty U] (f : X.functionField) :
    (∀ x : U, ∃ r : X.presheaf.stalk x.val,
      algebraMap (X.presheaf.stalk x.val) X.functionField r = f) ↔
      ∃ a : Γ(X, U), algebraMap Γ(X, U) X.functionField a = f := by
  classical
  constructor
  · intro hregular
    choose r hr using hregular
    choose V hx a ha using fun x : U => X.presheaf.germ_exist x.val (r x)
    let W (x : U) : X.Opens := V x ⊓ U
    letI : ∀ x : U, Nonempty (V x) := fun x => ⟨⟨x.val, hx x⟩⟩
    letI : ∀ x : U, Nonempty (W x) := fun x => ⟨⟨x.val, hx x, x.property⟩⟩
    let aW (x : U) : Γ(X, W x) := X.presheaf.map (Opens.infLELeft (V x) U).op (a x)
    have hfieldV : ∀ x : U, algebraMap Γ(X, V x) X.functionField (a x) = f := by
      intro x
      let xV : V x := ⟨x.val, hx x⟩
      letI := X.presheaf.algebra_section_stalk xV
      letI := functionField_isScalarTower X (V x) xV
      rw [IsScalarTower.algebraMap_apply Γ(X, V x) (X.presheaf.stalk x.val) X.functionField]
      change algebraMap (X.presheaf.stalk x.val) X.functionField
        (X.presheaf.germ (V x) x.val (hx x) (a x)) = f
      rw [ha x]
      exact hr x
    have hfieldW : ∀ x : U, algebraMap Γ(X, W x) X.functionField (aW x) = f := by
      intro x
      exact (RingHom.congr_fun
        (Litt3.SharedTensors.actual_section_restriction_function_field
          (X := X) (U := V x) (V := W x) inf_le_left) (a x)).trans (hfieldV x)
    have hcompatible : TopCat.Presheaf.IsCompatible X.presheaf W aW := by
      intro i j
      rcases isEmpty_or_nonempty (W i ⊓ W j : X.Opens) with hEmpty | hNonempty
      · letI := hEmpty
        have hWbot : (W i ⊓ W j : X.Opens) = ⊥ := by
          apply SetLike.ext'
          exact Set.eq_empty_iff_forall_notMem.mpr fun x hx =>
            hEmpty.false (⟨x, hx⟩ : (W i ⊓ W j : X.Opens))
        letI : Subsingleton Γ(X, W i ⊓ W j) :=
          CommRingCat.subsingleton_of_isTerminal (X.sheaf.isTerminalOfEqEmpty hWbot)
        exact Subsingleton.elim _ _
      · letI := hNonempty
        apply X.germToFunctionField_injective (W i ⊓ W j)
        have hi := RingHom.congr_fun
          (Litt3.SharedTensors.actual_section_restriction_function_field
            (X := X) (U := W i) (V := W i ⊓ W j) inf_le_left) (aW i)
        have hj := RingHom.congr_fun
          (Litt3.SharedTensors.actual_section_restriction_function_field
            (X := X) (U := W j) (V := W i ⊓ W j) inf_le_right) (aW j)
        exact hi.trans ((hfieldW i).trans ((hfieldW j).symm.trans hj.symm))
    have hcover : U ≤ iSup W := by
      intro x hxU
      let xU : U := ⟨x, hxU⟩
      exact Opens.mem_iSup.mpr ⟨xU, hx xU, hxU⟩
    obtain ⟨aU, haU, _⟩ := X.sheaf.existsUnique_gluing' W U
      (fun _ => homOfLE inf_le_right) hcover aW hcompatible
    let x : U := Classical.arbitrary U
    have h := RingHom.congr_fun
      (Litt3.SharedTensors.actual_section_restriction_function_field
        (X := X) (U := U) (V := W x) inf_le_right) aU
    change algebraMap Γ(X, W x) X.functionField
      (X.presheaf.map (homOfLE (show W x ≤ U from inf_le_right)).op aU) = _ at h
    have hg : X.presheaf.map (homOfLE (show W x ≤ U from inf_le_right)).op aU = aW x :=
      haU x
    rw [hg, hfieldW x] at h
    exact ⟨aU, h.symm⟩
  · rintro ⟨a, ha⟩ x
    letI := X.presheaf.algebra_section_stalk x
    letI := functionField_isScalarTower X U x
    refine ⟨X.presheaf.germ U x.val x.property a, ?_⟩
    change algebraMap (X.presheaf.stalk x.val) X.functionField
      (algebraMap Γ(X, U) (X.presheaf.stalk x.val) a) = f
    rw [← IsScalarTower.algebraMap_apply Γ(X, U) (X.presheaf.stalk x.val) X.functionField]
    exact ha

end Litt3.Jacobians

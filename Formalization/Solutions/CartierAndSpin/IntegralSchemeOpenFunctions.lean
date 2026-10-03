import Solutions.SharedTensors.IntegralSchemeGlobalFunctions

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.CartierAndSpin

universe u

variable {X : Scheme.{u}} [IsIntegral X]

/-- On ANY nonempty original open, a rational function belongs to every
original stalk precisely when it is an actual section on that open.
The section is constructed by genuine sheaf gluing. -/
theorem actual_function_field_regular_on_open_iff_section
    (U : X.Opens) [Nonempty U] (f : X.functionField) :
    (∀ x : U, ∃ r : X.presheaf.stalk x,
      algebraMap (X.presheaf.stalk x) X.functionField r = f) ↔
      ∃ a : Γ(X, U), algebraMap Γ(X, U) X.functionField a = f := by
  classical
  constructor
  · intro hregular
    choose r hr using hregular
    choose W hx a ha using fun x : U => X.presheaf.germ_exist x (r x)
    letI : ∀ x : U, Nonempty (W x) := fun x => ⟨⟨x, hx x⟩⟩
    let V : U → X.Opens := fun x => U ⊓ W x
    letI : ∀ x : U, Nonempty (V x) := fun x => ⟨⟨x, x.property, hx x⟩⟩
    let aV : ∀ x : U, Γ(X, V x) := fun x =>
      X.presheaf.map (homOfLE (show V x ≤ W x from inf_le_right)).op (a x)
    have hfieldW : ∀ x : U, algebraMap Γ(X, W x) X.functionField (a x) = f := by
      intro x
      let xW : W x := ⟨x, hx x⟩
      letI := X.presheaf.algebra_section_stalk xW
      letI := functionField_isScalarTower X (W x) xW
      rw [IsScalarTower.algebraMap_apply Γ(X, W x) (X.presheaf.stalk x) X.functionField]
      change algebraMap (X.presheaf.stalk x) X.functionField
        (X.presheaf.germ (W x) x (hx x) (a x)) = f
      rw [ha x]
      exact hr x
    have hfield : ∀ x : U, algebraMap Γ(X, V x) X.functionField (aV x) = f := by
      intro x
      have h := RingHom.congr_fun
        (Litt3.SharedTensors.actual_section_restriction_function_field
          (X := X) (U := W x) (V := V x) inf_le_right) (a x)
      exact h.trans (hfieldW x)
    have hcompatible : TopCat.Presheaf.IsCompatible X.presheaf V aV := by
      intro i j
      rcases isEmpty_or_nonempty (V i ⊓ V j : X.Opens) with hEmpty | hNonempty
      · letI := hEmpty
        have hbot : (V i ⊓ V j : X.Opens) = ⊥ := by
          apply SetLike.ext'
          exact Set.eq_empty_iff_forall_notMem.mpr fun x hx =>
            hEmpty.false (⟨x, hx⟩ : (V i ⊓ V j : X.Opens))
        letI : Subsingleton Γ(X, V i ⊓ V j) :=
          CommRingCat.subsingleton_of_isTerminal (X.sheaf.isTerminalOfEqEmpty hbot)
        exact Subsingleton.elim _ _
      · letI := hNonempty
        apply X.germToFunctionField_injective (V i ⊓ V j)
        have hi := RingHom.congr_fun
          (Litt3.SharedTensors.actual_section_restriction_function_field (X := X)
            (U := V i) (V := V i ⊓ V j) inf_le_left) (aV i)
        have hj := RingHom.congr_fun
          (Litt3.SharedTensors.actual_section_restriction_function_field (X := X)
            (U := V j) (V := V i ⊓ V j) inf_le_right) (aV j)
        exact hi.trans ((hfield i).trans ((hfield j).symm.trans hj.symm))
    have hcover : U ≤ iSup V := by
      intro x hxU
      exact Opens.mem_iSup.mpr ⟨⟨x, hxU⟩, hxU, hx ⟨x, hxU⟩⟩
    obtain ⟨aOpen, hOpen, _⟩ := X.sheaf.existsUnique_gluing' V U
      (fun _ => homOfLE inf_le_left) hcover aV hcompatible
    let x : U := Classical.arbitrary U
    have h := RingHom.congr_fun
      (Litt3.SharedTensors.actual_section_restriction_function_field
        (X := X) (U := U) (V := V x) inf_le_left) aOpen
    change algebraMap Γ(X, V x) X.functionField
      (X.presheaf.map (homOfLE (show V x ≤ U from inf_le_left)).op aOpen) = _ at h
    have hg : X.presheaf.map (homOfLE (show V x ≤ U from inf_le_left)).op aOpen = aV x :=
      hOpen x
    rw [hg, hfield x] at h
    exact ⟨aOpen, h.symm⟩
  · rintro ⟨a, ha⟩ x
    letI := X.presheaf.algebra_section_stalk x
    letI := functionField_isScalarTower X U x
    refine ⟨X.presheaf.germ U x x.property a, ?_⟩
    change algebraMap (X.presheaf.stalk x) X.functionField
      (algebraMap Γ(X, U) (X.presheaf.stalk x) a) = f
    rw [← IsScalarTower.algebraMap_apply Γ(X, U) (X.presheaf.stalk x) X.functionField]
    exact ha

end Litt3.CartierAndSpin

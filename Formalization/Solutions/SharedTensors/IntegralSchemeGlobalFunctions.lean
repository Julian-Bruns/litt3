import Mathlib.AlgebraicGeometry.FunctionField
import Mathlib.Topology.Sheaves.SheafCondition.UniqueGluing

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.SharedTensors

universe u

variable {X : Scheme.{u}} [IsIntegral X]

noncomputable local instance integralSchemeGlobalFunctionsTopNonempty :
    Nonempty (⊤ : X.Opens) := ⟨⟨genericPoint X, trivial⟩⟩

/-- Restriction of an original section preserves its literal image
in the actual generic-point function field. -/
theorem actual_section_restriction_function_field
    {U V : X.Opens} [Nonempty U] [Nonempty V] (hVU : V ≤ U) :
    (algebraMap Γ(X, V) X.functionField).comp
      (X.presheaf.map (homOfLE hVU).op).hom =
      algebraMap Γ(X, U) X.functionField := by
  change ((X.presheaf.map (homOfLE hVU).op) ≫
    X.presheaf.germ V (genericPoint X) _).hom =
    (X.presheaf.germ U (genericPoint X) _).hom
  rw [X.presheaf.germ_res]

/-- A rational function on ANY integral Scheme belongs to every
original stalk exactly when it is an actual global structure-sheaf
section. The global section is obtained by genuine sheaf gluing.
No properness, smoothness or finite presentation is assumed. -/
theorem actual_function_field_regular_everywhere_iff_global_section
    (f : X.functionField) :
    (∀ x : X, ∃ r : X.presheaf.stalk x,
      algebraMap (X.presheaf.stalk x) X.functionField r = f) ↔
      ∃ a : Γ(X, ⊤), algebraMap Γ(X, ⊤) X.functionField a = f := by
  classical
  constructor
  · intro hregular
    choose r hr using hregular
    choose U hx a ha using fun x : X => X.presheaf.germ_exist x (r x)
    letI : ∀ x : X, Nonempty (U x) := fun x => ⟨⟨x, hx x⟩⟩
    have hfield : ∀ x : X, algebraMap Γ(X, U x) X.functionField (a x) = f := by
      intro x
      let xU : U x := ⟨x, hx x⟩
      letI := X.presheaf.algebra_section_stalk xU
      letI := functionField_isScalarTower X (U x) xU
      rw [IsScalarTower.algebraMap_apply Γ(X, U x) (X.presheaf.stalk x) X.functionField]
      change algebraMap (X.presheaf.stalk x) X.functionField
        (X.presheaf.germ (U x) x (hx x) (a x)) = f
      rw [ha x]
      exact hr x
    have hcompatible : TopCat.Presheaf.IsCompatible X.presheaf U a := by
      intro i j
      let W : X.Opens := U i ⊓ U j
      rcases isEmpty_or_nonempty W with hEmpty | hNonempty
      · letI := hEmpty
        have hWbot : (U i ⊓ U j : X.Opens) = ⊥ := by
          apply SetLike.ext'
          exact Set.eq_empty_iff_forall_notMem.mpr fun x hx =>
            hEmpty.false (⟨x, hx⟩ : W)
        letI : Subsingleton Γ(X, U i ⊓ U j) :=
          CommRingCat.subsingleton_of_isTerminal (X.sheaf.isTerminalOfEqEmpty hWbot)
        exact Subsingleton.elim _ _
      · letI := hNonempty
        apply X.germToFunctionField_injective (U i ⊓ U j)
        have hi := RingHom.congr_fun
          (actual_section_restriction_function_field (X := X)
            (U := U i) (V := U i ⊓ U j) inf_le_left) (a i)
        have hj := RingHom.congr_fun
          (actual_section_restriction_function_field (X := X)
            (U := U j) (V := U i ⊓ U j) inf_le_right) (a j)
        exact hi.trans ((hfield i).trans ((hfield j).symm.trans hj.symm))
    have hcover : (⊤ : X.Opens) ≤ iSup U := by
      intro x _
      exact Opens.mem_iSup.mpr ⟨x, hx x⟩
    obtain ⟨aGlobal, hGlobal, _⟩ := X.sheaf.existsUnique_gluing' U ⊤
      (fun _ => homOfLE le_top) hcover a hcompatible
    let x : X := Classical.arbitrary X
    have h := RingHom.congr_fun
      (actual_section_restriction_function_field (X := X) (U := ⊤) (V := U x) le_top)
      aGlobal
    change algebraMap Γ(X, U x) X.functionField
      (X.presheaf.map (homOfLE le_top).op aGlobal) = _ at h
    have hg : X.presheaf.map (homOfLE (show U x ≤ ⊤ from le_top)).op aGlobal = a x :=
      hGlobal x
    rw [hg, hfield x] at h
    exact ⟨aGlobal, h.symm⟩
  · rintro ⟨a, ha⟩ x
    let xTop : (⊤ : X.Opens) := ⟨x, trivial⟩
    letI := X.presheaf.algebra_section_stalk xTop
    letI := functionField_isScalarTower X ⊤ xTop
    refine ⟨X.presheaf.germ ⊤ x trivial a, ?_⟩
    change algebraMap (X.presheaf.stalk x) X.functionField
      (algebraMap Γ(X, ⊤) (X.presheaf.stalk x) a) = f
    rw [← IsScalarTower.algebraMap_apply Γ(X, ⊤) (X.presheaf.stalk x) X.functionField]
    exact ha

end Litt3.SharedTensors

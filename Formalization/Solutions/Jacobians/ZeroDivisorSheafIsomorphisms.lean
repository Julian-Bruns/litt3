import Solutions.Jacobians.ZeroDivisorStructureMaps
import Solutions.Jacobians.SmoothCurveOpenRegularity

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace
open scoped WithZero
set_option maxHeartbeats 1000000

namespace Litt3.Jacobians

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X] [ClosedPointDVRStalks X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]

include sX

/-- The true zero-divisor sheaf has exactly the ORIGINAL structure
sections on EVERY original open, including the empty open. Bijectivity
is derived from true closed-stalk valuation regularity and actual gluing. -/
theorem actualStructureToZeroDivisorSheaf_app_bijective
    (U : X.Opensᵒᵖ) :
    Function.Bijective ((actualStructureToZeroDivisorSheaf X).val.app U).hom := by
  classical
  rcases isEmpty_or_nonempty U.unop with hEmpty | hNonempty
  · letI := hEmpty
    have hUbot : U.unop = (⊥ : X.Opens) := by
      apply SetLike.ext'
      exact Set.eq_empty_iff_forall_notMem.mpr fun x hx => hEmpty.false (⟨x, hx⟩ : U.unop)
    letI : Subsingleton Γ(X, U.unop) :=
      CommRingCat.subsingleton_of_isTerminal (X.sheaf.isTerminalOfEqEmpty hUbot)
    letI : Subsingleton ((actualSchemeRationalFunctionRingSheaf X).val.obj U) :=
      CommRingCat.subsingleton_of_isTerminal
        ((actualSchemeRationalFunctionRingSheaf X).isTerminalOfEqEmpty hUbot)
    letI : Subsingleton ((SheafOfModules.unit X.ringCatSheaf).val.obj U) :=
      inferInstanceAs (Subsingleton Γ(X, U.unop))
    letI : Subsingleton ((actualSchemeRationalFunctionModuleSheaf X).val.obj U) :=
      inferInstanceAs (Subsingleton ((actualSchemeRationalFunctionRingSheaf X).val.obj U))
    letI : Subsingleton ((actualSchemeDivisorSheaf X 0).val.obj U) :=
      inferInstanceAs (Subsingleton (actualSchemeDivisorOpenSubmodule X 0 U))
    constructor
    · intro a b h
      exact Subsingleton.elim _ _
    · intro a
      exact ⟨0, Subsingleton.elim _ _⟩
  · letI := hNonempty
    constructor
    · intro a b hab
      have hρ := congrArg Subtype.val hab
      change (actualSchemeStructureToRationalFunctions X).val.app U a =
        (actualSchemeStructureToRationalFunctions X).val.app U b at hρ
      have hf := congrArg (actualSchemeRationalFunctionOpenIso X U.unop).hom hρ
      apply X.germToFunctionField_injective U.unop
      exact (CategoryTheory.congr_fun
        (actualSchemeStructureToRationalFunctions_open X U.unop) a).symm.trans
          (hf.trans (CategoryTheory.congr_fun
            (actualSchemeStructureToRationalFunctions_open X U.unop) b))
    · intro a
      let f : X.functionField := (actualSchemeRationalFunctionOpenIso X U.unop).hom a.val
      have hf : ∀ (x : Litt3.SharedTensors.ClosedPoint X) (hx : x.val ∈ U.unop),
          closedPointValuation X x f ≤ 1 := by
        intro x hx
        have h := a.property x hx
        change closedPointValuation X x
          (actualRationalFunctionEvaluation X U.unop x.val hx a.val) ≤ WithZero.exp (0 : ℤ) at h
        rw [actualRationalFunctionEvaluation_eq_open] at h
        simpa only [WithZero.exp_zero] using h
      obtain ⟨r, hr⟩ := (actual_smooth_curve_open_section_iff_closed_valuation sX U.unop f).mpr hf
      refine ⟨r, ?_⟩
      apply Subtype.ext
      apply (actualSchemeRationalFunctionOpenIso X U.unop).commRingCatIsoToRingEquiv.injective
      exact (CategoryTheory.congr_fun
        (actualSchemeStructureToRationalFunctions_open X U.unop) r).trans hr

/-- On an ACTUAL smooth curve, the literal valuation-bounded zero
divisor SHEAF is isomorphic to its ORIGINAL structure-sheaf module.
The isomorphism uses every original open and genuine restriction map. -/
noncomputable def actualSmoothCurveZeroDivisorSheafIso :
    actualSchemeDivisorSheaf X 0 ≅ SheafOfModules.unit X.ringCatSheaf := by
  let e : (SheafOfModules.unit X.ringCatSheaf).val ≅
      (actualSchemeDivisorSheaf X 0).val := PresheafOfModules.isoMk
    (fun U => (LinearEquiv.ofBijective
      ((actualStructureToZeroDivisorSheaf X).val.app U).hom
      (actualStructureToZeroDivisorSheaf_app_bijective sX U)).toModuleIso)
    (fun _ _ i => (actualStructureToZeroDivisorSheaf X).val.naturality i)
  exact
    { hom := ⟨e.inv⟩
      inv := ⟨e.hom⟩
      hom_inv_id := SheafOfModules.hom_ext e.inv_hom_id
      inv_hom_id := SheafOfModules.hom_ext e.hom_inv_id }

end Litt3.Jacobians

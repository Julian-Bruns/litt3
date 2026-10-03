import Solutions.Jacobians.OriginalLineSheafGenericRestrictions

open CategoryTheory Opposite AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u}) [IsIntegral X] (M : X.Modules)
  (hM : ActualOriginalLineSheaf X M)

/-- A local original line frame supplies a DERIVED original rational
generator: the rational image of its actual original unit section. -/
noncomputable def actualOriginalLineFrameRationalGenerator
    (U : X.Opens) [Nonempty U]
    (e : M.over U ≅ (SheafOfModules.unit X.ringCatSheaf).over U) :
    X.functionField :=
  actualOriginalLineSheafGenericValue X M hM U
    ((actualOriginalLineFrameSectionEquiv X M U e U (𝟙 U)).symm 1)

theorem actualOriginalLineFrameRationalGenerator_ne_zero
    (U : X.Opens) [Nonempty U]
    (e : M.over U ≅ (SheafOfModules.unit X.ringCatSheaf).over U) :
    actualOriginalLineFrameRationalGenerator X M hM U e ≠ 0 := by
  intro hzero
  let E := actualOriginalLineFrameSectionEquiv X M U e U (𝟙 U)
  have hs : E.symm (1 : Γ(X, U)) = 0 :=
    actualOriginalLineSheafGenericValue_injective X M hM U
      (hzero.trans (map_zero (actualOriginalLineSheafGenericValue X M hM U)).symm)
  have hring : (1 : Γ(X, U)) = 0 := by
    have h := congrArg E hs
    simpa only [LinearEquiv.apply_symm_apply, map_zero] using h
  have hfield := congrArg (algebraMap Γ(X, U) X.functionField) hring
  exact one_ne_zero (by simpa only [map_one, map_zero] using hfield)

/-- EVERY original section in a genuine local frame has rational
image equal to its original structure-ring coefficient times ONE derived
original rational generator. This is an identity of ENTIRE section maps. -/
theorem actualOriginalLineFrameRationalGenerator_apply
    (U : X.Opens) [Nonempty U]
    (e : M.over U ≅ (SheafOfModules.unit X.ringCatSheaf).over U)
    (a : M.val.obj (op U)) :
    actualOriginalLineSheafGenericValue X M hM U a =
      algebraMap Γ(X, U) X.functionField
        (actualOriginalLineFrameSectionEquiv X M U e U (𝟙 U) a) *
          actualOriginalLineFrameRationalGenerator X M hM U e := by
  let E := actualOriginalLineFrameSectionEquiv X M U e U (𝟙 U)
  have ha : a = (E a) • E.symm (1 : Γ(X, U)) := by
    calc
      a = E.symm (E a) := (E.symm_apply_apply a).symm
      _ = E.symm ((E a) • (1 : Γ(X, U))) := by rw [smul_eq_mul, mul_one]
      _ = (E a) • E.symm (1 : Γ(X, U)) := E.symm.map_smul _ _
  calc
    actualOriginalLineSheafGenericValue X M hM U a =
        actualOriginalLineSheafGenericValue X M hM U
          ((E a) • E.symm (1 : Γ(X, U))) := congrArg _ ha
    _ = _ := by rw [map_smul, Algebra.smul_def]; rfl

/-- The original rational generator is IDENTICAL on EVERY nonempty
smaller open of its frame neighborhood, using the actual full restriction
and original generic-field squares. -/
theorem actualOriginalLineFrameRationalGenerator_on_subopen
    (U : X.Opens) [Nonempty U]
    (e : M.over U ≅ (SheafOfModules.unit X.ringCatSheaf).over U)
    (V : X.Opens) [Nonempty V] (i : V ⟶ U) :
    actualOriginalLineSheafGenericValue X M hM V
      ((actualOriginalLineFrameSectionEquiv X M U e V i).symm 1) =
        actualOriginalLineFrameRationalGenerator X M hM U e := by
  have h := actualOriginalLineFrameSectionEquiv_symm_restriction X M U e
    (𝟙 U) i i (1 : Γ(X, U))
  have hone : X.presheaf.map i.op (1 : Γ(X, U)) = 1 :=
    (X.presheaf.map i.op).hom.map_one
  rw [hone] at h
  rw [h]
  exact actualOriginalLineSheafGenericValue_restriction X M hM i _

end Litt3.Jacobians

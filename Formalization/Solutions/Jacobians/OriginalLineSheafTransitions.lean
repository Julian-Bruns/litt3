import Solutions.Jacobians.OriginalLineSheafFrames

open CategoryTheory Opposite AlgebraicGeometry

namespace Litt3.Jacobians

universe u

/-- Every actual rank-one scalar-module automorphism is
multiplication by a DERIVED actual unit of the ORIGINAL ring. -/
noncomputable def actualRankOneLinearAutomorphismUnit
    {R : Type*} [CommRing R] (e : R ≃ₗ[R] R) : Rˣ where
  val := e 1
  inv := e.symm 1
  val_inv := by
    have h : e.symm (e 1) = e 1 * e.symm 1 := by
      simpa only [smul_eq_mul, mul_one] using e.symm.map_smul (e 1) (1 : R)
    exact h.symm.trans (e.symm_apply_apply 1)
  inv_val := by
    have h : e (e.symm 1) = e.symm 1 * e 1 := by
      simpa only [smul_eq_mul, mul_one] using e.map_smul (e.symm 1) (1 : R)
    exact h.symm.trans (e.apply_symm_apply 1)

theorem actualRankOneLinearAutomorphismUnit_apply
    {R : Type*} [CommRing R] (e : R ≃ₗ[R] R) (a : R) :
    e a = (actualRankOneLinearAutomorphismUnit e).val * a := by
  have h : e a = a * e 1 := by
    simpa only [smul_eq_mul, mul_one] using e.map_smul a (1 : R)
  exact h.trans (mul_comm _ _)

variable (X : Scheme.{u}) (M : X.Modules) (U : X.Opens)

/-- Two genuine entire-site original line frames have an actual
unit transition coefficient on EVERY original smaller open. -/
noncomputable def actualOriginalLineFrameTransitionUnit
    (e f : M.over U ≅ (SheafOfModules.unit X.ringCatSheaf).over U)
    (V : X.Opens) (i : V ⟶ U) : Γ(X, V)ˣ :=
  actualRankOneLinearAutomorphismUnit
    ((actualOriginalLineFrameSectionEquiv X M U e V i).symm.trans
      (actualOriginalLineFrameSectionEquiv X M U f V i))

/-- The transition unit acts on the ENTIRE original section module. -/
theorem actualOriginalLineFrameTransitionUnit_apply
    (e f : M.over U ≅ (SheafOfModules.unit X.ringCatSheaf).over U)
    (V : X.Opens) (i : V ⟶ U) (a : M.val.obj (op V)) :
    actualOriginalLineFrameSectionEquiv X M U f V i a =
      (actualOriginalLineFrameTransitionUnit X M U e f V i).val *
        actualOriginalLineFrameSectionEquiv X M U e V i a := by
  simpa only [LinearEquiv.trans_apply, LinearEquiv.symm_apply_apply] using
    actualRankOneLinearAutomorphismUnit_apply
      ((actualOriginalLineFrameSectionEquiv X M U e V i).symm.trans
        (actualOriginalLineFrameSectionEquiv X M U f V i))
      (actualOriginalLineFrameSectionEquiv X M U e V i a)

/-- The actual unit transition coefficient on EVERY smaller
original open is the restriction of the ORIGINAL neighborhood unit. -/
theorem actualOriginalLineFrameTransitionUnit_restriction
    (e f : M.over U ≅ (SheafOfModules.unit X.ringCatSheaf).over U)
    (V : X.Opens) (i : V ⟶ U) :
    (actualOriginalLineFrameTransitionUnit X M U e f V i).val =
      X.presheaf.map i.op (actualOriginalLineFrameTransitionUnit X M U e f U (𝟙 U)).val := by
  have he := actualOriginalLineFrameSectionEquiv_symm_restriction X M U e
    (𝟙 U) i i (1 : Γ(X, U))
  have hone : X.presheaf.map i.op (1 : Γ(X, U)) = 1 :=
    (X.presheaf.map i.op).hom.map_one
  rw [hone] at he
  change actualOriginalLineFrameSectionEquiv X M U f V i
      ((actualOriginalLineFrameSectionEquiv X M U e V i).symm 1) =
    X.presheaf.map i.op
      (actualOriginalLineFrameSectionEquiv X M U f U (𝟙 U)
        ((actualOriginalLineFrameSectionEquiv X M U e U (𝟙 U)).symm 1))
  rw [he]
  exact actualOriginalLineFrameSectionEquiv_restriction X M U f (𝟙 U) i i _

end Litt3.Jacobians

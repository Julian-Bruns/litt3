import Solutions.Jacobians.OriginalLineSheafLocalRationalGenerators
import Solutions.Jacobians.OriginalLineSheafTransitions

open CategoryTheory Opposite AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u}) [IsIntegral X] (M : X.Modules)
  (hM : ActualOriginalLineSheaf X M)

/-- The original rational expression in a genuine local frame holds
on EVERY nonempty original subopen, with the SAME neighborhood generator. -/
theorem actualOriginalLineFrameRationalGenerator_apply_subopen
    (U : X.Opens) [Nonempty U]
    (e : M.over U ≅ (SheafOfModules.unit X.ringCatSheaf).over U)
    (V : X.Opens) [Nonempty V] (i : V ⟶ U) (a : M.val.obj (op V)) :
    actualOriginalLineSheafGenericValue X M hM V a =
      algebraMap Γ(X, V) X.functionField
        (actualOriginalLineFrameSectionEquiv X M U e V i a) *
          actualOriginalLineFrameRationalGenerator X M hM U e := by
  let E := actualOriginalLineFrameSectionEquiv X M U e V i
  have ha : a = (E a) • E.symm (1 : Γ(X, V)) := by
    calc
      a = E.symm (E a) := (E.symm_apply_apply a).symm
      _ = E.symm ((E a) • (1 : Γ(X, V))) := by rw [smul_eq_mul, mul_one]
      _ = (E a) • E.symm (1 : Γ(X, V)) := E.symm.map_smul _ _
  calc
    actualOriginalLineSheafGenericValue X M hM V a =
        actualOriginalLineSheafGenericValue X M hM V
          ((E a) • E.symm (1 : Γ(X, V))) := congrArg _ ha
    _ = algebraMap Γ(X, V) X.functionField (E a) *
        actualOriginalLineSheafGenericValue X M hM V (E.symm 1) := by
      rw [map_smul, Algebra.smul_def]
    _ = _ := by
      rw [actualOriginalLineFrameRationalGenerator_on_subopen X M hM U e V i]

/-- Two genuine original frames, even on DIFFERENT neighborhoods,
give generators differing by an ACTUAL unit of the common original open.
The transition unit is constructed from entire original section maps. -/
theorem actualOriginalLineFrameRationalGenerator_transition
    (U W V : X.Opens) [Nonempty U] [Nonempty W] [Nonempty V]
    (e : M.over U ≅ (SheafOfModules.unit X.ringCatSheaf).over U)
    (f : M.over W ≅ (SheafOfModules.unit X.ringCatSheaf).over W)
    (i : V ⟶ U) (j : V ⟶ W) :
    ∃ c : Γ(X, V)ˣ,
      actualOriginalLineFrameRationalGenerator X M hM U e =
        algebraMap Γ(X, V) X.functionField c.val *
          actualOriginalLineFrameRationalGenerator X M hM W f := by
  let E := actualOriginalLineFrameSectionEquiv X M U e V i
  let F := actualOriginalLineFrameSectionEquiv X M W f V j
  let c := actualRankOneLinearAutomorphismUnit (E.symm.trans F)
  refine ⟨c, ?_⟩
  have h := actualOriginalLineFrameRationalGenerator_apply_subopen X M hM W f V j
    (E.symm (1 : Γ(X, V)))
  rw [actualOriginalLineFrameRationalGenerator_on_subopen X M hM U e V i] at h
  exact h

end Litt3.Jacobians

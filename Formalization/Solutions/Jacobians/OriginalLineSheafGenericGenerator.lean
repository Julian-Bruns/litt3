import Solutions.Jacobians.OriginalLineSheafLocalRationalGenerators

open CategoryTheory Opposite AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u}) [IsIntegral X] (M : X.Modules)
  (hM : ActualOriginalLineSheaf X M)

/-- The DERIVED original generic neighborhood is nonempty. -/
theorem actualOriginalLineSheafGenericOpen_nonempty :
    Nonempty (actualOriginalLineSheafGenericOpen X M hM) :=
  ⟨⟨genericPoint X, actualOriginalLineSheafGenericOpen_contains_generic X M hM⟩⟩

/-- The rational embedding is genuinely normalized by the chosen
ORIGINAL generic frame: its actual rational generator is precisely one. -/
theorem actualOriginalLineSheafGenericGenerator_one :
    letI := actualOriginalLineSheafGenericOpen_nonempty X M hM
    actualOriginalLineFrameRationalGenerator X M hM
      (actualOriginalLineSheafGenericOpen X M hM)
      (actualOriginalLineSheafGenericFrame X M hM) = 1 := by
  let W := actualOriginalLineSheafGenericOpen X M hM
  let e := actualOriginalLineSheafGenericFrame X M hM
  letI : Nonempty W := actualOriginalLineSheafGenericOpen_nonempty X M hM
  let V := W ⊓ W
  letI : Nonempty V := actualOriginalLineSheafGenericIntersection_nonempty X M hM W
  let i : V ⟶ W := homOfLE inf_le_left
  let j : V ⟶ W := homOfLE inf_le_right
  let a := (actualOriginalLineFrameSectionEquiv X M W e W (𝟙 W)).symm
    (1 : Γ(X, W))
  have h := actualOriginalLineFrameSectionEquiv_restriction X M W e
    (𝟙 W) j i a
  rw [LinearEquiv.apply_symm_apply, map_one] at h
  change algebraMap Γ(X, V) X.functionField
    (actualOriginalLineFrameSectionEquiv X M W e V j (M.val.map i.op a)) = 1
  rw [h, map_one]

end Litt3.Jacobians

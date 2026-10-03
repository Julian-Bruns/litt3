import Solutions.Jacobians.OriginalLineSheafSubopenRationalGenerators
import Solutions.Jacobians.OriginalLineSheafGenericGenerator

open CategoryTheory AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u}) [IsIntegral X] (M : X.Modules)
  (hM : ActualOriginalLineSheaf X M)

/-- An ORIGINAL neighborhood chosen from genuine local freeness at
the specified actual point. -/
noncomputable def actualOriginalLinePointOpen (x : X) : X.Opens :=
  Classical.choose (hM x)

theorem actualOriginalLinePointOpen_contains (x : X) :
    x ∈ actualOriginalLinePointOpen X M hM x :=
  (Classical.choose_spec (hM x)).1

theorem actualOriginalLinePointOpen_nonempty (x : X) :
    Nonempty (actualOriginalLinePointOpen X M hM x) :=
  ⟨⟨x, actualOriginalLinePointOpen_contains X M hM x⟩⟩

noncomputable def actualOriginalLinePointFrame (x : X) :
    M.over (actualOriginalLinePointOpen X M hM x) ≅
      (SheafOfModules.unit X.ringCatSheaf).over
        (actualOriginalLinePointOpen X M hM x) :=
  Classical.choice (Classical.choose_spec (hM x)).2

/-- The nonzero ORIGINAL rational generator at an actual point is
constructed from the original local frame and the full generic embedding. -/
noncomputable def actualOriginalLinePointRationalUnit (x : X) : X.functionFieldˣ := by
  letI := actualOriginalLinePointOpen_nonempty X M hM x
  exact Units.mk0
    (actualOriginalLineFrameRationalGenerator X M hM
      (actualOriginalLinePointOpen X M hM x) (actualOriginalLinePointFrame X M hM x))
    (actualOriginalLineFrameRationalGenerator_ne_zero X M hM _ _)

end Litt3.Jacobians

import Mathlib.AlgebraicGeometry.Modules.Sheaf
import Mathlib.Algebra.Category.ModuleCat.Sheaf.PushforwardContinuous

open CategoryTheory AlgebraicGeometry

namespace Litt3.Jacobians

universe u

/-- A genuine line SHEAF on the original scheme: at every ORIGINAL
point, its restriction to the ENTIRE neighborhood site is isomorphic
to the ORIGINAL structure module. This is the actual local-freeness
condition; no divisor presentation, affine reconstruction or generic
rational embedding is supplied. -/
def ActualOriginalLineSheaf (X : Scheme.{u}) (M : X.Modules) : Prop :=
  ∀ x : X, ∃ U : X.Opens, x ∈ U ∧
    Nonempty (M.over U ≅ (SheafOfModules.unit X.ringCatSheaf).over U)

end Litt3.Jacobians

import Solutions.Jacobians.SchemeDivisorOpenSubmodules
import Solutions.Jacobians.ActualSubmoduleSheaves

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace
open scoped WithZero

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u}) [IsIntegral X] [ClosedPointDVRStalks X]

/-- Actual closed-point valuation bounds are LOCAL on the original
open site; the bounds glue through actual rational-function restriction. -/
theorem actualSchemeDivisorOpenSubmodule_local
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X))
    {ι : Type u} (U : ι → X.Opens)
    (a : (actualSchemeRationalFunctionModuleSheaf X).val.obj (op (iSup U)))
    (ha : ∀ i, (actualSchemeRationalFunctionModuleSheaf X).val.map
      (Opens.leSupr U i).op a ∈ actualSchemeDivisorOpenSubmodule X D (op (U i))) :
    a ∈ actualSchemeDivisorOpenSubmodule X D (op (iSup U)) := by
  intro x hx
  obtain ⟨i, hi⟩ := Opens.mem_iSup.mp hx
  have hb := ha i x hi
  change closedPointValuation X x
    (actualRationalFunctionEvaluation X (U i) x.val hi
      ((actualSchemeRationalFunctionRingSheaf X).val.map (Opens.leSupr U i).op a)) ≤ _ at hb
  have he := RingHom.congr_fun
    (actualRationalFunctionEvaluation_restriction X (Opens.leSupr U i) x.val hi) a
  change actualRationalFunctionEvaluation X (U i) x.val hi
    ((actualSchemeRationalFunctionRingSheaf X).val.map (Opens.leSupr U i).op a) =
      actualRationalFunctionEvaluation X (iSup U) x.val ((Opens.leSupr U i).le hi) a at he
  rw [he] at hb
  exact hb

/-- The genuine valuation-bounded global divisor SHEAF on the original integral scheme with
actual closed DVR stalks. Every section on every open is a genuine rational
function satisfying its true normalized closed-point pole bounds.
Local freeness and the structure-sheaf comparison are derived separately. -/
noncomputable def actualSchemeDivisorSheaf
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X)) : X.Modules :=
  actualSubmoduleSheaf (actualSchemeRationalFunctionModuleSheaf X)
    (actualSchemeDivisorOpenSubmodule X D)
    (actualSchemeDivisorOpenSubmodule_restriction X D)
    (actualSchemeDivisorOpenSubmodule_local X D)

/-- The actual divisor sheaf is an honest subsheaf of the honest
rational-function module sheaf, with literal section inclusion. -/
noncomputable def actualSchemeDivisorSheafToRational
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X)) :
    actualSchemeDivisorSheaf X D ⟶ actualSchemeRationalFunctionModuleSheaf X :=
  actualSubmoduleSheafInclusion (actualSchemeRationalFunctionModuleSheaf X)
    (actualSchemeDivisorOpenSubmodule X D)
    (actualSchemeDivisorOpenSubmodule_restriction X D)
    (actualSchemeDivisorOpenSubmodule_local X D)

end Litt3.Jacobians

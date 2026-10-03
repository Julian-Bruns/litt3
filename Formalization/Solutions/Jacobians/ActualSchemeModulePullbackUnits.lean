import Solutions.Jacobians.ActualSchemeModulePullbacks
import Solutions.Jacobians.ActualContinuousOpenFinality

open CategoryTheory AlgebraicGeometry

namespace Litt3.Jacobians

universe u

/-- The ACTUAL original module-SHEAF pullback preserves the ORIGINAL
structure module along ANY genuine scheme morphism. Original inverse-open
finality is derived from the whole original spaces; no surjectivity, flatness,
openness or curve hypothesis is needed. -/
noncomputable def actualSchemeModulePullbackUnitIso
    {X Y : Scheme.{u}} (f : X ⟶ Y) :
    (actualSchemeModulePullback f).obj (SheafOfModules.unit Y.ringCatSheaf) ≅
      SheafOfModules.unit X.ringCatSheaf := by
  letI := actualContinuousOpensMap_final f.base
  exact asIso (SheafOfModules.pullbackObjUnitToUnit (actualSchemeRingSheafMap f))

/-- An ACTUAL global trivialization pulls back to an ACTUAL whole
original SHEAF trivialization under ANY actual scheme morphism. -/
noncomputable def actualSchemeModulePullbackTrivialIso
    {X Y : Scheme.{u}} (f : X ⟶ Y) (M : Y.Modules)
    (e : M ≅ SheafOfModules.unit Y.ringCatSheaf) :
    (actualSchemeModulePullback f).obj M ≅ SheafOfModules.unit X.ringCatSheaf :=
  actualSchemeModulePullbackIso f e ≪≫ actualSchemeModulePullbackUnitIso f

end Litt3.Jacobians

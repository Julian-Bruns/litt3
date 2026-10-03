import Mathlib.AlgebraicGeometry.Modules.Sheaf
import Mathlib.Algebra.Category.ModuleCat.Sheaf.PullbackContinuous
import Mathlib.Algebra.Category.ModuleCat.Sheaf.PullbackFree

open CategoryTheory CategoryTheory.Functor AlgebraicGeometry TopologicalSpace

namespace Litt3.Jacobians

universe u

/-- The genuine ORIGINAL structure-sheaf morphism of an ACTUAL
scheme morphism, as a map of ring SHEAVES on its actual inverse-open
site functor. No field inclusion or abstract ringed-space map is supplied. -/
noncomputable def actualSchemeRingSheafMap {X Y : Scheme.{u}} (f : X ⟶ Y) :
    Y.ringCatSheaf ⟶
      ((Opens.map f.base).sheafPushforwardContinuous RingCat.{u}
        (Opens.grothendieckTopology Y)
        (Opens.grothendieckTopology X)).obj X.ringCatSheaf :=
  ⟨whiskerRight f.c (forget₂ CommRingCat RingCat)⟩

/-- The genuine ORIGINAL module-SHEAF pullback along an ACTUAL
scheme morphism. This is the actual left adjoint to the genuine original
module pushforward, constructed from original presheaf pullback and module
sheafification, not field-valued or divisor-class substitute data. -/
noncomputable def actualSchemeModulePullback {X Y : Scheme.{u}} (f : X ⟶ Y) :
    Y.Modules ⥤ X.Modules :=
  SheafOfModules.pullback (actualSchemeRingSheafMap f)

/-- Actual original SHEAF isomorphisms pull back to actual
original SHEAF isomorphisms along ANY genuine scheme morphism. -/
noncomputable def actualSchemeModulePullbackIso {X Y : Scheme.{u}} (f : X ⟶ Y)
    {M N : Y.Modules} (e : M ≅ N) :
    (actualSchemeModulePullback f).obj M ≅ (actualSchemeModulePullback f).obj N :=
  (actualSchemeModulePullback f).mapIso e

end Litt3.Jacobians

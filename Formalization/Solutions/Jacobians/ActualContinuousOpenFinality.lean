import Mathlib.Topology.Sheaves.SheafCondition.Sites
import Mathlib.CategoryTheory.Limits.Final
import Mathlib.CategoryTheory.Limits.Shapes.IsTerminal

open CategoryTheory CategoryTheory.Limits TopologicalSpace

namespace Litt3.Jacobians

universe u

/-- The ACTUAL inverse-open functor of ANY continuous map is final:
its image of the whole original space is the whole original source. This
derives the genuine global-unit pullback condition without openness,
surjectivity or any curve hypothesis. -/
theorem actualContinuousOpensMap_final {X Y : TopCat.{u}} (f : X ⟶ Y) :
    (Opens.map f).Final := by
  let F := Opens.map f
  let G : Discrete PUnit.{u + 1} ⥤ Opens Y := Functor.fromPUnit (⊤ : Opens Y)
  letI : G.Final := Functor.final_fromPUnit_of_isTerminal isTerminalTop
  haveI : (G ⋙ F).Final := by
    change (Functor.fromPUnit (F.obj ⊤)).Final
    have htop : F.obj ⊤ = ⊤ := by simp [F]
    rw [htop]
    exact Functor.final_fromPUnit_of_isTerminal isTerminalTop
  exact Functor.final_of_final_comp G F

end Litt3.Jacobians

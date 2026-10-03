import Theorems.SharedTensors.EtaleSpans

open CategoryTheory CategoryTheory.Limits AlgebraicGeometry

namespace Litt3.SharedTensors

universe u

theorem refine_retains_original_legs {X Y : Scheme.{u}} (s : FiniteEtaleSpan X Y)
    {W : Scheme.{u}} (h : W ⟶ s.source)
    [IsFinite h] [IsEtale h] [Surjective h] : RetainsOriginalLegs s h :=
  ⟨rfl, rfl⟩

/-- The square commutes for the actual full left-endpoint fiber product. -/
theorem baseChangeLeft_commutes {X Y X' : Scheme.{u}} (s : FiniteEtaleSpan X Y)
    (h : X' ⟶ X) [IsFinite h] [IsEtale h] [Surjective h] :
    CategoryTheory.Limits.pullback.fst s.left h ≫ s.left =
      (s.baseChangeLeft h).left ≫ h :=
  CategoryTheory.Limits.pullback.condition

/-- An already equal contravariant observation stays equal on an actual refinement. -/
theorem equal_observations_survive_refinement
    {X Y : Scheme.{u}} (s : FiniteEtaleSpan X Y) {W : Scheme.{u}} (h : W ⟶ s.source)
    [IsFinite h] [IsEtale h] [Surjective h]
    {C : Type*} [Category C] (F : Scheme.{u}ᵒᵖ ⥤ C)
    {A : C} (a : A ⟶ F.obj (Opposite.op X)) (b : A ⟶ F.obj (Opposite.op Y))
    (heq : a ≫ F.map s.left.op = b ≫ F.map s.right.op) :
    a ≫ F.map (s.refine h).left.op = b ≫ F.map (s.refine h).right.op := by
  simpa only [FiniteEtaleSpan.refine, op_comp, F.map_comp, Category.assoc] using
    congrArg (fun k => k ≫ F.map h.op) heq

end Litt3.SharedTensors

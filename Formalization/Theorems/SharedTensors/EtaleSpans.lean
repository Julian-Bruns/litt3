import Definitions.SharedTensors.EtaleSpans

open CategoryTheory AlgebraicGeometry

namespace Litt3.SharedTensors

universe u

/-- The refined span retains the two specified actual composites. -/
def RetainsOriginalLegs {X Y : Scheme.{u}} (s : FiniteEtaleSpan X Y)
    {W : Scheme.{u}} (h : W ⟶ s.source)
    [IsFinite h] [IsEtale h] [Surjective h] : Prop :=
  (s.refine h).left = h ≫ s.left ∧ (s.refine h).right = h ≫ s.right

end Litt3.SharedTensors

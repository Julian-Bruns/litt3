import Mathlib.AlgebraicGeometry.Morphisms.Etale
import Mathlib.AlgebraicGeometry.Morphisms.Finite
import Mathlib.AlgebraicGeometry.Fiber

/-!
Actual finite étale spans of schemes. Each span contains one source and
two actual morphisms. Curve hypotheses are deliberately absent from this
general infrastructure, rather than replaced by numerical labels.
-/

open CategoryTheory CategoryTheory.Limits AlgebraicGeometry

namespace Litt3.SharedTensors

universe u

noncomputable section

/-- A surjective finite étale span with the same actual source on both legs. -/
structure FiniteEtaleSpan (X Y : Scheme.{u}) where
  source : Scheme.{u}
  left : source ⟶ X
  right : source ⟶ Y
  left_finite : IsFinite left
  right_finite : IsFinite right
  left_etale : IsEtale left
  right_etale : IsEtale right
  left_surjective : Surjective left
  right_surjective : Surjective right

attribute [instance] FiniteEtaleSpan.left_finite FiniteEtaleSpan.right_finite
  FiniteEtaleSpan.left_etale FiniteEtaleSpan.right_etale
  FiniteEtaleSpan.left_surjective FiniteEtaleSpan.right_surjective

namespace FiniteEtaleSpan

/-- Refinement by an actual finite étale surjection, retaining both composites. -/
def refine {X Y : Scheme.{u}} (s : FiniteEtaleSpan X Y)
    {W : Scheme.{u}} (h : W ⟶ s.source)
    [IsFinite h] [IsEtale h] [Surjective h] : FiniteEtaleSpan X Y where
  source := W
  left := h ≫ s.left
  right := h ≫ s.right
  left_finite := inferInstance
  right_finite := inferInstance
  left_etale := inferInstance
  right_etale := inferInstance
  left_surjective := inferInstance
  right_surjective := inferInstance

/-- Cartesian refinement on the left endpoint, without choosing a component. -/
def baseChangeLeft {X Y X' : Scheme.{u}} (s : FiniteEtaleSpan X Y)
    (h : X' ⟶ X) [IsFinite h] [IsEtale h] [Surjective h] :
    FiniteEtaleSpan X' Y where
  source := pullback s.left h
  left := pullback.snd s.left h
  right := pullback.fst s.left h ≫ s.right
  left_finite := inferInstance
  right_finite := inferInstance
  left_etale := MorphismProperty.pullback_snd s.left h s.left_etale
  right_etale := by
    letI : IsEtale (pullback.fst s.left h) :=
      MorphismProperty.pullback_fst s.left h inferInstance
    infer_instance
  left_surjective := inferInstance
  right_surjective := inferInstance

/-- Exchange the endpoints; no source or morphism is discarded. -/
def swap {X Y : Scheme.{u}} (s : FiniteEtaleSpan X Y) : FiniteEtaleSpan Y X where
  source := s.source
  left := s.right
  right := s.left
  left_finite := s.right_finite
  right_finite := s.left_finite
  left_etale := s.right_etale
  right_etale := s.left_etale
  left_surjective := s.right_surjective
  right_surjective := s.left_surjective

/-- Cartesian refinement on the right endpoint, retaining the full fiber product. -/
def baseChangeRight {X Y Y' : Scheme.{u}} (s : FiniteEtaleSpan X Y)
    (h : Y' ⟶ Y) [IsFinite h] [IsEtale h] [Surjective h] :
    FiniteEtaleSpan X Y' := (s.swap.baseChangeLeft h).swap

/-- The full double Cartesian endpoint refinement. Connectedness is not inferred. -/
def baseChangeBoth {X Y X' Y' : Scheme.{u}} (s : FiniteEtaleSpan X Y)
    (hX : X' ⟶ X) (hY : Y' ⟶ Y)
    [IsFinite hX] [IsEtale hX] [Surjective hX]
    [IsFinite hY] [IsEtale hY] [Surjective hY] : FiniteEtaleSpan X' Y' :=
  (s.baseChangeLeft hX).baseChangeRight hY

end FiniteEtaleSpan
end
end Litt3.SharedTensors

import Definitions.SharedTensors.EtaleSpans
import Definitions.SharedTensors.DivisorRelations
import Mathlib.AlgebraicGeometry.Morphisms.UniversallyClosed

/-!
Closed-point divisors on actual schemes, and unweighted finite-fiber pullbacks.
For finite étale maps of smooth curves over an algebraically closed field,
these are the usual divisor pullbacks. The ramification-index identification
with normalized function-field valuations remains a separate bridge.
-/

open CategoryTheory AlgebraicGeometry

namespace Litt3.SharedTensors

universe u

def ClosedPoint (X : Scheme.{u}) := {x : X | IsClosed ({x} : Set X)}

/-- Finite morphisms actually carry closed points to closed points. -/
def mapClosedPoint {X Y : Scheme.{u}} (f : X ⟶ Y) [IsFinite f] :
    ClosedPoint X → ClosedPoint Y := fun x =>
  ⟨f x.1, by simpa only [Set.image_singleton] using f.isClosedMap {x.1} x.2⟩

theorem mapClosedPoint_finite_preimage {X Y : Scheme.{u}} (f : X ⟶ Y) [IsFinite f]
    (s : Set (ClosedPoint Y)) (hs : s.Finite) :
    ((mapClosedPoint f) ⁻¹' s).Finite := by
  let t : Set X := f ⁻¹' (Subtype.val '' s)
  have ht : t.Finite := f.finite_preimage (hs.image Subtype.val)
  have hsubset : (mapClosedPoint f) ⁻¹' s ⊆ Subtype.val ⁻¹' t := by
    intro x hx
    exact ⟨mapClosedPoint f x, hx, rfl⟩
  exact (ht.preimage Subtype.val_injective.injOn).subset hsubset

noncomputable def schemeDivisorPullback {X Y : Scheme.{u}} (f : X ⟶ Y) [IsFinite f] :
    Litt3.Jacobians.Divisor (ClosedPoint Y) →+
      Litt3.Jacobians.Divisor (ClosedPoint X) :=
  divisorPullback (mapClosedPoint f) (mapClosedPoint_finite_preimage f)

abbrev FiniteEtaleSpan.divisorRelations {X Y : Scheme.{u}} (s : FiniteEtaleSpan X Y) :=
  DivisorRelationQuotient (mapClosedPoint s.left) (mapClosedPoint s.right)
    (mapClosedPoint_finite_preimage s.left) (mapClosedPoint_finite_preimage s.right)

end Litt3.SharedTensors

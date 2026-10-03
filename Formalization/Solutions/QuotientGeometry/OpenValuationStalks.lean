import Solutions.QuotientGeometry.OpenFunctionFields
import Mathlib.RingTheory.Valuation.ValuationRing

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

theorem valuation_ring_of_ring_equiv
    {R S : Type*} [CommRing R] [IsDomain R] [CommRing S] [IsDomain S]
    [ValuationRing R] (e : R ≃+* S) : ValuationRing S := by
  refine { cond' := ?_ }
  intro a b
  obtain ⟨c, h | h⟩ := ValuationRing.cond (e.symm a) (e.symm b)
  · exact ⟨e c, Or.inl (by simpa using congrArg e h)⟩
  · exact ⟨e c, Or.inr (by simpa using congrArg e h)⟩

universe u

/-- Genuine valuation stalks are preserved by actual open restriction,
through the TRUE original stalk-map RingEquiv. -/
theorem actual_open_valuation_stalks
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (f : X ⟶ Y) [IsOpenImmersion f]
    (hvaluation : ∀ y : Y, ValuationRing (Y.presheaf.stalk y)) (x : X) :
    ValuationRing (X.presheaf.stalk x) := by
  letI : ValuationRing (Y.presheaf.stalk (f x)) := hvaluation (f x)
  exact valuation_ring_of_ring_equiv
    (asIso (f.stalkMap x)).commRingCatIsoToRingEquiv

end Litt3.QuotientGeometry

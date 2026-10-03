import Definitions.QuotientGeometry.FunctionFieldRationalMaps
import Mathlib.AlgebraicGeometry.ValuativeCriterion

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.QuotientGeometry

universe u

/-- The actual valuative square at an actual source point.  Its fraction
field is the generic stalk of the same integral Scheme. -/
noncomputable def valuationStalkSquare
    {X Y S : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (sX : X ⟶ S) (sY : Y ⟶ S)
    (φ : Y.functionField →+* X.functionField) (hφ : GenericFieldMapOver sX sY φ)
    (x : X) [ValuationRing (X.presheaf.stalk x)] : ValuativeCommSq sY where
  R := X.presheaf.stalk x
  K := X.functionField
  i₁ := genericStalkSchemeMap φ
  i₂ := X.fromSpecStalk x ≫ sX
  commSq := ⟨by
    change genericStalkSchemeMap φ ≫ sY =
      Spec.map (X.presheaf.stalkSpecializes (genericPoint_specializes x)) ≫
        (X.fromSpecStalk x ≫ sX)
    rw [← Category.assoc, Scheme.SpecMap_stalkSpecializes_fromSpecStalk]
    exact hφ⟩

end Litt3.QuotientGeometry

import Definitions.QuotientGeometry.ProperFieldExtension

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry.Targets

universe u

/-- The genuine proper-map extension bridge. This does not assert
finiteness or etaleness of the extension. -/
def ProperCurveFieldMapExtension : Prop :=
  ∀ (X Y S : Scheme.{u}) [IsIntegral X] [IsIntegral Y] [Y.IsSeparated] [S.IsSeparated]
    (sX : X ⟶ S) (sY : Y ⟶ S) [IsProper sY]
    (φ : Y.functionField →+* X.functionField) (hφ : GenericFieldMapOver sX sY φ),
    (∀ x : X, ValuationRing (X.presheaf.stalk x)) →
    ∃! f : X ⟶ Y, f.toRationalMap = functionFieldRationalMap sX sY φ hφ ∧
      f ≫ sY = sX ∧ IsDominant f

end Litt3.QuotientGeometry.Targets

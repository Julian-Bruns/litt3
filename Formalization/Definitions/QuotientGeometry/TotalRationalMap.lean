import Mathlib.AlgebraicGeometry.RationalMap

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

/-- A rational map defined everywhere becomes a genuine Scheme morphism.
The equality of its actual domain with the entire source is explicit. -/
noncomputable def totalRationalMapMorphism
    {X Y : Scheme.{u}} [IsReduced X] [Y.IsSeparated]
    (r : X.RationalMap Y) (hdom : r.domain = ⊤) : X ⟶ Y :=
  X.topIso.inv ≫ (X.isoOfEq hdom).inv ≫ r.toPartialMap.hom

end Litt3.QuotientGeometry

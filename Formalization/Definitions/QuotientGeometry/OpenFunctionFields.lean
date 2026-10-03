import Mathlib.AlgebraicGeometry.FunctionField

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.QuotientGeometry

universe u

/-- The genuine generic-stalk equivalence of an actual open immersion.
It need not be surjective on the whole original Scheme. -/
noncomputable def actualOpenFunctionFieldEquiv
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (f : X ⟶ Y) [IsOpenImmersion f] : Y.functionField ≃+* X.functionField :=
  ((Y.presheaf.stalkCongr (.of_eq (genericPoint_eq_of_isOpenImmersion f))).symm ≪≫
    asIso (f.stalkMap (genericPoint X))).commRingCatIsoToRingEquiv

end Litt3.QuotientGeometry

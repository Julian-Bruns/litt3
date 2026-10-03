import Definitions.QuotientGeometry.FunctionFieldRationalMaps

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.QuotientGeometry

universe u

/-- The actual constants map is obtained from the actual structure
morphism to Spec K and the actual generic-point stalk inclusion. -/
noncomputable def genericBaseFieldHom
    {X : Scheme.{u}} [IsIntegral X] {K : Type u} [Field K]
    (sX : X ⟶ Spec (.of K)) : K →+* X.functionField :=
  (Spec.preimage (X.fromSpecStalk (genericPoint X) ≫ sX)).hom

/-- The actual base map on an actual open's ring of sections. -/
noncomputable def chartBaseFieldHom
    {X : Scheme.{u}} {K : Type u} [Field K]
    (sX : X ⟶ Spec (.of K)) (U : X.Opens) : K →+* Γ(X, U) :=
  ((Scheme.ΓSpecIso (.of K)).inv ≫ sX.appTop ≫
    X.presheaf.map (homOfLE le_top).op).hom

end Litt3.QuotientGeometry

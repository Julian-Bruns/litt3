import Definitions.QuotientGeometry.FunctionFieldRationalMaps

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.QuotientGeometry

universe u

/-- The ACTUAL coefficient-ring map into an original generic stalk,
constructed from the original structure map over Spec R. The base may
be any commutative ring, rather than only a constant field. -/
noncomputable def genericBaseRingHom
    {X : Scheme.{u}} [IsIntegral X] {R : Type u} [CommRing R]
    (sX : X ⟶ Spec (.of R)) : R →+* X.functionField :=
  (Spec.preimage (X.fromSpecStalk (genericPoint X) ≫ sX)).hom

end Litt3.QuotientGeometry

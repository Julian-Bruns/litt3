import Definitions.SharedTensors.SchemeDifferentialSheaf

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.SharedTensors

universe u

variable {k : Type u} [Field k] {X : Scheme.{u}}

/-- The constructed ORIGINAL differential presheaf has its genuine
universal derivation on every open. -/
noncomputable def schemePresheafUniversalDerivation (sX : X ⟶ Spec (.of k)) :
    (schemeDifferentialPresheaf sX).Derivation'
      (schemeConstantFieldPresheafMap sX) :=
  PresheafOfModules.DifferentialsConstruction.derivation'
    (schemeConstantFieldPresheafMap sX)

/-- Universality is proved for the actual original coefficient/section
diagram, using the literal universal module on every actual open. -/
noncomputable def schemePresheafUniversalDerivation_isUniversal
    (sX : X ⟶ Spec (.of k)) :
    (schemePresheafUniversalDerivation sX).Universal :=
  PresheafOfModules.DifferentialsConstruction.isUniversal'
    (schemeConstantFieldPresheafMap sX)

/-- The original differential restriction carries d(a) to d(res(a)),
including the empty open. -/
theorem schemeDifferentialPresheaf_restrict_derivative
    (sX : X ⟶ Spec (.of k)) {U V : X.Opens} (hVU : V ≤ U)
    (a : Γ(X, U)) :
    ((schemeDifferentialPresheaf sX).map (homOfLE hVU).op).hom
      (CommRingCat.KaehlerDifferential.d
        (f := (schemeConstantFieldPresheafMap sX).app (Opposite.op U)) a) =
      CommRingCat.KaehlerDifferential.d
        (f := (schemeConstantFieldPresheafMap sX).app (Opposite.op V))
        (X.presheaf.map (homOfLE hVU).op a) :=
  PresheafOfModules.DifferentialsConstruction.relativeDifferentials'_map_d
    (schemeConstantFieldPresheafMap sX) (homOfLE hVU).op a

end Litt3.SharedTensors

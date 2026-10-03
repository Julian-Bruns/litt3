import Solutions.SharedTensors.ConstantPrincipalDivisors
import Mathlib.RingTheory.Kaehler.Basic

open CategoryTheory AlgebraicGeometry

namespace Litt3.SharedTensors

open Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] {X : Scheme.{u}} [IsIntegral X]

/-- The actual local regular rational differentials: the image of the
universal differentials of the original scheme stalk in its function field.
All coefficient structures come from the actual structure morphism. -/
noncomputable def schemeLocalRegularDifferentials
    (sX : X ⟶ Spec (.of k)) (x : X) :
    letI := (genericBaseFieldHom sX).toAlgebra
    Submodule k (KaehlerDifferential k X.functionField) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (stalkBaseFieldHom sX x).toAlgebra
  letI : IsScalarTower k (X.presheaf.stalk x) X.functionField :=
    IsScalarTower.of_algebraMap_eq' (stalk_base_field_generic_compatibility sX x).symm
  exact LinearMap.range ((KaehlerDifferential.map k k (X.presheaf.stalk x)
    X.functionField).restrictScalars k)

/-- Rational differentials regular at every original closed point. This
definition does not assume an identification with sheaf cohomology. -/
noncomputable def schemeGlobalRegularDifferentials
    (sX : X ⟶ Spec (.of k)) :
    letI := (genericBaseFieldHom sX).toAlgebra
    Submodule k (KaehlerDifferential k X.functionField) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  exact ⨅ x : ClosedPoint X, schemeLocalRegularDifferentials sX x.val

end Litt3.SharedTensors

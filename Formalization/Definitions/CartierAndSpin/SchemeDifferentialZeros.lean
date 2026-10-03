import Definitions.CartierAndSpin.DifferentialZeroLattices
import Definitions.SharedTensors.SchemeRegularDifferentials

open CategoryTheory AlgebraicGeometry

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry

universe u

/-- Genuine original closed-point zeros of a rational differential:
membership in the image of m·Ω of the ENTIRE original stalk module. -/
noncomputable def schemeDifferentialZeroSet
    {k : Type u} [Field k] {X : Scheme.{u}} [IsIntegral X]
    (sX : X ⟶ Spec (.of k)) :
    letI := (genericBaseFieldHom sX).toAlgebra
    KaehlerDifferential k X.functionField → Set (ClosedPoint X) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega
  exact {x | by
    letI := (stalkBaseFieldHom sX x.val).toAlgebra
    letI : IsScalarTower k (X.presheaf.stalk x.val) X.functionField :=
      IsScalarTower.of_algebraMap_eq' (stalk_base_field_generic_compatibility sX x.val).symm
    exact differentialZeroLattice (R := X.presheaf.stalk x.val) omega}

end Litt3.CartierAndSpin

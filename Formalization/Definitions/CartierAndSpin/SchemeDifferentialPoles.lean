import Definitions.SharedTensors.SchemeRegularDifferentials

open CategoryTheory AlgebraicGeometry

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry

universe u

/-- The literal set of original closed points at which an actual
rational universal differential is outside the original stalk image. -/
noncomputable def schemeDifferentialPoleSet
    {k : Type u} [Field k] {X : Scheme.{u}} [IsIntegral X]
    (sX : X ⟶ Spec (.of k)) :
    letI := (genericBaseFieldHom sX).toAlgebra
    KaehlerDifferential k X.functionField → Set (ClosedPoint X) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  exact fun omega => {x | omega ∉ schemeLocalRegularDifferentials sX x.val}

end Litt3.CartierAndSpin

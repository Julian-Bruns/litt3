import Definitions.Jacobians.SchemeDivisors
import Mathlib.RingTheory.DedekindDomain.Dvr

open AlgebraicGeometry

namespace Litt3.Jacobians

universe u

def ChartClosedPoint {X : Scheme.{u}} (U : X.Opens) :=
  {x : Litt3.SharedTensors.ClosedPoint X // x.val ∈ U}

/-- The actual height-one ideal corresponding to an actual closed point
inside a nonempty affine Dedekind chart. -/
noncomputable def chartHeightOne
    {X : Scheme.{u}} {U : X.Opens} (hU : IsAffineOpen U)
    [IsDedekindDomain Γ(X, U)] (hfield : ¬IsField Γ(X, U)) (x : ChartClosedPoint U) :
    IsDedekindDomain.HeightOneSpectrum Γ(X, U) where
  asIdeal := (hU.primeIdealOf ⟨x.val.val, x.property⟩).asIdeal
  isPrime := inferInstance
  ne_bot := Ring.ne_bot_of_isMaximal_of_not_isField
    (hU.primeIdealOf_isMaximal_of_isClosed ⟨x.val.val, x.property⟩ x.val.property) hfield

end Litt3.Jacobians

import Definitions.QuotientGeometry.QuadraticPlaneModels
import Mathlib.AlgebraicGeometry.AffineScheme

namespace Litt3.QuotientGeometry

noncomputable def quadraticPlaneAffineScheme
    {k : Type*} [Field k] (p : Polynomial k) : AlgebraicGeometry.Scheme :=
  AlgebraicGeometry.Spec (CommRingCat.of (QuadraticPlaneCoordinateRing p))

end Litt3.QuotientGeometry

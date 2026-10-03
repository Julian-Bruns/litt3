import Definitions.CurveArithmetic.HyperellipticAffineModels
import Mathlib.AlgebraicGeometry.AffineScheme

namespace Litt3.CurveArithmetic

noncomputable def finiteBranchAffineScheme
    (K : Type*) [Field K] [Fintype K] {L : Type*} [CommRing L] (a : L) :
    AlgebraicGeometry.Scheme :=
  AlgebraicGeometry.Scheme.Spec.obj (Opposite.op
    (CommRingCat.of (FiniteBranchCoordinateRing K a)))

end Litt3.CurveArithmetic

import Definitions.CurveArithmetic.HyperellipticAffineModels

namespace Litt3.CurveArithmetic.Targets

def FiniteBranchAffineCoordinateIsomorphism : Prop :=
  ∀ (K L : Type) [Field K] [Fintype K] [Field L] [Algebra K L]
    (u : Kˣ) (v : K) (a : L),
    Nonempty (FiniteBranchCoordinateRing K (finiteAffineTransform u v a) ≃ₐ[L]
      FiniteBranchCoordinateRing K a)

end Litt3.CurveArithmetic.Targets

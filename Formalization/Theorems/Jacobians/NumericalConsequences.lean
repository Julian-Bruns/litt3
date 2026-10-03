import Definitions.Jacobians.NumericalInputs

namespace Litt3.Jacobians.Targets

/-- A concrete numerical component of Rosati saturation, not the
curve-map factorization theorem. -/
def RosatiSaturationNumerical : Prop :=
  ∀ (K : Type) [Field K] [LinearOrder K] [IsStrictOrderedRing K]
    (a b c genus trace : K),
    0 < a → 1 < genus → c ≤ b →
    JointImageTraceBound a b c genus trace →
    trace = 2 * a * b * genus → c = b

/-- The numerical obstruction to rank-one defect on an abelian divisor.
The Raynaud dimension inequality itself is not assumed proved here. -/
def AbelianDivisorRankOneImpossible : Prop :=
  ∀ (K : Type) [Field K] [LinearOrder K] [IsStrictOrderedRing K]
    (characteristic genus : K),
    1 < genus →
    ¬ RankOneDimensionBound characteristic genus (genus - 1)

end Litt3.Jacobians.Targets

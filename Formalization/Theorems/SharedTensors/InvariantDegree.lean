import Definitions.SharedTensors.InvariantDegree

namespace Litt3.SharedTensors

/-- Literal equality of the actual invariant degree image and the full
degree image. Geometric Picard descent is a separate assertion. -/
def FixedDegreeImage {G A B : Type*} [Group G] [AddCommGroup A] [AddCommGroup B]
    (d : A →+ B) (rho : G →* AddAut A) : Prop :=
  (fixedDegreeMap d rho).range = d.range

end Litt3.SharedTensors

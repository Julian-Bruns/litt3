import Definitions.Deformations.CorestrictionDescent

namespace Litt3.Deformations.Specifications

variable {V W : Type*} [AddCommGroup V] [AddCommGroup W]

/-- A specified point descends exactly when its whole trace-free
component vanishes. -/
def SpecifiedPointDescent (pullback : V →+ W) (retraction : W →+ V) : Prop :=
  ∀ w, (∃ v, pullback v = w) ↔ traceFreePart pullback retraction w = 0

end Litt3.Deformations.Specifications

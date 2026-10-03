import Mathlib.FieldTheory.IntermediateField.Adjoin.Basic
import Mathlib.RingTheory.Derivation.Basic

namespace Litt3.CartierAndSpin.Specifications

/-- The actual slope/intercept field contains both original coordinates. -/
def GaussFieldRecoversCoordinates {k L : Type*} [Field k] [Field L] [Algebra k L]
    (D : Derivation k L L) (u v : L) : Prop :=
  u ∈ IntermediateField.adjoin k ({D v, v - u * D v} : Set L) ∧
  v ∈ IntermediateField.adjoin k ({D v, v - u * D v} : Set L)

end Litt3.CartierAndSpin.Specifications

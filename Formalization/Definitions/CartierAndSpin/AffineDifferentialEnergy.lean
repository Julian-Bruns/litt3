import Mathlib.Algebra.Algebra.Basic
import Mathlib.Algebra.GroupWithZero.Units.Basic

namespace Litt3.CartierAndSpin

/-- Actual multiplication of an algebra unit by a nonzero base scalar. -/
def scaledAlgebraUnit {K A : Type*} [Field K] [CommRing A] [Algebra K A]
    (a : K) (ha : a ≠ 0) (unit : Aˣ) : Aˣ :=
  Units.map (algebraMap K A).toMonoidHom (Units.mk0 a ha) * unit

end Litt3.CartierAndSpin

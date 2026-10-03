import Mathlib.FieldTheory.Finite.Basic
import Mathlib.LinearAlgebra.FiniteDimensional.Basic

namespace Litt3.Atlases

variable (K A : Type*) [Field K] [Fintype K] [CommRing A] [Algebra K A]

/-- The actual cardinality-power Frobenius, linear over a finite coefficient field. -/
def qFrobenius : Module.End K A := (FiniteField.frobeniusAlgHom K A).toLinearMap

end Litt3.Atlases

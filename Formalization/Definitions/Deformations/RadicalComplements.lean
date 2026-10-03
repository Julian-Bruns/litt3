import Mathlib.LinearAlgebra.BilinearForm.Orthogonal
import Mathlib.LinearAlgebra.Matrix.BilinearForm
import Mathlib.LinearAlgebra.Basis.VectorSpace

namespace Litt3.Deformations

open LinearMap

variable {k V : Type*} [Field k] [AddCommGroup V] [Module k V]

/-- The complete left radical of an actual bilinear form. -/
abbrev BilinearRadical (B : LinearMap.BilinForm k V) : Submodule k V := LinearMap.ker B

end Litt3.Deformations

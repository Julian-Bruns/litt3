import Mathlib.LinearAlgebra.Matrix.BilinearForm
import Mathlib.LinearAlgebra.BilinearForm.Orthogonal

namespace Litt3.Deformations

variable {k ι : Type*} [Field k] [Fintype ι] [DecidableEq ι]

/-- The actual bilinear form represented by the complete
residue matrix in the coordinate basis. -/
noncomputable def residueMatrixForm (A : Matrix ι ι k) : LinearMap.BilinForm k (ι → k) :=
  Matrix.toBilin' A

end Litt3.Deformations

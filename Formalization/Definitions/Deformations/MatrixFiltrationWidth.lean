import Definitions.Deformations.MultiplicativeFiltration
import Mathlib.LinearAlgebra.Pi
import Mathlib.Data.Matrix.Basic

namespace Litt3.Deformations

variable {k A ι : Type*} [Field k] [Ring A] [Algebra k A]

/-- The actual coefficient-linear row-matrix operator over
an arbitrary noncommutative coefficient algebra. -/
noncomputable def rightMatrixOperator [Fintype ι] (M : Matrix ι ι A) :
    (ι → A) →ₗ[k] (ι → A) :=
  LinearMap.pi fun j => ∑ i, (LinearMap.mulRight k (M i j)).comp (LinearMap.proj i)

def coordinateFiltration (F : ℕ → Submodule k A) (i : ℕ) : Submodule k (ι → A) :=
  Submodule.pi Set.univ (fun _ => F i)

end Litt3.Deformations

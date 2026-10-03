import Definitions.Deformations.MatrixFiltrationWidth
import Mathlib.Algebra.Algebra.Operations
import Mathlib.RingTheory.Jacobson.Radical

namespace Litt3.Deformations

variable {k A : Type*} [Field k] [Ring A] [Algebra k A]

/-- Actual ideal powers as k-subspaces, with the full ring in
degree zero rather than the scalar line. -/
def subspaceIdealPowerFiltration (J : Submodule k A) : ℕ → Submodule k A
  | 0 => ⊤
  | n + 1 => J ^ (n + 1)

/-- The genuine noncommutative Jacobson radical viewed over k. -/
def jacobsonRadicalSubspace : Submodule k A := (Ring.jacobson A).restrictScalars k

def jacobsonRadicalFiltration : ℕ → Submodule k A :=
  subspaceIdealPowerFiltration (jacobsonRadicalSubspace (k := k) (A := A))

end Litt3.Deformations

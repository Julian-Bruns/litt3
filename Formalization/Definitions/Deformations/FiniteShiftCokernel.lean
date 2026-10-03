import Definitions.Deformations.PreparedFiniteShift
import Mathlib.LinearAlgebra.Quotient.Basic

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- The actual scalar-multiple submodule of the original coefficient module. -/
def coefficientScalarRange (scalar : R) : Submodule R K :=
  LinearMap.range (scalar • (LinearMap.id : K →ₗ[R] K))

/-- The literal constant coordinate and the literal positive-degree
residue coordinates of a truncated coefficient vector. -/
def finiteShiftCokernelMap (n : ℕ) (scalar : R) :
    (Fin (n + 1) → K) →ₗ[R] K × (Fin n → K ⧸ coefficientScalarRange scalar) where
  toFun v := (v 0, fun i => (coefficientScalarRange scalar).mkQ (v i.succ))
  map_add' v w := by
    apply Prod.ext
    · rfl
    · funext i
      exact map_add _ _ _
  map_smul' c v := by
    apply Prod.ext
    · rfl
    · funext i
      exact map_smul _ _ _

end Litt3.Deformations

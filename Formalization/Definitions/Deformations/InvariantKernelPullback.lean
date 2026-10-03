import Definitions.Deformations.InvariantCokernelObstruction

namespace Litt3.Deformations.InvariantDescentSquare

universe u

variable {k G L U DL DU : Type u} [Field k] [Group G]
    [AddCommGroup L] [Module k L] [AddCommGroup U] [Module k U]
    [AddCommGroup DL] [Module k DL] [AddCommGroup DU] [Module k DU]
    (square : InvariantDescentSquare k G L U DL DU)

/-- The actual comparison square restricts its source pullback to
the actual lower kernel and lands in the actual upper kernel. -/
def kernelPullback : LinearMap.ker square.lowerMap →ₗ[k] LinearMap.ker square.upperMap where
  toFun d := ⟨square.sourcePullback d.1, by
    change square.upperMap (square.sourcePullback d.1) = 0
    calc
      square.upperMap (square.sourcePullback d.1) = square.targetPullback (square.lowerMap d.1) :=
        LinearMap.congr_fun square.commutes d.1
      _ = 0 := by rw [show square.lowerMap d.1 = 0 from d.2, map_zero]⟩
  map_add' d e := Subtype.ext (square.sourcePullback.map_add d.1 e.1)
  map_smul' a d := Subtype.ext (square.sourcePullback.map_smul a d.1)

end Litt3.Deformations.InvariantDescentSquare

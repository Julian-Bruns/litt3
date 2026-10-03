import Mathlib.Algebra.Group.Subgroup.Ker
import Mathlib.Algebra.Group.Prod
import Mathlib.Algebra.AddTorsor.Defs

namespace Litt3.CartierAndSpin

variable {A B W : Type*} [AddCommGroup A] [AddCommGroup B] [AddCommGroup W]

/-- The original two-endpoint additive difference, with both maps. -/
def endpointDifferentialDifference (mA : A →+ W) (mB : B →+ W) : A × B →+ W :=
  mB.comp (AddMonoidHom.snd A B) - mA.comp (AddMonoidHom.fst A B)

/-- Literal pairs of endpoint forms with specified original difference. -/
def endpointDecompositionFiber (mA : A →+ W) (mB : B →+ W) (omega : W) :=
  {ab : A × B // endpointDifferentialDifference mA mB ab = omega}

end Litt3.CartierAndSpin

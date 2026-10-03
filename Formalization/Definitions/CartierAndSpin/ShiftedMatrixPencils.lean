import Definitions.CartierAndSpin.OrderedCommutatorStacks

namespace Litt3.CartierAndSpin

variable {R n : Type*} [CommRing R] [Fintype n] [DecidableEq n]

/-- The actual vertical pencil stack, with both original matrix blocks. -/
def shiftedPencilStack (U V : Matrix n n R) (a b : R) :
    Matrix (Sum n n) n R := Sum.elim (a • (1 : Matrix n n R) + U)
      (b • (1 : Matrix n n R) + V)

end Litt3.CartierAndSpin

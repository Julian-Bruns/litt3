import Definitions.CartierAndSpin.OrderedCommutatorStacks
import Mathlib.LinearAlgebra.Matrix.ToLinearEquiv

namespace Litt3.CartierAndSpin

variable {R n : Type*} [CommRing R] [Fintype n] [DecidableEq n]

/-- Every pair of positive power exponents below the column count. -/
abbrev PowerCommutatorPairs (n : Type*) [Fintype n] :=
  Fin (Fintype.card n - 1) × Fin (Fintype.card n - 1)

/-- The literal rectangular alternative stack, with all original rows. -/
def powerCommutatorStack (U V : Matrix n n R) :
    Matrix (PowerCommutatorPairs n × n) n R := fun i j =>
  (U ^ (i.1.1.val + 1) * V ^ (i.1.2.val + 1) -
    V ^ (i.1.2.val + 1) * U ^ (i.1.1.val + 1)) i.2 j

/-- The literal finite intersection in the canonical power criterion. -/
def boundedPowerCommutatorKernel (U V : Matrix n n R) : Submodule R (n → R) :=
  ⨅ i : Fin (Fintype.card n - 1), ⨅ j : Fin (Fintype.card n - 1),
    LinearMap.ker (Matrix.toLin' (U ^ (i.val + 1) * V ^ (j.val + 1) -
      V ^ (j.val + 1) * U ^ (i.val + 1)))

end Litt3.CartierAndSpin

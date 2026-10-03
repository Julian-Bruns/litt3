import Definitions.CartierAndSpin.CommutatorRows

namespace Litt3.CartierAndSpin

/-- All actual ordered word exponents with total degree at most d. -/
abbrev OrderedCommutatorPairs (d : ℕ) := Σ a : Fin (d + 1), Fin (d + 1 - a.val)

variable {R n : Type*} [CommRing R] [Fintype n] [DecidableEq n]

/-- Literal stack of all CU^aV^b blocks, with every matrix row retained. -/
def orderedCommutatorStack (U V : Matrix n n R) (d : ℕ) :
    Matrix (OrderedCommutatorPairs d × n) n R := fun i j =>
  ((U * V - V * U) * U ^ i.1.1.val * V ^ i.1.2.val) i.2 j

end Litt3.CartierAndSpin

import Definitions.CartierAndSpin.SplitResidues
import Mathlib.Algebra.Algebra.Pi
import Mathlib.Algebra.Polynomial.AlgebraMap
import Mathlib.RingTheory.Ideal.Quotient.Operations

namespace Litt3.CartierAndSpin

open Polynomial

variable {K ι : Type*} [Field K]

/-- Evaluation at all nodes as an actual algebra map to the split algebra. -/
noncomputable def splitPolynomialEvaluation (node : ι → K) : K[X] →ₐ[K] (ι → K) :=
  Pi.algHom K (fun _ : ι => K) fun i => Polynomial.aeval (node i)

end Litt3.CartierAndSpin

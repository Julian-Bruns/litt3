import Mathlib.Algebra.Polynomial.Derivative
import Mathlib.LinearAlgebra.Lagrange

namespace Litt3.CartierAndSpin

open Polynomial

variable {K ι : Type*} [Field K]

/-- The root-residue sum for an actual polynomial and a finite split-root
family. When the roots are simple this is the split trace of `P/F'`. -/
noncomputable def splitPolynomialResidueSum (s : Finset ι) (node : ι → K) (P F : K[X]) : K :=
  ∑ i ∈ s, P.eval (node i) / F.derivative.eval (node i)

end Litt3.CartierAndSpin

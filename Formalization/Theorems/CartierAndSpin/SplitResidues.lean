import Definitions.CartierAndSpin.SplitResidues

namespace Litt3.CartierAndSpin.Specifications

open Polynomial

variable {K ι : Type*} [Field K]

/-- The characteristic-independent split interpolation input to the source
trace identities. Both the polynomial and all distinct roots are explicit. -/
def SplitPolynomialLowResidueVanishing (s : Finset ι) (node : ι → K)
    (P : K[X]) (c : K) : Prop :=
  Set.InjOn node s →
  P.degree < (s.card - 1 : ℕ) →
    splitPolynomialResidueSum s node P (C c * Lagrange.nodal s node) = 0

end Litt3.CartierAndSpin.Specifications

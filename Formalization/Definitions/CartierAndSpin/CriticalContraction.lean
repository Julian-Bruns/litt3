import Mathlib.Algebra.Polynomial.Div

namespace Litt3.CartierAndSpin

open Polynomial

noncomputable section

/-- The polynomial part of `D(T) ∑_{j<d} n_j T^(-j-1)`, formed by
actual division by monic powers. It remains defined at every degree drop. -/
def criticalTraceContraction {R : Type*} [CommRing R]
    (D : R[X]) (n : ℕ → R) (d : ℕ) : R[X] :=
  ∑ j ∈ Finset.range d, C (n j) * (D /ₘ X ^ (j + 1))

end
end Litt3.CartierAndSpin

import Definitions.Deformations.TruncatedCoefficientRing

namespace Litt3.Deformations

variable {k ι : Type*} [CommRing k] [Fintype ι] [DecidableEq ι]

/-- Actual matrix chain maps and homotopies between two minimal
two-term complexes over the actual truncated coefficient algebra. -/
structure MinimalTwoTermHomotopyEquivalence (N : ℕ) (positive : 0 < N)
    (A B : Matrix ι ι (TruncatedCoefficientRing k N)) where
  f₀ : Matrix ι ι (TruncatedCoefficientRing k N)
  f₁ : Matrix ι ι (TruncatedCoefficientRing k N)
  g₀ : Matrix ι ι (TruncatedCoefficientRing k N)
  g₁ : Matrix ι ι (TruncatedCoefficientRing k N)
  hC : Matrix ι ι (TruncatedCoefficientRing k N)
  hD : Matrix ι ι (TruncatedCoefficientRing k N)
  source_minimal : (truncatedResidue k N positive).mapMatrix A = 0
  target_minimal : (truncatedResidue k N positive).mapMatrix B = 0
  forward_chain_map : f₁ * A = B * f₀
  inverse_chain_map : g₁ * B = A * g₀
  source_zero_homotopy : g₀ * f₀ = 1 + hC * A
  source_one_homotopy : g₁ * f₁ = 1 + A * hC
  target_zero_homotopy : f₀ * g₀ = 1 + hD * B
  target_one_homotopy : f₁ * g₁ = 1 + B * hD

end Litt3.Deformations

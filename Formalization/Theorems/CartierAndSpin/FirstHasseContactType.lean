import Solutions.CartierAndSpin.TruncatedHasseDerivatives

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {L : Type*} [Field L] {p : ℕ} [Fact p.Prime] [CharP L p]

/-- Literal first tangent contact, measured by the genuine field Taylor
coefficients rather than an unspecified higher-derivative operation. -/
def FirstHasseContactType (b : PowerPBasis L p) (v : L) : Prop :=
  ∃ e q : ℕ, 2 ≤ q ∧ q < p ^ e ∧
    (q = 2 ∨ ∃ r : ℕ, 0 < r ∧ q = p ^ r) ∧
    truncatedHasseDerivative b e q v ≠ 0 ∧
    ∀ j : ℕ, 2 ≤ j → j < q → truncatedHasseDerivative b e j v = 0

end Litt3.CartierAndSpin

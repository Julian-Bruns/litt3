import Mathlib.Data.Nat.Basic

namespace Litt3.QuotientGeometry.Targets

/-- The character-twist orbit exponent controls the first-break divisor.
Constructing the character orbits from a faithful local action remains a
separate geometric and representation-theoretic obligation. -/
def SwanOrbitExponentBound : Prop :=
  ∀ rank degreeExponent stabilizerExponent : ℕ,
    stabilizerExponent ≤ rank → stabilizerExponent ≤ 2 * degreeExponent →
    (rank + 1) / 2 ≤ rank - stabilizerExponent + degreeExponent

end Litt3.QuotientGeometry.Targets

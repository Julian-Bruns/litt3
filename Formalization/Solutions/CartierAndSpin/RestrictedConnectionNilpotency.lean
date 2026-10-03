import Solutions.CartierAndSpin.RestrictedConnectionMinimalPolynomial

namespace Litt3.CartierAndSpin

open Polynomial Litt3.SharedTensors

variable {K : Type*} [Field K] {p : ℕ} [Fact p.Prime] [CharP K p]

/-- NO genuine connection power below p vanishes. This derives the
entire minimal-nilpotency boundary without any Jordan matrix. -/
theorem actual_normalized_connection_power_ne_zero_below_characteristic
    (b : PowerPBasis K p) (D : Derivation (frobeniusSubfield K p) K K)
    (hDt : D b.parameter = 1) (f : K) (n : ℕ) (hn : n < p) :
    (scalarDerivationConnection D f) ^ n ≠ 0 := by
  intro hzero
  have hdiv : minpoly (frobeniusSubfield K p) (scalarDerivationConnection D f) ∣
      (X : (frobeniusSubfield K p)[X]) ^ n :=
    minpoly.dvd _ _ (by simpa only [Polynomial.aeval_X_pow] using hzero)
  have hle := Polynomial.natDegree_le_of_dvd hdiv
    (pow_ne_zero n (Polynomial.X_ne_zero (R := frobeniusSubfield K p)))
  rw [actual_normalized_connection_minpoly_degree b D hDt f,
    Polynomial.natDegree_X_pow] at hle
  exact (not_le_of_gt hn) hle

/-- Literal curvature zero has EXACT nilpotency exponent p: its pth
power vanishes and every smaller whole operator power is nonzero. -/
theorem actual_normalized_connection_exact_nilpotency
    (b : PowerPBasis K p) (D : Derivation (frobeniusSubfield K p) K K)
    (hDt : D b.parameter = 1) (f : K)
    (hcurvature : D^[p - 1] f + f ^ p = 0) :
    (scalarDerivationConnection D f) ^ p = 0 ∧
      ∀ n : ℕ, n < p → (scalarDerivationConnection D f) ^ n ≠ 0 := by
  constructor
  · ext a
    rw [Module.End.pow_apply,
      actual_normalized_derivation_restricted_connection_identity b D hDt f,
      hcurvature, neg_zero, zero_mul]
    rfl
  · exact actual_normalized_connection_power_ne_zero_below_characteristic b D hDt f

end Litt3.CartierAndSpin

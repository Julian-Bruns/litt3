import Solutions.Deformations.OriginalQuadraticFrobeniusTruncation

namespace Litt3.Deformations

variable (K : Type*) [Field K] (p : ℕ) [Fact p.Prime] [CharP K p]

/-- The entire ORIGINAL unequal binary source clause. Its displayed
Q>P inequality alone derives the preparation degree bound. The lower
power may be any positive integer, including one. -/
theorem original_unequal_binary_quadratic_truncation_length
    (oddCharacteristic : p ≠ 2) (n P : ℕ) (positiveP : 0 < P) (smaller : P < p ^ n) :
    Specifications.OriginalQuadraticFrobeniusTruncationLength K 1 p n (fun _ => P) := by
  apply original_quadratic_frobenius_truncation_length_odd_characteristic K p
    oddCharacteristic 1 (fun _ => P) (fun _ => positiveP) n
  simp only [Fin.sum_univ_one]
  omega

end Litt3.Deformations

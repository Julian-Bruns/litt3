import Solutions.Deformations.BasisWeightedPowers

namespace Litt3.Deformations

theorem basis_weight_exponent_monotone (w b d e : ℕ) (positive : 0 < w)
    (bound : d ≤ e) : basisWeightExponent w d b ≤ basisWeightExponent w e b := by
  apply (basis_weight_exponent_le w d b _ positive).mpr
  exact bound.trans (basis_weight_exponent_reaches w e b positive)

theorem basis_weight_successor_exponent (w d b : ℕ) (positive : 0 < w) :
    basisWeightExponent w (d + 1) b =
      if w * basisWeightExponent w d b + b = d then
        basisWeightExponent w d b + 1 else basisWeightExponent w d b := by
  split_ifs with exactWeight
  · apply Nat.le_antisymm
    · apply (basis_weight_exponent_le w (d + 1) b _ positive).mpr
      rw [Nat.mul_add, Nat.mul_one]
      omega
    · have cannot : ¬ basisWeightExponent w (d + 1) b ≤ basisWeightExponent w d b := by
        intro smaller
        have contradiction := (basis_weight_exponent_le w (d + 1) b _ positive).mp smaller
        rw [exactWeight] at contradiction
        omega
      omega
  · apply Nat.le_antisymm
    · apply (basis_weight_exponent_le w (d + 1) b _ positive).mpr
      have reached := basis_weight_exponent_reaches w d b positive
      omega
    · exact basis_weight_exponent_monotone w b d (d + 1) positive (by omega)

end Litt3.Deformations

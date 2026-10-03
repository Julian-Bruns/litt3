import Theorems.Deformations.ElementaryPrimeCriticalDimensions

namespace Litt3.Deformations

open scoped LinearAlgebra.Projectivization ElementaryPrimeGradedScalars

variable (p r a : ℕ) [Fact p.Prime]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]
variable [Fintype (ℙ (ZMod p) (Fin r → ZMod p))]

local instance : Fact (0 < r + 1) := ⟨by omega⟩

theorem elementary_prime_critical_dimensions
    (large : 2 < p) (positive : 0 < r)
    (principalLower : 2 ≤ a) (degreeBound : a + 1 ≤ p - 1) :
    Specifications.ElementaryPrimeCriticalDimensions p r a k := by
  have weightPositive : 0 < p - 1 := by omega
  have topPositive : 0 < (p - 1) * r := Nat.mul_pos weightPositive positive
  have sourceIndex : (p - 1) * r - 1 + 1 = (p - 1) * r := by omega
  have sourceNonzero : ((p - 1) * r - 1) % (p - 1) ≠ 0 := by
    intro zero
    have modulo := congrArg (fun n => n % (p - 1)) sourceIndex
    simp [Nat.add_mod, zero, Nat.mod_eq_of_lt (show 1 < p - 1 by omega)] at modulo
  have targetIndex : (p - 1) * r + a - 1 + 1 = (p - 1) * r + a := by omega
  have targetNonzero : ((p - 1) * r + a - 1) % (p - 1) ≠ 0 := by
    intro zero
    have modulo := congrArg (fun n => n % (p - 1)) targetIndex
    simp [Nat.add_mod, zero, Nat.mod_eq_of_lt (show 1 < p - 1 by omega),
      Nat.mod_eq_of_lt (show a < p - 1 by omega)] at modulo
    omega
  constructor
  · exact elementary_prime_witt_graded_projective_finrank p (r + 1) k r
      ((p - 1) * r - 1) (by rw [Nat.mul_add, Nat.mul_one]; omega) le_rfl sourceNonzero
  · exact elementary_prime_witt_graded_projective_finrank p (r + 1) k r
      ((p - 1) * r + a - 1) (by rw [Nat.mul_add, Nat.mul_one]; omega) (by omega) targetNonzero

end Litt3.Deformations

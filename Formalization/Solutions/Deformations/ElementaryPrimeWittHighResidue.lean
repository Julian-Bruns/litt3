import Solutions.Deformations.ElementaryPrimeWittRepairCoordinates

namespace Litt3.Deformations

open scoped BigOperators

variable (p N : ℕ) [Fact p.Prime] [Fact (0 < N)]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Nontrivial (TruncatedWittVector p N k) :=
  truncated_witt_nontrivial p N (Fact.out : 0 < N) k

/-- Above the full original normal degree every coefficient is divisible
by the actual prime; hence the literal whole group-algebra residue is zero. -/
theorem elementary_prime_witt_high_residue_zero (r d : ℕ)
    (high : (p - 1) * r < d)
    (x : AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p))
    (member : x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p N k)
      p (Fact.out : p.Prime).pos r d) :
    AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod p)
      (truncatedWittResidue p N (Fact.out : 0 < N) k) x = 0 := by
  classical
  apply (elementary_prime_witt_prime_space_residue p N k r x).mp
  apply (elementary_prime_witt_prime_space_coordinates p N k r x).mpr
  intro alpha
  have degreeBound : (∑ i, (alpha i).val) ≤ (p - 1) * r := by
    have bound := Finset.sum_le_sum (s := Finset.univ) (f := fun i => (alpha i).val)
      (g := fun _ : Fin r => p - 1) (fun i _ => Nat.le_pred_of_lt (alpha i).isLt)
    simpa only [Finset.sum_const, Finset.card_univ, Fintype.card_fin, smul_eq_mul,
      Nat.mul_comm] using bound
  have first : 1 ≤ basisWeightExponent (p - 1) d (∑ i, (alpha i).val) := by
    by_contra absent
    have weighted := (basis_weight_exponent_le (p - 1) d (∑ i, (alpha i).val) 0
      (by have := (Fact.out : p.Prime).two_le; omega)).mp (by omega)
    omega
  have coefficient := (elementary_normal_weight_coordinate_iff (R := TruncatedWittVector p N k)
    p (Fact.out : p.Prime).pos (Fact.out : p.Prime).one_lt r d x).mp member alpha
  obtain ⟨z, equation⟩ := (pow_dvd_pow (p : TruncatedWittVector p N k) first).trans coefficient
  simp only [pow_one] at equation
  rw [equation, map_mul, map_natCast, CharP.cast_eq_zero k p, zero_mul]

end Litt3.Deformations

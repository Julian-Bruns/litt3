import Theorems.Deformations.TruncatedMatrixValuation
import Solutions.Deformations.TruncatedSymmetry

namespace Litt3.Deformations

variable {k ι κ : Type*} [CommRing k]

/-- Minimum entry valuation and its actual factorization are
proved uniformly, without enumerating entries or assuming a
pre-existing Smith form. Even infinite matrix index types and
coefficient rings with zero divisors are allowed. -/
theorem truncated_matrix_valuation (N : ℕ) (positive : 0 < N) :
    Specifications.TruncatedMatrixValuation (k := k) (ι := ι) (κ := κ) N positive := by
  classical
  intro A nonzero
  have hentry : ∃ i j, A i j ≠ 0 := by
    by_contra h
    apply nonzero
    ext i j
    exact not_ne_iff.mp (fun hn => h ⟨i, j, hn⟩)
  let P := fun e : ℕ => ∃ i j, A i j ∉ LinearMap.range (truncatedPowerMultiplication k N (e + 1))
  have existsFailure : ∃ e, P e := by
    obtain ⟨i, j, h⟩ := hentry
    refine ⟨N - 1, i, j, ?_⟩
    intro hm
    obtain ⟨y, hy⟩ := hm
    change truncatedParameter k N ^ (N - 1 + 1) * y = A i j at hy
    rw [Nat.sub_add_cancel (Nat.one_le_iff_ne_zero.mpr positive.ne'),
      truncated_parameter_pow, zero_mul] at hy
    exact h hy.symm
  let e := Nat.find existsFailure
  have he : e < N := by
    have h := Nat.find_min' existsFailure (show P (N - 1) from by
      obtain ⟨i, j, hn⟩ := hentry
      refine ⟨i, j, ?_⟩
      intro hm
      obtain ⟨y, hy⟩ := hm
      change truncatedParameter k N ^ (N - 1 + 1) * y = A i j at hy
      rw [Nat.sub_add_cancel (Nat.one_le_iff_ne_zero.mpr positive.ne'),
        truncated_parameter_pow, zero_mul] at hy
      exact hn hy.symm)
    dsimp [e]
    omega
  have divisible : ∀ i j, A i j ∈ LinearMap.range (truncatedPowerMultiplication k N e) := by
    intro i j
    by_cases hezero : e = 0
    · rw [hezero]
      exact ⟨A i j, by change truncatedParameter k N ^ 0 * A i j = A i j; rw [pow_zero, one_mul]⟩
    · by_contra hn
      have hprev := Nat.find_min existsFailure (show e - 1 < Nat.find existsFailure by
        change e - 1 < e
        omega)
      apply hprev
      refine ⟨i, j, ?_⟩
      have heindex : e - 1 + 1 = e := by omega
      simpa only [heindex] using hn
  choose B hB using fun i j => LinearMap.mem_range.mp (divisible i j)
  have hfactor : A = truncatedParameter k N ^ e • B := by
    ext i j
    exact (hB i j).symm
  obtain ⟨i, j, notDivisible⟩ := Nat.find_spec existsFailure
  refine ⟨e, he, B, hfactor, i, j, ?_⟩
  intro hz
  obtain ⟨y, hy⟩ := truncated_scalar_decomposition N positive (B i j)
  rw [hz, map_zero, zero_add] at hy
  apply notDivisible
  refine ⟨y, ?_⟩
  change truncatedParameter k N ^ (e + 1) * y = A i j
  rw [← hB i j]
  change truncatedParameter k N ^ (e + 1) * y = truncatedParameter k N ^ e * B i j
  rw [hy, pow_succ, mul_assoc]

end Litt3.Deformations

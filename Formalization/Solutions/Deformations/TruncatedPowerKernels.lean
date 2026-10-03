import Theorems.Deformations.TruncatedPowerKernels
import Solutions.Deformations.TruncatedCoefficientRing
import Mathlib.Algebra.Polynomial.Div

namespace Litt3.Deformations

open Polynomial

variable {k : Type*} [CommRing k]

/-- Cancellation of a power of X holds over arbitrary coefficient
rings, using coefficient shifts rather than a domain assumption. -/
theorem polynomial_power_divisibility_shift (N j : ℕ) (bound : j ≤ N)
    (P : Polynomial k) :
    (X : Polynomial k) ^ N ∣ X ^ j * P ↔ X ^ (N - j) ∣ P := by
  constructor
  · intro h
    apply X_pow_dvd_iff.mpr
    intro d hd
    have hindex : d + j < N := by omega
    have hc := X_pow_dvd_iff.mp h (d + j) hindex
    rw [coeff_X_pow_mul] at hc
    exact hc
  · rintro ⟨Q, rfl⟩
    refine ⟨Q, ?_⟩
    rw [← mul_assoc, ← pow_add, Nat.add_sub_of_le bound]

theorem truncated_parameter_mul_mk_zero_iff (N j : ℕ) (bound : j ≤ N)
    (P : Polynomial k) :
    truncatedParameter k N ^ j * AdjoinRoot.mk ((X : Polynomial k) ^ N) P = 0 ↔
      (X : Polynomial k) ^ (N - j) ∣ P := by
  change AdjoinRoot.mk ((X : Polynomial k) ^ N) X ^ j *
    AdjoinRoot.mk ((X : Polynomial k) ^ N) P = 0 ↔ _
  rw [← map_pow, ← map_mul, AdjoinRoot.mk_eq_zero]
  exact polynomial_power_divisibility_shift N j bound P

/-- The actual kernel is precisely the actual opposite power
ideal, over every commutative coefficient ring and at every length. -/
theorem truncated_kernel_power_shape (N j : ℕ) (bound : j ≤ N) :
    Specifications.TruncatedKernelPowerShape (k := k) N j := by
  apply SetLike.ext
  intro x
  rw [LinearMap.mem_ker, LinearMap.mem_range]
  change truncatedParameter k N ^ j * x = 0 ↔
    ∃ y, truncatedParameter k N ^ (N - j) * y = x
  constructor
  · intro hx
    obtain ⟨P, rfl⟩ := AdjoinRoot.mk_surjective (g := (X : Polynomial k) ^ N) x
    obtain ⟨Q, hQ⟩ := (truncated_parameter_mul_mk_zero_iff N j bound P).mp hx
    refine ⟨AdjoinRoot.mk ((X : Polynomial k) ^ N) Q, ?_⟩
    rw [hQ, map_mul, map_pow, AdjoinRoot.mk_X]
    rfl
  · rintro ⟨y, rfl⟩
    rw [← mul_assoc, ← pow_add, Nat.add_sub_of_le bound,
      truncated_parameter_pow, zero_mul]

/-- Each actual truncated cyclic block has the expected kernel
module, with its full scalar action retained. This is a module
equivalence, rather than only a dimension count. -/
noncomputable def truncatedKernelQuotientEquiv (N j : ℕ) (bound : j ≤ N) :
    (TruncatedCoefficientRing k N ⧸ LinearMap.range (truncatedPowerMultiplication k N j))
      ≃ₗ[TruncatedCoefficientRing k N]
        LinearMap.ker (truncatedPowerMultiplication k N j) := by
  let map := truncatedPowerMultiplication k N (N - j)
  have hker : LinearMap.range (truncatedPowerMultiplication k N j) = LinearMap.ker map := by
    have h := truncated_kernel_power_shape (k := k) N (N - j) (Nat.sub_le _ _)
    unfold Specifications.TruncatedKernelPowerShape at h
    have hindex : N - (N - j) = j := by omega
    rw [hindex] at h
    exact h.symm
  have hrange : LinearMap.range map = LinearMap.ker (truncatedPowerMultiplication k N j) :=
    (truncated_kernel_power_shape (k := k) N j bound).symm
  exact (Submodule.quotEquivOfEq _ _ hker).trans
    (map.quotKerEquivRange.trans (LinearEquiv.ofEq _ _ hrange))

end Litt3.Deformations

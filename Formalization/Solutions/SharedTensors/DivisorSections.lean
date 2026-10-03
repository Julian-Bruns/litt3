import Definitions.SharedTensors.DivisorSections
import Solutions.SharedTensors.ConstantPrincipalDivisors

namespace Litt3.SharedTensors

open Litt3.Jacobians
open scoped WithZero

variable {k K X : Type*} [Field k] [Field K] [Algebra k K]
  (S : ValuationDivisorSystem K X)
  (constants : ∀ c : k, ∀ x, S.valuation x (algebraMap k K c) ≤ 1)

theorem mem_divisorSectionSpace_iff (D : Divisor X) (f : K) :
    f ∈ divisorSectionSpace S constants D ↔
      ∀ x, S.valuation x f ≤ WithZero.exp (D x) := Iff.rfl

theorem divisorSectionSpace_mono {D E : Divisor X} (h : ∀ x, D x ≤ E x) :
    divisorSectionSpace S constants D ≤ divisorSectionSpace S constants E := by
  intro f hf x
  exact (hf x).trans (WithZero.exp_le_exp.mpr (h x))

theorem divisorSectionSpace_one_of_effective (D : Divisor X) (hD : EffectiveDivisor D) :
    (1 : K) ∈ divisorSectionSpace S constants D := by
  intro x
  rw [map_one, ← WithZero.exp_zero]
  exact WithZero.exp_le_exp.mpr (hD x)

/-- These actual bounded rational-function spaces multiply with their
actual integral divisors; no section-ring existence is assumed. -/
theorem divisorSectionSpace_mul {D E : Divisor X} {f g : K}
    (hf : f ∈ divisorSectionSpace S constants D)
    (hg : g ∈ divisorSectionSpace S constants E) :
    f * g ∈ divisorSectionSpace S constants (D + E) := by
  intro x
  rw [map_mul, Finsupp.add_apply, WithZero.exp_add]
  exact mul_le_mul' (hf x) (hg x)

theorem divisorSectionSpace_pow {D : Divisor X} {f : K}
    (hf : f ∈ divisorSectionSpace S constants D) (n : ℕ) :
    f ^ n ∈ divisorSectionSpace S constants (n • D) := by
  induction n with
  | zero =>
      simpa using divisorSectionSpace_one_of_effective S constants 0 (by intro x; exact le_rfl)
  | succ n hn =>
      simpa only [pow_succ, succ_nsmul] using divisorSectionSpace_mul S constants hn hf

end Litt3.SharedTensors

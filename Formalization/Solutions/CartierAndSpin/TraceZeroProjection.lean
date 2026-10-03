import Definitions.CartierAndSpin.TraceZeroProjection
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

open Module LinearMap

variable {K L : Type*} [Field K] [Field L] [Algebra K L] [FiniteDimensional K L]

theorem normalizedTrace_algebraMap (n : ℕ) (hdim : finrank K L = n) (hn : (n : K) ≠ 0) (c : K) :
    normalizedTrace (K := K) (L := L) n (algebraMap K L c) = c := by
  simp only [normalizedTrace, LinearMap.smul_apply, smul_eq_mul,
    Algebra.trace_algebraMap, hdim, nsmul_eq_mul]
  field_simp

omit [FiniteDimensional K L] in
theorem traceZeroProjection_apply (n : ℕ) (x : L) :
    traceZeroProjection (K := K) n x = x - algebraMap K L (normalizedTrace n x) := rfl

theorem traceZeroProjection_mem (n : ℕ) (hdim : finrank K L = n) (hn : (n : K) ≠ 0) (x : L) :
    traceZeroProjection (K := K) n x ∈ traceZeroSpace (K := K) n := by
  change normalizedTrace n (traceZeroProjection n x) = 0
  rw [traceZeroProjection_apply, map_sub, normalizedTrace_algebraMap n hdim hn, sub_self]

omit [FiniteDimensional K L] in
theorem traceZeroProjection_eq_self (n : ℕ) (x : traceZeroSpace (K := K) (L := L) n) :
    traceZeroProjection (K := K) n (x : L) = x := by
  rw [traceZeroProjection_apply]
  have hx : normalizedTrace (K := K) n (x : L) = 0 := x.property
  rw [hx, map_zero, sub_zero]

theorem traceZeroProjection_algebraMap (n : ℕ) (hdim : finrank K L = n) (hn : (n : K) ≠ 0) (c : K) :
    traceZeroProjection (K := K) n (algebraMap K L c) = 0 := by
  rw [traceZeroProjection_apply, normalizedTrace_algebraMap n hdim hn, sub_self]

theorem traceZeroProjection_eq_zero_iff (n : ℕ) (hdim : finrank K L = n) (hn : (n : K) ≠ 0) (x : L) :
    traceZeroProjection (K := K) n x = 0 ↔ x ∈ Set.range (algebraMap K L) := by
  constructor
  · intro hx
    rw [traceZeroProjection_apply] at hx
    exact ⟨normalizedTrace n x, (sub_eq_zero.mp hx).symm⟩
  · rintro ⟨c, rfl⟩
    exact traceZeroProjection_algebraMap n hdim hn c

omit [FiniteDimensional K L] in
theorem normalizedTraceZeroPairing_apply (n : ℕ)
    (x y : traceZeroSpace (K := K) (L := L) n) :
    normalizedTraceZeroPairing n x y = normalizedTrace n ((x : L) * (y : L)) := rfl

omit [FiniteDimensional K L] in
theorem normalizedTraceZeroPairing_symmetric (n : ℕ) :
    (normalizedTraceZeroPairing (K := K) (L := L) n).IsSymm := by
  constructor
  intro x y
  simp only [normalizedTraceZeroPairing_apply, mul_comm]

theorem normalizedTrace_surjective (n : ℕ) (hdim : finrank K L = n)
    (hn : (n : K) ≠ 0) : Function.Surjective (normalizedTrace (K := K) (L := L) n) := by
  intro c
  exact ⟨algebraMap K L c, normalizedTrace_algebraMap n hdim hn c⟩

theorem traceZeroSpace_finrank_add_one (n : ℕ) (hdim : finrank K L = n)
    (hn : (n : K) ≠ 0) : finrank K (traceZeroSpace (K := K) (L := L) n) + 1 = n := by
  have h := (normalizedTrace (K := K) (L := L) n).finrank_range_add_finrank_ker
  rw [LinearMap.range_eq_top.mpr (normalizedTrace_surjective n hdim hn),
    finrank_top, finrank_self, hdim] at h
  simpa only [traceZeroSpace, Nat.add_comm] using h

omit [FiniteDimensional K L] in
theorem normalizedTrace_mul_projection (n : ℕ)
    (x : traceZeroSpace (K := K) (L := L) n) (y : L) :
    normalizedTrace (K := K) n ((x : L) * traceZeroProjection (K := K) n y) =
      normalizedTrace (K := K) n ((x : L) * y) := by
  have hx : normalizedTrace (K := K) n (x : L) = 0 := x.property
  rw [traceZeroProjection_apply, mul_sub, map_sub]
  have hc : normalizedTrace (K := K) n ((x : L) * algebraMap K L (normalizedTrace n y)) = 0 := by
    rw [mul_comm, ← Algebra.smul_def, map_smul, hx, smul_zero]
  rw [hc, sub_zero]

theorem normalizedTraceZeroPairing_nondegenerate [Algebra.IsSeparable K L]
    (n : ℕ) (hdim : finrank K L = n) (hn : (n : K) ≠ 0) :
    (normalizedTraceZeroPairing (K := K) (L := L) n).Nondegenerate := by
  intro x hx
  apply Subtype.ext
  change (x : L) = 0
  apply traceForm_nondegenerate K L
  intro y
  have hz := hx ⟨traceZeroProjection n y, traceZeroProjection_mem n hdim hn y⟩
  rw [normalizedTraceZeroPairing_apply, normalizedTrace_mul_projection] at hz
  change (n : K)⁻¹ * Algebra.trace K L ((x : L) * y) = 0 at hz
  exact (mul_eq_zero.mp hz).resolve_left (inv_ne_zero hn)

end Litt3.CartierAndSpin

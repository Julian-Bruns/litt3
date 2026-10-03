import Solutions.CartierAndSpin.TraceZeroProjection

namespace Litt3.CartierAndSpin

open Module LinearMap
open LinearMap (BilinForm)

variable {K L : Type*} [Field K] [Field L] [Algebra K L] [FiniteDimensional K L]

noncomputable def traceZeroProjectionToSpace (n : ℕ) (hdim : finrank K L = n)
    (hn : (n : K) ≠ 0) : L →ₗ[K] traceZeroSpace (K := K) (L := L) n :=
  (traceZeroProjection n).codRestrict (traceZeroSpace n) (traceZeroProjection_mem n hdim hn)

noncomputable def traceZeroCompression (n : ℕ) (hdim : finrank K L = n)
    (hn : (n : K) ≠ 0) (epsilon : L) :
    traceZeroSpace (K := K) (L := L) n →ₗ[K] traceZeroSpace (K := K) (L := L) n :=
  (traceZeroProjectionToSpace n hdim hn).comp
    ((LinearMap.mulLeft K epsilon).comp (traceZeroSpace n).subtype)

theorem traceZeroCompression_apply (n : ℕ) (hdim : finrank K L = n)
    (hn : (n : K) ≠ 0) (epsilon : L) (x : traceZeroSpace (K := K) (L := L) n) :
    ((traceZeroCompression n hdim hn epsilon x : traceZeroSpace (K := K) (L := L) n) : L) =
      traceZeroProjection (K := K) n (epsilon * (x : L)) := rfl

theorem traceZeroCompression_self_adjoint (n : ℕ) (hdim : finrank K L = n)
    (hn : (n : K) ≠ 0) (epsilon : L) :
    (normalizedTraceZeroPairing n).IsSelfAdjoint (traceZeroCompression n hdim hn epsilon) := by
  intro x y
  simp only [normalizedTraceZeroPairing_apply, traceZeroCompression_apply]
  rw [mul_comm (traceZeroProjection (K := K) n (epsilon * (x : L))),
    normalizedTrace_mul_projection, normalizedTrace_mul_projection]
  congr 1
  ring

theorem traceZeroProjectionToSpace_nonzero_iff (n : ℕ) (hdim : finrank K L = n)
    (hn : (n : K) ≠ 0) (epsilon : L) :
    traceZeroProjectionToSpace n hdim hn epsilon ≠ 0 ↔
      epsilon ∉ Set.range (algebraMap K L) := by
  have hzero : traceZeroProjectionToSpace n hdim hn epsilon = 0 ↔
      traceZeroProjection (K := K) n epsilon = 0 := by
    constructor
    · intro h
      exact congrArg Subtype.val h
    · intro h
      exact Subtype.ext h
  rw [ne_eq, hzero, traceZeroProjection_eq_zero_iff n hdim hn]

end Litt3.CartierAndSpin

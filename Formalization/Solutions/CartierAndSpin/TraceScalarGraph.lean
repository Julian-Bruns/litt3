import Solutions.CartierAndSpin.TraceCompression
import Solutions.CartierAndSpin.ScalarGraphAdjoint
import Solutions.CartierAndSpin.ScalarGraph

namespace Litt3.CartierAndSpin

open Module LinearMap

variable {K L ι : Type*} [Field K] [Field L] [Algebra K L] [FiniteDimensional K L]

omit [FiniteDimensional K L] in
theorem normalizedTrace_projection_mul (n : ℕ)
    (x : L) (y : traceZeroSpace (K := K) (L := L) n) :
    normalizedTrace (K := K) n (traceZeroProjection (K := K) n x * (y : L)) =
      normalizedTrace (K := K) n (x * (y : L)) := by
  rw [mul_comm (traceZeroProjection (K := K) n x), normalizedTrace_mul_projection, mul_comm]

theorem trace_scalar_graph_basis_criterion (n : ℕ) (hdim : finrank K L = n)
    (hn : (n : K) ≠ 0) (epsilon : L) (hepsilon : epsilon ∉ Set.range (algebraMap K L))
    (M : traceZeroSpace (K := K) (L := L) n →ₗ[K] traceZeroSpace (K := K) (L := L) n)
    (basis : Basis ι K (traceZeroSpace (K := K) (L := L) n)) :
    (∃ a : traceZeroSpace (K := K) (L := L) n →ₗ[K] K,
      M = traceZeroCompression n hdim hn epsilon +
      a.smulRight (traceZeroProjectionToSpace n hdim hn epsilon)) ↔
      ∀ i, M (basis i) - traceZeroCompression n hdim hn epsilon (basis i) ∈
        Submodule.span K ({traceZeroProjectionToSpace n hdim hn epsilon} :
          Set (traceZeroSpace (K := K) (L := L) n)) := by
  exact scalarGraphBasisCriterion M (traceZeroCompression n hdim hn epsilon)
    (traceZeroProjectionToSpace n hdim hn epsilon) basis
    ((traceZeroProjectionToSpace_nonzero_iff n hdim hn epsilon).mpr hepsilon)

theorem trace_scalar_graph_skew_kernel_recovers_multiplication [Algebra.IsSeparable K L]
    (n : ℕ) (hdim : finrank K L = n) (hn : (n : K) ≠ 0) (epsilon : L)
    (a : traceZeroSpace (K := K) (L := L) n →ₗ[K] K)
    (M : traceZeroSpace (K := K) (L := L) n →ₗ[K] traceZeroSpace (K := K) (L := L) n)
    (hM : M = traceZeroCompression n hdim hn epsilon +
      a.smulRight (traceZeroProjectionToSpace n hdim hn epsilon))
    (hne : M - (normalizedTraceZeroPairing n).leftAdjointOfNondegenerate
      (normalizedTraceZeroPairing_nondegenerate n hdim hn) M ≠ 0)
    (k : traceZeroSpace (K := K) (L := L) n)
    (hk : (M - (normalizedTraceZeroPairing n).leftAdjointOfNondegenerate
      (normalizedTraceZeroPairing_nondegenerate n hdim hn) M) k = 0) :
    (M k : L) = epsilon * (k : L) := by
  rw [hM] at hne hk ⊢
  have hzero := (scalar_graph_nonzero_skew_kernel (normalizedTraceZeroPairing n)
    (normalizedTraceZeroPairing_nondegenerate n hdim hn)
    (normalizedTraceZeroPairing_symmetric n) (traceZeroCompression n hdim hn epsilon)
    (traceZeroCompression_self_adjoint n hdim hn epsilon)
    (traceZeroProjectionToSpace n hdim hn epsilon) a hne k).mp hk
  have htrace : normalizedTrace (K := K) n (epsilon * (k : L)) = 0 := by
    simpa only [normalizedTraceZeroPairing_apply, traceZeroProjectionToSpace,
      LinearMap.codRestrict_apply, normalizedTrace_projection_mul] using hzero.2
  simp only [LinearMap.add_apply, LinearMap.smulRight_apply, hzero.1, zero_smul, add_zero,
    traceZeroCompression_apply, traceZeroProjection_apply, htrace, map_zero, sub_zero]

theorem trace_scalar_graph_skew_kernel_recovers_ratio [Algebra.IsSeparable K L]
    (n : ℕ) (hdim : finrank K L = n) (hn : (n : K) ≠ 0) (epsilon : L)
    (a : traceZeroSpace (K := K) (L := L) n →ₗ[K] K)
    (M : traceZeroSpace (K := K) (L := L) n →ₗ[K] traceZeroSpace (K := K) (L := L) n)
    (hM : M = traceZeroCompression n hdim hn epsilon +
      a.smulRight (traceZeroProjectionToSpace n hdim hn epsilon))
    (hne : M - (normalizedTraceZeroPairing n).leftAdjointOfNondegenerate
      (normalizedTraceZeroPairing_nondegenerate n hdim hn) M ≠ 0)
    (k : traceZeroSpace (K := K) (L := L) n) (hk0 : (k : L) ≠ 0)
    (hk : (M - (normalizedTraceZeroPairing n).leftAdjointOfNondegenerate
      (normalizedTraceZeroPairing_nondegenerate n hdim hn) M) k = 0) :
    epsilon = (M k : L) / (k : L) := by
  rw [trace_scalar_graph_skew_kernel_recovers_multiplication n hdim hn epsilon a M hM hne k hk,
    mul_div_cancel_right₀ _ hk0]

theorem trace_scalar_graph_skew_kernel_finrank [Algebra.IsSeparable K L]
    (n : ℕ) (hdim : finrank K L = n) (hn : (n : K) ≠ 0) (epsilon : L)
    (a : traceZeroSpace (K := K) (L := L) n →ₗ[K] K)
    (M : traceZeroSpace (K := K) (L := L) n →ₗ[K] traceZeroSpace (K := K) (L := L) n)
    (hM : M = traceZeroCompression n hdim hn epsilon +
      a.smulRight (traceZeroProjectionToSpace n hdim hn epsilon))
    (hne : M - (normalizedTraceZeroPairing n).leftAdjointOfNondegenerate
      (normalizedTraceZeroPairing_nondegenerate n hdim hn) M ≠ 0) :
    finrank K (LinearMap.ker (M - (normalizedTraceZeroPairing n).leftAdjointOfNondegenerate
      (normalizedTraceZeroPairing_nondegenerate n hdim hn) M)) + 3 = n := by
  have hspace := traceZeroSpace_finrank_add_one n hdim hn
  rw [hM] at hne ⊢
  have hkernel := scalar_graph_nonzero_skew_finrank_kernel (normalizedTraceZeroPairing n)
    (normalizedTraceZeroPairing_nondegenerate n hdim hn)
    (normalizedTraceZeroPairing_symmetric n) (traceZeroCompression n hdim hn epsilon)
    (traceZeroCompression_self_adjoint n hdim hn epsilon)
    (traceZeroProjectionToSpace n hdim hn epsilon) a hne
  omega

end Litt3.CartierAndSpin

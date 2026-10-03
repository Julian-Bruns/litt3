import Solutions.CartierAndSpin.AlternatingThreeForm
import Solutions.CartierAndSpin.TraceZeroProjection

namespace Litt3.CartierAndSpin

set_option maxHeartbeats 1000000

open Module LinearMap
open LinearMap (BilinForm)

variable {K V : Type*} [Field K] [AddCommGroup V] [Module K V] [FiniteDimensional K V]

theorem skew_adjoint_difference_alternating (B : BilinForm K V) (hB : B.Nondegenerate)
    (hsym : B.IsSymm) (M : V →ₗ[K] V) :
    (B.compLeft (M - B.leftAdjointOfNondegenerate hB M)).IsAlt := by
  intro x
  rw [BilinForm.compLeft_apply, LinearMap.sub_apply, map_sub, LinearMap.sub_apply,
    B.isAdjointPairLeftAdjointOfNondegenerate hB M x x, hsym.eq, sub_self]

omit [FiniteDimensional K V] in
theorem nondegenerate_compression_kernel (B : BilinForm K V) (hB : B.Nondegenerate)
    (S : V →ₗ[K] V) : LinearMap.ker (B.compLeft S) = LinearMap.ker S := by
  ext x
  change B (S x) = 0 ↔ S x = 0
  constructor
  · intro h
    apply hB (S x)
    intro y
    exact LinearMap.congr_fun h y
  · intro h
    rw [h, map_zero]

theorem nonzero_skew_three_finrank_kernel (B : BilinForm K V) (hB : B.Nondegenerate)
    (hsym : B.IsSymm) (M : V →ₗ[K] V) (hdim : finrank K V = 3)
    (hne : M - B.leftAdjointOfNondegenerate hB M ≠ 0) :
    finrank K (LinearMap.ker (M - B.leftAdjointOfNondegenerate hB M)) = 1 := by
  let S := M - B.leftAdjointOfNondegenerate hB M
  have hform : B.compLeft S ≠ 0 := by
    intro hzero
    apply hne
    apply B.compLeft_injective hB
    change B.compLeft S = B.compLeft 0
    rw [hzero]
    ext x y
    simp [BilinForm.compLeft_apply]
  rw [← nondegenerate_compression_kernel B hB S]
  exact alternating_three_form_finrank_kernel (B.compLeft S)
    (skew_adjoint_difference_alternating B hB hsym M) hform hdim

theorem nonzero_skew_three_finrank_range (B : BilinForm K V) (hB : B.Nondegenerate)
    (hsym : B.IsSymm) (M : V →ₗ[K] V) (hdim : finrank K V = 3)
    (hne : M - B.leftAdjointOfNondegenerate hB M ≠ 0) :
    finrank K (LinearMap.range (M - B.leftAdjointOfNondegenerate hB M)) = 2 := by
  have h := (M - B.leftAdjointOfNondegenerate hB M).finrank_range_add_finrank_ker
  rw [nonzero_skew_three_finrank_kernel B hB hsym M hdim hne, hdim] at h
  omega

section Quartic

variable {L : Type*} [Field L] [Algebra K L] [FiniteDimensional K L] [Algebra.IsSeparable K L]

theorem quartic_normalization_nonzero (hchar : (2 : K) ≠ 0) : (4 : K) ≠ 0 := by
  have hfour : (4 : K) = (2 : K) * 2 := by ring
  rw [hfour]
  exact mul_ne_zero hchar hchar

theorem quartic_nonzero_skew_finrank_kernel (hdim : finrank K L = 4) (hchar : (2 : K) ≠ 0)
    (M : traceZeroSpace (K := K) (L := L) 4 →ₗ[K] traceZeroSpace (K := K) (L := L) 4)
    (hne : M - (normalizedTraceZeroPairing 4).leftAdjointOfNondegenerate
      (normalizedTraceZeroPairing_nondegenerate 4 hdim (quartic_normalization_nonzero hchar)) M ≠ 0) :
    finrank K (LinearMap.ker (M - (normalizedTraceZeroPairing 4).leftAdjointOfNondegenerate
      (normalizedTraceZeroPairing_nondegenerate 4 hdim (quartic_normalization_nonzero hchar)) M)) = 1 := by
  have hspace : finrank K (traceZeroSpace (K := K) (L := L) 4) = 3 := by
    have h := traceZeroSpace_finrank_add_one 4 hdim (quartic_normalization_nonzero hchar)
    omega
  exact nonzero_skew_three_finrank_kernel (K := K)
    (V := traceZeroSpace (K := K) (L := L) 4)
    (normalizedTraceZeroPairing (K := K) (L := L) 4)
    (normalizedTraceZeroPairing_nondegenerate 4 hdim (quartic_normalization_nonzero hchar))
    (normalizedTraceZeroPairing_symmetric (K := K) (L := L) 4) M hspace hne

end Quartic

end Litt3.CartierAndSpin

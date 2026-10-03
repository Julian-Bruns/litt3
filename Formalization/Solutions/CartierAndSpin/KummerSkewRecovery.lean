import Solutions.CartierAndSpin.KummerPairing
import Solutions.CartierAndSpin.KummerMatrixSkew
import Solutions.CartierAndSpin.SkewThreeDimension

namespace Litt3.CartierAndSpin

open Module LinearMap
open LinearMap (BilinForm)
open scoped Matrix

variable {K V : Type*} [Field K] [AddCommGroup V] [Module K V] [FiniteDimensional K V]

omit [FiniteDimensional K V] in
theorem reversed_skew_form_alternating (B : BilinForm K V) (hsym : B.IsSymm)
    (M : V →ₗ[K] V) : (B.compRight M - B.compLeft M).IsAlt := by
  intro x
  change B x (M x) - B (M x) x = 0
  rw [hsym.eq, sub_self]

theorem reversed_skew_form_kernel (B : BilinForm K V) (hB : B.Nondegenerate)
    (M : V →ₗ[K] V) :
    LinearMap.ker (B.compRight M - B.compLeft M) =
      LinearMap.ker (M - B.leftAdjointOfNondegenerate hB M) := by
  have hform : B.compRight M - B.compLeft M =
      -(B.compLeft (M - B.leftAdjointOfNondegenerate hB M)) := by
    ext x y
    change B x (M y) - B (M x) y = -(B ((M - B.leftAdjointOfNondegenerate hB M) x) y)
    rw [LinearMap.sub_apply, map_sub, LinearMap.sub_apply,
      B.isAdjointPairLeftAdjointOfNondegenerate hB M x y]
    ring
  rw [hform, ← nondegenerate_compression_kernel B hB]
  ext x
  change -(B.compLeft (M - B.leftAdjointOfNondegenerate hB M)) x = 0 ↔
    (B.compLeft (M - B.leftAdjointOfNondegenerate hB M)) x = 0
  exact neg_eq_zero

theorem kummer_gram_skew_kernel (B : BilinForm K V) (hB : B.Nondegenerate)
    (hsym : B.IsSymm) (basis : Basis (Fin 3) K V) (m : K)
    (hgram : BilinForm.toMatrix basis B = kummerTracePairingMatrix m) (M : V →ₗ[K] V) :
    (M - B.leftAdjointOfNondegenerate hB M)
      (basis.equivFun.symm (kummerSkewKernelCoordinates (LinearMap.toMatrix basis basis M))) = 0 := by
  let C := B.compRight M - B.compLeft M
  have hmatrix : BilinForm.toMatrix basis C = kummerTracePairingMatrix m *
      LinearMap.toMatrix basis basis M - (LinearMap.toMatrix basis basis M)ᵀ *
        kummerTracePairingMatrix m := by
    dsimp only [C]
    have hmap := (BilinForm.toMatrix basis).toLinearMap.map_sub (B.compRight M) (B.compLeft M)
    calc
      _ = BilinForm.toMatrix basis (B.compRight M) - BilinForm.toMatrix basis (B.compLeft M) := hmap
      _ = _ := by rw [BilinForm.toMatrix_compRight, BilinForm.toMatrix_compLeft, hgram]
  have hkernel : basis.equivFun.symm (kummerSkewKernelCoordinates (LinearMap.toMatrix basis basis M)) ∈
      LinearMap.ker C := by
    apply (alternating_form_matrix_kernel_iff C (reversed_skew_form_alternating B hsym M) basis _).mp
    rw [hmatrix, LinearEquiv.apply_symm_apply]
    exact kummer_skew_kernel_coordinates m _
  rw [reversed_skew_form_kernel B hB M] at hkernel
  exact hkernel

theorem kummer_gram_kernel_zero_iff_self_adjoint (B : BilinForm K V) (hB : B.Nondegenerate)
    (basis : Basis (Fin 3) K V) (m : K) (hm : m ≠ 0)
    (hgram : BilinForm.toMatrix basis B = kummerTracePairingMatrix m) (M : V →ₗ[K] V) :
    basis.equivFun.symm (kummerSkewKernelCoordinates (LinearMap.toMatrix basis basis M)) = 0 ↔
      M = B.leftAdjointOfNondegenerate hB M := by
  rw [LinearEquiv.map_eq_zero_iff, kummer_skew_kernel_coordinates_zero_iff m hm]
  have hmatrix : BilinForm.toMatrix basis (B.compRight M - B.compLeft M) =
      kummerTracePairingMatrix m * LinearMap.toMatrix basis basis M -
        (LinearMap.toMatrix basis basis M)ᵀ * kummerTracePairingMatrix m := by
    have hmap := (BilinForm.toMatrix basis).toLinearMap.map_sub (B.compRight M) (B.compLeft M)
    calc
      _ = BilinForm.toMatrix basis (B.compRight M) - BilinForm.toMatrix basis (B.compLeft M) := hmap
      _ = _ := by rw [BilinForm.toMatrix_compRight, BilinForm.toMatrix_compLeft, hgram]
  rw [← hmatrix, LinearEquiv.map_eq_zero_iff]
  constructor
  · intro hzero
    have hpair : B.IsAdjointPair B M M := by
      intro x y
      have h := congrArg (fun C : BilinForm K V => C x y) hzero
      change B x (M y) - B (M x) y = 0 at h
      exact (sub_eq_zero.mp h).symm
    exact (B.isAdjointPair_iff_eq_of_nondegenerate hB M M).mp hpair
  · intro hself
    ext x y
    have hpair := B.isAdjointPairLeftAdjointOfNondegenerate hB M x y
    rw [← hself] at hpair
    change B x (M y) - B (M x) y = 0
    rw [hpair, sub_self]

end Litt3.CartierAndSpin

import Solutions.CartierAndSpin.KummerCompression
import Solutions.CartierAndSpin.ScalarGraphAdjoint

namespace Litt3.CartierAndSpin

open Module LinearMap
open LinearMap (BilinForm)

variable {K V : Type*} [Field K] [AddCommGroup V] [Module K V]

theorem kummer_gram_rank_one_matrix (B : BilinForm K V) (basis : Basis (Fin 3) K V)
    (m : K) (hgram : BilinForm.toMatrix basis B = kummerTracePairingMatrix m)
    (e : V) (b c d : K) (he : e = b • basis 0 + c • basis 1 + d • basis 2) :
    LinearMap.toMatrix basis basis ((B e).smulRight e) = kummerBoundaryMatrix m b c d := by
  have hB (i j : Fin 3) : B (basis i) (basis j) = kummerTracePairingMatrix m i j := by
    rw [← BilinForm.toMatrix_apply basis B, hgram]
  have h0 : B e (basis 0) = m*d := by
    rw [he]
    simp only [map_add, map_smul, LinearMap.add_apply, LinearMap.smul_apply, smul_eq_mul, hB]
    change (b*0 + c*0) + d*m = m*d
    ring
  have h1 : B e (basis 1) = m*c := by
    rw [he]
    simp only [map_add, map_smul, LinearMap.add_apply, LinearMap.smul_apply, smul_eq_mul, hB]
    change (b*0 + c*m) + d*0 = m*c
    ring
  have h2 : B e (basis 2) = m*b := by
    rw [he]
    simp only [map_add, map_smul, LinearMap.add_apply, LinearMap.smul_apply, smul_eq_mul, hB]
    change (b*m + c*0) + d*0 = m*b
    ring
  have he0 : basis.repr e 0 = b := by rw [he]; simp [basis.repr_self]
  have he1 : basis.repr e 1 = c := by rw [he]; simp [basis.repr_self]
  have he2 : basis.repr e 2 = d := by rw [he]; simp [basis.repr_self]
  ext i j
  rw [LinearMap.toMatrix_apply, LinearMap.smulRight_apply, map_smul]
  fin_cases i <;> fin_cases j
  · change B e (basis 0) * basis.repr e 0 = m * (b*d)
    rw [h0, he0]; ring
  · change B e (basis 1) * basis.repr e 0 = m * (b*c)
    rw [h1, he0]; ring
  · change B e (basis 2) * basis.repr e 0 = m * (b*b)
    rw [h2, he0]; ring
  · change B e (basis 0) * basis.repr e 1 = m * (c*d)
    rw [h0, he1]; ring
  · change B e (basis 1) * basis.repr e 1 = m * (c*c)
    rw [h1, he1]; ring
  · change B e (basis 2) * basis.repr e 1 = m * (c*b)
    rw [h2, he1]; ring
  · change B e (basis 0) * basis.repr e 2 = m * (d*d)
    rw [h0, he2]; ring
  · change B e (basis 1) * basis.repr e 2 = m * (d*c)
    rw [h1, he2]; ring
  · change B e (basis 2) * basis.repr e 2 = m * (d*b)
    rw [h2, he2]; ring

section FieldExtension

variable {L : Type*} [Field L] [Algebra K L] [FiniteDimensional K L] [Algebra.IsSeparable K L]

omit [FiniteDimensional K L] [Algebra.IsSeparable K L] in
theorem kummer_nonbase_coefficients_nonzero (t : L) (a b c d : K)
    (hepsilon : kummerElement t a b c d ∉ Set.range (algebraMap K L)) : ![b, c, d] ≠ 0 := by
  intro hzero
  have hb : b = 0 := congrFun hzero 0
  have hc : c = 0 := congrFun hzero 1
  have hd : d = 0 := congrFun hzero 2
  apply hepsilon
  exact ⟨a, by simp only [kummerElement, hb, hc, hd, zero_smul, add_zero]⟩

theorem quartic_kummer_self_adjoint_graph_boundary_matrix
    (basis : Basis (Fin 4) K L) (t : L)
    (hbasis : ∀ i : Fin 4, basis i = t ^ (i : ℕ)) (m : K)
    (ht : t ^ 4 = algebraMap K L m) (hfour : (4 : K) ≠ 0)
    (hdim : finrank K L = 4)
    (bV : Basis (Fin 3) K (traceZeroSpace (K := K) (L := L) 4))
    (hbV : ∀ i : Fin 3, (bV i : L) = t ^ ((i : ℕ) + 1))
    (a b c d : K) (hepsilon : kummerElement t a b c d ∉ Set.range (algebraMap K L))
    (f : traceZeroSpace (K := K) (L := L) 4 →ₗ[K] K)
    (M : traceZeroSpace (K := K) (L := L) 4 →ₗ[K] traceZeroSpace (K := K) (L := L) 4)
    (hM : M = traceZeroCompression 4 hdim hfour (kummerElement t a b c d) +
      f.smulRight (traceZeroProjectionToSpace 4 hdim hfour (kummerElement t a b c d)))
    (hself : M = (normalizedTraceZeroPairing 4).leftAdjointOfNondegenerate
      (normalizedTraceZeroPairing_nondegenerate 4 hdim hfour) M) :
    ∃ kappa : K, LinearMap.toMatrix bV bV M =
      kummerCompressionMatrix m a b c d + kappa • kummerBoundaryMatrix m b c d := by
  let e := traceZeroProjectionToSpace 4 hdim hfour (kummerElement t a b c d)
  have he : e ≠ 0 := (traceZeroProjectionToSpace_nonzero_iff 4 hdim hfour _).mpr hepsilon
  have hzero : (traceZeroCompression 4 hdim hfour (kummerElement t a b c d) + f.smulRight e) -
      (normalizedTraceZeroPairing 4).leftAdjointOfNondegenerate
        (normalizedTraceZeroPairing_nondegenerate 4 hdim hfour)
        (traceZeroCompression 4 hdim hfour (kummerElement t a b c d) + f.smulRight e) = 0 := by
    change (traceZeroCompression 4 hdim hfour (kummerElement t a b c d) +
      f.smulRight (traceZeroProjectionToSpace 4 hdim hfour (kummerElement t a b c d))) -
      (normalizedTraceZeroPairing 4).leftAdjointOfNondegenerate
        (normalizedTraceZeroPairing_nondegenerate 4 hdim hfour)
        (traceZeroCompression 4 hdim hfour (kummerElement t a b c d) +
          f.smulRight (traceZeroProjectionToSpace 4 hdim hfour (kummerElement t a b c d))) = 0
    rw [← hM]
    apply LinearMap.ext
    intro x
    change M x - (normalizedTraceZeroPairing 4).leftAdjointOfNondegenerate
      (normalizedTraceZeroPairing_nondegenerate 4 hdim hfour) M x = 0
    rw [← hself]
    exact sub_self _
  obtain ⟨kappa, hf⟩ := (self_adjoint_scalar_graph_zero_skew_iff
    (normalizedTraceZeroPairing (K := K) (L := L) 4)
    (normalizedTraceZeroPairing_nondegenerate 4 hdim hfour)
    (normalizedTraceZeroPairing_symmetric (K := K) (L := L) 4)
    (traceZeroCompression 4 hdim hfour (kummerElement t a b c d))
    (traceZeroCompression_self_adjoint 4 hdim hfour _) e he f).mp hzero
  have hecoords : e = b • bV 0 + c • bV 1 + d • bV 2 := by
    apply Subtype.ext
    change traceZeroProjection (K := K) 4 (kummerElement t a b c d) = _
    rw [quartic_projection_kummerElement basis t hbasis m ht hfour]
    simp only [Submodule.coe_add, Submodule.coe_smul, hbV]
    congr 2
    all_goals norm_num only [Fin.val_zero, Fin.val_one, Fin.reduceFinMk, Nat.reduceAdd, pow_one]
  refine ⟨kappa, ?_⟩
  have hrankone := kummer_gram_rank_one_matrix (normalizedTraceZeroPairing (K := K) (L := L) 4)
    bV m (quartic_trace_zero_power_basis_pairing_matrix basis t hbasis m ht hfour bV hbV)
    e b c d hecoords
  rw [hM, hf]
  have hsmul : (kappa • (normalizedTraceZeroPairing 4) e).smulRight e =
      kappa • ((normalizedTraceZeroPairing 4) e).smulRight e := by
    ext x
    simp only [LinearMap.smulRight_apply, LinearMap.smul_apply, smul_smul, smul_eq_mul]
  change LinearMap.toMatrix bV bV (traceZeroCompression 4 hdim hfour (kummerElement t a b c d) +
    (kappa • (normalizedTraceZeroPairing 4) e).smulRight e) = _
  rw [hsmul]
  have hmapadd := (LinearMap.toMatrix bV bV).toLinearMap.map_add
    (traceZeroCompression 4 hdim hfour (kummerElement t a b c d))
    (kappa • ((normalizedTraceZeroPairing 4) e).smulRight e)
  have hmapsmul := (LinearMap.toMatrix bV bV).toLinearMap.map_smul kappa
    (((normalizedTraceZeroPairing 4) e).smulRight e)
  calc
    _ = LinearMap.toMatrix bV bV (traceZeroCompression 4 hdim hfour (kummerElement t a b c d)) +
      LinearMap.toMatrix bV bV (kappa • ((normalizedTraceZeroPairing 4) e).smulRight e) := hmapadd
    _ = LinearMap.toMatrix bV bV (traceZeroCompression 4 hdim hfour (kummerElement t a b c d)) +
      kappa • LinearMap.toMatrix bV bV (((normalizedTraceZeroPairing 4) e).smulRight e) :=
        congrArg (fun T => LinearMap.toMatrix bV bV
          (traceZeroCompression 4 hdim hfour (kummerElement t a b c d)) + T) hmapsmul
    _ = _ := by
      rw [quartic_kummer_compression_matrix basis t hbasis m ht hfour hdim bV hbV, hrankone]

end FieldExtension

end Litt3.CartierAndSpin

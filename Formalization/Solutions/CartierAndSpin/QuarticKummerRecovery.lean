import Solutions.CartierAndSpin.KummerSkewRecovery
import Solutions.CartierAndSpin.KummerBoundary
import Mathlib.FieldTheory.IntermediateField.Adjoin.Algebra

namespace Litt3.CartierAndSpin

open Module LinearMap

variable {K L : Type*} [Field K] [Field L] [Algebra K L] [FiniteDimensional K L]
    [Algebra.IsSeparable K L]

theorem quartic_kummer_skew_recovery (t : L) (m : K) (hm : m ≠ 0)
    (ht : t ^ 4 = algebraMap K L m)
    (hgen : IntermediateField.adjoin K ({t} : Set L) = ⊤)
    (hdim : finrank K L = 4) (hfour : (4 : K) ≠ 0) :
    ∃ basis : Basis (Fin 4) K L,
      ∃ bV : Basis (Fin 3) K (traceZeroSpace (K := K) (L := L) 4),
        (∀ i : Fin 4, basis i = t ^ (i : ℕ)) ∧
        (∀ i : Fin 3, (bV i : L) = t ^ ((i : ℕ) + 1)) ∧
        ∀ M : traceZeroSpace (K := K) (L := L) 4 →ₗ[K] traceZeroSpace (K := K) (L := L) 4,
          let A := LinearMap.toMatrix bV bV M
          let k := bV.equivFun.symm (kummerSkewKernelCoordinates A)
          (M - (normalizedTraceZeroPairing 4).leftAdjointOfNondegenerate
            (normalizedTraceZeroPairing_nondegenerate 4 hdim hfour) M) k = 0 ∧
          (k = 0 ↔ M = (normalizedTraceZeroPairing 4).leftAdjointOfNondegenerate
            (normalizedTraceZeroPairing_nondegenerate 4 hdim hfour) M) ∧
          ((k : L) = (A 1 2 - A 0 1) • t + (A 0 0 - A 2 2) • t ^ 2 +
            (A 2 1 - A 1 0) • t ^ 3) := by
  have hgenAlg : Algebra.adjoin K ({t} : Set L) = ⊤ := by
    rw [← IntermediateField.adjoin_toSubalgebra (F := K) ({t} : Set L), hgen,
      IntermediateField.top_toSubalgebra]
  obtain ⟨basis, hbasis⟩ := quartic_power_basis_exists t hgenAlg hdim
  obtain ⟨bV, hbV⟩ := quartic_trace_zero_power_basis_exists basis t hbasis m ht hfour
  have hgram := quartic_trace_zero_power_basis_pairing_matrix basis t hbasis m ht hfour bV hbV
  refine ⟨basis, bV, hbasis, hbV, ?_⟩
  intro M
  dsimp only
  refine ⟨kummer_gram_skew_kernel (K := K)
    (V := traceZeroSpace (K := K) (L := L) 4)
    (normalizedTraceZeroPairing (K := K) (L := L) 4)
    (normalizedTraceZeroPairing_nondegenerate 4 hdim hfour)
    (normalizedTraceZeroPairing_symmetric (K := K) (L := L) 4) bV m hgram M, ?_, ?_⟩
  · exact kummer_gram_kernel_zero_iff_self_adjoint (K := K)
      (V := traceZeroSpace (K := K) (L := L) 4)
      (normalizedTraceZeroPairing (K := K) (L := L) 4)
      (normalizedTraceZeroPairing_nondegenerate 4 hdim hfour) bV m hm hgram M
  · rw [Basis.equivFun_symm_apply, Fin.sum_univ_three]
    simp only [Submodule.coe_add, Submodule.coe_smul]
    have hb0 : (bV 0 : L) = t := by
      have h := hbV 0
      change (bV 0 : L) = t ^ (0 + 1) at h
      simpa only [Nat.reduceAdd, pow_one] using h
    have hb1 : (bV 1 : L) = t ^ 2 := by
      have h := hbV 1
      change (bV 1 : L) = t ^ (1 + 1) at h
      simpa only [Nat.reduceAdd] using h
    have hb2 : (bV 2 : L) = t ^ 3 := by
      have h := hbV 2
      change (bV 2 : L) = t ^ (2 + 1) at h
      simpa only [Nat.reduceAdd] using h
    rw [hb0, hb1, hb2]
    rfl

end Litt3.CartierAndSpin

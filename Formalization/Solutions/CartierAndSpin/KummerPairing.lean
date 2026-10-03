import Solutions.CartierAndSpin.KummerTrace
import Definitions.CartierAndSpin.KummerMatrices
import Mathlib.LinearAlgebra.Matrix.BilinearForm

namespace Litt3.CartierAndSpin

open Module LinearMap
open LinearMap (BilinForm)

variable {K L : Type*} [Field K] [Field L] [Algebra K L] [FiniteDimensional K L]

theorem quartic_trace_zero_power_basis_exists (basis : Basis (Fin 4) K L) (t : L)
    (hbasis : ∀ i : Fin 4, basis i = t ^ (i : ℕ)) (m : K)
    (ht : t ^ 4 = algebraMap K L m) (hfour : (4 : K) ≠ 0) :
    ∃ bV : Basis (Fin 3) K (traceZeroSpace (K := K) (L := L) 4),
      ∀ i : Fin 3, (bV i : L) = t ^ ((i : ℕ) + 1) := by
  have hdim : finrank K L = 4 := by
    simpa only [Fintype.card_fin] using finrank_eq_card_basis basis
  have hmem (i : Fin 3) : basis i.succ ∈ traceZeroSpace (K := K) (L := L) 4 := by
    change normalizedTrace (K := K) 4 (basis i.succ) = 0
    rw [hbasis]
    change (4 : K)⁻¹ * Algebra.trace K L (t ^ (i.succ : ℕ)) = 0
    rw [quartic_power_basis_trace_nonconstant basis t hbasis m ht i.succ
      (Fin.succ_ne_zero i), mul_zero]
  let v : Fin 3 → traceZeroSpace (K := K) (L := L) 4 := fun i => ⟨basis i.succ, hmem i⟩
  have hli : LinearIndependent K v := by
    apply LinearIndependent.of_comp (traceZeroSpace (K := K) (L := L) 4).subtype
    exact basis.linearIndependent.comp Fin.succ (Fin.succ_injective 3)
  have hcard : Fintype.card (Fin 3) = finrank K (traceZeroSpace (K := K) (L := L) 4) := by
    have h := traceZeroSpace_finrank_add_one 4 hdim hfour
    rw [Fintype.card_fin]
    omega
  refine ⟨basisOfLinearIndependentOfCardEqFinrank hli hcard, ?_⟩
  intro i
  rw [coe_basisOfLinearIndependentOfCardEqFinrank]
  exact hbasis i.succ

theorem quartic_trace_zero_power_basis_pairing_matrix (basis : Basis (Fin 4) K L) (t : L)
    (hbasis : ∀ i : Fin 4, basis i = t ^ (i : ℕ)) (m : K)
    (ht : t ^ 4 = algebraMap K L m) (hfour : (4 : K) ≠ 0)
    (bV : Basis (Fin 3) K (traceZeroSpace (K := K) (L := L) 4))
    (hbV : ∀ i : Fin 3, (bV i : L) = t ^ ((i : ℕ) + 1)) :
    BilinForm.toMatrix bV (normalizedTraceZeroPairing 4) = kummerTracePairingMatrix m := by
  have hdim : finrank K L = 4 := by
    simpa only [Fintype.card_fin] using finrank_eq_card_basis basis
  have hnorm (k : Fin 4) (hk : k ≠ 0) :
      normalizedTrace (K := K) 4 (t ^ (k : ℕ)) = 0 := by
    change (4 : K)⁻¹ * Algebra.trace K L (t ^ (k : ℕ)) = 0
    rw [quartic_power_basis_trace_nonconstant basis t hbasis m ht k hk, mul_zero]
  have h2 : normalizedTrace (K := K) 4 (t ^ 2) = 0 := hnorm 2 (by decide)
  have h3 : normalizedTrace (K := K) 4 (t ^ 3) = 0 := hnorm 3 (by decide)
  have h1 : normalizedTrace (K := K) 4 t = 0 := by
    have h := hnorm (1 : Fin 4) (by decide)
    change normalizedTrace (K := K) 4 (t ^ 1) = 0 at h
    simpa only [pow_one] using h
  have h4 : normalizedTrace (K := K) 4 (t ^ 4) = m := by
    rw [ht, normalizedTrace_algebraMap 4 hdim hfour]
  have h5 : normalizedTrace (K := K) 4 (t ^ 5) = 0 := by
    rw [show 5 = 4 + 1 from rfl, pow_add, ht, pow_one, ← Algebra.smul_def, map_smul, h1, smul_zero]
  have h6 : normalizedTrace (K := K) 4 (t ^ 6) = 0 := by
    rw [show 6 = 4 + 2 from rfl, pow_add, ht, ← Algebra.smul_def, map_smul, h2, smul_zero]
  ext i j
  rw [BilinForm.toMatrix_apply, normalizedTraceZeroPairing_apply, hbV i, hbV j, ← pow_add]
  fin_cases i <;> fin_cases j
  · exact h2
  · exact h3
  · exact h4
  · exact h3
  · exact h4
  · exact h5
  · exact h4
  · exact h5
  · exact h6

end Litt3.CartierAndSpin

import Solutions.CartierAndSpin.KummerPairing
import Solutions.CartierAndSpin.TraceCompression
import Definitions.CartierAndSpin.KummerElements

namespace Litt3.CartierAndSpin

open Module LinearMap

variable {K L : Type*} [Field K] [Field L] [Algebra K L] [FiniteDimensional K L]

theorem quartic_normalizedTrace_kummerElement (basis : Basis (Fin 4) K L) (t : L)
    (hbasis : ∀ i : Fin 4, basis i = t ^ (i : ℕ)) (m : K)
    (ht : t ^ 4 = algebraMap K L m) (hfour : (4 : K) ≠ 0) (a b c d : K) :
    normalizedTrace (K := K) 4 (kummerElement t a b c d) = a := by
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
  simp only [kummerElement, map_add, map_smul, h1, h2, h3, smul_zero, add_zero,
    normalizedTrace_algebraMap 4 hdim hfour]

theorem quartic_projection_kummerElement (basis : Basis (Fin 4) K L) (t : L)
    (hbasis : ∀ i : Fin 4, basis i = t ^ (i : ℕ)) (m : K)
    (ht : t ^ 4 = algebraMap K L m) (hfour : (4 : K) ≠ 0) (a b c d : K) :
    traceZeroProjection (K := K) 4 (kummerElement t a b c d) =
      b • t + c • t ^ 2 + d • t ^ 3 := by
  rw [traceZeroProjection_apply,
    quartic_normalizedTrace_kummerElement basis t hbasis m ht hfour a b c d]
  dsimp only [kummerElement]
  abel

omit [FiniteDimensional K L] in
theorem kummerElement_mul_generator (t : L) (m : K)
    (ht : t ^ 4 = algebraMap K L m) (a b c d : K) :
    kummerElement t a b c d * t = kummerElement t (m*d) a b c := by
  simp only [kummerElement, Algebra.smul_def, map_mul]
  linear_combination algebraMap K L d * ht

omit [FiniteDimensional K L] in
theorem kummerElement_mul_generator_square (t : L) (m : K)
    (ht : t ^ 4 = algebraMap K L m) (a b c d : K) :
    kummerElement t a b c d * t ^ 2 = kummerElement t (m*c) (m*d) a b := by
  rw [pow_two, ← mul_assoc, kummerElement_mul_generator t m ht,
    kummerElement_mul_generator t m ht]

omit [FiniteDimensional K L] in
theorem kummerElement_mul_generator_cube (t : L) (m : K)
    (ht : t ^ 4 = algebraMap K L m) (a b c d : K) :
    kummerElement t a b c d * t ^ 3 = kummerElement t (m*b) (m*c) (m*d) a := by
  rw [show 3 = 2 + 1 from rfl, pow_add, pow_one, ← mul_assoc,
    kummerElement_mul_generator_square t m ht, kummerElement_mul_generator t m ht]

theorem quartic_kummer_compression_matrix (basis : Basis (Fin 4) K L) (t : L)
    (hbasis : ∀ i : Fin 4, basis i = t ^ (i : ℕ)) (m : K)
    (ht : t ^ 4 = algebraMap K L m) (hfour : (4 : K) ≠ 0)
    (hdim : finrank K L = 4)
    (bV : Basis (Fin 3) K (traceZeroSpace (K := K) (L := L) 4))
    (hbV : ∀ i : Fin 3, (bV i : L) = t ^ ((i : ℕ) + 1)) (a b c d : K) :
    LinearMap.toMatrix bV bV (traceZeroCompression 4 hdim hfour (kummerElement t a b c d)) =
      kummerCompressionMatrix m a b c d := by
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
  have hcol0 : traceZeroCompression 4 hdim hfour (kummerElement t a b c d) (bV 0) =
      a • bV 0 + b • bV 1 + c • bV 2 := by
    apply Subtype.ext
    rw [traceZeroCompression_apply, hb0]
    rw [kummerElement_mul_generator t m ht,
      quartic_projection_kummerElement basis t hbasis m ht hfour]
    simp only [Submodule.coe_add, Submodule.coe_smul, hb0, hb1, hb2]
  have hcol1 : traceZeroCompression 4 hdim hfour (kummerElement t a b c d) (bV 1) =
      (m*d) • bV 0 + a • bV 1 + b • bV 2 := by
    apply Subtype.ext
    rw [traceZeroCompression_apply, hb1]
    rw [kummerElement_mul_generator_square t m ht,
      quartic_projection_kummerElement basis t hbasis m ht hfour]
    simp only [Submodule.coe_add, Submodule.coe_smul, hb0, hb1, hb2]
  have hcol2 : traceZeroCompression 4 hdim hfour (kummerElement t a b c d) (bV 2) =
      (m*c) • bV 0 + (m*d) • bV 1 + a • bV 2 := by
    apply Subtype.ext
    rw [traceZeroCompression_apply, hb2]
    rw [kummerElement_mul_generator_cube t m ht,
      quartic_projection_kummerElement basis t hbasis m ht hfour]
    simp only [Submodule.coe_add, Submodule.coe_smul, hb0, hb1, hb2]
  ext i j
  rw [LinearMap.toMatrix_apply]
  fin_cases i <;> fin_cases j
  · change (bV.repr (traceZeroCompression 4 hdim hfour (kummerElement t a b c d) (bV 0))) 0 = a
    rw [hcol0]
    simp [bV.repr_self]
  · change (bV.repr (traceZeroCompression 4 hdim hfour (kummerElement t a b c d) (bV 1))) 0 = m*d
    rw [hcol1]
    simp [bV.repr_self]
  · change (bV.repr (traceZeroCompression 4 hdim hfour (kummerElement t a b c d) (bV 2))) 0 = m*c
    rw [hcol2]
    simp [bV.repr_self]
  · change (bV.repr (traceZeroCompression 4 hdim hfour (kummerElement t a b c d) (bV 0))) 1 = b
    rw [hcol0]
    simp [bV.repr_self]
  · change (bV.repr (traceZeroCompression 4 hdim hfour (kummerElement t a b c d) (bV 1))) 1 = a
    rw [hcol1]
    simp [bV.repr_self]
  · change (bV.repr (traceZeroCompression 4 hdim hfour (kummerElement t a b c d) (bV 2))) 1 = m*d
    rw [hcol2]
    simp [bV.repr_self]
  · change (bV.repr (traceZeroCompression 4 hdim hfour (kummerElement t a b c d) (bV 0))) 2 = c
    rw [hcol0]
    simp [bV.repr_self]
  · change (bV.repr (traceZeroCompression 4 hdim hfour (kummerElement t a b c d) (bV 1))) 2 = b
    rw [hcol1]
    simp [bV.repr_self]
  · change (bV.repr (traceZeroCompression 4 hdim hfour (kummerElement t a b c d) (bV 2))) 2 = a
    rw [hcol2]
    simp [bV.repr_self]

end Litt3.CartierAndSpin

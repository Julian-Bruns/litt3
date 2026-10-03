import Solutions.CartierAndSpin.SeparableSubfieldDerivations
import Theorems.CartierAndSpin.GaussFieldRecovery

namespace Litt3.CartierAndSpin

open IntermediateField

variable {k L : Type*} [Field k] [Field L] [Algebra k L]

/-- The classical Gauss-field calculation over arbitrary characteristic.
The actual intercept is separable over the actual slope field, and the
second derivative is nonzero. Stability is proved by minimal-polynomial
differentiation, rather than assumed for the slope/intercept field. -/
theorem gauss_field_recovers_coordinates (D : Derivation k L L) (u v : L)
    (hDu : D u = 1) (hsecond : D (D v) ≠ 0)
    (hseparable : IsSeparable (IntermediateField.adjoin k ({D v} : Set L)) (v - u * D v)) :
    Specifications.GaussFieldRecoversCoordinates D u v := by
  let M := D v
  let N := v - u * D v
  let B := IntermediateField.adjoin k ({M} : Set L)
  let G := IntermediateField.adjoin k ({M, N} : Set L)
  have hM : M ∈ G := subset_adjoin k _ (by simp)
  have hN : N ∈ G := subset_adjoin k _ (by simp)
  have hBG : B ≤ G := by
    apply adjoin_le_iff.mpr
    intro x hx
    have hxeq : x = M := Set.mem_singleton_iff.mp hx
    simpa only [hxeq] using hM
  let d : Derivation k L L := (D M)⁻¹ • D
  have hDM : D M ≠ 0 := hsecond
  have hdM : d M = 1 := by
    change (D M)⁻¹ * D M = 1
    exact inv_mul_cancel₀ hDM
  have hstable : ∀ x ∈ B, d x ∈ B := by
    apply derivation_stable_adjoin d ({M} : Set L)
    intro x hx
    have hxeq : x = M := Set.mem_singleton_iff.mp hx
    rw [hxeq, hdM]
    exact one_mem _
  let dB := restrictedIntermediateDerivation d B hstable
  let GB := IntermediateField.extendScalars hBG
  have hdNmem : d N ∈ GB := separable_element_derivation_mem dB d
    (restrictedIntermediateDerivation_compatible d B hstable) GB N hN hseparable
  have hDN : D N = -u * D M := by
    dsimp only [N, M]
    rw [map_sub, D.leibniz, hDu]
    simp only [smul_eq_mul]
    ring
  have hdN : d N = -u := by
    change (D M)⁻¹ * D N = -u
    rw [hDN]
    calc
      (D M)⁻¹ * (-u * D M) = -u * ((D M)⁻¹ * D M) := by ring
      _ = -u := by rw [inv_mul_cancel₀ hDM, mul_one]
  have hu : u ∈ G := by
    have hnegative : -u ∈ G := by simpa only [hdN] using hdNmem
    simpa only [neg_neg] using G.neg_mem hnegative
  have hv : v ∈ G := by
    have hvalue : v = N + u * M := by dsimp only [N, M]; ring
    rw [hvalue]
    exact G.add_mem hN (G.mul_mem hu hM)
  exact ⟨hu, hv⟩

/-- A genuinely generating original coordinate pair makes the actual
slope/intercept field the entire original function field. No smoothness
or nonsingularity assumption on a plane image is used in this algebra. -/
theorem gauss_field_eq_top (D : Derivation k L L) (u v : L)
    (hDu : D u = 1) (hsecond : D (D v) ≠ 0)
    (hseparable : IsSeparable (IntermediateField.adjoin k ({D v} : Set L)) (v - u * D v))
    (hgenerates : IntermediateField.adjoin k ({u, v} : Set L) = ⊤) :
    IntermediateField.adjoin k ({D v, v - u * D v} : Set L) = ⊤ := by
  obtain ⟨hu, hv⟩ := gauss_field_recovers_coordinates D u v hDu hsecond hseparable
  apply top_unique
  rw [← hgenerates]
  apply adjoin_le_iff.mpr
  intro x hx
  rcases Set.mem_insert_iff.mp hx with hxu | hxv
  · simpa only [hxu] using hu
  · have hxv' : x = v := Set.mem_singleton_iff.mp hxv
    simpa only [hxv'] using hv

end Litt3.CartierAndSpin

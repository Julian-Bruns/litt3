import Solutions.CartierAndSpin.RestrictedConnectionDichotomy

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {R K : Type*} [CommRing R] [Field K] [Algebra R K]
  {p : ℕ} [Fact p.Prime] [CharP K p]

/-- When the literal curvature coefficient is nonzero, the actual
connection is bijective. Surjection has the explicit iterate/division
preimage; neither finite dimension nor an inverse matrix is assumed. -/
theorem actual_normalized_connection_bijective_of_curvature_ne_zero
    (b : PowerPBasis K p) (D : Derivation R K K)
    (hDt : D b.parameter = 1) (f : K)
    (hcurv : D^[p - 1] f + f ^ p ≠ 0) :
    Function.Bijective (scalarDerivationConnection D f) := by
  let L := scalarDerivationConnection D f
  let c := -(D^[p - 1] f + f ^ p)
  have hc : c ≠ 0 := neg_ne_zero.mpr hcurv
  constructor
  · intro a d had
    have hpow : L^[p] a = L^[p] d := by
      obtain ⟨n, hn⟩ := Nat.exists_eq_succ_of_ne_zero (Fact.out : p.Prime).ne_zero
      rw [hn, Function.iterate_succ_apply, Function.iterate_succ_apply, had]
    rw [actual_normalized_derivation_restricted_connection_identity b D hDt f a,
      actual_normalized_derivation_restricted_connection_identity b D hDt f d] at hpow
    exact mul_left_cancel₀ hc hpow
  · intro y
    refine ⟨L^[p - 1] (y / c), ?_⟩
    rw [← Function.iterate_succ_apply' L (p - 1) (y / c)]
    have hexp : (p - 1).succ = p := by have := (Fact.out : p.Prime).pos; omega
    rw [hexp,
      actual_normalized_derivation_restricted_connection_identity b D hDt f]
    change c * (y / c) = y
    field_simp [hc]

/-- Exact connection bijectivity criterion, complementary to the
derived nonzero-kernel/nilpotent curvature-zero case. -/
theorem actual_normalized_connection_bijective_iff
    (b : PowerPBasis K p) (D : Derivation R K K)
    (hDt : D b.parameter = 1) (f : K) :
    Function.Bijective (scalarDerivationConnection D f) ↔
      D^[p - 1] f + f ^ p ≠ 0 := by
  constructor
  · intro hbij hzero
    obtain ⟨u, hune, hu⟩ :=
      (actual_normalized_connection_kernel_iff b D hDt f).mpr hzero
    have hLzero : scalarDerivationConnection D f u = 0 := sub_eq_zero.mpr hu
    exact hune (hbij.1 (hLzero.trans (map_zero _).symm))
  · exact actual_normalized_connection_bijective_of_curvature_ne_zero b D hDt f

end Litt3.CartierAndSpin

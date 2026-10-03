import Solutions.CartierAndSpin.RestrictedNormalizedDerivations

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {R K : Type*} [CommRing R] [Field K] [Algebra R K]
  {p : ℕ} [Fact p.Prime] [CharP K p]

/-- The actual normalized connection has a nonzero field kernel EXACTLY
when its literal curvature coefficient vanishes. Nilpotence and the
nonzero solution are proved from the restricted identity, not supplied. -/
theorem actual_normalized_connection_kernel_iff
    (b : PowerPBasis K p) (D : Derivation R K K)
    (hDt : D b.parameter = 1) (f : K) :
    (∃ u : K, u ≠ 0 ∧ D u = f * u) ↔ D^[p - 1] f + f ^ p = 0 := by
  let L := scalarDerivationConnection D f
  constructor
  · rintro ⟨u, hune, hu⟩
    have hLu : L u = 0 := sub_eq_zero.mpr hu
    have hiter : ∀ n : ℕ, L^[n + 1] u = 0 := by
      intro n
      rw [Function.iterate_succ_apply, hLu]
      exact iterate_map_zero L n
    have hid := actual_normalized_derivation_restricted_connection_identity b D hDt f u
    have hzero : L^[p] u = 0 := by
      have h := hiter (p - 1)
      simpa only [Nat.sub_add_cancel (Fact.out : p.Prime).pos] using h
    change L^[p] u = _ at hid
    rw [hzero] at hid
    have hcurvneg : -(D^[p - 1] f + f ^ p) = 0 :=
      (mul_eq_zero.mp hid.symm).resolve_right hune
    exact neg_eq_zero.mp hcurvneg
  · intro hcurv
    by_contra hnone
    have hinj : Function.Injective L := by
      intro a c hac
      have hLzero : L (a - c) = 0 := by rw [map_sub, hac, sub_self]
      have heq : D (a - c) = f * (a - c) := sub_eq_zero.mp hLzero
      by_contra hne
      exact hnone ⟨a - c, sub_ne_zero.mpr hne, heq⟩
    have hone : L^[p] (1 : K) = 0 := by
      rw [actual_normalized_derivation_restricted_connection_identity b D hDt f,
        hcurv, neg_zero, zero_mul]
    have hzero : L^[p] (0 : K) = 0 := iterate_map_zero L p
    exact one_ne_zero ((hinj.iterate p) (hone.trans hzero.symm))

end Litt3.CartierAndSpin

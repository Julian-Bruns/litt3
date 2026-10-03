import Mathlib.Algebra.Polynomial.Lifts
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K]

theorem source_remainder_coefficient_mem_subring (S : Subring K) (H : K[X])
    (q : K) (p j : ℕ) (hp : 0 < p)
    (hH : ∀ n, H.coeff n ∈ S) (hq : q ∈ S) :
    (H %ₘ (X ^ p + C q)).coeff j ∈ S := by
  have hlift : H ∈ Polynomial.lifts S.subtype := by
    rw [Polynomial.lifts_iff_coeff_lifts]
    intro n
    exact ⟨⟨H.coeff n, hH n⟩, rfl⟩
  obtain ⟨P, hP⟩ := hlift
  change P.map S.subtype = H at hP
  have hm : (X ^ p + C (⟨q, hq⟩ : S) : S[X]).Monic :=
    monic_X_pow_add_C _ (by omega)
  have hmap := Polynomial.map_modByMonic S.subtype (p := P) hm
  have hmap' : (P %ₘ (X ^ p + C (⟨q, hq⟩ : S))).map S.subtype =
      H %ₘ (X ^ p + C q) := by
    simpa only [hP, Polynomial.map_add, Polynomial.map_pow, Polynomial.map_X,
      Polynomial.map_C] using hmap
  rw [← hmap', Polynomial.coeff_map]
  exact ((P %ₘ (X ^ p + C (⟨q, hq⟩ : S))).coeff j).property

theorem inverse_mem_subring_of_unit (S : Subring K) (x : K) (hx : x ∈ S)
    (hunit : IsUnit (⟨x, hx⟩ : S)) : x⁻¹ ∈ S := by
  obtain ⟨u, hu⟩ := hunit
  have huvalue : ((u : S) : K) = x := congrArg (fun z : S => (z : K)) hu
  have hmul : x * ((↑u⁻¹ : S) : K) = 1 := by
    rw [← huvalue, ← Subring.coe_mul]
    exact congrArg (fun z : S => (z : K)) (Units.mul_inv u)
  have hinv : ((↑u⁻¹ : S) : K) = x⁻¹ := by
    have hxzero : x ≠ 0 := by intro hz; simp [hz] at hmul
    apply (mul_left_cancel₀ hxzero)
    rw [hmul, mul_inv_cancel₀ hxzero]
  rw [← hinv]
  exact (↑u⁻¹ : S).property

end Litt3.CartierAndSpin

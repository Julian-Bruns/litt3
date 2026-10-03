import Definitions.Atlases.FrobeniusCertificates
import Solutions.Atlases.StableRange
import Mathlib.RingTheory.Nilpotent.Basic

namespace Litt3.Atlases

variable {K A : Type*} [Field K] [Fintype K] [CommRing A] [Algebra K A]

theorem qFrobenius_pow_apply (e : ℕ) (x : A) :
    (qFrobenius K A ^ e) x = x ^ (Fintype.card K ^ e) := by
  rw [Module.End.pow_apply]
  change ((fun a : A => a ^ Fintype.card K)^[e]) x = _
  exact congr_fun (pow_iterate (Fintype.card K) e) x

/-- Nilpotents are actually killed by a Frobenius iterate. -/
theorem qFrobenius_eventually_kills_nilpotent (x : A) (h : IsNilpotent x) :
    ∃ n : ℕ, (qFrobenius K A ^ n) x = 0 := by
  obtain ⟨n, hn⟩ := h
  refine ⟨n, ?_⟩
  rw [qFrobenius_pow_apply]
  exact pow_eq_zero_of_le (Nat.lt_pow_self Fintype.one_lt_card).le hn

variable [FiniteDimensional K A]

/-- A single exact consecutive rank plateau certifies that the actual
Frobenius image contains no nonzero nilpotent, including exponent zero. -/
theorem stable_qFrobenius_image_reduced (e : ℕ)
    (h : ExactRangePlateau (qFrobenius K A) e)
    (x : A) (hx : x ∈ LinearMap.range (qFrobenius K A ^ e))
    (hnil : IsNilpotent x) : x = 0 := by
  obtain ⟨n, hn⟩ := qFrobenius_eventually_kills_nilpotent (K := K) x hnil
  exact stable_range_has_no_nilpotent_vector (qFrobenius K A) e h x hx n hn

/-- The adaptive rank certificate determines the nilradical exactly. -/
theorem stable_qFrobenius_kernel_iff_nilpotent (e : ℕ)
    (h : ExactRangePlateau (qFrobenius K A) e) (x : A) :
    (qFrobenius K A ^ e) x = 0 ↔ IsNilpotent x := by
  constructor
  · intro hx
    exact ⟨Fintype.card K ^ e, by simpa only [qFrobenius_pow_apply] using hx⟩
  · intro hx
    apply stable_qFrobenius_image_reduced e h ((qFrobenius K A ^ e) x)
      (LinearMap.mem_range_self _ x)
    rw [qFrobenius_pow_apply]
    exact hx.pow_of_pos (pow_pos (Fintype.card_pos : 0 < Fintype.card K) e).ne'

end Litt3.Atlases

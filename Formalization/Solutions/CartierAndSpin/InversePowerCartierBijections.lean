import Solutions.SharedTensors.SemilinearLineCartier

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {k V : Type*} [Field k] [IsAlgClosed k]
  [AddCommGroup V] [Module k V]

/-- ANY nonzero inverse-n semilinear additive map on a genuine line
over an algebraically closed field is bijective, for EVERY n>0.
No characteristic, prime exponent, chosen fixed generator or scalar
solvability premise is used. All roots are taken in the ORIGINAL field. -/
theorem actual_line_nonzero_inverse_power_cartier_bijective
    {n : ℕ} (hn : 0 < n) (e : V ≃ₗ[k] k) (C : V →+ V)
    (hC : ∀ (a : k) (v : V), C (a ^ n • v) = a • C v)
    (hne : C ≠ 0) : Function.Bijective C := by
  let v := e.symm 1
  have hCv : e (C v) ≠ 0 := by
    intro hz
    apply hne
    apply actual_line_inverse_power_semilinear_eq_zero_of_generator hn e C hC
    apply e.injective
    simpa only [map_zero] using hz
  have hkernel : ∀ w : V, C w = 0 → w = 0 := by
    intro w hw
    obtain ⟨t, ht⟩ := IsAlgClosed.exists_pow_nat_eq (e w) hn
    have hrepr : t ^ n • v = w := by
      apply e.injective
      rw [map_smul]
      change t ^ n * e (e.symm 1) = e w
      rw [e.apply_symm_apply, mul_one, ht]
    have htzero : t = 0 := by
      have heq := congrArg e (hC t v)
      rw [hrepr, hw, map_zero, map_smul, smul_eq_mul] at heq
      exact (mul_eq_zero.mp heq.symm).resolve_right hCv
    rw [← hrepr, htzero, zero_pow hn.ne', zero_smul]
  constructor
  · intro a b h
    apply sub_eq_zero.mp
    apply hkernel
    rw [map_sub, h, sub_self]
  · intro w
    refine ⟨(e w / e (C v)) ^ n • v, e.injective ?_⟩
    rw [hC, map_smul, smul_eq_mul]
    exact div_mul_cancel₀ _ hCv

/-- The same conclusion derives the coordinate from a TRUE finite
dimension bound at most one; a nonzero operator excludes the zero space. -/
theorem actual_rank_le_one_nonzero_inverse_power_cartier_bijective
    [Module.Finite k V] {n : ℕ} (hn : 0 < n)
    (hdim : Module.finrank k V ≤ 1) (C : V →+ V)
    (hC : ∀ (a : k) (v : V), C (a ^ n • v) = a • C v)
    (hne : C ≠ 0) : Function.Bijective C := by
  have hdimone : Module.finrank k V = 1 := by
    by_contra hnot
    have hz : Module.finrank k V = 0 := by omega
    letI : Subsingleton V := Module.finrank_zero_iff.mp hz
    apply hne
    ext v
    exact Subsingleton.elim _ _
  have hsame : Module.finrank k V = Module.finrank k k := by
    simpa only [Module.finrank_self] using hdimone
  exact actual_line_nonzero_inverse_power_cartier_bijective hn
    (LinearEquiv.ofFinrankEq (R := k) V k hsame) C hC hne

end Litt3.CartierAndSpin

import Solutions.CartierAndSpin.FrobeniusPowerFixedCardinality

namespace Litt3.CartierAndSpin

/-- A field automorphism and its inverse have the SAME literal fixed
scalar subfield. -/
theorem field_equiv_symm_scalar_equalizer {k : Type*} [Field k]
    (sigma : k ≃+* k) :
    sigma.symm.toRingHom.eqLocusField (RingHom.id k) =
      sigma.toRingHom.eqLocusField (RingHom.id k) := by
  ext x
  change sigma.symm x = x ↔ sigma x = x
  constructor
  · intro h
    have heq := congrArg sigma h
    rw [sigma.apply_symm_apply] at heq
    exact heq.symm
  · intro h
    have heq := congrArg sigma.symm h
    rw [sigma.symm_apply_apply] at heq
    exact heq.symm

variable {k V : Type*} [Field k] [PerfectField k] [AddCommGroup V] [Module k V]
    {p : ℕ} [Fact p.Prime] [CharP k p]

/-- Positive inverse-Frobenius powers have finite literal fixed groups
with size at most p^(n*dim), over every perfect field. Every scalar
equalizer and its finite root count is derived, and the operator need
not be invertible. -/
theorem inverse_frobenius_power_fixed_kernel_finite_and_card_le
    [Module.Finite k V] (n : ℕ) (hn : 0 < n)
    (C : V →+ V) (hC : ∀ (a : k) (v : V), C (a ^ (p ^ n) • v) = a • C v) :
    Finite (C - AddMonoidHom.id V).ker ∧
      Nat.card (C - AddMonoidHom.id V).ker ≤ p ^ (n * Module.finrank k V) := by
  let sigma := iterateFrobeniusEquiv k p n
  have hlinear (a : k) (v : V) : C (a • v) = sigma.symm a • C v := by
    have hroot : (sigma.symm a) ^ (p ^ n) = a := sigma.apply_symm_apply a
    simpa only [hroot] using hC (sigma.symm a) v
  have hE : sigma.symm.toRingHom.eqLocusField (RingHom.id k) =
      (iterateFrobenius k p n).eqLocusField (RingHom.id k) :=
    field_equiv_symm_scalar_equalizer sigma
  obtain ⟨hfinite, hcard⟩ := frobenius_power_scalar_fixed_finite_and_card_le (k := k) n hn
  letI : Finite (sigma.symm.toRingHom.eqLocusField (RingHom.id k)) := by
    rw [hE]
    exact hfinite
  refine ⟨field_endomorphism_fixed_kernel_finite sigma.symm.toRingHom C hlinear, ?_⟩
  calc
    Nat.card (C - AddMonoidHom.id V).ker ≤
        Nat.card (sigma.symm.toRingHom.eqLocusField (RingHom.id k)) ^
          Module.finrank k V :=
      field_endomorphism_fixed_kernel_card_le sigma.symm.toRingHom C hlinear
    _ ≤ (p ^ n) ^ Module.finrank k V :=
      Nat.pow_le_pow_left (by simpa only [hE] using hcard) _
    _ = p ^ (n * Module.finrank k V) := (pow_mul p n _).symm

end Litt3.CartierAndSpin

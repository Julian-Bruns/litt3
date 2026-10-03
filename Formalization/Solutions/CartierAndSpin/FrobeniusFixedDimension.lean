import Solutions.CartierAndSpin.FieldEndomorphismFixedDimension
import Mathlib.FieldTheory.Finite.Basic

namespace Litt3.CartierAndSpin

variable {k V : Type*} [Field k] [AddCommGroup V] [Module k V]
    {p : ℕ} [Fact p.Prime] [CharP k p]

/-- The actual scalar equalizer of Frobenius is the literal prime
subfield, also over IMPERFECT fields. -/
theorem frobenius_scalar_equalizer_prime_subfield :
    (frobenius k p).eqLocusField (RingHom.id k) = (⊥ : Subfield k) := by
  ext x
  exact (Subfield.mem_bot_iff_pow_eq_self k p).symm

/-- For FORWARD Frobenius semilinearity, independence descent does not
need perfectness of the scalar field or invertibility of the operator. -/
theorem frobenius_fixed_independent
    (C : V →+ V) (hC : ∀ (a : k) (v : V), C (a • v) = a ^ p • C v)
    {ι : Type*} (v : ι → V) (hfixed : ∀ i, C (v i) = v i)
    (hind : LinearIndependent (⊥ : Subfield k) v) : LinearIndependent k v := by
  apply field_endomorphism_fixed_independent (frobenius k p) C hC v hfixed
  rw [frobenius_scalar_equalizer_prime_subfield]
  exact hind

/-- Literal fixed groups of actual forward Frobenius-semilinear maps
on finite-dimensional spaces are finite with size at most p^dim,
over arbitrary characteristic-p fields, including imperfect fields. -/
theorem frobenius_fixed_kernel_finite_and_card_le
    [Module.Finite k V]
    (C : V →+ V) (hC : ∀ (a : k) (v : V), C (a • v) = a ^ p • C v) :
    Finite (C - AddMonoidHom.id V).ker ∧
      Nat.card (C - AddMonoidHom.id V).ker ≤ p ^ Module.finrank k V := by
  letI : Finite ((frobenius k p).eqLocusField (RingHom.id k)) := by
    rw [frobenius_scalar_equalizer_prime_subfield]
    letI := Subfield.fintypeBot k p
    infer_instance
  refine ⟨field_endomorphism_fixed_kernel_finite (frobenius k p) C hC, ?_⟩
  simpa only [frobenius_scalar_equalizer_prime_subfield, Subfield.card_bot k p] using
    field_endomorphism_fixed_kernel_card_le (frobenius k p) C hC

end Litt3.CartierAndSpin

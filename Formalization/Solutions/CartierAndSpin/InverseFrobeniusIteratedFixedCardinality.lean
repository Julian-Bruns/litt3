import Solutions.CartierAndSpin.InverseFrobeniusPowerFixedCardinality
import Mathlib.Logic.Function.Iterate
import Mathlib.Algebra.Group.Hom.End

namespace Litt3.CartierAndSpin

variable {k V : Type*} [Field k] [AddCommGroup V] [Module k V]
    {p : ℕ} [Fact p.Prime] [CharP k p]

omit [Fact p.Prime] [CharP k p] in
/-- Every actual compositional power of an inverse-Frobenius additive
operator has the literal inverse-p^n scalar law. Perfectness is not
needed to derive the law itself. -/
theorem inverse_frobenius_addhom_power_semilinear
    (C : AddMonoid.End V) (hC : ∀ (a : k) (v : V), C (a ^ p • v) = a • C v)
    (n : ℕ) (a : k) (v : V) :
    (C ^ n) (a ^ (p ^ n) • v) = a • (C ^ n) v := by
  change C^[n] (a ^ (p ^ n) • v) = a • C^[n] v
  induction n generalizing a v with
  | zero => simp only [pow_zero, pow_one, Function.iterate_zero, id_eq]
  | succ n ih =>
    have hexp : a ^ (p ^ (n + 1)) = (a ^ p) ^ (p ^ n) := by
      rw [pow_succ, Nat.mul_comm (p ^ n) p, pow_mul]
    rw [hexp, Function.iterate_succ_apply', ih, hC, Function.iterate_succ_apply']

/-- At iteration zero the literal fixed group is the ENTIRE ambient
additive group. It is not presumed finite. -/
theorem inverse_frobenius_addhom_zero_fixed_kernel (C : AddMonoid.End V) :
    (C ^ 0 - 1 : AddMonoid.End V).ker = ⊤ := by
  apply SetLike.ext
  intro v
  change v - v = 0 ↔ True
  simp

/-- Every POSITIVE compositional iterate has a finite literal fixed
group of size at most p^(n*dim) over perfect scalars. Operator
invertibility and supplied fixed-space finiteness are not assumptions. -/
theorem inverse_frobenius_iterated_fixed_kernel_finite_and_card_le
    [PerfectField k] [Module.Finite k V]
    (C : AddMonoid.End V) (hC : ∀ (a : k) (v : V), C (a ^ p • v) = a • C v)
    (n : ℕ) (hn : 0 < n) :
    Finite (C ^ n - 1 : AddMonoid.End V).ker ∧
      Nat.card (C ^ n - 1 : AddMonoid.End V).ker ≤ p ^ (n * Module.finrank k V) :=
  inverse_frobenius_power_fixed_kernel_finite_and_card_le n hn (C ^ n)
    (inverse_frobenius_addhom_power_semilinear C hC n)

end Litt3.CartierAndSpin

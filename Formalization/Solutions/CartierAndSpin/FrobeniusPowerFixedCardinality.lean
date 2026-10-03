import Solutions.CartierAndSpin.FieldEndomorphismFixedDimension
import Mathlib.FieldTheory.Perfect
import Mathlib.Algebra.Polynomial.Roots

namespace Litt3.CartierAndSpin

open Polynomial

variable {k V : Type*} [Field k] [AddCommGroup V] [Module k V]
    {p : ℕ} [Fact p.Prime] [CharP k p]

/-- The LITERAL fixed scalar field of the n-th Frobenius is finite and
has at most p^n elements, over any characteristic-p field. The n=0 case
is intentionally excluded because its fixed scalar field is all of k. -/
theorem frobenius_power_scalar_fixed_finite_and_card_le
    (n : ℕ) (hn : 0 < n) :
    Finite ((iterateFrobenius k p n).eqLocusField (RingHom.id k)) ∧
      Nat.card ((iterateFrobenius k p n).eqLocusField (RingHom.id k)) ≤ p ^ n := by
  classical
  let E := (iterateFrobenius k p n).eqLocusField (RingHom.id k)
  let P : k[X] := Polynomial.X ^ (p ^ n) - Polynomial.X
  have hq : 1 < p ^ n := Nat.one_lt_pow (Nat.ne_of_gt hn) (Fact.out : p.Prime).one_lt
  have hP : P ≠ 0 := by
    intro h
    have hcoeff := congrArg (fun Q : k[X] => Q.coeff (p ^ n)) h
    simp [P, Polynomial.coeff_X, ne_of_lt hq] at hcoeff
  let f : E → P.roots.toFinset := fun a => ⟨a.val, by
    have ha : a.val ^ (p ^ n) = a.val := a.property
    rw [Multiset.mem_toFinset, Polynomial.mem_roots hP]
    change P.eval a.val = 0
    simpa only [P, Polynomial.eval_sub, Polynomial.eval_pow, Polynomial.eval_X] using
      sub_eq_zero.mpr ha⟩
  have hf : Function.Injective f := by
    intro a b h
    exact Subtype.ext (congrArg (fun z : P.roots.toFinset => (z : k)) h)
  letI : Finite E := Finite.of_injective f hf
  refine ⟨inferInstance, ?_⟩
  calc
    Nat.card E ≤ Nat.card P.roots.toFinset := Nat.card_le_card_of_injective f hf
    _ = P.roots.toFinset.card := by simp only [Nat.card_eq_fintype_card, Fintype.card_coe]
    _ ≤ P.roots.card := Multiset.toFinset_card_le _
    _ ≤ P.natDegree := Polynomial.card_roots' P
    _ ≤ p ^ n := by
      calc
        P.natDegree ≤ max (p ^ n) 1 := by
          simpa only [P, Polynomial.natDegree_X_pow, Polynomial.natDegree_X] using
            Polynomial.natDegree_sub_le (Polynomial.X ^ (p ^ n) : k[X]) Polynomial.X
        _ ≤ p ^ n := max_le le_rfl hq.le

/-- Forward p^n-semilinear fixed groups obey the finite size bound
p^(n*dim), even over imperfect fields and for noninvertible operators. -/
theorem frobenius_power_fixed_kernel_finite_and_card_le
    [Module.Finite k V] (n : ℕ) (hn : 0 < n)
    (C : V →+ V) (hC : ∀ (a : k) (v : V), C (a • v) = a ^ (p ^ n) • C v) :
    Finite (C - AddMonoidHom.id V).ker ∧
      Nat.card (C - AddMonoidHom.id V).ker ≤ p ^ (n * Module.finrank k V) := by
  obtain ⟨hfinite, hcard⟩ := frobenius_power_scalar_fixed_finite_and_card_le (k := k) n hn
  letI := hfinite
  refine ⟨field_endomorphism_fixed_kernel_finite (iterateFrobenius k p n) C hC, ?_⟩
  calc
    Nat.card (C - AddMonoidHom.id V).ker ≤
        Nat.card ((iterateFrobenius k p n).eqLocusField (RingHom.id k)) ^
          Module.finrank k V :=
      field_endomorphism_fixed_kernel_card_le (iterateFrobenius k p n) C hC
    _ ≤ (p ^ n) ^ Module.finrank k V := Nat.pow_le_pow_left hcard _
    _ = p ^ (n * Module.finrank k V) := (pow_mul p n _).symm

end Litt3.CartierAndSpin

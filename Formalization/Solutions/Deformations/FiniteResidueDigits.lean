import Mathlib.RingTheory.Ideal.Quotient.Defs
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Tactic

namespace Litt3.Deformations

open scoped BigOperators

variable {R k : Type*} [CommRing R] [CommRing k]

/-- Fixed residue sections give actual finite integral digit expansions.
Divisibility gives vanishing lower digits even with coefficient torsion;
uniqueness is not asserted. -/
theorem finite_residue_section_digits (p : R) (phi : R →+* k)
    (kernel : RingHom.ker phi = Ideal.span {p}) (lift : k → R)
    (residue : ∀ c, phi (lift c) = c) (zero : lift 0 = 0)
    (m n : ℕ) (c : R) (divisible : p ^ n ∣ c) :
    ∃ digits : Fin m → k, ∃ remainder : R,
      c = (∑ j : Fin m, p ^ j.val * lift (digits j)) + p ^ m * remainder ∧
      ∀ j : Fin m, j.val < n → digits j = 0 := by
  classical
  induction m generalizing n c with
  | zero => exact ⟨Fin.elim0, c, by simp, fun j => Fin.elim0 j⟩
  | succ m induction =>
    obtain ⟨q, z, first, nextDivisible, lower⟩ :
        ∃ q : k, ∃ z : R, c = lift q + p * z ∧ p ^ (n - 1) ∣ z ∧
          (0 < n → q = 0) := by
      by_cases initial : n = 0
      · subst n
        have member : c - lift (phi c) ∈ RingHom.ker phi := by
          rw [RingHom.mem_ker]
          simp [residue]
        rw [kernel, Ideal.mem_span_singleton] at member
        obtain ⟨z, equality⟩ := member
        refine ⟨phi c, z, ?_, by simp, by omega⟩
        linear_combination equality
      · obtain ⟨t, ht⟩ := divisible
        refine ⟨0, p ^ (n - 1) * t, ?_, dvd_mul_right _ _, fun _ => rfl⟩
        rw [zero, zero_add, ht, ← mul_assoc, ← pow_succ']
        rw [show n - 1 + 1 = n by omega]
    obtain ⟨digits, remainder, expansion, vanishing⟩ :=
      induction (n - 1) z nextDivisible
    refine ⟨Fin.cons q digits, remainder, ?_, ?_⟩
    · rw [Fin.sum_univ_succ]
      simp only [Fin.cons_zero, Fin.cons_succ, Fin.val_zero, Fin.val_succ, pow_zero, one_mul]
      have shifted : (∑ j : Fin m, p ^ (j.val + 1) * lift (digits j)) =
          p * ∑ j : Fin m, p ^ j.val * lift (digits j) := by
        rw [Finset.mul_sum]
        apply Finset.sum_congr rfl
        intro j _
        rw [pow_succ']
        ring
      rw [shifted, first, expansion, pow_succ']
      ring
    · intro j
      refine Fin.cases ?_ (fun i => ?_) j
      · intro bound
        exact lower bound
      · intro bound
        exact vanishing i (by simpa only [Fin.val_succ] using
          (show i.val < n - 1 by have := bound; simp only [Fin.val_succ] at this; omega))

end Litt3.Deformations

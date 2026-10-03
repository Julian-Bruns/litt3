import Mathlib.RingTheory.AdicCompletion.Basic
import Mathlib.Logic.Function.Iterate
import Mathlib.Tactic

namespace Litt3.Deformations

variable {A : Type*} [CommRing A]

/-- Actual contraction on positive ideal-power congruences constructs
the unique fixed point in the original residue class, together with
its full compatible original iteration. Continuity is not an input. -/
theorem adic_contracting_fixed_point (J : Ideal A) [IsAdicComplete J A]
    (T : A → A)
    (improves : ∀ (n : ℕ), 0 < n → ∀ x y,
      x ≡ y [SMOD (J ^ n)] → T x ≡ T y [SMOD (J ^ (n + 1))])
    (seed : A) (initial : T seed ≡ seed [SMOD J]) :
    ∃ x : A, T x = x ∧ x ≡ seed [SMOD J] ∧
      (∀ n, T^[n] seed ≡ x [SMOD (J ^ n)]) ∧
      ∀ y : A, T y = y → y ≡ seed [SMOD J] → y = x := by
  have consecutive (n : ℕ) : T^[n + 1] seed ≡ T^[n] seed [SMOD (J ^ (n + 1))] := by
    induction n with
    | zero => simpa using initial
    | succ n induction =>
      have next := improves (n + 1) (by omega) (T^[n + 1] seed) (T^[n] seed) induction
      simpa only [Function.iterate_succ_apply'] using next
  have compatible : ∀ (m n : ℕ), m ≤ n → T^[m] seed ≡ T^[n] seed [SMOD (J ^ m)] := by
    intro m n bound
    induction n, bound using Nat.le_induction with
    | base => exact SModEq.rfl
    | succ n bound induction =>
      have step := SModEq.mono (Ideal.pow_le_pow_right (by omega : m ≤ n + 1)) (consecutive n).symm
      exact induction.trans step
  obtain ⟨x, limits⟩ := IsPrecomplete.prec' (I := J) (fun n => T^[n] seed) (by
    intro m n bound
    simpa only [smul_eq_mul, Ideal.mul_top] using compatible m n bound)
  have approximation : ∀ n, T^[n] seed ≡ x [SMOD (J ^ n)] := by
    intro n
    simpa only [smul_eq_mul, Ideal.mul_top] using limits n
  have fixed : T x = x := by
    apply (IsHausdorff.eq_iff_smodEq (I := J)).mpr
    intro n
    simp only [smul_eq_mul, Ideal.mul_top]
    cases n with
    | zero => simp
    | succ n =>
      have next := improves (n + 1) (by omega) x (T^[n + 1] seed) (approximation (n + 1)).symm
      rw [← Function.iterate_succ_apply' T (n + 1) seed] at next
      exact SModEq.mono (Ideal.pow_le_pow_right (by omega : n + 1 ≤ n + 1 + 1))
        (next.trans (approximation (n + 1 + 1)))
  have residue : x ≡ seed [SMOD J] := by
    have approxOne := (approximation 1).symm
    simpa using approxOne.trans (consecutive 0)
  refine ⟨x, fixed, residue, approximation, ?_⟩
  intro y yFixed yResidue
  have allDepths (n : ℕ) : y ≡ x [SMOD (J ^ (n + 1))] := by
    induction n with
    | zero => simpa using yResidue.trans residue.symm
    | succ n induction =>
      have next := improves (n + 1) (by omega) y x induction
      simpa only [yFixed, fixed] using next
  apply (IsHausdorff.eq_iff_smodEq (I := J)).mpr
  intro n
  simp only [smul_eq_mul, Ideal.mul_top]
  cases n with
  | zero => simp
  | succ n => exact allDepths n

end Litt3.Deformations

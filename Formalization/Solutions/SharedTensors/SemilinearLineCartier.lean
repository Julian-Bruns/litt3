import Mathlib.FieldTheory.IsAlgClosed.Basic
import Mathlib.LinearAlgebra.FiniteDimensional.Basic
import Mathlib.LinearAlgebra.Dimension.Free

namespace Litt3.SharedTensors

open Polynomial Module

variable {k V : Type*} [Field k] [IsAlgClosed k]
  [AddCommGroup V] [Module k V]

/-- Every inverse-power semilinear additive endomorphism of an actual
line over algebraically closed coefficients has surjective C-1.
The exponent is ANY n>1; characteristic and primeness are unnecessary. -/
theorem actual_line_inverse_power_semilinear_sub_id_surjective
    {n : ℕ} (hn : 1 < n) (e : V ≃ₗ[k] k) (C : V →+ V)
    (hC : ∀ (a : k) (v : V), C (a ^ n • v) = a • C v) :
    Function.Surjective (fun v : V => C v - v) := by
  intro w
  let v := e.symm 1
  let a := e (C v)
  let b := e w
  let P : k[X] := X ^ n - (Polynomial.C a * X - Polynomial.C b)
  have hlower : (Polynomial.C a * X - Polynomial.C b).natDegree ≤ 1 := by
    apply (natDegree_sub_le _ _).trans
    apply max_le
    · exact natDegree_mul_le.trans (by simp)
    · simp
  have hdegree : P.natDegree = n := by
    have hlt : (Polynomial.C a * X - Polynomial.C b).natDegree <
        (X ^ n : k[X]).natDegree := by
      rw [natDegree_X_pow]
      omega
    exact (natDegree_sub_eq_left_of_natDegree_lt hlt).trans (natDegree_X_pow n)
  obtain ⟨t, ht⟩ := IsAlgClosed.exists_root P
    (ne_of_gt (natDegree_pos_iff_degree_pos.mp (by rw [hdegree]; omega)))
  have ht' : t ^ n - (a * t - b) = 0 := by
    simpa [Polynomial.IsRoot, P] using ht
  refine ⟨t ^ n • v, e.injective ?_⟩
  rw [map_sub, hC, map_smul, map_smul]
  change t * a - t ^ n * e (e.symm 1) = b
  rw [e.apply_symm_apply, mul_one]
  linear_combination -ht'

/-- The same conclusion includes the zero-dimensional case and derives
the line coordinate from the actual dimension bound. -/
theorem actual_rank_le_one_inverse_power_semilinear_sub_id_surjective
    [Module.Finite k V] {n : ℕ} (hn : 1 < n)
    (hdim : Module.finrank k V ≤ 1) (C : V →+ V)
    (hC : ∀ (a : k) (v : V), C (a ^ n • v) = a • C v) :
    Function.Surjective (fun v : V => C v - v) := by
  by_cases hz : Module.finrank k V = 0
  · letI : Subsingleton V := Module.finrank_zero_iff.mp hz
    intro w
    exact ⟨0, Subsingleton.elim _ _⟩
  · have hdim' : Module.finrank k V = Module.finrank k k := by
      rw [Module.finrank_self]
      omega
    exact actual_line_inverse_power_semilinear_sub_id_surjective hn
      (LinearEquiv.ofFinrankEq (R := k) V k hdim') C hC

/-- On an actual line, inverse-power semilinearity and algebraic
closedness make the value on one genuine generator determine the map. -/
theorem actual_line_inverse_power_semilinear_eq_zero_of_generator
    {n : ℕ} (hn : 0 < n) (e : V ≃ₗ[k] k) (C : V →+ V)
    (hC : ∀ (a : k) (v : V), C (a ^ n • v) = a • C v)
    (hzero : C (e.symm 1) = 0) : C = 0 := by
  ext w
  obtain ⟨t, ht⟩ := IsAlgClosed.exists_pow_nat_eq (e w) hn
  have hw : t ^ n • e.symm 1 = w := by
    apply e.injective
    simp [ht]
  rw [← hw, hC, hzero]
  simp

/-- Every nonzero inverse-power semilinear endomorphism of a genuine
line has a nonzero fixed generator, constructed by a single symbolic
algebraically closed root. No scalar solvability or chosen fixed
generator is supplied as an input. -/
theorem actual_line_inverse_power_semilinear_nonzero_fixed_generator
    {n : ℕ} (hn : 1 < n) (e : V ≃ₗ[k] k) (C : V →+ V)
    (hC : ∀ (a : k) (v : V), C (a ^ n • v) = a • C v)
    (hne : C ≠ 0) : ∃ v : V, v ≠ 0 ∧ C v = v := by
  let v := e.symm 1
  let a := e (C v)
  have ha : a ≠ 0 := by
    intro hz
    apply hne
    apply actual_line_inverse_power_semilinear_eq_zero_of_generator (by omega) e C hC
    apply e.injective
    simpa [a, v] using hz
  obtain ⟨t, ht⟩ := IsAlgClosed.exists_pow_nat_eq a (show 0 < n - 1 by omega)
  have htzero : t ≠ 0 := by
    intro hz
    apply ha
    rw [← ht, hz, zero_pow (show n - 1 ≠ 0 by omega)]
  refine ⟨t ^ n • v, ?_, e.injective ?_⟩
  · intro hz
    have h := congrArg e hz
    simp only [map_smul, v, e.apply_symm_apply, smul_eq_mul, mul_one, map_zero] at h
    exact (pow_ne_zero n htzero) h
  · rw [hC, map_smul, map_smul]
    change t * a = t ^ n * e (e.symm 1)
    rw [e.apply_symm_apply, mul_one, ← ht]
    conv_rhs => rw [← Nat.sub_add_cancel (show 1 ≤ n by omega), pow_succ]
    exact mul_comm _ _

/-- Relative to a genuine nonzero fixed vector, all fixed scalars are
EXACTLY the roots of a^n=a. The inverse-power root used in the forward
direction is constructed in the original coefficient field. -/
theorem actual_inverse_power_semilinear_fixed_scalar_iff
    {n : ℕ} (hn : 0 < n) (C : V →+ V)
    (hC : ∀ (a : k) (v : V), C (a ^ n • v) = a • C v)
    (v : V) (hv : v ≠ 0) (hfixed : C v = v) (a : k) :
    C (a • v) = a • v ↔ a ^ n = a := by
  constructor
  · intro h
    obtain ⟨t, ht⟩ := IsAlgClosed.exists_pow_nat_eq a hn
    have heq : t • v = a • v := by
      calc
        t • v = C (t ^ n • v) := by rw [hC, hfixed]
        _ = C (a • v) := by rw [ht]
        _ = a • v := h
    have hta : t = a := (smul_left_injective k hv) heq
    simpa only [hta] using ht
  · intro h
    rw [← h, hC, hfixed, h]

end Litt3.SharedTensors

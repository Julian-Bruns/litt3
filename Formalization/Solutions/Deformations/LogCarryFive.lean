import Solutions.Deformations.PreparedLogReduction
import Mathlib.Tactic

namespace Litt3.Deformations

variable {R V : Type*} [CommRing R] [AddCommGroup V] [Module R V]

/-- In every characteristic-five module, the actual inverse of two
in the original coefficient ring acts as three. -/
theorem inverse_two_smul_mod_five (twoUnit : IsUnit (2 : R))
    (fiveZero : ∀ v : V, (5 : R) • v = 0) (v : V) :
    Ring.inverse (2 : R) • v = (3 : R) • v := by
  have six : (6 : R) • v = v := by
    have arithmetic : (6 : R) = 5 + 1 := by norm_num
    rw [arithmetic, add_smul, fiveZero, one_smul, zero_add]
  calc
    Ring.inverse (2 : R) • v = Ring.inverse (2 : R) • ((6 : R) • v) := by rw [six]
    _ = (Ring.inverse (2 : R) * (2 * 3)) • v := by norm_num [mul_smul]
    _ = (3 : R) • v := by rw [← mul_assoc, Ring.inverse_mul_cancel _ twoUnit, one_mul]

/-- Literal two-coordinate expansion of the exact negative logarithmic
carry in characteristic five. The final D₂ is absent. -/
theorem truncated_log_carry_five_two (twoUnit : IsUnit (2 : R))
    (fiveZero : ∀ v : V, (5 : R) • v = 0)
    (C : V) (D : Fin 2 → V) :
    -truncatedLogValue (R := R) 2 (finiteCoefficientShift (R := R) (K := V) 2)
      ((Fin.cons C 0 : Fin 2 → V) + finiteCoefficientShift (R := R) 2 D) =
        Fin.cons (-C) (fun _ : Fin 1 => -((2 : R) • C + D 0)) := by
  have log : truncatedLogValue (R := R) 2 (finiteCoefficientShift (R := R) (K := V) 2) =
      (1 : Module.End R (Fin 2 → V)) -
        Ring.inverse (2 : R) • finiteCoefficientShift (R := R) 2 := by
    norm_num [truncatedLogValue, Finset.sum_range_succ, sub_eq_add_neg]
  rw [log]
  have shiftOne (v : Fin 2 → V) : finiteCoefficientShift (R := R) 2 v (1 : Fin 2) = v 0 :=
    finite_coefficient_shift_succ 1 v (0 : Fin 1)
  have consOne (v : V) (f : Fin 1 → V) : (Fin.cons v f : Fin 2 → V) (1 : Fin 2) = f 0 :=
    Fin.cons_one (α := fun _ : Fin 2 => V) v f
  ext i
  fin_cases i
  · simp
  · change (-(1 - Ring.inverse (2 : R) • finiteCoefficientShift (R := R) (K := V) 2)
      ((Fin.cons C 0 : Fin 2 → V) + finiteCoefficientShift (R := R) 2 D)) (1 : Fin 2) =
        (Fin.cons (-C) (fun _ : Fin 1 => -((2 : R) • C + D 0)) : Fin 2 → V) (1 : Fin 2)
    simp only [Pi.neg_apply, LinearMap.sub_apply, Module.End.one_apply, LinearMap.smul_apply,
      Pi.sub_apply, Pi.smul_apply, Pi.add_apply, shiftOne, consOne, Pi.zero_apply,
      zero_add, finite_coefficient_shift_zero, Fin.cons_zero, add_zero]
    rw [inverse_two_smul_mod_five twoUnit fiveZero]
    have five : (3 : R) • C + (2 : R) • C = 0 := by
      rw [← add_smul]
      convert fiveZero C using 1 <;> norm_num
    have identity : -(3 : R) • C = (2 : R) • C := by
      rw [neg_smul]
      exact neg_eq_iff_add_eq_zero.mpr five
    rw [sub_eq_add_neg, ← neg_smul, identity, add_comm]

end Litt3.Deformations

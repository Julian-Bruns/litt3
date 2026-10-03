import Solutions.Deformations.FiniteFieldNormalCoordinates
import Mathlib.FieldTheory.Finite.Basic
import Mathlib.GroupTheory.OrderOfElement

namespace Litt3.Deformations

open scoped BigOperators

variable (F k : Type*) [Field F] [Fintype F] [DecidableEq F] [Field k]
variable {I : Type*} [Fintype I] [DecidableEq I]

/-- Every scalar character forces the exact degree congruence of the
unchanged original normal coefficients. A primitive unit is derived from
finite-field cyclicity; no scalar or tuple enumeration is needed. -/
theorem finite_field_normal_character_support (ψ : F →+* k)
    (c : (I → Fin (Fintype.card F - 1 + 1)) → k) (d : ℕ)
    (character : ∀ (u : Fˣ) (a : I → F),
      finiteFieldNormalFunctionCoordinates (I := I) F k ψ c ((u : F) • a) =
        ψ u ^ d * finiteFieldNormalFunctionCoordinates (I := I) F k ψ c a)
    (alpha : I → Fin (Fintype.card F - 1 + 1)) (nonzero : c alpha ≠ 0) :
    (∑ i, (alpha i).val) % (Fintype.card F - 1) = d % (Fintype.card F - 1) := by
  classical
  obtain ⟨u, generator⟩ := IsCyclic.exists_generator (α := Fˣ)
  have order : orderOf u = Fintype.card F - 1 := by
    rw [orderOf_eq_card_of_forall_mem_zpowers generator, Nat.card_units,
      Nat.card_eq_fintype_card]
  have coefficients : (fun beta : I → Fin (Fintype.card F - 1 + 1) =>
      ψ u ^ (∑ i, (beta i).val) * c beta) =
      (fun beta => ψ u ^ d * c beta) := by
    apply (finiteFieldNormalFunctionCoordinates (I := I) F k ψ).injective
    funext a
    rw [finite_field_normal_function_coordinates_apply,
      finite_field_normal_function_coordinates_apply]
    calc
      _ = finiteFieldNormalFunctionCoordinates (I := I) F k ψ c ((u : F) • a) := by
        rw [finite_field_normal_function_coordinates_apply]
        have scale (beta : I → Fin (Fintype.card F - 1 + 1)) :
            (∏ i, ψ (((u : F) • a) i) ^ (beta i).val) =
              ψ u ^ (∑ i, (beta i).val) * ∏ i, ψ (a i) ^ (beta i).val := by
          change (∏ i, ψ ((u : F) * a i) ^ (beta i).val) = _
          simp only [map_mul, mul_pow, Finset.prod_mul_distrib,
            ← Finset.prod_pow_eq_pow_sum]
        simp_rw [scale]
        apply Finset.sum_congr rfl
        intro beta _
        ring
      _ = _ := by
        rw [character, finite_field_normal_function_coordinates_apply, Finset.mul_sum]
        apply Finset.sum_congr rfl
        intro beta _
        ring
  have scalar := mul_right_cancel₀ nonzero (congrFun coefficients alpha)
  have original : (u : F) ^ (∑ i, (alpha i).val) = (u : F) ^ d := by
    apply ψ.injective
    simpa only [map_pow] using scalar
  have units : u ^ (∑ i, (alpha i).val) = u ^ d := Units.ext original
  simpa only [order] using (pow_inj_mod).mp units

end Litt3.Deformations

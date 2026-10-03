import Solutions.Deformations.FiniteFieldNormalCoordinates
import Solutions.Deformations.ElementaryHomogeneousEvaluation
import Mathlib.GroupTheory.OrderOfElement

namespace Litt3.Deformations

open scoped BigOperators

variable {I k : Type*} [Fintype I] [DecidableEq I] [Field k] [Fact (Nat.Prime 5)]

theorem original_five_two_nonzero : (2 : ZMod 5) ≠ 0 := by
  intro same
  have value := congrArg ZMod.val same
  change 2 = 0 at value
  omega

/-- The single scalar two separates the four possible original
finite-field characters; no tuple enumeration is used. -/
theorem original_five_two_unit_order :
    orderOf (Units.mk0 (2 : ZMod 5) original_five_two_nonzero) = 4 := by
  let u := Units.mk0 (2 : ZMod 5) original_five_two_nonzero
  have lower : ¬ u ^ 2 ^ 1 = 1 := by
    intro same
    have value := congrArg (fun v : (ZMod 5)ˣ => (v : ZMod 5)) same
    have integerValue := congrArg ZMod.val value
    change 4 = 1 at integerValue
    omega
  have upper : u ^ 2 ^ (1 + 1) = 1 := by
    apply Units.ext
    exact (show (2 : ZMod 5) ^ 4 = 1 from rfl)
  exact orderOf_eq_prime_pow lower upper

/-- A scalar character of an actual normal function forces the exact
congruence class of every nonzero original normal coefficient. -/
theorem elementary_normal_character_support (ψ : ZMod 5 →+* k)
    (c : (I → Fin 5) → k) (d : ℕ)
    (character : ∀ (u : (ZMod 5)ˣ) (a : I → ZMod 5),
      finiteFieldNormalFunctionCoordinates (I := I) (ZMod 5) k ψ c ((u : ZMod 5) • a) =
        ψ u ^ d * finiteFieldNormalFunctionCoordinates (I := I) (ZMod 5) k ψ c a)
    (alpha : I → Fin 5) (nonzero : c alpha ≠ 0) :
    (∑ i, (alpha i).val) % 4 = d % 4 := by
  classical
  let u := Units.mk0 (2 : ZMod 5) original_five_two_nonzero
  have coefficients : (fun beta : I → Fin 5 => ψ u ^ (∑ i, (beta i).val) * c beta) =
      (fun beta : I → Fin 5 => ψ u ^ d * c beta) := by
    apply (finiteFieldNormalFunctionCoordinates (I := I) (ZMod 5) k ψ).injective
    funext a
    rw [finite_field_normal_function_coordinates_apply,
      finite_field_normal_function_coordinates_apply]
    calc
      _ = finiteFieldNormalFunctionCoordinates (I := I) (ZMod 5) k ψ c
          ((u : ZMod 5) • a) := by
        rw [finite_field_normal_function_coordinates_apply]
        simp_rw [finite_field_original_monomial_scale]
        apply Finset.sum_congr rfl
        intro beta _
        ring
      _ = _ := by
        rw [character, finite_field_normal_function_coordinates_apply, Finset.mul_sum]
        apply Finset.sum_congr rfl
        intro beta _
        ring
  have scalar := mul_right_cancel₀ nonzero (congrFun coefficients alpha)
  have original : (u : ZMod 5) ^ (∑ i, (alpha i).val) = (u : ZMod 5) ^ d := by
    apply ψ.injective
    simpa only [map_pow] using scalar
  have units : u ^ (∑ i, (alpha i).val) = u ^ d := Units.ext original
  have modular := (pow_inj_mod).mp units
  simpa only [u, original_five_two_unit_order] using modular

end Litt3.Deformations

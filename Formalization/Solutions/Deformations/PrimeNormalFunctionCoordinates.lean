import Solutions.Deformations.FiniteFieldNormalCharacter

namespace Litt3.Deformations

open scoped BigOperators

variable (p : ℕ) [Fact p.Prime]
variable (k : Type*) [Field k]
variable {I : Type*} [Fintype I] [DecidableEq I]

noncomputable def primeNormalExponentEquiv :
    (I → Fin p) ≃ (I → Fin (Fintype.card (ZMod p) - 1 + 1)) :=
  Equiv.piCongrRight (fun _ => finCongr (by
    rw [ZMod.card, Nat.sub_add_cancel (Fact.out : p.Prime).one_le]))

@[simp] theorem prime_normal_exponent_value (alpha : I → Fin p) (i : I) :
    (primeNormalExponentEquiv p alpha i).val = (alpha i).val := rfl

/-- Constructed interpolation on literal unchanged exponent arrays. -/
noncomputable def primeNormalFunctionCoordinates (ψ : ZMod p →+* k) :
    ((I → Fin p) → k) ≃ₗ[k] ((I → ZMod p) → k) :=
  (LinearEquiv.piCongrLeft k (fun _ : I → Fin (Fintype.card (ZMod p) - 1 + 1) => k)
    (primeNormalExponentEquiv p)).trans
      (finiteFieldNormalFunctionCoordinates (I := I) (ZMod p) k ψ)

theorem prime_normal_function_coordinates_apply (ψ : ZMod p →+* k)
    (c : (I → Fin p) → k) (a : I → ZMod p) :
    primeNormalFunctionCoordinates p k ψ c a =
      ∑ alpha : I → Fin p, c alpha * ∏ i, ψ (a i) ^ (alpha i).val := by
  classical
  rw [primeNormalFunctionCoordinates, LinearEquiv.trans_apply,
    finite_field_normal_function_coordinates_apply]
  rw [← Equiv.sum_comp (primeNormalExponentEquiv p)]
  apply Finset.sum_congr rfl
  intro alpha _
  simp [LinearEquiv.piCongrLeft, LinearEquiv.piCongrLeft', primeNormalExponentEquiv]

/-- Every scalar character forces the original coefficient congruence.
The primitive unit is obtained from finite-field cyclicity. -/
theorem prime_normal_character_support (ψ : ZMod p →+* k)
    (c : (I → Fin p) → k) (d : ℕ)
    (character : ∀ (u : (ZMod p)ˣ) (a : I → ZMod p),
      primeNormalFunctionCoordinates p k ψ c ((u : ZMod p) • a) =
        ψ u ^ d * primeNormalFunctionCoordinates p k ψ c a)
    (alpha : I → Fin p) (nonzero : c alpha ≠ 0) :
    (∑ i, (alpha i).val) % (p - 1) = d % (p - 1) := by
  classical
  obtain ⟨u, generator⟩ := IsCyclic.exists_generator (α := (ZMod p)ˣ)
  have order : orderOf u = p - 1 := by
    rw [orderOf_eq_card_of_forall_mem_zpowers generator, Nat.card_eq_fintype_card,
      ZMod.card_units]
  have coefficients : (fun beta : I → Fin p => ψ u ^ (∑ i, (beta i).val) * c beta) =
      (fun beta => ψ u ^ d * c beta) := by
    apply (primeNormalFunctionCoordinates p k ψ).injective
    funext a
    rw [prime_normal_function_coordinates_apply, prime_normal_function_coordinates_apply]
    calc
      _ = primeNormalFunctionCoordinates p k ψ c ((u : ZMod p) • a) := by
        rw [prime_normal_function_coordinates_apply]
        have scale (beta : I → Fin p) :
            (∏ i, ψ (((u : ZMod p) • a) i) ^ (beta i).val) =
              ψ u ^ (∑ i, (beta i).val) * ∏ i, ψ (a i) ^ (beta i).val := by
          change (∏ i, ψ ((u : ZMod p) * a i) ^ (beta i).val) = _
          simp only [map_mul, mul_pow, Finset.prod_mul_distrib,
            ← Finset.prod_pow_eq_pow_sum]
        simp_rw [scale]
        apply Finset.sum_congr rfl
        intro beta _
        ring
      _ = _ := by
        rw [character, prime_normal_function_coordinates_apply, Finset.mul_sum]
        apply Finset.sum_congr rfl
        intro beta _
        ring
  have scalar := mul_right_cancel₀ nonzero (congrFun coefficients alpha)
  have original : (u : ZMod p) ^ (∑ i, (alpha i).val) = (u : ZMod p) ^ d := by
    apply ψ.injective
    simpa only [map_pow] using scalar
  have units : u ^ (∑ i, (alpha i).val) = u ^ d := Units.ext original
  simpa only [order] using (pow_inj_mod).mp units

end Litt3.Deformations

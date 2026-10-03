import Solutions.CurveArithmetic.EmbeddedFields
import Mathlib.FieldTheory.Galois.Basic
import Mathlib.GroupTheory.OrderOfElement

namespace Litt3.SharedTensors

variable {K E : Type*} [Field K] [Field E] [Algebra K E]

/-- Every actual automorphism order divides the actual extension degree,
even when the original extension is not Galois or not separable. -/
theorem actual_automorphism_order_dvd_degree [FiniteDimensional K E]
    (sigma : E ≃ₐ[K] E) : orderOf sigma ∣ Module.finrank K E := by
  rw [← Nat.card_zpowers sigma, ← IntermediateField.finrank_fixedField_eq_card]
  simpa only [IntermediateField.finrank_bot'] using
    IntermediateField.finrank_dvd_of_le_left
      (bot_le : (⊥ : IntermediateField K E) ≤
        IntermediateField.fixedField (Subgroup.zpowers sigma))

/-- A coprime finite cyclic ambiguity is impossible on the actual field.
The condition is on the actual automorphism and actual field degree. -/
theorem actual_automorphism_eq_one_of_coprime_power [FiniteDimensional K E]
    (sigma : E ≃ₐ[K] E) (n : ℕ) (hpower : sigma ^ n = 1)
    (hcoprime : n.Coprime (Module.finrank K E)) : sigma = 1 := by
  apply orderOf_eq_one_iff.mp
  exact Nat.eq_one_of_dvd_coprimes hcoprime
    (orderOf_dvd_of_pow_eq_one hpower) (actual_automorphism_order_dvd_degree sigma)

/-- The cubic ambiguity in the original differential-ratio argument
vanishes in any actual degree-five extension, in every characteristic. -/
theorem actual_degree_five_cubic_ambiguity_trivial [FiniteDimensional K E]
    (sigma : E ≃ₐ[K] E) (hpower : sigma ^ 3 = 1)
    (hdegree : Module.finrank K E = 5) : sigma = 1 := by
  apply actual_automorphism_eq_one_of_coprime_power sigma 3 hpower
  rw [hdegree]
  decide

/-- The quadratic ambiguity vanishes whenever the actual function degree
is odd, with no Galois hypothesis on that function. -/
theorem actual_odd_degree_involution_trivial [FiniteDimensional K E]
    (sigma : E ≃ₐ[K] E) (hpower : sigma ^ 2 = 1)
    (hodd : Odd (Module.finrank K E)) : sigma = 1 := by
  apply actual_automorphism_eq_one_of_coprime_power sigma 2 hpower
  exact hodd.coprime_two_left

/-- Fixing the actual function fixes its full actual generated subfield,
including all inverses; no algebraicity over constants is presumed. -/
theorem fixes_generated_function_field
    (q : E) (sigma : E ≃ₐ[K] E) (hq : sigma q = q) :
    sigma ∈ (IntermediateField.adjoin K {q}).fixingSubgroup := by
  let F := IntermediateField.adjoin K {q}
  have hmaps : sigma.toAlgHom.comp F.val = F.val := by
    apply IntermediateField.adjoin_algHom_ext K
    intro x hx
    have hxq : x = q := Set.mem_singleton_iff.mp hx
    subst x
    exact hq
  rw [IntermediateField.mem_fixingSubgroup_iff]
  intro x hx
  exact DFunLike.congr_fun hmaps ⟨x, hx⟩

/-- The original automorphism rebased to the actual function subfield. -/
def functionFieldAutomorphism
    (q : E) (sigma : E ≃ₐ[K] E) (hq : sigma q = q) :
    E ≃ₐ[IntermediateField.adjoin K {q}] E :=
  IntermediateField.fixingSubgroupEquiv (IntermediateField.adjoin K {q})
    ⟨sigma, fixes_generated_function_field q sigma hq⟩

@[simp] theorem functionFieldAutomorphism_apply
    (q : E) (sigma : E ≃ₐ[K] E) (hq : sigma q = q) (x : E) :
    functionFieldAutomorphism q sigma hq x = sigma x := rfl

theorem function_field_automorphism_power
    (q : E) (sigma : E ≃ₐ[K] E) (hq : sigma q = q) (n : ℕ)
    (hpower : sigma ^ n = 1) : functionFieldAutomorphism q sigma hq ^ n = 1 := by
  let s : (IntermediateField.adjoin K {q}).fixingSubgroup :=
    ⟨sigma, fixes_generated_function_field q sigma hq⟩
  have hs : s ^ n = 1 := by
    apply Subtype.ext
    simpa only [Subgroup.coe_pow, Subgroup.coe_one] using hpower
  change IntermediateField.fixingSubgroupEquiv _ s ^ n = 1
  rw [← map_pow, hs, map_one]

/-- The cyclic obstruction on a rational function requires only the actual
finite function degree, not finiteness over the constant field. -/
theorem actual_fixed_function_coprime_ambiguity_trivial
    (q : E) (sigma : E ≃ₐ[K] E) (hq : sigma q = q)
    [FiniteDimensional (IntermediateField.adjoin K {q}) E]
    (n : ℕ) (hpower : sigma ^ n = 1)
    (hcoprime : n.Coprime (Module.finrank (IntermediateField.adjoin K {q}) E)) :
    sigma = 1 := by
  have h := actual_automorphism_eq_one_of_coprime_power
    (functionFieldAutomorphism q sigma hq) n
    (function_field_automorphism_power q sigma hq n hpower) hcoprime
  apply AlgEquiv.ext
  intro x
  have hx := congrArg (fun f : E ≃ₐ[IntermediateField.adjoin K {q}] E => f x) h
  exact hx

end Litt3.SharedTensors

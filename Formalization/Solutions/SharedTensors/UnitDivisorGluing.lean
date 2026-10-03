import Solutions.SharedTensors.DivisorGluing
import Solutions.SharedTensors.MultiplicativeQuotients

namespace Litt3.SharedTensors

open Litt3.Jacobians

variable {F G E X Y Z : Type*} [Field F] [Field G] [Field E]
  (φ : F →+* E) (ψ : G →+* E)
  (SX : ValuationDivisorSystem F X) (SY : ValuationDivisorSystem G Y)
  (SZ : ValuationDivisorSystem E Z) (f : Z → X) (g : Z → Y)
  (hf : ∀ s : Set X, s.Finite → (f ⁻¹' s).Finite)
  (hg : ∀ s : Set Y, s.Finite → (g ⁻¹' s).Finite)
  (left : ∀ u, principalDivisorMap SZ (rationalUnitPullback φ u) =
    divisorPullback f hf (principalDivisorMap SX u))
  (right : ∀ u, principalDivisorMap SZ (rationalUnitPullback ψ u) =
    divisorPullback g hg (principalDivisorMap SY u))

/-- All groups and maps in the divisor model are the actual endpoint
divisors and rational-function units on one common source. -/
noncomputable def unitDivisorGluingSquare :
    DivisorGluingSquare (Divisor X × Divisor Y) (Additive Eˣ)
      (Additive Fˣ × Additive Gˣ) (Divisor Z) where
  divisor := divisorRelationMap f g hf hg
  principal := principalDivisorMap SZ
  endpointPrincipal := (principalDivisorMap SX).prodMap (principalDivisorMap SY)
  endpointUnit := unitRelationMap φ ψ
  compatible := unit_relation_principal φ ψ SX SY SZ f g hf hg left right

theorem unitDivisorGluingSquare_principal_map :
    (unitDivisorGluingSquare φ ψ SX SY SZ f g hf hg left right).principalClassMap =
      quotientPrincipalDivisorMap φ ψ SX SY SZ f g hf hg left right := rfl

/-- Surjectivity onto the actual saturated relation kernel is proved
without any intersection-field or connected-component assumption. -/
theorem actual_divisor_gluing_range :
    (unitDivisorGluingSquare φ ψ SX SY SZ f g hf hg left right).gluingUnitClass.range =
      (quotientPrincipalDivisorMap φ ψ SX SY SZ f g hf hg left right).ker :=
  DivisorGluingSquare.gluingUnitClass_range _

theorem actual_divisor_gluing_kernel :
    (unitDivisorGluingSquare φ ψ SX SY SZ f g hf hg left right).gluingUnitClass.ker =
      (unitDivisorGluingSquare φ ψ SX SY SZ f g hf hg left right).invariantDivisorClass.range :=
  DivisorGluingSquare.gluingUnitClass_kernel _

theorem actual_invariant_divisor_injection
    (h : ∀ u : Additive Fˣ × Additive Gˣ, unitRelationMap φ ψ u = 0 →
      principalDivisorMap SX u.1 = 0 ∧ principalDivisorMap SY u.2 = 0) :
    Function.Injective
      (unitDivisorGluingSquare φ ψ SX SY SZ f g hf hg left right).invariantDivisorClass := by
  apply DivisorGluingSquare.invariantDivisorClass_injective
  intro u hu
  obtain ⟨hX, hY⟩ := h u hu
  exact Prod.ext hX hY

end Litt3.SharedTensors

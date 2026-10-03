import Definitions.SharedTensors.MultiplicativeQuotients
import Solutions.SharedTensors.DivisorRelations
import Solutions.SharedTensors.SaturatedKernels

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

include left right

theorem unit_relation_principal (u : Additive Fˣ × Additive Gˣ) :
    principalDivisorMap SZ (unitRelationMap φ ψ u) =
      divisorRelationMap f g hf hg (principalDivisorMap SX u.1, principalDivisorMap SY u.2) := by
  change principalDivisorMap SZ (rationalUnitPullback φ u.1 - rationalUnitPullback ψ u.2) = _
  rw [map_sub, left, right]
  rfl

/-- The actual principal divisor descends through the original unit
quotient to the integral two-leg divisor quotient. -/
noncomputable def quotientPrincipalDivisorMap :
    UnitRelationQuotient φ ψ →+ DivisorRelationQuotient f g hf hg :=
  QuotientAddGroup.lift (unitRelationMap φ ψ).range
    ((QuotientAddGroup.mk' (divisorRelationMap f g hf hg).range).comp (principalDivisorMap SZ))
    (by
      rintro _ ⟨u, rfl⟩
      change QuotientAddGroup.mk' (divisorRelationMap f g hf hg).range
        (principalDivisorMap SZ (unitRelationMap φ ψ u)) = 0
      rw [unit_relation_principal φ ψ SX SY SZ f g hf hg left right]
      exact (QuotientAddGroup.eq_zero_iff _).mpr ⟨_, rfl⟩)

theorem quotientPrincipalDivisorMap_apply_mk (u : Additive Eˣ) :
    quotientPrincipalDivisorMap φ ψ SX SY SZ f g hf hg left right
      (QuotientAddGroup.mk' (unitRelationMap φ ψ).range u) =
      QuotientAddGroup.mk' (divisorRelationMap f g hf hg).range (principalDivisorMap SZ u) := rfl

/-- Saturation holds in the actual multiplicative quotient, with
no finite generation, intersection-field, or clump hypothesis. -/
theorem actual_unit_quotient_principal_kernel_saturated :
    KernelRootsSaturated (quotientPrincipalDivisorMap φ ψ SX SY SZ f g hf hg left right) := by
  letI := divisor_relation_quotient_torsionFree f g hf hg
  exact kernel_integral_roots_saturated _

end Litt3.SharedTensors

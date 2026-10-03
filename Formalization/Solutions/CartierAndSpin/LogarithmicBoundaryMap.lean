import Definitions.CartierAndSpin.PowerRelationLifts
import Solutions.CartierAndSpin.LogarithmicBoundaryLifts

namespace Litt3.CartierAndSpin

variable {A B C X : Type*} [AddCommGroup A] [AddCommGroup B]
  [AddCommGroup C] [AddCommGroup X]
variable (φ : B →+ A) (ψ : C →+ A) (p : ℕ) (ℓ : A →+ X)

/-- Choice only selects concrete witnesses whose existence follows
from the actual quotient. The resulting boundary is independent of it. -/
noncomputable def chosenPowerRelationLift
    (q : powerTorsionSubgroup (TwoLegRelationQuotient φ ψ) p) :
    PowerRelationLift φ ψ p q :=
  Classical.choice (show Nonempty (PowerRelationLift φ ψ p q) from by
    obtain ⟨a, b, c, hq, hr⟩ := power_torsion_relation_lift_exists φ ψ p q
    exact ⟨⟨a, b, c, hq, hr⟩⟩)

/-- The genuine two-leg torsion boundary. Its value is the common
logarithmic image of the two actual endpoint factors of a power relation.
The choice-independence theorem proves that it is an additive map. -/
noncomputable def logarithmicBoundaryHom
    (hkerA : ∀ a : A, ℓ a = 0 ↔ ∃ r : A, p • r = a)
    (hintersection : ∀ b : B, ∀ c : C, φ b = ψ c → ℓ (φ b) = 0) :
    powerTorsionSubgroup (TwoLegRelationQuotient φ ψ) p →+
      sharedLogarithmicImage ℓ φ ψ where
  toFun q :=
    let L := chosenPowerRelationLift φ ψ p q
    ⟨ℓ (φ L.left), ⟨⟨L.left, rfl⟩,
      ⟨L.right, (power_relation_logarithms_eq φ ψ p ℓ hkerA L.relation).symm⟩⟩⟩
  map_zero' := by
    apply Subtype.ext
    let L := chosenPowerRelationLift φ ψ p 0
    change ℓ (φ L.left) = 0
    have hzero : p • (0 : A) = φ 0 - ψ 0 := by simp
    have hclass : QuotientAddGroup.mk' (twoLegRelationHom φ ψ).range L.representative =
        QuotientAddGroup.mk' (twoLegRelationHom φ ψ).range 0 := by
      rw [L.quotient_eq, map_zero]
      rfl
    simpa only [map_zero] using
      power_relation_logarithm_well_defined φ ψ p ℓ hkerA hintersection
        L.relation hzero hclass
  map_add' q r := by
    apply Subtype.ext
    let Lq := chosenPowerRelationLift φ ψ p q
    let Lr := chosenPowerRelationLift φ ψ p r
    let Lqr := chosenPowerRelationLift φ ψ p (q + r)
    change ℓ (φ Lqr.left) = ℓ (φ Lq.left) + ℓ (φ Lr.left)
    have hrel : p • (Lq.representative + Lr.representative) =
        φ (Lq.left + Lr.left) - ψ (Lq.right + Lr.right) := by
      rw [nsmul_add, Lq.relation, Lr.relation, map_add, map_add]
      abel
    have hclass : QuotientAddGroup.mk' (twoLegRelationHom φ ψ).range Lqr.representative =
        QuotientAddGroup.mk' (twoLegRelationHom φ ψ).range
          (Lq.representative + Lr.representative) := by
      rw [Lqr.quotient_eq, map_add, Lq.quotient_eq, Lr.quotient_eq]
      rfl
    have h := power_relation_logarithm_well_defined φ ψ p ℓ hkerA hintersection
      Lqr.relation hrel hclass
    simpa only [map_add] using h

/-- Every concrete representative computes the canonical boundary. -/
theorem logarithmicBoundaryHom_compute
    (hkerA : ∀ a : A, ℓ a = 0 ↔ ∃ r : A, p • r = a)
    (hintersection : ∀ b : B, ∀ c : C, φ b = ψ c → ℓ (φ b) = 0)
    (q : powerTorsionSubgroup (TwoLegRelationQuotient φ ψ) p)
    {a : A} {b : B} {c : C}
    (hq : QuotientAddGroup.mk' (twoLegRelationHom φ ψ).range a = q.val)
    (hrel : p • a = φ b - ψ c) :
    (logarithmicBoundaryHom φ ψ p ℓ hkerA hintersection q).val = ℓ (φ b) := by
  let L := chosenPowerRelationLift φ ψ p q
  exact power_relation_logarithm_well_defined φ ψ p ℓ hkerA hintersection
    L.relation hrel (L.quotient_eq.trans hq.symm)

end Litt3.CartierAndSpin

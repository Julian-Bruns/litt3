import Definitions.CartierAndSpin.LogarithmicQuotientBoundary
import Mathlib.Algebra.Module.Basic
import Mathlib.Tactic.Abel

namespace Litt3.CartierAndSpin

variable {A B C X : Type*} [AddCommGroup A] [AddCommGroup B]
  [AddCommGroup C] [AddCommGroup X]
variable (φ : B →+ A) (ψ : C →+ A) (p : ℕ)

/-- Every actual torsion class has an actual representative and actual
two-leg power relation. This is proved from the quotient definition. -/
theorem power_torsion_relation_lift_exists
    (q : powerTorsionSubgroup (TwoLegRelationQuotient φ ψ) p) :
    ∃ a : A, ∃ b : B, ∃ c : C,
      QuotientAddGroup.mk' (twoLegRelationHom φ ψ).range a = q.val ∧
        p • a = φ b - ψ c := by
  obtain ⟨a, ha⟩ := QuotientAddGroup.mk'_surjective (twoLegRelationHom φ ψ).range q.val
  have hzero : QuotientAddGroup.mk' (twoLegRelationHom φ ψ).range (p • a) = 0 := by
    rw [map_nsmul, ha]
    exact q.property
  obtain ⟨bc, hbc⟩ := (QuotientAddGroup.eq_zero_iff _).mp hzero
  refine ⟨a, bc.1, bc.2, ha, ?_⟩
  exact hbc.symm

variable (ℓ : A →+ X)
variable (hkerA : ∀ a : A, ℓ a = 0 ↔ ∃ r : A, p • r = a)
variable (hintersection : ∀ b : B, ∀ c : C, φ b = ψ c → ℓ (φ b) = 0)

include hkerA

/-- A logarithmic homomorphism with exact power kernel kills every
literal p-multiple; no characteristic assumption on a proxy is needed. -/
theorem logarithmic_power_multiple_zero (a : A) : ℓ (p • a) = 0 :=
  (hkerA _).mpr ⟨a, rfl⟩

/-- The two endpoint logarithmic images of an actual power relation
coincide, as actual elements of the common ambient group. -/
theorem power_relation_logarithms_eq {a : A} {b : B} {c : C}
    (hrel : p • a = φ b - ψ c) : ℓ (φ b) = ℓ (ψ c) := by
  have hzero := logarithmic_power_multiple_zero p ℓ hkerA a
  rw [hrel, map_sub] at hzero
  exact sub_eq_zero.mp hzero

include hintersection

/-- The shared logarithmic value is independent of all choices of
representative and endpoint power factors. The literal intersection
condition is the only additional input. -/
theorem power_relation_logarithm_well_defined
    {a a' : A} {b b' : B} {c c' : C}
    (hrel : p • a = φ b - ψ c) (hrel' : p • a' = φ b' - ψ c')
    (hclass : QuotientAddGroup.mk' (twoLegRelationHom φ ψ).range a =
      QuotientAddGroup.mk' (twoLegRelationHom φ ψ).range a') :
    ℓ (φ b) = ℓ (φ b') := by
  have hmem : a - a' ∈ (twoLegRelationHom φ ψ).range :=
    QuotientAddGroup.eq_iff_sub_mem.mp hclass
  obtain ⟨⟨d, e⟩, hde⟩ := hmem
  change φ d - ψ e = a - a' at hde
  have hpp : (φ b - ψ c) - (φ b' - ψ c') = p • φ d - p • ψ e := by
    rw [← hrel, ← hrel', ← nsmul_sub, ← hde, nsmul_sub]
  have hcommon : φ (b - b' - p • d) = ψ (c - c' - p • e) := by
    simp only [map_sub, map_nsmul]
    calc
      φ b - φ b' - p • φ d =
          ((φ b - ψ c) - (φ b' - ψ c') - (p • φ d - p • ψ e)) +
            (ψ c - ψ c' - p • ψ e) := by abel
      _ = ψ c - ψ c' - p • ψ e := by rw [hpp, sub_self, zero_add]
  have hzero := hintersection _ _ hcommon
  simp only [map_sub, map_nsmul] at hzero
  have hmultiple : p • ℓ (φ d) = 0 := by
    rw [← map_nsmul]
    exact logarithmic_power_multiple_zero p ℓ hkerA (φ d)
  rw [hmultiple, sub_zero] at hzero
  exact sub_eq_zero.mp hzero

end Litt3.CartierAndSpin

import Solutions.CartierAndSpin.LogarithmicBoundaryMap

namespace Litt3.CartierAndSpin

variable {A B C X : Type*} [AddCommGroup A] [AddCommGroup B]
  [AddCommGroup C] [AddCommGroup X]
variable (φ : B →+ A) (ψ : C →+ A) (p : ℕ) (ℓ : A →+ X)
variable (hkerA : ∀ a : A, ℓ a = 0 ↔ ∃ r : A, p • r = a)
variable (hintersection : ∀ b : B, ∀ c : C, φ b = ψ c → ℓ (φ b) = 0)

/-- Exactness of the ambient logarithmic kernel constructs a quotient
torsion class for every shared actual endpoint logarithmic image. -/
theorem logarithmicBoundaryHom_surjective :
    Function.Surjective (logarithmicBoundaryHom φ ψ p ℓ hkerA hintersection) := by
  intro omega
  obtain ⟨b, hb⟩ := omega.property.1
  obtain ⟨c, hc⟩ := omega.property.2
  change ℓ (φ b) = omega.val at hb
  change ℓ (ψ c) = omega.val at hc
  have hzero : ℓ (φ b - ψ c) = 0 := by rw [map_sub, hb, hc, sub_self]
  obtain ⟨a, ha⟩ := (hkerA _).mp hzero
  have hqt : p • QuotientAddGroup.mk' (twoLegRelationHom φ ψ).range a = 0 := by
    rw [← map_nsmul, ha]
    exact (QuotientAddGroup.eq_zero_iff _).mpr ⟨(b, c), rfl⟩
  let q : powerTorsionSubgroup (TwoLegRelationQuotient φ ψ) p :=
    ⟨QuotientAddGroup.mk' (twoLegRelationHom φ ψ).range a, hqt⟩
  refine ⟨q, ?_⟩
  apply Subtype.ext
  exact (logarithmicBoundaryHom_compute φ ψ p ℓ hkerA hintersection q rfl ha).trans hb

variable (hkerB : ∀ b : B, ℓ (φ b) = 0 ↔ ∃ r : B, p • r = b)
variable (hkerC : ∀ c : C, ℓ (ψ c) = 0 ↔ ∃ r : C, p • r = c)
variable (hpinj : Function.Injective (fun a : A => p • a))

include hkerB hkerC hpinj in
/-- Endpoint kernel exactness and ambient power injectivity make the
actual two-leg boundary injective. This uses actual endpoint roots. -/
theorem logarithmicBoundaryHom_zero_implies_zero
    (q : powerTorsionSubgroup (TwoLegRelationQuotient φ ψ) p)
    (hq : logarithmicBoundaryHom φ ψ p ℓ hkerA hintersection q = 0) : q = 0 := by
  let L := chosenPowerRelationLift φ ψ p q
  have hleft : ℓ (φ L.left) = 0 := congrArg Subtype.val hq
  obtain ⟨b, hb⟩ := (hkerB L.left).mp hleft
  have hright : ℓ (ψ L.right) = 0 := by
    rw [← power_relation_logarithms_eq φ ψ p ℓ hkerA L.relation]
    exact hleft
  obtain ⟨c, hc⟩ := (hkerC L.right).mp hright
  have hrep : L.representative = φ b - ψ c := by
    apply hpinj
    calc
      p • L.representative = φ L.left - ψ L.right := L.relation
      _ = φ (p • b) - ψ (p • c) := by rw [hb, hc]
      _ = p • (φ b - ψ c) := by rw [nsmul_sub, map_nsmul, map_nsmul]
  apply Subtype.ext
  change q.val = 0
  rw [← L.quotient_eq, hrep]
  exact (QuotientAddGroup.eq_zero_iff _).mpr ⟨(b, c), rfl⟩

include hkerB hkerC hpinj in
theorem logarithmicBoundaryHom_injective :
    Function.Injective (logarithmicBoundaryHom φ ψ p ℓ hkerA hintersection) := by
  intro q r hqr
  apply sub_eq_zero.mp
  apply logarithmicBoundaryHom_zero_implies_zero φ ψ p ℓ hkerA hintersection
    hkerB hkerC hpinj
  rw [map_sub, hqr, sub_self]

/-- The canonical power-torsion/shared-logarithmic-image isomorphism
over arbitrary abelian groups, derived from literal kernel exactness,
power injectivity and the common-unit logarithmic condition. All these
conditions are independently derived for actual function fields. -/
noncomputable def logarithmicBoundaryEquiv :
    powerTorsionSubgroup (TwoLegRelationQuotient φ ψ) p ≃+
      sharedLogarithmicImage ℓ φ ψ :=
  AddEquiv.ofBijective (logarithmicBoundaryHom φ ψ p ℓ hkerA hintersection)
    ⟨logarithmicBoundaryHom_injective φ ψ p ℓ hkerA hintersection hkerB hkerC hpinj,
      logarithmicBoundaryHom_surjective φ ψ p ℓ hkerA hintersection⟩

end Litt3.CartierAndSpin

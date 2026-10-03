import Theorems.Deformations.ActualPGroupInvariants
import Solutions.Deformations.PGroupInvariants

namespace Litt3.Deformations

variable {p : ℕ} [Fact p.Prime] {k G V : Type*} [CommRing k] [CharP k p]
    [Group G] [Finite G] [AddCommGroup V] [Module k V]

/-- Nonzero invariants exist for every actual finite p-group
representation over any commutative characteristic-p ring,
without finite dimension or finiteness of the coefficient ring. -/
theorem nonzero_characteristic_p_group_invariants (group : IsPGroup p G)
    (ρ : Representation k G V) : Specifications.NonzeroCharacteristicPGroupInvariants ρ := by
  letI : Module (ZMod p) V := AddCommGroup.zmodModule (n := p) (fun x => by
    rw [← Nat.cast_smul_eq_nsmul k, CharP.cast_eq_zero k p, zero_smul])
  let action : G → Module.End (ZMod p) V := fun g =>
    AddMonoidHom.toZModLinearMap p (ρ g).toAddMonoidHom
  let endMulOne : MulOne (Module.End (ZMod p) V) :=
    { one := LinearMap.id, mul := fun f g => LinearMap.comp f g }
  let sourceMulOne : MulOne G := inferInstance
  let ρp : @MonoidHom G (Module.End (ZMod p) V) sourceMulOne endMulOne :=
    @MonoidHom.mk G (Module.End (ZMod p) V) sourceMulOne endMulOne
      (@OneHom.mk G (Module.End (ZMod p) V) sourceMulOne.toOne endMulOne.toOne action
        (by
          apply LinearMap.ext
          intro x
          change ρ 1 x = x
          simp))
      (by
        intro g h
        apply LinearMap.ext
        intro x
        change ρ (g * h) x = ρ g (ρ h x)
        simp [Module.End.mul_apply])
  intro nonzero
  obtain ⟨w, hw, hfix⟩ := nonzero_p_group_invariants group ρp nonzero
  exact ⟨w, hw, hfix⟩

end Litt3.Deformations

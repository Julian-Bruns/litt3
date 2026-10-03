import Solutions.SharedTensors.SemilinearLineCartier
import Mathlib.Algebra.Module.Submodule.Range

namespace Litt3.SharedTensors

open Module

variable {k A B W : Type*} [Field k] [IsAlgClosed k]
  [AddCommGroup A] [Module k A] [AddCommGroup B] [Module k B]
  [AddCommGroup W] [Module k W]

/-- A Cartier-fixed difference of actual endpoint images admits
Cartier-fixed endpoint representatives whenever their LITERAL shared
image has dimension at most one. The common correction is constructed
inside that intersection; no endpoint fixedness or scalar solvability
conclusion is supplied as input. The inverse exponent may be any n>1. -/
theorem actual_shared_rank_le_one_fixed_difference_correction
    (mA : A →ₗ[k] W) (mB : B →ₗ[k] W)
    (hmA : Function.Injective mA) (hmB : Function.Injective mB)
    (CA : A →+ A) (CB : B →+ B) (CW : W →+ W)
    (hA : ∀ a, CW (mA a) = mA (CA a))
    (hB : ∀ b, CW (mB b) = mB (CB b))
    {n : ℕ} (hn : 1 < n)
    (hC : ∀ (c : k) (w : W), CW (c ^ n • w) = c • CW w)
    [Module.Finite k ↥(LinearMap.range mA ⊓ LinearMap.range mB)]
    (hdim : Module.finrank k ↥(LinearMap.range mA ⊓ LinearMap.range mB) ≤ 1)
    (a : A) (b : B) (hfixed : CW (mB b - mA a) = mB b - mA a) :
    ∃ a' : A, ∃ b' : B,
      CA a' = a' ∧ CB b' = b' ∧ mB b' - mA a' = mB b - mA a := by
  classical
  let S := LinearMap.range mA ⊓ LinearMap.range mB
  have hstable : ∀ w : S, CW w.val ∈ S := by
    intro w
    obtain ⟨a, ha⟩ := w.property.1
    obtain ⟨b, hb⟩ := w.property.2
    constructor
    · exact ⟨CA a, by rw [← hA, ha]⟩
    · exact ⟨CB b, by rw [← hB, hb]⟩
  let CS : S →+ S :=
    { toFun := fun w => ⟨CW w.val, hstable w⟩
      map_zero' := by apply Subtype.ext; exact CW.map_zero
      map_add' := by intro w z; apply Subtype.ext; exact CW.map_add _ _ }
  have hCS : ∀ (c : k) (w : S), CS (c ^ n • w) = c • CS w := by
    intro c w
    apply Subtype.ext
    exact hC c w.val
  have hdifference : CW (mA a) - mA a = CW (mB b) - mB b := by
    have h := hfixed
    rw [map_sub] at h
    apply sub_eq_sub_iff_add_eq_add.mpr
    have h' := sub_eq_sub_iff_add_eq_add.mp h
    simpa only [add_comm] using h'.symm
  have hdelta : CW (mA a) - mA a ∈ S := by
    constructor
    · exact ⟨CA a - a, by rw [map_sub, ← hA]⟩
    · exact ⟨CB b - b, by rw [map_sub, ← hB, ← hdifference]⟩
  let delta : S := ⟨CW (mA a) - mA a, hdelta⟩
  obtain ⟨gamma, hgamma⟩ :=
    actual_rank_le_one_inverse_power_semilinear_sub_id_surjective
      hn hdim CS hCS (-delta)
  have hgam : CW gamma.val - gamma.val = -(CW (mA a) - mA a) :=
    congrArg Subtype.val hgamma
  obtain ⟨ga, hga⟩ := gamma.property.1
  obtain ⟨gb, hgb⟩ := gamma.property.2
  refine ⟨a + ga, b + gb, hmA ?_, hmB ?_, ?_⟩
  · rw [← hA, map_add, map_add, hga]
    have h : CW gamma.val - gamma.val = mA a - CW (mA a) := by
      simpa only [neg_sub] using hgam
    simpa only [add_comm] using sub_eq_sub_iff_add_eq_add.mp h
  · rw [← hB, map_add, map_add, hgb]
    rw [hdifference] at hgam
    have h : CW gamma.val - gamma.val = mB b - CW (mB b) := by
      simpa only [neg_sub] using hgam
    simpa only [add_comm] using sub_eq_sub_iff_add_eq_add.mp h
  · rw [map_add, map_add, hga, hgb]
    abel

end Litt3.SharedTensors

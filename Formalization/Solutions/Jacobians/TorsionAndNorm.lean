import Theorems.Jacobians.TorsionAndNorm
import Mathlib.Tactic

namespace Litt3.Jacobians

/-- Killing a quotient point lifts to killing its preimage by the product
of the quotient exponent and the kernel exponent, even inseparably. -/
theorem torsion_lifts_across_exponent_kernel
    {A B : Type*} [AddCommGroup A] [AddCommGroup B]
    (q : A →+ B) (kernelExponent quotientOrder : ℕ)
    (hkernel : ∀ a, q a = 0 → kernelExponent • a = 0)
    (a : A) (hquotient : quotientOrder • q a = 0) :
    (kernelExponent * quotientOrder) • a = 0 := by
  have hzero : q (quotientOrder • a) = 0 := by
    simpa only [map_nsmul] using hquotient
  rw [Nat.mul_comm, mul_nsmul]
  exact hkernel (quotientOrder • a) hzero

/-- The group-homomorphism algebra in Rosati image containment. The two
norm--pullback identities imply saturation; factorization of actual curve
maps additionally needs the joint-image theorem. -/
theorem image_containment_implies_norm_saturation
    {V U W : Type*} [AddCommGroup V] [AddCommGroup U] [AddCommGroup W]
    (f : V →+ W) (g : U →+ W) (normF : W →+ V) (normG : W →+ U)
    (a b : ℕ) (hnormF : ∀ v, normF (f v) = a • v)
    (hnormG : ∀ u, normG (g u) = b • u)
    (hcontainment : ∀ v, ∃ u, g u = f v) (v : V) :
    normF (g (normG (f v))) = (a * b) • v := by
  obtain ⟨u, hu⟩ := hcontainment v
  calc
    normF (g (normG (f v))) = normF (g (normG (g u))) := by rw [hu]
    _ = normF (g (b • u)) := by rw [hnormG]
    _ = b • normF (g u) := by simp only [map_nsmul]
    _ = b • normF (f v) := by rw [hu]
    _ = b • (a • v) := by rw [hnormF]
    _ = (a * b) • v := by rw [← mul_nsmul, Nat.mul_comm]

theorem two_torsion_member_eq_zero
    {A : Type*} [AddCommGroup A] {W : Set A}
    (hseparated : TwoTorsionSeparated W) (hzero : 0 ∈ W)
    (a : A) (ha : a ∈ W) (htorsion : 2 • a = 0) : a = 0 := by
  apply hseparated 0 hzero a ha
  simpa only [sub_zero] using htorsion

/-- A conjugate differing by two-torsion must be the original point. -/
theorem preserved_two_torsion_difference_vanishes
    {A : Type*} [AddCommGroup A] {W : Set A} (M : A →+ A)
    (hseparated : TwoTorsionSeparated W) (hpreserves : PreservesSubset M W)
    (a : A) (ha : a ∈ W) (hdifference : 2 • (M a - a) = 0) : M a = a :=
  hseparated a ha (M a) (hpreserves a ha) hdifference

theorem four_torsion_separation
    {A : Type*} [AddCommGroup A] (W : Set A) (M U : A →+ A)
    (hseparated : TwoTorsionSeparated W) (hpreserves : PreservesSubset M W)
    (hzero : 0 ∈ W) (hinjective : Function.Injective U)
    (hformula : ∀ a, M a - a = 2 • U a)
    (a : A) (ha : a ∈ W) (htorsion : 4 • a = 0) : a = 0 := by
  have hfourU : 4 • U a = 0 := by
    simpa only [map_nsmul, map_zero] using congrArg U htorsion
  have hdifference : 2 • (M a - a) = 0 := by
    rw [hformula, ← mul_nsmul]
    norm_num
    exact hfourU
  have hfixed := preserved_two_torsion_difference_vanishes M
    hseparated hpreserves a ha hdifference
  have htwoU : 2 • U a = 0 := by rw [← hformula, hfixed, sub_self]
  have htwo : 2 • a = 0 := by
    apply hinjective
    simpa only [map_nsmul, map_zero] using htwoU
  exact two_torsion_member_eq_zero hseparated hzero a ha htwo

theorem four_torsion_separation_target : Targets.FourTorsionSeparation := by
  intro A inst W M U hsep hpres hzero hinj hform a ha htor
  exact four_torsion_separation W M U hsep hpres hzero hinj hform a ha htor

end Litt3.Jacobians

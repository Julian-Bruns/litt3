import Solutions.Jacobians.FractionalIdealPrincipalPicard
import Mathlib.RingTheory.DedekindDomain.Ideal.Basic

open scoped nonZeroDivisors TensorProduct

namespace Litt3.Jacobians

variable (R K : Type*) [CommRing R] [IsDomain R] [Field K]
  [Algebra R K] [IsFractionRing R K]
variable (M : Type*) [AddCommGroup M] [Module R M] [Module.Invertible R M]

/-- The literal image of an invertible module inside a true fraction field
is a fractional ideal: its denominators are derived from finite generation. -/
noncomputable def invertibleModuleFractionalIdeal : FractionalIdeal R⁰ K :=
  ⟨Module.Invertible.toSubmodule R M K,
    FractionalIdeal.isFractional_of_fg (S := R⁰)
      (Module.Finite.iff_fg.mp (Module.Finite.range (Module.Invertible.embAlgebra R M K)))⟩

noncomputable def invertibleModuleFractionalIdealEquiv :
    M ≃ₗ[R] (invertibleModuleFractionalIdeal R K M : Submodule R K) :=
  LinearEquiv.ofInjective (Module.Invertible.embAlgebra R M K)
    (Module.Invertible.embAlgebra_injective R M K)

theorem invertibleModuleFractionalIdeal_ne_zero :
    invertibleModuleFractionalIdeal R K M ≠ 0 := by
  intro h
  have hz (m : M) : Module.Invertible.embAlgebra R M K m = 0 := by
    have hm : Module.Invertible.embAlgebra R M K m ∈
        invertibleModuleFractionalIdeal R K M := ⟨m, rfl⟩
    rw [h] at hm
    simpa using hm
  have hM : Subsingleton M := ⟨fun a b =>
    Module.Invertible.embAlgebra_injective R M K ((hz a).trans (hz b).symm)⟩
  letI := hM
  have hsmul : (0 : R) = 1 := smul_left_injective' (α := M)
    (funext fun m => Subsingleton.elim (0 • m) (1 • m))
  exact zero_ne_one hsmul

/-- Over an actual Dedekind domain, the image has a genuine fractional-ideal inverse. -/
noncomputable def invertibleModuleFractionalIdealUnit [IsDedekindDomain R] :
    (FractionalIdeal R⁰ K)ˣ :=
  Units.mk0 (invertibleModuleFractionalIdeal R K M)
    (invertibleModuleFractionalIdeal_ne_zero R K M)

theorem invertibleModuleFractionalIdealUnit_picard [IsDedekindDomain R] :
    fractionalIdealPicardClass (invertibleModuleFractionalIdealUnit R K M) =
      CommRing.Pic.mk R M := by
  letI := actual_invertible_fractional_ideal_module
    (invertibleModuleFractionalIdealUnit R K M)
  apply CommRing.Pic.mk_eq_mk_iff.mpr
  exact ⟨(invertibleModuleFractionalIdealEquiv R K M).symm⟩

end Litt3.Jacobians

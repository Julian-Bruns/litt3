import Solutions.Jacobians.FractionalIdealProductModules
import Mathlib.RingTheory.ClassGroup

open scoped nonZeroDivisors TensorProduct

namespace Litt3.Jacobians

variable {R K : Type*} [CommRing R] [IsDomain R] [Field K]
  [Algebra R K] [IsFractionRing R K]

/-- The genuine ring Picard class of the ACTUAL invertible fractional
ideal module. This is affine ring Picard, without a Scheme Picard assertion. -/
noncomputable def fractionalIdealPicardClass (I : (FractionalIdeal R⁰ K)ˣ) : CommRing.Pic R :=
  letI := actual_invertible_fractional_ideal_module I
  CommRing.Pic.mk R (I.val : Submodule R K)

theorem fractionalIdealPicardClass_one :
    fractionalIdealPicardClass (1 : (FractionalIdeal R⁰ K)ˣ) = 1 := by
  letI := actual_invertible_fractional_ideal_module (1 : (FractionalIdeal R⁰ K)ˣ)
  apply CommRing.Pic.mk_eq_one_iff.mpr
  exact ⟨fractionalIdealOneModuleEquiv.symm⟩

theorem fractionalIdealPicardClass_mul (I J : (FractionalIdeal R⁰ K)ˣ) :
    fractionalIdealPicardClass (I * J) = fractionalIdealPicardClass I * fractionalIdealPicardClass J := by
  letI := actual_invertible_fractional_ideal_module I
  letI := actual_invertible_fractional_ideal_module J
  letI := actual_invertible_fractional_ideal_module (I * J)
  change CommRing.Pic.mk R ((I * J).val : Submodule R K) =
    CommRing.Pic.mk R (I.val : Submodule R K) * CommRing.Pic.mk R (J.val : Submodule R K)
  rw [← CommRing.Pic.mk_tensor]
  apply CommRing.Pic.mk_eq_mk_iff.mpr
  exact ⟨(fractionalIdealTensorMultiplyEquiv I J).symm⟩

/-- Literal ideal multiplication maps to literal tensor multiplication
in Mathlib's genuine ring Picard group. -/
noncomputable def fractionalIdealPicardHom : (FractionalIdeal R⁰ K)ˣ →* CommRing.Pic R where
  toFun := fractionalIdealPicardClass
  map_one' := fractionalIdealPicardClass_one
  map_mul' := fractionalIdealPicardClass_mul

end Litt3.Jacobians

import Solutions.Jacobians.FractionalIdealTensorEquivalence

open scoped nonZeroDivisors TensorProduct

namespace Litt3.Jacobians

variable {R K : Type*} [CommRing R] [IsDomain R] [Field K]
  [Algebra R K] [IsFractionRing R K]

/-- Genuine multiplication lands in the ACTUAL product ideal module. -/
noncomputable def fractionalIdealTensorMultiplyMap
    (I J : (FractionalIdeal R⁰ K)ˣ) :
    (I.val : Submodule R K) ⊗[R] (J.val : Submodule R K) →ₗ[R]
      ((I * J).val : Submodule R K) :=
  (fractionalIdealTensorProductMap I.val J.val).codRestrict _
    (fractionalIdealTensorProductMap_mem I.val J.val)

theorem fractionalIdealTensorMultiplyMap_surjective
    (I J : (FractionalIdeal R⁰ K)ˣ) :
    Function.Surjective (fractionalIdealTensorMultiplyMap I J) := by
  intro x
  obtain ⟨u, hu⟩ := fractionalIdealTensorProductMap_exists_of_mem I.val J.val x.property
  exact ⟨u, Subtype.ext hu⟩

/-- Multiplication gives the actual tensor equivalence for ANY two
invertible fractional ideals. Both modules and their product are genuine
Mathlib invertible modules; surjectivity follows from actual ideal multiplication. -/
noncomputable def fractionalIdealTensorMultiplyEquiv
    (I J : (FractionalIdeal R⁰ K)ˣ) :
    (I.val : Submodule R K) ⊗[R] (J.val : Submodule R K) ≃ₗ[R]
      ((I * J).val : Submodule R K) := by
  letI := actual_invertible_fractional_ideal_module I
  letI := actual_invertible_fractional_ideal_module J
  letI := actual_invertible_fractional_ideal_module (I * J)
  exact LinearEquiv.ofBijective (fractionalIdealTensorMultiplyMap I J)
    (Module.Invertible.bijective_of_surjective (fractionalIdealTensorMultiplyMap_surjective I J))

@[simp] theorem fractionalIdealTensorMultiplyEquiv_tmul
    (I J : (FractionalIdeal R⁰ K)ˣ)
    (x : (I.val : Submodule R K)) (y : (J.val : Submodule R K)) :
    (fractionalIdealTensorMultiplyEquiv I J (x ⊗ₜ[R] y) : K) = (x : K) * (y : K) := by
  exact fractionalIdealTensorProductMap_tmul I.val J.val x y

noncomputable def fractionalIdealOneModuleMap :
    R →ₗ[R] ((1 : FractionalIdeal R⁰ K) : Submodule R K) :=
  (Algebra.linearMap R K).codRestrict _ (FractionalIdeal.coe_mem_one R⁰)

theorem fractionalIdealOneModuleMap_bijective :
    Function.Bijective (fractionalIdealOneModuleMap (R := R) (K := K)) := by
  constructor
  · intro a b h
    apply IsFractionRing.injective R K
    exact congrArg Subtype.val h
  · intro x
    obtain ⟨r, hr⟩ := (FractionalIdeal.mem_one_iff R⁰).mp x.property
    exact ⟨r, Subtype.ext hr⟩

noncomputable def fractionalIdealOneModuleEquiv :
    R ≃ₗ[R] ((1 : FractionalIdeal R⁰ K) : Submodule R K) :=
  LinearEquiv.ofBijective fractionalIdealOneModuleMap fractionalIdealOneModuleMap_bijective

end Litt3.Jacobians

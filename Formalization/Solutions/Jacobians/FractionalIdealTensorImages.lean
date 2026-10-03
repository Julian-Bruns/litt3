import Definitions.Jacobians.FractionalIdealTensors

open scoped nonZeroDivisors TensorProduct

namespace Litt3.Jacobians

variable {R K : Type*} [CommRing R] [Field K] [Algebra R K]

@[simp] theorem fractionalIdealTensorProductMap_tmul
    (I J : FractionalIdeal R⁰ K) (x : (I : Submodule R K)) (y : (J : Submodule R K)) :
    fractionalIdealTensorProductMap I J (x ⊗ₜ[R] y) = (x : K) * (y : K) := by
  simp [fractionalIdealTensorProductMap, LinearMap.mul']

/-- The image is the genuine fractional-ideal product, not an abstract
paired-module input. -/
theorem fractionalIdealTensorProductMap_mem
    (I J : FractionalIdeal R⁰ K)
    (u : (I : Submodule R K) ⊗[R] (J : Submodule R K)) :
    fractionalIdealTensorProductMap I J u ∈ I * J := by
  induction u using TensorProduct.induction_on with
  | zero => simpa using (I * J).zero_mem
  | tmul x y => simpa using FractionalIdeal.mul_mem_mul x.property y.property
  | add u v hu hv =>
    rw [map_add]
    exact (I * J).val.add_mem hu hv

/-- EVERY original element of the actual fractional-ideal product has
a preimage in the genuine tensor multiplication map. -/
theorem fractionalIdealTensorProductMap_exists_of_mem
    (I J : FractionalIdeal R⁰ K) {x : K} (hx : x ∈ I * J) :
    ∃ u : (I : Submodule R K) ⊗[R] (J : Submodule R K),
      fractionalIdealTensorProductMap I J u = x := by
  refine FractionalIdeal.mul_induction_on hx ?_ ?_
  · intro a ha b hb
    exact ⟨(⟨a, ha⟩ : (I : Submodule R K)) ⊗ₜ[R]
      (⟨b, hb⟩ : (J : Submodule R K)), fractionalIdealTensorProductMap_tmul I J _ _⟩
  · intro a b ha hb
    obtain ⟨u, hu⟩ := ha
    obtain ⟨v, hv⟩ := hb
    exact ⟨u + v, by rw [map_add, hu, hv]⟩

theorem fractionalIdealTensorProductMap_range
    (I J : FractionalIdeal R⁰ K) :
    LinearMap.range (fractionalIdealTensorProductMap I J) = (I * J : FractionalIdeal R⁰ K) := by
  ext x
  constructor
  · rintro ⟨u, rfl⟩
    exact fractionalIdealTensorProductMap_mem I J u
  · intro hx
    exact fractionalIdealTensorProductMap_exists_of_mem I J hx

end Litt3.Jacobians

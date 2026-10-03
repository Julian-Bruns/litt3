import Solutions.Jacobians.FractionalIdealTensorImages

open scoped nonZeroDivisors TensorProduct

namespace Litt3.Jacobians

variable {R K : Type*} [CommRing R] [IsDomain R] [Field K]
  [Algebra R K] [IsFractionRing R K]

theorem fractionalIdealTensorProductMap_integer
    (I J : FractionalIdeal R⁰ K) (hIJ : I * J = 1)
    (u : (I : Submodule R K) ⊗[R] (J : Submodule R K)) :
    ∃ r : R, algebraMap R K r = fractionalIdealTensorProductMap I J u := by
  apply (FractionalIdeal.mem_one_iff R⁰).mp
  rw [← hIJ]
  exact fractionalIdealTensorProductMap_mem I J u

/-- The unique ORIGINAL ring element represented by genuine tensor
multiplication when the actual inverse fractional ideals multiply to R. -/
noncomputable def fractionalIdealScalarProductValue
    (I J : FractionalIdeal R⁰ K) (hIJ : I * J = 1)
    (u : (I : Submodule R K) ⊗[R] (J : Submodule R K)) : R :=
  Classical.choose (fractionalIdealTensorProductMap_integer I J hIJ u)

theorem fractionalIdealScalarProductValue_map
    (I J : FractionalIdeal R⁰ K) (hIJ : I * J = 1)
    (u : (I : Submodule R K) ⊗[R] (J : Submodule R K)) :
    algebraMap R K (fractionalIdealScalarProductValue I J hIJ u) =
      fractionalIdealTensorProductMap I J u :=
  Classical.choose_spec (fractionalIdealTensorProductMap_integer I J hIJ u)

/-- Actual tensor multiplication lands in the ORIGINAL ring, with its
literal fraction-field inclusion; this is not an abstract dual pairing. -/
noncomputable def fractionalIdealScalarProductMap
    (I J : FractionalIdeal R⁰ K) (hIJ : I * J = 1) :
    (I : Submodule R K) ⊗[R] (J : Submodule R K) →ₗ[R] R where
  toFun := fractionalIdealScalarProductValue I J hIJ
  map_add' u v := by
    apply IsFractionRing.injective R K
    rw [map_add, fractionalIdealScalarProductValue_map,
      fractionalIdealScalarProductValue_map, fractionalIdealScalarProductValue_map, map_add]
  map_smul' r u := by
    apply IsFractionRing.injective R K
    change algebraMap R K (fractionalIdealScalarProductValue I J hIJ (r • u)) =
      algebraMap R K (r * fractionalIdealScalarProductValue I J hIJ u)
    rw [map_mul, fractionalIdealScalarProductValue_map,
      fractionalIdealScalarProductValue_map, map_smul, Algebra.smul_def]

theorem fractionalIdealScalarProductMap_map
    (I J : FractionalIdeal R⁰ K) (hIJ : I * J = 1)
    (u : (I : Submodule R K) ⊗[R] (J : Submodule R K)) :
    algebraMap R K (fractionalIdealScalarProductMap I J hIJ u) =
      fractionalIdealTensorProductMap I J u := fractionalIdealScalarProductValue_map I J hIJ u

@[simp] theorem fractionalIdealScalarProductMap_tmul_map
    (I J : FractionalIdeal R⁰ K) (hIJ : I * J = 1)
    (x : (I : Submodule R K)) (y : (J : Submodule R K)) :
    algebraMap R K (fractionalIdealScalarProductMap I J hIJ (x ⊗ₜ[R] y)) =
      (x : K) * (y : K) := by
  rw [fractionalIdealScalarProductMap_map, fractionalIdealTensorProductMap_tmul]

end Litt3.Jacobians

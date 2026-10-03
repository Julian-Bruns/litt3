import Solutions.Jacobians.FractionalIdealScalarProducts

open scoped nonZeroDivisors TensorProduct

namespace Litt3.Jacobians

variable {R K : Type*} [CommRing R] [IsDomain R] [Field K]
  [Algebra R K] [IsFractionRing R K]

/-- The genuine multiplication pairing has rank-one interchange on
pure tensors, using literal equality of original field products. -/
theorem fractionalIdealScalarProductMap_tmul_swap
    (I J : FractionalIdeal R⁰ K) (hIJ : I * J = 1)
    (x a : (I : Submodule R K)) (y b : (J : Submodule R K)) :
    fractionalIdealScalarProductMap I J hIJ (x ⊗ₜ[R] y) • (a ⊗ₜ[R] b) =
      fractionalIdealScalarProductMap I J hIJ (a ⊗ₜ[R] b) • (x ⊗ₜ[R] y) := by
  let r := fractionalIdealScalarProductMap I J hIJ (x ⊗ₜ[R] y)
  let s := fractionalIdealScalarProductMap I J hIJ (a ⊗ₜ[R] y)
  let t := fractionalIdealScalarProductMap I J hIJ (a ⊗ₜ[R] b)
  have hi : r • a = s • x := by
    apply Subtype.ext
    simp only [Submodule.coe_smul, Algebra.smul_def]
    change algebraMap R K r * (a : K) = algebraMap R K s * (x : K)
    rw [fractionalIdealScalarProductMap_tmul_map, fractionalIdealScalarProductMap_tmul_map]
    ring
  have hj : s • b = t • y := by
    apply Subtype.ext
    simp only [Submodule.coe_smul, Algebra.smul_def]
    change algebraMap R K s * (b : K) = algebraMap R K t * (y : K)
    rw [fractionalIdealScalarProductMap_tmul_map, fractionalIdealScalarProductMap_tmul_map]
    ring
  change r • (a ⊗ₜ[R] b) = t • (x ⊗ₜ[R] y)
  calc
    r • (a ⊗ₜ[R] b) = (r • a) ⊗ₜ[R] b := TensorProduct.smul_tmul' r a b
    _ = (s • x) ⊗ₜ[R] b := by rw [hi]
    _ = x ⊗ₜ[R] (s • b) := TensorProduct.smul_tmul s x b
    _ = x ⊗ₜ[R] (t • y) := by rw [hj]
    _ = t • (x ⊗ₜ[R] y) := TensorProduct.tmul_smul t x y

theorem fractionalIdealScalarProductMap_swap
    (I J : FractionalIdeal R⁰ K) (hIJ : I * J = 1)
    (u v : (I : Submodule R K) ⊗[R] (J : Submodule R K)) :
    fractionalIdealScalarProductMap I J hIJ u • v =
      fractionalIdealScalarProductMap I J hIJ v • u := by
  induction u using TensorProduct.induction_on with
  | zero => simp
  | tmul x y =>
    induction v using TensorProduct.induction_on with
    | zero => simp
    | tmul a b => exact fractionalIdealScalarProductMap_tmul_swap I J hIJ x a y b
    | add v w hv hw => simp only [map_add, smul_add, add_smul, hv, hw]
  | add u w hu hw => simp only [map_add, smul_add, add_smul, hu, hw]

theorem fractionalIdealScalarProductMap_one_preimage
    (I J : FractionalIdeal R⁰ K) (hIJ : I * J = 1) :
    ∃ e : (I : Submodule R K) ⊗[R] (J : Submodule R K),
      fractionalIdealScalarProductMap I J hIJ e = 1 := by
  obtain ⟨e, he⟩ := fractionalIdealTensorProductMap_exists_of_mem I J
    (show (1 : K) ∈ I * J by
      rw [hIJ]
      exact (FractionalIdeal.mem_one_iff R⁰).mpr ⟨1, map_one _⟩)
  refine ⟨e, ?_⟩
  apply IsFractionRing.injective R K
  rw [fractionalIdealScalarProductMap_map, he, map_one]

theorem fractionalIdealScalarProductMap_bijective
    (I J : FractionalIdeal R⁰ K) (hIJ : I * J = 1) :
    Function.Bijective (fractionalIdealScalarProductMap I J hIJ) := by
  obtain ⟨e, he⟩ := fractionalIdealScalarProductMap_one_preimage I J hIJ
  have hu (u : (I : Submodule R K) ⊗[R] (J : Submodule R K)) :
      u = fractionalIdealScalarProductMap I J hIJ u • e := by
    simpa only [he, one_smul] using fractionalIdealScalarProductMap_swap I J hIJ e u
  constructor
  · intro u v h
    rw [hu u, hu v, h]
  · intro r
    exact ⟨r • e, by simp [he]⟩

/-- Genuine multiplication of actual inverse fractional ideals is an
ACTUAL tensor equivalence with the original ring. No Noetherian or
Dedekind assumption is required. -/
noncomputable def fractionalIdealTensorProductEquiv
    (I J : FractionalIdeal R⁰ K) (hIJ : I * J = 1) :
    (I : Submodule R K) ⊗[R] (J : Submodule R K) ≃ₗ[R] R :=
  LinearEquiv.ofBijective (fractionalIdealScalarProductMap I J hIJ)
    (fractionalIdealScalarProductMap_bijective I J hIJ)

theorem actual_invertible_fractional_ideal_module
    (I : (FractionalIdeal R⁰ K)ˣ) :
    Module.Invertible R ((I.val : FractionalIdeal R⁰ K) : Submodule R K) :=
  Module.Invertible.left (fractionalIdealTensorProductEquiv I.val I.inv I.val_inv)

end Litt3.Jacobians

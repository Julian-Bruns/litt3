import Solutions.Deformations.WeightedRootBaseCoordinates

namespace Litt3.Deformations

open scoped TensorProduct BigOperators

variable {R : Type*} [CommRing R] [Nontrivial R]

/-- The actual original top augmentation exponent tuple. -/
def weightedRootTopExponent (q : ℕ) (large : 1 < q) (r : ℕ) : Fin r → Fin q :=
  fun _ => ⟨q - 1, by omega⟩

/-- The literal norm product over the original coefficient ring,
before any localization or extension of scalars. -/
noncomputable def weightedRootProductNorm (q : ℕ) (tau : R) (r : ℕ) : weightedRootProduct R q tau r :=
  ∏ i : Fin r, (weightedRootProductParameter R q tau r i ^ (q - 1) +
    algebraMap R (weightedRootProduct R q tau r) tau)

theorem weighted_root_norm_successor (q : ℕ) (tau : R) (r : ℕ) :
    weightedRootProductNorm q tau (r + 1) =
      (AdjoinRoot.root (weightedRootRelation q tau) ^ (q - 1) +
        algebraMap R (WeightedRootFactor R q tau) tau) ⊗ₜ[R] weightedRootProductNorm q tau r := by
  rw [weightedRootProductNorm, Fin.prod_univ_succ]
  let left := (Algebra.TensorProduct.includeLeft : WeightedRootFactor R q tau →ₐ[R]
    WeightedRootFactor R q tau ⊗[R] weightedRootProduct R q tau r)
  let right := (Algebra.TensorProduct.includeRight : weightedRootProduct R q tau r →ₐ[R]
    WeightedRootFactor R q tau ⊗[R] weightedRootProduct R q tau r)
  have head : weightedRootProductParameter R q tau (r + 1) 0 ^ (q - 1) +
      algebraMap R (weightedRootProduct R q tau (r + 1)) tau =
      left (AdjoinRoot.root (weightedRootRelation q tau) ^ (q - 1) +
        algebraMap R (WeightedRootFactor R q tau) tau) := by
    rw [map_add, map_pow, AlgHom.commutes]
    rfl
  have tail (i : Fin r) : weightedRootProductParameter R q tau (r + 1) i.succ ^ (q - 1) +
      algebraMap R (weightedRootProduct R q tau (r + 1)) tau =
      right (weightedRootProductParameter R q tau r i ^ (q - 1) +
        algebraMap R (weightedRootProduct R q tau r) tau) := by
    rw [map_add, map_pow, AlgHom.commutes]
    rfl
  rw [head]
  simp_rw [tail]
  have product := map_prod right (fun i : Fin r =>
    weightedRootProductParameter R q tau r i ^ (q - 1) +
      algebraMap R (weightedRootProduct R q tau r) tau) Finset.univ
  rw [← product]
  change left _ * right (weightedRootProductNorm q tau r) = _
  rw [Algebra.TensorProduct.includeLeft_apply, Algebra.TensorProduct.includeRight_apply,
    Algebra.TensorProduct.tmul_mul_tmul, mul_one, one_mul]

theorem weighted_root_factor_norm_top_coordinate (q : ℕ) (large : 1 < q) (tau : R) :
    (weightedRootFactorBasis q large tau).repr
      (AdjoinRoot.root (weightedRootRelation q tau) ^ (q - 1) +
        algebraMap R (WeightedRootFactor R q tau) tau) ⟨q - 1, by omega⟩ = 1 := by
  classical
  let last : Fin q := ⟨q - 1, by omega⟩
  let first : Fin q := ⟨0, by omega⟩
  change (weightedRootFactorBasis q large tau).repr
    (AdjoinRoot.root (weightedRootRelation q tau) ^ (q - 1) +
      algebraMap R (WeightedRootFactor R q tau) tau) last = 1
  have power : weightedRootFactorBasis q large tau last =
      AdjoinRoot.root (weightedRootRelation q tau) ^ (q - 1) := weighted_root_factor_basis_apply _ _ _ _
  have constant : algebraMap R (WeightedRootFactor R q tau) tau =
      tau • weightedRootFactorBasis q large tau first := by
    rw [weighted_root_factor_basis_apply]
    simp only [first, pow_zero, Algebra.smul_def, mul_one]
  have different : first ≠ last := by intro same; have := congrArg Fin.val same; dsimp [first, last] at this; omega
  rw [← power, constant, map_add, Finsupp.add_apply, map_smul, Finsupp.smul_apply]
  simp only [Module.Basis.repr_self_apply, different, ite_false, ite_true, smul_zero, add_zero]

/-- The literal full norm has original top normal coefficient exactly
one, over the unchanged arbitrary coefficient ring. -/
theorem weighted_root_norm_top_coordinate (q : ℕ) (large : 1 < q) (tau : R) (r : ℕ) :
    (weightedRootProductBasis q large tau r).repr (weightedRootProductNorm q tau r)
      (weightedRootTopExponent q large r) = 1 := by
  induction r with
  | zero =>
    have value := (Module.Basis.singleton Unit R).repr_reindex_apply
      (weightedRootProductNorm q tau 0) (Equiv.ofUnique Unit (Fin 0 → Fin q))
      (weightedRootTopExponent q large 0)
    apply value.trans
    simp [weightedRootProductNorm, Module.Basis.singleton_repr]
  | succ r induction =>
    have value := ((weightedRootFactorBasis q large tau).tensorProduct
      (weightedRootProductBasis q large tau r)).repr_reindex_apply
        (weightedRootProductNorm q tau (r + 1)) (finiteFunctionSplitEquiv (Fin q) r).symm
        (weightedRootTopExponent q large (r + 1))
    apply value.trans
    rw [weighted_root_norm_successor, Module.Basis.tensorProduct_repr_tmul_apply]
    change (weightedRootProductBasis q large tau r).repr (weightedRootProductNorm q tau r)
      (weightedRootTopExponent q large r) •
        (weightedRootFactorBasis q large tau).repr
          (AdjoinRoot.root (weightedRootRelation q tau) ^ (q - 1) +
            algebraMap R (WeightedRootFactor R q tau) tau) ⟨q - 1, by omega⟩ = 1
    rw [weighted_root_factor_norm_top_coordinate]
    change (weightedRootProductBasis q large tau r).repr (weightedRootProductNorm q tau r)
      (weightedRootTopExponent q large r) • (1 : R) = 1
    rw [induction, one_smul]

end Litt3.Deformations

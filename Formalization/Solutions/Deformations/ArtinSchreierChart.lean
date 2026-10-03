import Solutions.Deformations.ArtinSchreierFactor
import Solutions.Deformations.ElementaryAugmentationBasis

namespace Litt3.Deformations

open scoped TensorProduct BigOperators

variable {R : Type*} [CommRing R] [Nontrivial R]

/-- The actual original normal monomials form a free basis of the
literal integral chart, uniformly over any nontrivial coefficient ring. -/
noncomputable def artinSchreierChartBasis (p : ℕ) (large : 1 < p) :
    (r : ℕ) → (a b : Fin r → R) →
      Module.Basis (Fin r → Fin p) R (artinSchreierChart R p r a b)
  | 0, _, _ => (Module.Basis.singleton Unit R).reindex (Equiv.ofUnique Unit (Fin 0 → Fin p))
  | r + 1, a, b => ((artinSchreierFactorBasis p large (a 0) (b 0)).tensorProduct
      (artinSchreierChartBasis p large r (fun i => a i.succ) (fun i => b i.succ))).reindex
        (finiteFunctionSplitEquiv (Fin p) r).symm

@[simp] theorem artin_schreier_chart_basis_apply (p : ℕ) (large : 1 < p)
    (r : ℕ) (a b : Fin r → R) (alpha : Fin r → Fin p) :
    artinSchreierChartBasis p large r a b alpha =
      ∏ i, artinSchreierChartCoordinate R p r a b i ^ (alpha i).val := by
  induction r with
  | zero =>
    have value := (Module.Basis.singleton Unit R).reindex_apply
      (Equiv.ofUnique Unit (Fin 0 → Fin p)) alpha
    exact value.trans (by simp [Module.Basis.singleton_apply])
  | succ r induction =>
    have value := ((artinSchreierFactorBasis p large (a 0) (b 0)).tensorProduct
      (artinSchreierChartBasis p large r (fun i => a i.succ) (fun i => b i.succ))).reindex_apply
        (finiteFunctionSplitEquiv (Fin p) r).symm alpha
    apply value.trans
    change ((artinSchreierFactorBasis p large (a 0) (b 0)).tensorProduct
      (artinSchreierChartBasis p large r (fun i => a i.succ) (fun i => b i.succ)))
        (alpha 0, fun i => alpha i.succ) = _
    rw [Module.Basis.tensorProduct_apply, artin_schreier_factor_basis_apply, induction]
    rw [Fin.prod_univ_succ]
    change (AdjoinRoot.root (artinSchreierRelation p (a 0) (b 0)) ^ (alpha 0).val) ⊗ₜ[R]
        (∏ i : Fin r, artinSchreierChartCoordinate R p r
          (fun i => a i.succ) (fun i => b i.succ) i ^ (alpha i.succ).val) =
      (Algebra.TensorProduct.includeLeft (AdjoinRoot.root (artinSchreierRelation p (a 0) (b 0)))) ^
          (alpha 0).val *
        ∏ i : Fin r, (Algebra.TensorProduct.includeRight
          (artinSchreierChartCoordinate R p r (fun i => a i.succ) (fun i => b i.succ) i)) ^
            (alpha i.succ).val
    simp only [← map_pow]
    rw [← map_prod, Algebra.TensorProduct.includeLeft_apply,
      Algebra.TensorProduct.includeRight_apply, Algebra.TensorProduct.tmul_mul_tmul, mul_one, one_mul]

omit [Nontrivial R] in
/-- Every literal original chart coordinate satisfies its actual
integral relation; the chart need not be etale. -/
theorem artin_schreier_chart_relation (p r : ℕ) (a b : Fin r → R) (i : Fin r) :
    artinSchreierChartCoordinate R p r a b i ^ p =
      a i • artinSchreierChartCoordinate R p r a b i + b i • (1 : artinSchreierChart R p r a b) := by
  induction r with
  | zero => exact Fin.elim0 i
  | succ r induction =>
    refine Fin.cases ?_ (fun j => ?_) i
    · let inclusion := (Algebra.TensorProduct.includeLeft : ArtinSchreierFactor R p (a 0) (b 0) →ₐ[R]
        ArtinSchreierFactor R p (a 0) (b 0) ⊗[R]
          artinSchreierChart R p r (fun i => a i.succ) (fun i => b i.succ))
      have relation := congrArg inclusion (artin_schreier_factor_relation p (a 0) (b 0))
      simp only [map_pow, map_add, map_mul, AlgHom.commutes, Algebra.smul_def, mul_one] at relation ⊢
      exact relation
    · let inclusion := (Algebra.TensorProduct.includeRight :
        artinSchreierChart R p r (fun i => a i.succ) (fun i => b i.succ) →ₐ[R]
          ArtinSchreierFactor R p (a 0) (b 0) ⊗[R]
            artinSchreierChart R p r (fun i => a i.succ) (fun i => b i.succ))
      have relation := congrArg inclusion
        (induction (fun i => a i.succ) (fun i => b i.succ) j)
      simp only [map_pow, map_add, map_smul, map_one] at relation
      exact relation

end Litt3.Deformations

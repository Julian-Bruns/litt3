import Solutions.Deformations.ElementaryWittKernelStep
import Solutions.Deformations.ElementaryGradedPrecisionBounds
import Solutions.Deformations.FilteredAdditiveLifting

set_option maxHeartbeats 1200000

namespace Litt3.Deformations

variable (N : ℕ) [Fact (0 < N)]
variable (k : Type*) [Field k] [Fact (Nat.Prime 5)] [CharP k 5] [PerfectRing k 5]

local instance : Nontrivial (TruncatedWittVector 5 N k) :=
  truncated_witt_nontrivial 5 N (Fact.out : 0 < N) k

/-- The source's actual finite-precision kernel bound, for an arbitrary
perfect characteristic-five field and a merely additive operator.
The genuine parameter injectivity is proved from original anisotropy. -/
theorem elementary_witt_precision_kernel_bound (r : ℕ) (precisionBound : N ≤ r)
    (L : AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5) →+
      AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5))
    (q : MvPolynomial (Fin r) k) (reduction : ElementaryWittQuadraticReduction N k r L q)
    (anisotropic : ∀ a : Fin r → ZMod 5, a ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl 5) k (a i)) ≠ 0)
    (x : AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5))
    (kernel : L x = 0) :
    x ∈ elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r (4 * N - 1) := by
  let F := fun d => (elementaryNormalWeightFiltration (TruncatedWittVector 5 N k)
    5 (by omega) r d).toAddSubgroup
  apply filtered_additive_kernel_bound F L 0 (4 * N - 1) (by omega) ?_ x ?_ kernel
  · intro d _ small y member vanish
    apply elementary_witt_kernel_step N k r d L q reduction ?_ y member vanish
    intro Z homogeneous zero
    exact elementary_graded_precision_low_kernel k r N d (Fact.out : 0 < N)
      precisionBound small q reduction.2.1 anisotropic Z homogeneous zero
  · change x ∈ elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r 0
    rw [elementary_normal_weight_initial]
    exact Submodule.mem_top

/-- The actual final precision has the sharper exact source bound 4r,
proved for the original additive operator rather than a supplied model. -/
theorem elementary_witt_final_kernel_bound (r : ℕ)
    (L : AddMonoidAlgebra (TruncatedWittVector 5 (r + 1) k) (Fin r → ZMod 5) →+
      AddMonoidAlgebra (TruncatedWittVector 5 (r + 1) k) (Fin r → ZMod 5))
    (q : MvPolynomial (Fin r) k)
    (reduction : @ElementaryWittQuadraticReduction (r + 1) ⟨by omega⟩ k _ _ _ _ r L q)
    (anisotropic : ∀ a : Fin r → ZMod 5, a ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl 5) k (a i)) ≠ 0)
    (x : AddMonoidAlgebra (TruncatedWittVector 5 (r + 1) k) (Fin r → ZMod 5))
    (kernel : L x = 0) :
    x ∈ @elementaryNormalWeightFiltration (TruncatedWittVector 5 (r + 1) k) _
      (truncated_witt_nontrivial 5 (r + 1) (by omega) k) 5 (by omega) r (4 * r) := by
  letI : Fact (0 < r + 1) := ⟨by omega⟩
  letI : Nontrivial (TruncatedWittVector 5 (r + 1) k) :=
    truncated_witt_nontrivial 5 (r + 1) (by omega) k
  let F := fun d => (elementaryNormalWeightFiltration (TruncatedWittVector 5 (r + 1) k)
    5 (by omega) r d).toAddSubgroup
  apply filtered_additive_kernel_bound F L 0 (4 * r) (by omega) ?_ x ?_ kernel
  · intro d _ small y member vanish
    apply elementary_witt_kernel_step (r + 1) k r d L q reduction ?_ y member vanish
    intro Z homogeneous zero
    exact elementary_graded_final_precision_low_kernel k r d small q reduction.2.1
      anisotropic Z homogeneous zero
  · change x ∈ elementaryNormalWeightFiltration (TruncatedWittVector 5 (r + 1) k) 5 (by omega) r 0
    rw [elementary_normal_weight_initial]
    exact Submodule.mem_top

end Litt3.Deformations

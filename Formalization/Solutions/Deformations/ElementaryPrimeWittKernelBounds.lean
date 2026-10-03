import Solutions.Deformations.ElementaryPrimeWittKernelStep
import Solutions.Deformations.ElementaryPrimeGradedPrecisionBounds
import Solutions.Deformations.FilteredAdditiveLifting

set_option maxHeartbeats 1200000

namespace Litt3.Deformations

variable (p N : ℕ) [Fact p.Prime] [Fact (0 < N)]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Nontrivial (TruncatedWittVector p N k) :=
  truncated_witt_nontrivial p N (Fact.out : 0 < N) k

/-- Actual finite-precision kernel threshold for a merely additive,
original-deck-equivariant operator with anisotropic homogeneous principal part. -/
theorem elementary_prime_witt_precision_kernel_bound (large : 2 < p)
    (r a : ℕ) (precisionBound : N ≤ r) (principalPositive : 0 < a)
    (degreeBound : a + 1 ≤ p - 1)
    (L : AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p) →+
      AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p))
    (q : MvPolynomial (Fin r) k)
    (reduction : ElementaryPrimeWittReduction p N k r a L q)
    (anisotropic : ∀ v : Fin r → ZMod p, v ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl p) k (v i)) ≠ 0)
    (x : AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p))
    (kernel : L x = 0) :
    x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p N k)
      p (Fact.out : p.Prime).pos r ((p - 1) * N - a + 1) := by
  let F := fun d => (elementaryNormalWeightFiltration (TruncatedWittVector p N k)
    p (Fact.out : p.Prime).pos r d).toAddSubgroup
  apply filtered_additive_kernel_bound F L 0 ((p - 1) * N - a + 1)
    (by omega) ?_ x ?_ kernel
  · intro d _ small y member vanish
    apply elementary_prime_witt_kernel_step p N k r d a degreeBound L q reduction ?_ y member vanish
    intro Z homogeneous zero
    exact elementary_prime_graded_precision_low_kernel p k large r N d a (Fact.out : 0 < N)
      precisionBound principalPositive degreeBound small q reduction.2.1 anisotropic Z homogeneous zero
  · change x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p N k)
      p (Fact.out : p.Prime).pos r 0
    rw [elementary_normal_weight_initial]
    exact Submodule.mem_top

/-- The original operator's kernel at final precision has the exact
sharper normal-weight threshold, without coefficient linearity. -/
theorem elementary_prime_witt_final_kernel_bound (large : 2 < p)
    (r a : ℕ) (principalPositive : 0 < a) (degreeBound : a + 1 ≤ p - 1)
    (L : AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p) →+
      AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p))
    (q : MvPolynomial (Fin r) k)
    (reduction : @ElementaryPrimeWittReduction p (r + 1) _ ⟨by omega⟩ k _ _ _ r a L q)
    (anisotropic : ∀ v : Fin r → ZMod p, v ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl p) k (v i)) ≠ 0)
    (x : AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p))
    (kernel : L x = 0) :
    x ∈ @elementaryNormalWeightFiltration (TruncatedWittVector p (r + 1) k) _
      (truncated_witt_nontrivial p (r + 1) (by omega) k)
      p (Fact.out : p.Prime).pos r ((p - 1) * r) := by
  letI : Fact (0 < r + 1) := ⟨by omega⟩
  letI : Nontrivial (TruncatedWittVector p (r + 1) k) :=
    truncated_witt_nontrivial p (r + 1) (by omega) k
  let F := fun d => (elementaryNormalWeightFiltration (TruncatedWittVector p (r + 1) k)
    p (Fact.out : p.Prime).pos r d).toAddSubgroup
  apply filtered_additive_kernel_bound F L 0 ((p - 1) * r) (by omega) ?_ x ?_ kernel
  · intro d _ small y member vanish
    apply elementary_prime_witt_kernel_step p (r + 1) k r d a degreeBound L q reduction ?_ y member vanish
    intro Z homogeneous zero
    exact elementary_prime_graded_final_precision_low_kernel p k large r d a
      principalPositive degreeBound small q reduction.2.1 anisotropic Z homogeneous zero
  · change x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p (r + 1) k)
      p (Fact.out : p.Prime).pos r 0
    rw [elementary_normal_weight_initial]
    exact Submodule.mem_top

end Litt3.Deformations

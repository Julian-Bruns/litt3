import Solutions.Deformations.ArtinSchreierAdicRoot
import Solutions.Deformations.AdicApproximationClosed
import Solutions.Deformations.ClosedSignedFiltration

namespace Litt3.Deformations

open scoped Topology

variable {R A I : Type*} [CommRing R] [CommRing A] [Algebra R A] [Fintype I]
  [TopologicalSpace A] [ContinuousAdd A] [ContinuousMul A] [ContinuousConstSMul R A]

theorem artin_schreier_root_step_preserves_degree_one (p : ℕ) (prime : p.Prime)
    (e : I → A) (a b : I → R)
    (relations : ∀ i, e i ^ p = a i • e i + b i • (1 : A))
    (u : Rˣ) (v : R) (x : A)
    (member : x ∈ closedSignedFiltration R (p : A) (p - 1) e 1) :
    artinSchreierRootStep p u v x ∈ closedSignedFiltration R (p : A) (p - 1) e 1 := by
  have one : (1 : A) ∈ closedSignedFiltration R (p : A) (p - 1) e 1 := by
    apply (signedGeneratorFiltration R (p : A) (p - 1) e 1).le_topologicalClosure
    exact signed_generator_filtration_monotone (p : A) (p - 1) e (by omega)
      (signed_generator_initial_one (R := R) (p : A) (p - 1) e)
  have constant : algebraMap R A v ∈ closedSignedFiltration R (p : A) (p - 1) e 1 := by
    simpa only [Algebra.smul_def, mul_one] using
      (closedSignedFiltration R (p : A) (p - 1) e 1).smul_mem v one
  exact (closedSignedFiltration R (p : A) (p - 1) e 1).smul_mem _
    ((closedSignedFiltration R (p : A) (p - 1) e 1).sub_mem
      (artin_schreier_closed_degree_one_power p prime e a b relations x member) constant)

/-- The actual unique lifted root lies in the actual closed degree-one
module. This derives the degree bound through every genuine original
fixed-point approximation, not through a presumed Hensel conclusion. -/
theorem artin_schreier_closed_root_lift (p : ℕ) (prime : p.Prime)
    [IsAdicComplete (Ideal.span {(p : A)}) A]
    (adic : IsAdic (Ideal.span {(p : A)}))
    (e : I → A) (a b : I → R)
    (relations : ∀ i, e i ^ p = a i • e i + b i • (1 : A))
    (u : Rˣ) (v : R) (seed : A)
    (seedMember : seed ∈ closedSignedFiltration R (p : A) (p - 1) e 1)
    (initial : seed ^ p ≡ u.val • seed + v • (1 : A)
      [SMOD (Ideal.span {(p : A)})]) :
    ∃ x : A, x ^ p = u.val • x + v • (1 : A) ∧
      x ∈ closedSignedFiltration R (p : A) (p - 1) e 1 ∧
      x ≡ seed [SMOD (Ideal.span {(p : A)})] ∧
      ∀ y : A, y ^ p = u.val • y + v • (1 : A) →
        y ≡ seed [SMOD (Ideal.span {(p : A)})] → y = x := by
  obtain ⟨x, root, residue, approximations, unique⟩ :=
    artin_schreier_adic_root_lift p prime u v seed initial
  have iterationMember (n : ℕ) : (artinSchreierRootStep p u v)^[n] seed ∈
      closedSignedFiltration R (p : A) (p - 1) e 1 := by
    induction n with
    | zero => exact seedMember
    | succ n induction =>
      rw [Function.iterate_succ_apply']
      exact artin_schreier_root_step_preserves_degree_one p prime e a b relations u v _ induction
  have member := adic_approximation_mem_closed (Ideal.span {(p : A)}) adic
    (fun n => (artinSchreierRootStep p u v)^[n] seed) x approximations
    (closedSignedFiltration R (p : A) (p - 1) e 1)
    (Submodule.isClosed_topologicalClosure _) iterationMember
  exact ⟨x, root, member, residue, unique⟩

end Litt3.Deformations

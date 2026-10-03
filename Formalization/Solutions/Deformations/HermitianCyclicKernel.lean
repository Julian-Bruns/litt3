import Theorems.Deformations.HermitianCyclicKernel
import Solutions.Deformations.HermitianValuationStep
import Solutions.Deformations.RectangularCongruenceKernels
import Solutions.Deformations.BlockDiagonalKernels
import Solutions.Deformations.TruncatedBlockKernels

namespace Litt3.Deformations

variable {k : Type*} [Field k]

/-- The zero matrix gives its actual free kernel module.
The cyclic presentation at j=N is retained without imposing
any parity condition on this free block. -/
theorem zero_hermitian_cyclic_kernel (N d : ℕ)
    (A : Matrix (Fin d) (Fin d) (TruncatedCoefficientRing k N)) (zeroA : A = 0) :
    Specifications.HermitianCyclicKernel N d A := by
  have hA : A = truncatedParameter k N ^ N • (1 : Matrix (Fin d) (Fin d)
      (TruncatedCoefficientRing k N)) := by
    rw [truncated_parameter_pow, zero_smul, zeroA]
  let E := (LinearEquiv.ofEq _ _ (congrArg (fun M => LinearMap.ker (Matrix.toLin' M)) hA)).trans
    (truncatedUnitBlockKernelEquiv N N (Nat.le_refl N) 1 isUnit_one)
  refine ⟨{
    s := 1
    degree := fun _ => N
    multiplicity := fun _ => d
    bounded := fun _ => Nat.le_refl N
    odd_nonfree_even := fun _ _ impossible => False.elim (Nat.lt_irrefl N impossible)
    rank_sum := by simp
    kernel_equiv := E.trans (LinearEquiv.piUnique (TruncatedCoefficientRing k N)
      (fun _ : Fin 1 => Fin d → TruncatedCyclicModule (k := k) N N)).symm }⟩

/-- Finite recursion on the actual remaining radical rank
constructs the complete Q_N-module kernel decomposition of
every Hermitian matrix. No Smith normal form or decomposition
existence is assumed. -/
theorem hermitian_cyclic_kernel (two_ne_zero : (2 : k) ≠ 0)
    (N : ℕ) (positive : 0 < N) :
    ∀ d : ℕ, ∀ A : Matrix (Fin d) (Fin d) (TruncatedCoefficientRing k N),
      truncatedHermitianTranspose k N A = A → Specifications.HermitianCyclicKernel N d A := by
  intro d
  induction d using Nat.strong_induction_on with
  | h d inductionHypothesis =>
    intro A hermitian
    by_cases zeroA : A = 0
    · exact zero_hermitian_cyclic_kernel N d A zeroA
    obtain ⟨step⟩ := hermitian_valuation_step two_ne_zero N positive A zeroA hermitian
    let remainder := truncatedParameter k N ^ (step.e + 1) • step.F
    obtain ⟨rest⟩ := inductionHypothesis step.r
      (by simpa only [Fintype.card_fin] using step.radical_drop) remainder step.remainder_hermitian
    let newDegree : Fin (rest.s + 1) → ℕ := Fin.cons step.e rest.degree
    let newMultiplicity : Fin (rest.s + 1) → ℕ := Fin.cons step.m rest.multiplicity
    let blockKernel := (rectangularCongruenceKernelEquiv A step.P step.Q step.inverse_pair).symm
    let exactKernel := LinearEquiv.ofEq _ _
      (congrArg (fun M => LinearMap.ker (Matrix.toLin' M)) step.congruence)
    let splitKernel := blockDiagonalKernelEquiv
      (truncatedParameter k N ^ step.e • step.C) remainder
    let leadingKernel := truncatedUnitBlockKernelEquiv N step.e (Nat.le_of_lt step.less)
      step.C step.unit_leading
    let components := leadingKernel.prodCongr rest.kernel_equiv
    let assemble := Fin.consLinearEquiv (TruncatedCoefficientRing k N)
      (fun i : Fin (rest.s + 1) =>
        Fin (newMultiplicity i) → TruncatedCyclicModule (k := k) N (newDegree i))
    refine ⟨{
      s := rest.s + 1
      degree := newDegree
      multiplicity := newMultiplicity
      bounded := ?_
      odd_nonfree_even := ?_
      rank_sum := ?_
      kernel_equiv := blockKernel.trans (exactKernel.trans
        (splitKernel.trans (components.trans assemble))) }⟩
    · intro i
      refine Fin.cases (Nat.le_of_lt step.less) (fun j => ?_) i
      exact rest.bounded j
    · intro i
      refine Fin.cases (fun odd _ => step.odd_rank odd) (fun j => ?_) i
      exact rest.odd_nonfree_even j
    · change (∑ i : Fin (rest.s + 1), Fin.cons step.m rest.multiplicity i) = d
      rw [Fin.sum_univ_succ]
      simp only [Fin.cons_zero, Fin.cons_succ, rest.rank_sum]
      simpa only [Fintype.card_fin] using step.rank_sum

end Litt3.Deformations

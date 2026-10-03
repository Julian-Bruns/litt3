import Theorems.Deformations.HermitianCyclicParity
import Solutions.Deformations.HermitianCyclicKernel
import Solutions.Deformations.CyclicDecompositionUniqueness

namespace Litt3.Deformations

variable {k : Type*} [Field k]

/-- Every actual finite cyclic decomposition of the kernel
of an actual Hermitian matrix has even multiplicity in each
odd nonfree degree. The complete scalar action is essential
to the proved comparison of the actual decompositions. -/
theorem hermitian_cyclic_parity (two_ne_zero : (2 : k) ≠ 0)
    (N : ℕ) (positive : 0 < N) (d : ℕ)
    (A : Matrix (Fin d) (Fin d) (TruncatedCoefficientRing k N))
    (hermitian : truncatedHermitianTranspose k N A = A)
    (s : ℕ) (degree multiplicity : Fin s → ℕ) (bounded : ∀ i, degree i ≤ N)
    (E : LinearMap.ker (Matrix.toLin' A) ≃ₗ[TruncatedCoefficientRing k N]
      TruncatedCyclicBlocks k N s degree multiplicity) :
    Specifications.HermitianCyclicParity N s degree multiplicity := by
  obtain ⟨data⟩ := hermitian_cyclic_kernel two_ne_zero N positive d A hermitian
  have unique := truncated_cyclic_decomposition_unique N data.s s
    data.degree data.multiplicity degree multiplicity data.bounded bounded
    (data.kernel_equiv.symm.trans E)
  intro a odd less
  have positiveA : 0 < a := odd.pos
  rw [← unique a positiveA]
  unfold cyclicMultiplicityAt
  apply Finset.even_sum
  intro i _
  by_cases hi : data.degree i = a
  · rw [if_pos hi]
    exact data.odd_nonfree_even i (hi.symm ▸ odd) (hi.symm ▸ less)
  · rw [if_neg hi]
    exact ⟨0, rfl⟩

end Litt3.Deformations

import Theorems.Deformations.CanonicalCyclicParity
import Solutions.Deformations.HermitianCyclicParity

namespace Litt3.Deformations

theorem canonical_cyclic_multiplicity (N : ℕ) (multiplicity : Fin (N + 1) → ℕ)
    (j : Fin (N + 1)) :
    cyclicMultiplicityAt (canonicalCyclicDegree N) multiplicity j.val = multiplicity j := by
  unfold cyclicMultiplicityAt canonicalCyclicDegree
  rw [Finset.sum_eq_single j]
  · exact if_pos rfl
  · intro i _ different
    rw [if_neg]
    intro equal
    exact different (Fin.ext equal)
  · intro outside
    exact False.elim (outside (Finset.mem_univ _))

variable {k : Type*} [Field k]

/-- In an actual canonical cyclic decomposition of an
actual Hermitian kernel, each individual odd nonfree
multiplicity is even. The free multiplicity is unrestricted. -/
theorem hermitian_canonical_cyclic_parity (two_ne_zero : (2 : k) ≠ 0)
    (N : ℕ) (positive : 0 < N) (d : ℕ)
    (A : Matrix (Fin d) (Fin d) (TruncatedCoefficientRing k N))
    (hermitian : truncatedHermitianTranspose k N A = A)
    (multiplicity : Fin (N + 1) → ℕ)
    (E : LinearMap.ker (Matrix.toLin' A) ≃ₗ[TruncatedCoefficientRing k N]
      TruncatedCyclicBlocks k N (N + 1) (canonicalCyclicDegree N) multiplicity) :
    Specifications.CanonicalCyclicParity N multiplicity := by
  have bounded : ∀ i, canonicalCyclicDegree N i ≤ N := fun i => Nat.le_of_lt_succ i.isLt
  have parity := hermitian_cyclic_parity two_ne_zero N positive d A hermitian
    (N + 1) (canonicalCyclicDegree N) multiplicity bounded E
  intro j odd less
  have h := parity j.val odd less
  rwa [canonical_cyclic_multiplicity] at h

end Litt3.Deformations

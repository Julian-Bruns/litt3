import Definitions.Deformations.HermitianValuationStep
import Definitions.Deformations.TruncatedBlockDimensions

namespace Litt3.Deformations

variable (k : Type*) [CommRing k]

noncomputable abbrev TruncatedCyclicBlocks (N s : ℕ) (degree multiplicity : Fin s → ℕ) :=
  (i : Fin s) → Fin (multiplicity i) → TruncatedCyclicModule (k := k) N (degree i)

variable {k} [Field k]

/-- A genuine finite decomposition of the whole Hermitian
kernel as Q_N modules. Odd nonfree powers occur in even-sized
blocks, while the free power j=N has no parity restriction. -/
structure HermitianCyclicKernelData (N d : ℕ)
    (A : Matrix (Fin d) (Fin d) (TruncatedCoefficientRing k N)) where
  s : ℕ
  degree : Fin s → ℕ
  multiplicity : Fin s → ℕ
  bounded : ∀ i, degree i ≤ N
  odd_nonfree_even : ∀ i, Odd (degree i) → degree i < N → Even (multiplicity i)
  rank_sum : ∑ i, multiplicity i = d
  kernel_equiv : LinearMap.ker (Matrix.toLin' A) ≃ₗ[TruncatedCoefficientRing k N]
    TruncatedCyclicBlocks k N s degree multiplicity

end Litt3.Deformations

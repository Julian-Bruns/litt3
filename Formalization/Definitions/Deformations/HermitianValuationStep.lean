import Definitions.Deformations.SignedLeadingSplit
import Definitions.Deformations.TruncatedSchurStep

namespace Litt3.Deformations

variable {k ι : Type*} [Field k] [Fintype ι] [DecidableEq ι]

/-- A full actual Hermitian valuation split. The basis change
has actual inverses even when the new indices are different;
the complete remainder has strictly larger parameter valuation. -/
structure HermitianValuationStepData (N : ℕ)
    (A : Matrix ι ι (TruncatedCoefficientRing k N)) where
  e : ℕ
  less : e < N
  m : ℕ
  r : ℕ
  positive_rank : 0 < m
  radical_drop : r < Fintype.card ι
  rank_sum : m + r = Fintype.card ι
  P : Matrix ι (Fin m ⊕ Fin r) (TruncatedCoefficientRing k N)
  Q : Matrix (Fin m ⊕ Fin r) ι (TruncatedCoefficientRing k N)
  inverse_pair : MatrixInversePair P Q
  C : Matrix (Fin m) (Fin m) (TruncatedCoefficientRing k N)
  unit_leading : IsUnit C
  F : Matrix (Fin r) (Fin r) (TruncatedCoefficientRing k N)
  congruence : truncatedHermitianTranspose k N P * A * P =
    Matrix.fromBlocks (truncatedParameter k N ^ e • C) 0 0
      (truncatedParameter k N ^ (e + 1) • F)
  remainder_hermitian : truncatedHermitianTranspose k N
      (truncatedParameter k N ^ (e + 1) • F) =
    truncatedParameter k N ^ (e + 1) • F
  odd_rank : Odd e → Even m

end Litt3.Deformations

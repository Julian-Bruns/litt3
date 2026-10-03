import Mathlib.RingTheory.DiscreteValuationRing.Basic
import Mathlib.RingTheory.LocalRing.ResidueField.Basic

namespace Litt3.QuotientGeometry

/-- Literal DVR parameter and coefficient-field residue data. No
completion isomorphism is a field of this structure. -/
structure DVRCompletionParameters (k R : Type*) [Field k] [CommRing R]
    [IsDomain R] [IsDiscreteValuationRing R] [Algebra k R] where
  parameter : R
  irreducible : Irreducible parameter
  residue_surjective : Function.Surjective (algebraMap k (IsLocalRing.ResidueField R))

end Litt3.QuotientGeometry

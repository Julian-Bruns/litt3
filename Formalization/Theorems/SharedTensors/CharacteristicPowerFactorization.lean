import Definitions.SharedTensors.CharacteristicPowerBlocks

namespace Litt3.SharedTensors

open Polynomial

variable {k K : Type*} [Field k] [Field K] [Algebra k K]

/-- Actual characteristic-power polynomial factorization, with the
constant polynomial in the original embedded field. -/
def CharacteristicPowerFactorization (p : ℕ) (F : K[X]) : Prop :=
  ∃ R : K[X], ∃ P : k[X], R.Monic ∧ P.Monic ∧
    R.natDegree = F.natDegree % p ∧ P.natDegree = F.natDegree / p ∧
    F = R * expand K p (P.map (algebraMap k K))

end Litt3.SharedTensors

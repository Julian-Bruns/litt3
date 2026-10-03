import Definitions.Deformations.BasisWeightedPowers
import Solutions.Deformations.TruncatedWittMaps
import Mathlib.RingTheory.WittVector.Teichmuller

namespace Litt3.Deformations

/-- A literal surviving original normal coordinate of a selected
weight in a length-N coefficient ring. -/
def wittWeightActive (w d b N : ℕ) : Prop :=
  w * basisWeightExponent w d b + b = d ∧ basisWeightExponent w d b < N

/-- The actual prime-power Teichmüller representative of one original
normal coordinate, with no phantom terminal coefficient. -/
noncomputable def wittWeightedInitialCoefficient (p N : ℕ) [Fact p.Prime]
    {k : Type*} [CommRing k] (w d b : ℕ) (c : k) : TruncatedWittVector p N k := by
  classical
  exact if wittWeightActive w d b N then
      (p : TruncatedWittVector p N k) ^ basisWeightExponent w d b *
        WittVector.truncate N (WittVector.teichmuller p c)
    else 0

/-- A residue coefficient represents an actual weighted initial class
precisely when the actual remainder lies one weight higher. -/
def WittWeightedCoefficientInitial (p N : ℕ) [Fact p.Prime]
    {k : Type*} [CommRing k] (w d b : ℕ)
    (a : TruncatedWittVector p N k) (c : k) : Prop :=
  (¬ wittWeightActive w d b N → c = 0) ∧
  (p : TruncatedWittVector p N k) ^ basisWeightExponent w (d + 1) b ∣
    a - wittWeightedInitialCoefficient p N w d b c

end Litt3.Deformations

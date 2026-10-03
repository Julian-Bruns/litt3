import Definitions.CartierAndSpin.CanonicalWeightedSquareSupport
import Definitions.CartierAndSpin.NormalizedDVRBoundary
import Mathlib.RingTheory.Valuation.ValuationRing
import Mathlib.RingTheory.LocalRing.ResidueField.Basic

namespace Litt3.CartierAndSpin

open scoped WithZero
open IsLocalRing

variable {k L : Type*} [Field k] [Field L] [Algebra k L]

/-- The literal constant-field inclusion into an actual valuation ring,
when all constants are integral. No chosen residue-value function occurs. -/
def boundedConstantRingHom (v : Valuation L ℤᵐ⁰)
    (hbase : ∀ c : k, v (algebraMap k L c) ≤ 1) : k →+* v.integer where
  toFun c := ⟨algebraMap k L c, hbase c⟩
  map_zero' := Subtype.ext (map_zero _)
  map_one' := Subtype.ext (map_one _)
  map_add' a b := Subtype.ext (map_add _ a b)
  map_mul' a b := Subtype.ext (map_mul _ a b)

/-- The actual induced constant-field map to the actual residue field. -/
def constantResidueMap (v : Valuation L ℤᵐ⁰)
    (hbase : ∀ c : k, v (algebraMap k L c) ≤ 1) :
    k →+* ResidueField v.integer :=
  (residue v.integer).comp (boundedConstantRingHom v hbase)

/-- A literal residue fiber, which is an explicit zero-or-one candidate
support because the constant field maps injectively to the residue field. -/
def oddPointResidueCandidates (v : Valuation L ℤᵐ⁰)
    (hbase : ∀ c : k, v (algebraMap k L c) ≤ 1)
    (q : L) (hq : v q ≤ 1) : Set k :=
  {theta | constantResidueMap v hbase theta = residue v.integer ⟨q, hq⟩}

end Litt3.CartierAndSpin

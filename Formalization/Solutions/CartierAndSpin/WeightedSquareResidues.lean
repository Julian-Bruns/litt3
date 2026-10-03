import Definitions.CartierAndSpin.WeightedSquareResidues
import Solutions.CartierAndSpin.WeightedSquareValuationParity

namespace Litt3.CartierAndSpin

open scoped WithZero
open IsLocalRing

variable {k L : Type*} [Field k] [Field L] [Algebra k L]

/-- The canonical odd-divisor-point recipe gives an actual finite
zero-or-one residue fiber containing the whole actual square support. -/
theorem odd_point_residue_candidate_support (v : Valuation L ℤᵐ⁰)
    (hbase : ∀ c : k, v (algebraMap k L c) ≤ 1)
    (g q : L) (hg : g ≠ 0) (hq : v q ≤ 1)
    (hodd : Odd (integerFieldOrder v g)) :
    nonzeroWeightedSquareSupport (k := k) g q ⊆ oddPointResidueCandidates v hbase q hq ∧
    (oddPointResidueCandidates v hbase q hq).Finite ∧
    (oddPointResidueCandidates v hbase q hq).ncard ≤ 1 := by
  have hsubset : nonzeroWeightedSquareSupport (k := k) g q ⊆
      oddPointResidueCandidates v hbase q hq := by
    intro theta htheta
    exact weighted_square_odd_point_forces_residue v g hg
      (boundedConstantRingHom v hbase theta) ⟨q, hq⟩ hodd htheta.1
  have hsubsingleton : (oddPointResidueCandidates v hbase q hq).Subsingleton := by
    intro theta htheta eta heta
    apply (constantResidueMap v hbase).injective
    exact htheta.trans heta.symm
  refine ⟨hsubset, hsubsingleton.finite, ?_⟩
  exact (Set.ncard_le_one hsubsingleton.finite).mpr hsubsingleton

/-- If the actual residue of q is the residue of the constant c, the
candidate is literally the singleton c. Its square class remains to be checked. -/
theorem odd_point_residue_candidates_eq_singleton (v : Valuation L ℤᵐ⁰)
    (hbase : ∀ c : k, v (algebraMap k L c) ≤ 1)
    (q : L) (hq : v q ≤ 1) (c : k)
    (hc : residue v.integer ⟨q, hq⟩ = constantResidueMap v hbase c) :
    oddPointResidueCandidates v hbase q hq = {c} := by
  ext theta
  simp only [oddPointResidueCandidates, Set.mem_setOf_eq, hc,
    (constantResidueMap v hbase).injective.eq_iff, Set.mem_singleton_iff]

/-- Incompatible actual q-values at two odd divisor points exclude every
parameter. The valuations and both residue maps are genuine. -/
theorem incompatible_odd_point_values_empty_support (v w : Valuation L ℤᵐ⁰)
    (hvbase : ∀ c : k, v (algebraMap k L c) ≤ 1)
    (hwbase : ∀ c : k, w (algebraMap k L c) ≤ 1)
    (g q : L) (hg : g ≠ 0) (hvq : v q ≤ 1) (hwq : w q ≤ 1)
    (hvodd : Odd (integerFieldOrder v g)) (hwodd : Odd (integerFieldOrder w g))
    (c d : k) (hcd : c ≠ d)
    (hc : residue v.integer ⟨q, hvq⟩ = constantResidueMap v hvbase c)
    (hd : residue w.integer ⟨q, hwq⟩ = constantResidueMap w hwbase d) :
    nonzeroWeightedSquareSupport (k := k) g q = ∅ := by
  apply Set.eq_empty_iff_forall_notMem.mpr
  intro theta htheta
  have hvcandidate := (odd_point_residue_candidate_support v hvbase g q hg hvq hvodd).1 htheta
  have hwcandidate := (odd_point_residue_candidate_support w hwbase g q hg hwq hwodd).1 htheta
  rw [odd_point_residue_candidates_eq_singleton v hvbase q hvq c hc] at hvcandidate
  rw [odd_point_residue_candidates_eq_singleton w hwbase q hwq d hd] at hwcandidate
  exact hcd ((Set.mem_singleton_iff.mp hvcandidate).symm.trans
    (Set.mem_singleton_iff.mp hwcandidate))

end Litt3.CartierAndSpin

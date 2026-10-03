import Solutions.Deformations.ElementaryWittQuadraticReduction
import Solutions.Deformations.ElementaryWittPolynomialInitial
import Solutions.Deformations.ElementaryWittAssociatedMultiplication

set_option maxHeartbeats 1200000

namespace Litt3.Deformations

open scoped WeightedRootPolynomialScalars

variable (N : ℕ) [Fact (0 < N)]
variable (k : Type*) [Field k] [Fact (Nat.Prime 5)] [CharP k 5] [PerfectRing k 5]

local instance : Nontrivial (TruncatedWittVector 5 N k) :=
  truncated_witt_nontrivial 5 N (Fact.out : 0 < N) k

theorem elementary_witt_associated_map_reindex (r d e : ℕ) (index : d = e)
    (x : AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5))
    (left : x ∈ elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d)
    (right : x ∈ elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r e) :
    elementaryWittAssociatedMap N k r d ⟨x, left⟩ =
      elementaryWittAssociatedMap N k r e ⟨x, right⟩ := by
  subst e
  rfl

/-- The full original additive operator has literally quadratic times
actual coefficient Frobenius as its constructed initial action. -/
theorem elementary_witt_operator_initial (r d : ℕ)
    (L : AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5) →+
      AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5))
    (q : MvPolynomial (Fin r) k) (reduction : ElementaryWittQuadraticReduction N k r L q)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d) :
    ∃ member : L x.val ∈ elementaryNormalWeightFiltration (TruncatedWittVector 5 N k)
        5 (by omega) r (d + 2),
      elementaryWittAssociatedMap N k r (d + 2) ⟨_, member⟩ =
        weightedRootTruncation k 5 N (Fact.out : 0 < N) r
          (weightedRootPolynomialEvaluation 5 Polynomial.X r (MvPolynomial.map Polynomial.C q)) *
          elementaryWittAssociatedMap N k r d (elementaryWittFrobeniusWeight N k r d x) := by
  let R := TruncatedWittVector 5 N k
  let Q := elementaryWittPolynomialLift N k r q
  have leading := elementary_witt_quadratic_reduction_leading N k r L q reduction d x.val x.property
  have qMember := elementary_witt_homogeneous_polynomial_lift_weight N k r 2 q reduction.2.1
  let a : elementaryNormalWeightFiltration R 5 (by omega) r 2 := ⟨Q, qMember⟩
  let y := elementaryWittFrobeniusWeight N k r d x
  have productMember : Q * elementaryWittFrobenius 5 N r k x.val ∈
      elementaryNormalWeightFiltration R 5 (by omega) r (d + 2) := by
    simpa only [show 2 + d = d + 2 by omega] using
      (elementaryWittWeightProduct N k r 2 d a y).property
  refine ⟨leading.1, ?_⟩
  have compare := (elementary_witt_associated_map_equal_iff N k r (d + 2)
    ⟨L x.val, leading.1⟩ ⟨Q * elementaryWittFrobenius 5 N r k x.val, productMember⟩).mpr
    (by simpa only [Nat.add_assoc] using leading.2)
  rw [compare]
  have multiply := elementary_witt_associated_map_multiplicative N k r 2 d a y
  have quadratic := elementary_witt_small_polynomial_initial N k r 2 (by omega)
    q reduction.2.1 qMember
  rw [quadratic] at multiply
  have reindex := elementary_witt_associated_map_reindex N k r (d + 2) (2 + d)
    (by omega) (Q * elementaryWittFrobenius 5 N r k x.val) productMember
    (elementaryWittWeightProduct N k r 2 d a y).property
  exact reindex.trans multiply

end Litt3.Deformations

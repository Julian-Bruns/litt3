import Solutions.Deformations.ElementaryPrimeWittReduction
import Solutions.Deformations.ElementaryPrimeWittPolynomialInitial
import Solutions.Deformations.ElementaryPrimeWittAssociatedMultiplication

import Solutions.Deformations.ElementaryPrimeWittFrobeniusWeight

set_option maxHeartbeats 1200000

namespace Litt3.Deformations

open scoped WeightedRootPolynomialScalars

variable (p N : ℕ) [Fact p.Prime] [Fact (0 < N)]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Nontrivial (TruncatedWittVector p N k) :=
  truncated_witt_nontrivial p N (Fact.out : 0 < N) k

theorem elementary_prime_witt_associated_map_reindex (r d e : ℕ) (index : d = e)
    (x : AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p))
    (left : x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r d)
    (right : x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r e) :
    elementaryPrimeWittAssociatedMap p N k r d ⟨x, left⟩ =
      elementaryPrimeWittAssociatedMap p N k r e ⟨x, right⟩ := by
  subst e
  rfl

/-- The full original additive operator has literally its principal polynomial times
actual coefficient Frobenius as its constructed initial action. -/
theorem elementary_prime_witt_operator_initial (r d a : ℕ) (degreeBound : a + 1 ≤ p - 1)
    (L : AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p) →+
      AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p))
    (q : MvPolynomial (Fin r) k) (reduction : ElementaryPrimeWittReduction p N k r a L q)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r d) :
    ∃ member : L x.val ∈ elementaryNormalWeightFiltration (TruncatedWittVector p N k)
        p (by have := (Fact.out : p.Prime).two_le; omega) r (d + a),
      elementaryPrimeWittAssociatedMap p N k r (d + a) ⟨_, member⟩ =
        weightedRootTruncation k p N (Fact.out : 0 < N) r
          (weightedRootPolynomialEvaluation p Polynomial.X r (MvPolynomial.map Polynomial.C q)) *
          elementaryPrimeWittAssociatedMap p N k r d (elementaryPrimeWittFrobeniusWeight p N k r d x) := by
  let R := TruncatedWittVector p N k
  let Q := elementaryPrimeWittPolynomialLift p N k r q
  have leading := elementary_prime_witt_reduction_leading p N k r a degreeBound L q reduction d x.val x.property
  have qMember := elementary_prime_witt_homogeneous_weight p N k r a q reduction.2.1
  let coefficientPoint : elementaryNormalWeightFiltration R p (by have := (Fact.out : p.Prime).two_le; omega) r a := ⟨Q, qMember⟩
  let y := elementaryPrimeWittFrobeniusWeight p N k r d x
  have productMember : Q * elementaryWittFrobenius p N r k x.val ∈
      elementaryNormalWeightFiltration R p (by have := (Fact.out : p.Prime).two_le; omega) r (d + a) := by
    simpa only [show a + d = d + a by omega] using
      (elementaryPrimeWittWeightProduct p N k r a d coefficientPoint y).property
  refine ⟨leading.1, ?_⟩
  have compare := (elementary_prime_witt_associated_map_equal_iff p N k r (d + a)
    ⟨L x.val, leading.1⟩ ⟨Q * elementaryWittFrobenius p N r k x.val, productMember⟩).mpr
    (by simpa only [Nat.add_assoc] using leading.2)
  rw [compare]
  have multiply := elementary_prime_witt_associated_map_multiplicative p N k r a d coefficientPoint y
  have quadratic := elementary_prime_witt_small_polynomial_initial p N k r a (by have := (Fact.out : p.Prime).two_le; omega)
    q reduction.2.1 qMember
  rw [quadratic] at multiply
  have reindex := elementary_prime_witt_associated_map_reindex p N k r (d + a) (a + d)
    (by have := (Fact.out : p.Prime).two_le; omega) (Q * elementaryWittFrobenius p N r k x.val) productMember
    (elementaryPrimeWittWeightProduct p N k r a d coefficientPoint y).property
  exact reindex.trans multiply

end Litt3.Deformations

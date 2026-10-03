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

/-- Genuine parameter injectivity transfers through the constructed
Witt grading and actual Frobenius to a single actual operator-kernel step. -/
theorem elementary_prime_witt_kernel_step (r d a : ℕ) (degreeBound : a + 1 ≤ p - 1)
    (L : AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p) →+
      AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p))
    (q : MvPolynomial (Fin r) k) (reduction : ElementaryPrimeWittReduction p N k r a L q)
    (parameterInjective : ∀ Z : weightedRootProduct (Polynomial k) p Polynomial.X r,
      Z ∈ weightedRootHomogeneousComponent k p (by have := (Fact.out : p.Prime).two_le; omega) r d →
      weightedRootTruncation k p N (Fact.out : 0 < N) r
        (weightedRootPolynomialEvaluation p Polynomial.X r (MvPolynomial.map Polynomial.C q) * Z) = 0 →
      Z = 0)
    (x : AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p))
    (member : x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r d)
    (kernel : L x = 0) :
    x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r (d + 1) := by
  let R := TruncatedWittVector p N k
  let Q := elementaryPrimeWittPolynomialLift p N k r q
  have qMember := elementary_prime_witt_homogeneous_weight p N k r a q reduction.2.1
  let coefficientPoint : elementaryNormalWeightFiltration R p (by have := (Fact.out : p.Prime).two_le; omega) r a := ⟨Q, qMember⟩
  let y : elementaryNormalWeightFiltration R p (by have := (Fact.out : p.Prime).two_le; omega) r d :=
    ⟨elementaryWittFrobenius p N r k x,
      elementary_prime_witt_frobenius_weight p N k r d x member⟩
  have error := (elementary_prime_witt_reduction_leading p N k r a degreeBound L q reduction d x member).2
  rw [kernel, zero_sub] at error
  have productHigher : Q * elementaryWittFrobenius p N r k x ∈
      elementaryNormalWeightFiltration R p (by have := (Fact.out : p.Prime).two_le; omega) r (a + d + 1) := by
    dsimp only [Q, R]
    have positive := (elementaryNormalWeightFiltration (TruncatedWittVector p N k)
      p (by have := (Fact.out : p.Prime).two_le; omega) r (d + (a + 1))).neg_mem error
    simp only [neg_neg] at positive
    rw [show d + (a + 1) = a + d + 1 by omega] at positive
    exact positive
  have productZero := (elementary_prime_witt_associated_map_kernel p N k r (a + d)
    (elementaryPrimeWittWeightProduct p N k r a d coefficientPoint y)).mpr productHigher
  rw [elementary_prime_witt_associated_map_multiplicative,
    elementary_prime_witt_small_polynomial_initial p N k r a (by have := (Fact.out : p.Prime).two_le; omega) q reduction.2.1 qMember] at productZero
  obtain ⟨Z, homogeneous, representation⟩ :=
    (elementary_prime_witt_associated_map_full_range p N k r d
      (elementaryPrimeWittAssociatedMap p N k r d y)).mp ⟨y, rfl⟩
  have vanish : weightedRootTruncation k p N (Fact.out : 0 < N) r
      (weightedRootPolynomialEvaluation p Polynomial.X r (MvPolynomial.map Polynomial.C q) * Z) = 0 := by
    rw [map_mul, representation]
    exact productZero
  have zZero := parameterInjective Z homogeneous vanish
  have yZero : elementaryPrimeWittAssociatedMap p N k r d y = 0 := by
    rw [← representation, zZero, map_zero]
  have next := (elementary_prime_witt_associated_map_kernel p N k r d y).mp yZero
  have inverse := elementary_prime_witt_inverse_frobenius_weight p N k r (d + 1)
    (elementaryWittFrobenius p N r k x) next
  simpa only [RingEquiv.symm_apply_apply] using inverse

end Litt3.Deformations

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

/-- Genuine parameter injectivity transfers through the constructed
Witt grading and actual Frobenius to a single actual operator-kernel step. -/
theorem elementary_witt_kernel_step (r d : ℕ)
    (L : AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5) →+
      AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5))
    (q : MvPolynomial (Fin r) k) (reduction : ElementaryWittQuadraticReduction N k r L q)
    (parameterInjective : ∀ Z : weightedRootProduct (Polynomial k) 5 Polynomial.X r,
      Z ∈ weightedRootHomogeneousComponent k 5 (by omega) r d →
      weightedRootTruncation k 5 N (Fact.out : 0 < N) r
        (weightedRootPolynomialEvaluation 5 Polynomial.X r (MvPolynomial.map Polynomial.C q) * Z) = 0 →
      Z = 0)
    (x : AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5))
    (member : x ∈ elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d)
    (kernel : L x = 0) :
    x ∈ elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r (d + 1) := by
  let R := TruncatedWittVector 5 N k
  let Q := elementaryWittPolynomialLift N k r q
  have qMember := elementary_witt_homogeneous_polynomial_lift_weight N k r 2 q reduction.2.1
  let a : elementaryNormalWeightFiltration R 5 (by omega) r 2 := ⟨Q, qMember⟩
  let y : elementaryNormalWeightFiltration R 5 (by omega) r d :=
    ⟨elementaryWittFrobenius 5 N r k x,
      elementary_witt_frobenius_normal_weight N k r d x member⟩
  have error := (elementary_witt_quadratic_reduction_leading N k r L q reduction d x member).2
  rw [kernel, zero_sub] at error
  have productHigher : Q * elementaryWittFrobenius 5 N r k x ∈
      elementaryNormalWeightFiltration R 5 (by omega) r (2 + d + 1) := by
    dsimp only [Q, R]
    have positive := (elementaryNormalWeightFiltration (TruncatedWittVector 5 N k)
      5 (by omega) r (d + 3)).neg_mem error
    simp only [neg_neg] at positive
    rw [show d + 3 = 2 + d + 1 by omega] at positive
    exact positive
  have productZero := (elementary_witt_associated_map_kernel N k r (2 + d)
    (elementaryWittWeightProduct N k r 2 d a y)).mpr productHigher
  rw [elementary_witt_associated_map_multiplicative,
    elementary_witt_small_polynomial_initial N k r 2 (by omega) q reduction.2.1 qMember] at productZero
  obtain ⟨Z, homogeneous, representation⟩ :=
    (elementary_witt_associated_map_full_range N k r d
      (elementaryWittAssociatedMap N k r d y)).mp ⟨y, rfl⟩
  have vanish : weightedRootTruncation k 5 N (Fact.out : 0 < N) r
      (weightedRootPolynomialEvaluation 5 Polynomial.X r (MvPolynomial.map Polynomial.C q) * Z) = 0 := by
    rw [map_mul, representation]
    exact productZero
  have zZero := parameterInjective Z homogeneous vanish
  have yZero : elementaryWittAssociatedMap N k r d y = 0 := by
    rw [← representation, zZero, map_zero]
  have next := (elementary_witt_associated_map_kernel N k r d y).mp yZero
  have inverse := elementary_witt_inverse_frobenius_normal_weight N k r (d + 1)
    (elementaryWittFrobenius 5 N r k x) next
  simpa only [RingEquiv.symm_apply_apply] using inverse

end Litt3.Deformations

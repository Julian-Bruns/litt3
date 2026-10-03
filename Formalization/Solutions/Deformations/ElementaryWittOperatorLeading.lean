import Solutions.Deformations.ElementaryWittOperatorCorrection
import Solutions.Deformations.ElementaryWittPolynomialLift
import Solutions.Deformations.ElementaryWittFrobeniusWeight

set_option maxHeartbeats 1000000

namespace Litt3.Deformations

open scoped BigOperators

variable (N : ℕ) [Fact (0 < N)]
variable (k : Type*) [Field k] [Fact (Nat.Prime 5)] [CharP k 5] [PerfectRing k 5]

local instance : Nontrivial (TruncatedWittVector 5 N k) :=
  truncated_witt_nontrivial 5 N (Fact.out : 0 < N) k

/-- The source's genuine mod-five polynomial reduction gives exactly
quadratic leading action and a higher actual error, for a merely
additive original deck-equivariant operator. -/
theorem elementary_witt_operator_quadratic_leading (r : ℕ)
    (L : AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5) →+
      AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5))
    (deck : ElementaryDeckEquivariant 5 r L)
    (q h : MvPolynomial (Fin r) k) (quadratic : q.IsHomogeneous 2)
    (higher : ∀ m, h.coeff m ≠ 0 → 3 ≤ ∑ i, m i)
    (reduction : ∀ x, AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod 5)
        (truncatedWittResidue 5 N (Fact.out : 0 < N) k) (L x) =
      (q + h).eval₂ (algebraMap k (AddMonoidAlgebra k (Fin r → ZMod 5)))
        (elementaryAugmentationParameter (R := k) 5 r) *
        groupCoefficientEquiv (G := Fin r → ZMod 5) (_root_.frobeniusEquiv k 5)
          (AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod 5)
            (truncatedWittResidue 5 N (Fact.out : 0 < N) k) x))
    (d : ℕ) (x : AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5))
    (member : x ∈ elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d) :
    L x ∈ elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r (d + 2) ∧
      L x - elementaryWittPolynomialLift N k r q * elementaryWittFrobenius 5 N r k x ∈
        elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r (d + 3) := by
  let R := TruncatedWittVector 5 N k
  let Q := elementaryWittPolynomialLift N k r q
  let H := elementaryWittPolynomialLift N k r h
  let D := elementaryWittOperatorCorrection N r k L (Q + H)
  have liftReduction : AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod 5)
      (truncatedWittResidue 5 N (Fact.out : 0 < N) k) (Q + H) =
    (q + h).eval₂ (algebraMap k (AddMonoidAlgebra k (Fin r → ZMod 5)))
      (elementaryAugmentationParameter (R := k) 5 r) := by
    rw [map_add, elementary_witt_polynomial_lift_reduction,
      elementary_witt_polynomial_lift_reduction, MvPolynomial.eval₂_add]
  have correction := elementary_witt_operator_correction_raises N k r L deck _ (Q + H)
    liftReduction reduction d x member
  have correctionHigher := elementary_normal_weight_antitone (R := R) 5 (by omega) r
    (show d + 3 ≤ d + 4 by omega) correction
  have frobeniusMember := elementary_witt_frobenius_normal_weight N k r d x member
  have qMember := elementary_witt_homogeneous_polynomial_lift_weight N k r 2 q quadratic
  have hMember := elementary_witt_polynomial_lift_weight N k r 3 h higher
  have qProduct := elementary_five_normal_weight_mul (R := R) r 2 d Q
    (elementaryWittFrobenius 5 N r k x) qMember frobeniusMember
  have hProduct := elementary_five_normal_weight_mul (R := R) r 3 d H
    (elementaryWittFrobenius 5 N r k x) hMember frobeniusMember
  have qIndex : 2 + d = d + 2 := by omega
  have hIndex : 3 + d = d + 3 := by omega
  rw [qIndex] at qProduct
  rw [hIndex] at hProduct
  have identity : L x - Q * elementaryWittFrobenius 5 N r k x =
      H * elementaryWittFrobenius 5 N r k x + D x := by
    change L x - Q * elementaryWittFrobenius 5 N r k x =
      H * elementaryWittFrobenius 5 N r k x +
        (L x - (Q + H) * elementaryWittFrobenius 5 N r k x)
    ring
  have tail : L x - Q * elementaryWittFrobenius 5 N r k x ∈
      elementaryNormalWeightFiltration R 5 (by omega) r (d + 3) := by
    rw [identity]
    exact Submodule.add_mem _ hProduct correctionHigher
  refine ⟨?_, tail⟩
  have tailLower := elementary_normal_weight_antitone (R := R) 5 (by omega) r
    (show d + 2 ≤ d + 3 by omega) tail
  have reconstruct : L x = Q * elementaryWittFrobenius 5 N r k x +
      (L x - Q * elementaryWittFrobenius 5 N r k x) := by abel
  rw [reconstruct]
  exact Submodule.add_mem _ qProduct tailLower

end Litt3.Deformations

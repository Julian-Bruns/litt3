import Definitions.Deformations.ElementaryWittOperatorLift
import Solutions.Deformations.GroupCoefficientFrobenius
import Solutions.Deformations.TruncatedWittResidue
import Solutions.Deformations.ElementaryDeckOperators
import Mathlib.RingTheory.MvPolynomial.Homogeneous
import Solutions.Deformations.ElementaryWeightedInitial

namespace Litt3.Deformations

open scoped BigOperators

variable (N : ℕ) [Fact (0 < N)]
variable (k : Type*) [Field k] [Fact (Nat.Prime 5)] [CharP k 5] [PerfectRing k 5]

local instance : Nontrivial (TruncatedWittVector 5 N k) :=
  truncated_witt_nontrivial 5 N (Fact.out : 0 < N) k

/-- The source's literal reduction hypothesis for a merely additive
operator. The higher polynomial is actual original-generator data;
no kernel, image, or graded conclusion is included. -/
def ElementaryWittQuadraticReduction (r : ℕ)
    (L : AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5) →+
      AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5))
    (q : MvPolynomial (Fin r) k) : Prop :=
  ElementaryDeckEquivariant 5 r L ∧ q.IsHomogeneous 2 ∧
    ∃ h : MvPolynomial (Fin r) k,
      (∀ m, h.coeff m ≠ 0 → 3 ≤ ∑ i, m i) ∧
      ∀ x, AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod 5)
          (truncatedWittResidue 5 N (Fact.out : 0 < N) k) (L x) =
        (q + h).eval₂ (algebraMap k (AddMonoidAlgebra k (Fin r → ZMod 5)))
          (elementaryAugmentationParameter (R := k) 5 r) *
          groupCoefficientEquiv (G := Fin r → ZMod 5) (_root_.frobeniusEquiv k 5)
            (AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod 5)
              (truncatedWittResidue 5 N (Fact.out : 0 < N) k) x)

end Litt3.Deformations

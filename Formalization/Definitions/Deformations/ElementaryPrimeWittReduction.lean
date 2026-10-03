import Definitions.Deformations.ElementaryPrimeWittOperator
import Solutions.Deformations.GroupCoefficientFrobenius
import Solutions.Deformations.TruncatedWittResidue
import Solutions.Deformations.ElementaryDeckOperators
import Mathlib.RingTheory.MvPolynomial.Homogeneous
import Solutions.Deformations.ElementaryWeightedInitial

namespace Litt3.Deformations

open scoped BigOperators

variable (p N : ℕ) [Fact p.Prime] [Fact (0 < N)]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Nontrivial (TruncatedWittVector p N k) :=
  truncated_witt_nontrivial p N (Fact.out : 0 < N) k

/-- Only the original source hypotheses of the additive operator are
recorded. No graded, kernel, image or detector conclusion is included. -/
def ElementaryPrimeWittReduction (r a : ℕ)
    (L : AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p) →+
      AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p))
    (q : MvPolynomial (Fin r) k) : Prop :=
  ElementaryDeckEquivariant p r L ∧ q.IsHomogeneous a ∧
    ∃ h : MvPolynomial (Fin r) k,
      (∀ m, h.coeff m ≠ 0 → a + 1 ≤ ∑ i, m i) ∧
      ∀ x, AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod p)
          (truncatedWittResidue p N (Fact.out : 0 < N) k) (L x) =
        (q + h).eval₂ (algebraMap k (AddMonoidAlgebra k (Fin r → ZMod p)))
          (elementaryAugmentationParameter (R := k) p r) *
          groupCoefficientEquiv (G := Fin r → ZMod p) (_root_.frobeniusEquiv k p)
            (AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod p)
              (truncatedWittResidue p N (Fact.out : 0 < N) k) x)

end Litt3.Deformations

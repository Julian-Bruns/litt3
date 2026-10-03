import Definitions.Deformations.ElementaryWittQuadraticReduction
import Solutions.Deformations.ElementaryWittOperatorLeading

namespace Litt3.Deformations

variable (N : ℕ) [Fact (0 < N)]
variable (k : Type*) [Field k] [Fact (Nat.Prime 5)] [CharP k 5] [PerfectRing k 5]

local instance : Nontrivial (TruncatedWittVector 5 N k) :=
  truncated_witt_nontrivial 5 N (Fact.out : 0 < N) k

theorem elementary_witt_quadratic_reduction_leading (r : ℕ)
    (L : AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5) →+
      AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5))
    (q : MvPolynomial (Fin r) k) (reduction : ElementaryWittQuadraticReduction N k r L q)
    (d : ℕ) (x : AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5))
    (member : x ∈ elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d) :
    L x ∈ elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r (d + 2) ∧
      L x - elementaryWittPolynomialLift N k r q * elementaryWittFrobenius 5 N r k x ∈
        elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r (d + 3) := by
  obtain ⟨deck, quadratic, h, higher, modulo⟩ := reduction
  exact elementary_witt_operator_quadratic_leading N k r L deck q h quadratic higher modulo d x member

end Litt3.Deformations

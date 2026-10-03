import Definitions.Deformations.ElementaryPrimeWittReduction
import Solutions.Deformations.ElementaryPrimeWittLeading

namespace Litt3.Deformations

variable (p N : ℕ) [Fact p.Prime] [Fact (0 < N)]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Nontrivial (TruncatedWittVector p N k) :=
  truncated_witt_nontrivial p N (Fact.out : 0 < N) k

theorem elementary_prime_witt_reduction_leading (r a : ℕ) (degreeBound : a + 1 ≤ p - 1)
    (L : AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p) →+
      AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p))
    (q : MvPolynomial (Fin r) k) (reduction : ElementaryPrimeWittReduction p N k r a L q)
    (d : ℕ) (x : AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p))
    (member : x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p N k) p
      (Fact.out : p.Prime).pos r d) :
    L x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p N k) p
      (Fact.out : p.Prime).pos r (d + a) ∧
      L x - elementaryPrimeWittPolynomialLift p N k r q * elementaryWittFrobenius p N r k x ∈
        elementaryNormalWeightFiltration (TruncatedWittVector p N k) p
          (Fact.out : p.Prime).pos r (d + a + 1) := by
  obtain ⟨deck, principal, h, higher, modulo⟩ := reduction
  exact elementary_prime_witt_principal_leading p N k r a degreeBound L deck q h
    principal higher modulo d x member

end Litt3.Deformations

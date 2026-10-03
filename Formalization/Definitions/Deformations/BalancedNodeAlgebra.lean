import Mathlib.RingTheory.MvPolynomial.Ideal
import Mathlib.RingTheory.Ideal.Quotient.Operations

namespace Litt3.Deformations

variable (R : Type*) [CommRing R]

/-- The literal balanced node relation ideal (x^Q,y^Q,xy). -/
noncomputable def balancedNodeIdeal (Q : ℕ) : Ideal (MvPolynomial (Fin 2) R) :=
  Ideal.span ((fun a : Fin 2 →₀ ℕ => MvPolynomial.monomial a (1 : R)) ''
    {Finsupp.single 0 Q, Finsupp.single 1 Q, Finsupp.single 0 1 + Finsupp.single 1 1})

abbrev BalancedNodeAlgebra (Q : ℕ) := MvPolynomial (Fin 2) R ⧸ balancedNodeIdeal R Q

/-- Precisely the original monomials removed by the three literal
balanced node relations. -/
def balancedNodeRemovedExponents (Q : ℕ) : Set (Fin 2 →₀ ℕ) :=
  {a | Q ≤ a 0 ∨ Q ≤ a 1 ∨ (1 ≤ a 0 ∧ 1 ≤ a 1)}

end Litt3.Deformations

import Definitions.CartierAndSpin.PolynomialContact
import Mathlib.Algebra.Polynomial.Roots

namespace Litt3.CartierAndSpin.Specifications

open Polynomial

variable {R : Type*} [CommRing R] [IsDomain R]

/-- Finite zero constraints plus two endpoint section orders force zero.
There is no denominator inversion and no separability assumption. -/
def PolynomialEndpointRigidity (H : R[X]) (s : Finset R) (N ezero einfinity : ℕ) : Prop :=
  (∀ z ∈ s, z ≠ 0) →
  (∀ z ∈ s, H.eval z = 0) →
  X ^ ezero ∣ H →
  polynomialSectionVanishesAtInfinity H N einfinity →
  N < s.card + ezero + einfinity → H = 0

end Litt3.CartierAndSpin.Specifications

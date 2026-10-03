import Solutions.CartierAndSpin.RestrictedPBasisConnection
import Solutions.CartierAndSpin.NormalizedPBasisDerivationComparison

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {R K : Type*} [CommRing R] [Field K] [Algebra R K]
  {p : ℕ} [Fact p.Prime] [CharP K p]

/-- The actual restricted connection identity is independent of the
constant ring: EVERY actual normalized derivation through the full
literal p-basis satisfies the formula. The derivation over the literal
pth powers is constructed and compared, rather than supplied. -/
theorem actual_normalized_derivation_restricted_connection_identity
    (b : PowerPBasis K p) (D : Derivation R K K)
    (hDt : D b.parameter = 1) (f a : K) :
    (scalarDerivationConnection D f)^[p] a = -(D^[p - 1] f + f ^ p) * a := by
  obtain ⟨D', hDt'⟩ := p_basis_normalized_derivation_exists b
  have hfun : (D : K → K) = (D' : K → K) :=
    funext (normalized_p_basis_derivations_apply_eq b D D' hDt hDt')
  have hL : (scalarDerivationConnection D f : K → K) =
      (pBasisLogarithmicConnection D' f : K → K) := by
    funext x
    change D x - f * x = D' x - f * x
    rw [normalized_p_basis_derivations_apply_eq b D D' hDt hDt' x]
  rw [hL, hfun]
  exact actual_p_basis_restricted_connection_identity b D' hDt' f a

/-- The ORIGINAL normalized derivation itself has zero pth iterate;
this is a conclusion, with no nilpotence premise. -/
theorem actual_normalized_derivation_prime_iterate_zero
    (b : PowerPBasis K p) (D : Derivation R K K)
    (hDt : D b.parameter = 1) (a : K) : D^[p] a = 0 := by
  have hLzero : (scalarDerivationConnection D (0 : K) : K → K) = (D : K → K) := by
    funext x
    change D x - 0 * x = D x
    simp
  have h := actual_normalized_derivation_restricted_connection_identity b D hDt 0 a
  rw [hLzero, iterate_map_zero D (p - 1), zero_pow (Fact.out : p.Prime).ne_zero,
    add_zero, neg_zero, zero_mul] at h
  exact h

end Litt3.CartierAndSpin

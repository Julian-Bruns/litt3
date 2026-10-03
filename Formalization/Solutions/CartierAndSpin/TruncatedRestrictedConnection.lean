import Solutions.CartierAndSpin.TruncatedODEGauge
import Solutions.CartierAndSpin.TruncatedTopConnection
import Solutions.CartierAndSpin.ConnectionUnitGauge

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K] {p : ℕ} [Fact p.Prime] [CharP K p]

/-- The actual pth connection iterate in the ENTIRE truncated algebra
is multiplication by its literal top obstruction. The proof constructs
the genuine unit gauge and uses the symbolic nilpotent derivative cycle.
No p-curvature, ODE solution or matrix singularity is a premise. -/
theorem truncated_connection_prime_iterate (F : K[X])
    (a : TruncatedPolynomialAlgebra K p) :
    (scalarDerivationConnection (truncatedPolynomialDerivation K p)
      (AdjoinRoot.mk ((X : K[X]) ^ p) F))^[p] a =
      a * algebraMap K (TruncatedPolynomialAlgebra K p)
        (F.coeff (p - 1) - (F.coeff 0) ^ p) := by
  letI : Nontrivial (TruncatedPolynomialAlgebra K p) :=
    AdjoinRoot.nontrivial ((X : K[X]) ^ p) (by
      rw [degree_X_pow]
      exact_mod_cast (Fact.out : p.Prime).ne_zero)
  letI : CharP (TruncatedPolynomialAlgebra K p) p :=
    charP_of_injective_algebraMap
      (algebraMap K (TruncatedPolynomialAlgebra K p)).injective p
  let c := F.coeff (p - 1) - (F.coeff 0) ^ p
  let g := algebraMap K (TruncatedPolynomialAlgebra K p) c *
    (AdjoinRoot.root ((X : K[X]) ^ p)) ^ (p - 1)
  let D := truncatedPolynomialDerivation K p
  let L := scalarDerivationConnection D (AdjoinRoot.mk ((X : K[X]) ^ p) F)
  have hD : ∀ x : TruncatedPolynomialAlgebra K p, D^[p] x = 0 :=
    truncated_polynomial_derivation_characteristic_iterate_zero (Fact.out : p.Prime).pos
  obtain ⟨u, hu⟩ := truncated_connection_top_gauge F
  have hleft := scalar_connection_prime_iterate_scalar D
    (AdjoinRoot.mk ((X : K[X]) ^ p) F) hD (u : TruncatedPolynomialAlgebra K p)
  have hgauge := scalar_connection_unit_gauge_iterate D
    (AdjoinRoot.mk ((X : K[X]) ^ p) F) g u hu 1 p
  rw [mul_one] at hgauge
  change L^[p] (u : TruncatedPolynomialAlgebra K p) =
    (u : TruncatedPolynomialAlgebra K p) *
      (scalarDerivationConnection D g)^[p] 1 at hgauge
  rw [truncated_top_connection_prime_iterate c, one_mul] at hgauge
  have hcoeff : L^[p] 1 = algebraMap K (TruncatedPolynomialAlgebra K p) c :=
    (u.mul_right_inj).mp (hleft.symm.trans hgauge)
  rw [scalar_connection_prime_iterate_scalar D _ hD a, hcoeff]

end Litt3.CartierAndSpin

import Solutions.CartierAndSpin.WeylCharacteristicDimension
import Solutions.CartierAndSpin.ConnectionWeylRelation
import Solutions.CartierAndSpin.RestrictedConnectionCharpoly

namespace Litt3.CartierAndSpin

open Polynomial Litt3.SharedTensors

variable {K : Type*} [Field K] {p : ℕ} [Fact p.Prime] [CharP K p]

/-- The genuine original normalized connection has its full
characteristic polynomial as minimal polynomial. Its degree p is
derived from the actual basis and Weyl relation; no cyclic-vector,
Jordan or companion-matrix assumption is present. -/
theorem actual_normalized_connection_minpoly
    (b : PowerPBasis K p) (D : Derivation (frobeniusSubfield K p) K K)
    (hDt : D b.parameter = 1) (f : K) :
    minpoly (frobeniusSubfield K p) (scalarDerivationConnection D f) =
      (X : (frobeniusSubfield K p)[X]) ^ p + C (actualConnectionCurvature b D hDt f) := by
  letI : Module.Finite (frobeniusSubfield K p) K := Module.Finite.of_basis b.basis
  rw [characteristic_dimension_weyl_minpoly_eq_charpoly
    (scalarDerivationConnection D f)
    (LinearMap.mulLeft (frobeniusSubfield K p) b.parameter)
    (Fact.out : p.Prime).pos (actual_power_p_basis_field_finrank b)
    (scalar_connection_weyl_relation D b.parameter f hDt)]
  exact actual_normalized_connection_charpoly b D hDt f

/-- Exact full minimal-polynomial degree, uniformly in every prime. -/
theorem actual_normalized_connection_minpoly_degree
    (b : PowerPBasis K p) (D : Derivation (frobeniusSubfield K p) K K)
    (hDt : D b.parameter = 1) (f : K) :
    (minpoly (frobeniusSubfield K p) (scalarDerivationConnection D f)).natDegree = p := by
  rw [actual_normalized_connection_minpoly b D hDt f, Polynomial.natDegree_X_pow_add_C]

end Litt3.CartierAndSpin

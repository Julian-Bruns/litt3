import Solutions.CartierAndSpin.PrimePowerScalarCharpoly
import Solutions.CartierAndSpin.RestrictedConnectionKernelParameters
import Solutions.CartierAndSpin.RestrictedCurvatureScalars
import Mathlib.LinearAlgebra.Trace

namespace Litt3.CartierAndSpin

open Polynomial Litt3.SharedTensors

variable {K : Type*} [Field K] {p : ℕ} [Fact p.Prime] [CharP K p]

/-- The literal curvature, retained as an element of the ACTUAL
pth-power subfield. Membership is derived, not a scalar-field premise. -/
noncomputable def actualConnectionCurvature
    (b : PowerPBasis K p) (D : Derivation (frobeniusSubfield K p) K K)
    (hDt : D b.parameter = 1) (f : K) : frobeniusSubfield K p :=
  ⟨D^[p - 1] f + f ^ p, by
    change ∃ r : K, frobenius K p r = D^[p - 1] f + f ^ p
    exact actual_normalized_curvature_is_pth_power b D hDt f⟩

theorem actual_connection_curvature_coe
    (b : PowerPBasis K p) (D : Derivation (frobeniusSubfield K p) K K)
    (hDt : D b.parameter = 1) (f : K) :
    (actualConnectionCurvature b D hDt f : K) = D^[p - 1] f + f ^ p := rfl

/-- Exact original characteristic polynomial over the literal pth
powers. The field may be imperfect; every dimension, scalar membership
and restricted operator identity is derived from the actual basis. -/
theorem actual_normalized_connection_charpoly
    (b : PowerPBasis K p) (D : Derivation (frobeniusSubfield K p) K K)
    (hDt : D b.parameter = 1) (f : K) :
    letI : Module.Finite (frobeniusSubfield K p) K := Module.Finite.of_basis b.basis
    (scalarDerivationConnection D f).charpoly =
      (X : (frobeniusSubfield K p)[X]) ^ p + C (actualConnectionCurvature b D hDt f) := by
  letI : Module.Finite (frobeniusSubfield K p) K := Module.Finite.of_basis b.basis
  have hT : (scalarDerivationConnection D f) ^ p =
      algebraMap (frobeniusSubfield K p)
        (Module.End (frobeniusSubfield K p) K) (-actualConnectionCurvature b D hDt f) := by
    ext a
    rw [Module.End.pow_apply,
      actual_normalized_derivation_restricted_connection_identity b D hDt f]
    rfl
  have h := prime_dimension_scalar_power_charpoly (scalarDerivationConnection D f)
    (-actualConnectionCurvature b D hDt f) (actual_power_p_basis_field_finrank b) hT
  simpa only [map_neg, sub_neg_eq_add] using h

/-- The exact original connection determinant is negative literal
curvature over Kp, uniformly including characteristic two. -/
theorem actual_normalized_connection_det
    (b : PowerPBasis K p) (D : Derivation (frobeniusSubfield K p) K K)
    (hDt : D b.parameter = 1) (f : K) :
    LinearMap.det (scalarDerivationConnection D f) =
      -actualConnectionCurvature b D hDt f := by
  letI : Module.Finite (frobeniusSubfield K p) K := Module.Finite.of_basis b.basis
  rw [LinearMap.det_eq_sign_charpoly_coeff,
    actual_power_p_basis_field_finrank b,
    actual_normalized_connection_charpoly b D hDt f]
  have hp : p ≠ 0 := (Fact.out : p.Prime).ne_zero
  simp [Ne.symm hp, neg_one_pow_char]

/-- The actual Kp-linear connection has trace zero in every prime
characteristic. No sampled matrix or prime-specific enumeration is
used; the literal pure-power characteristic polynomial suffices. -/
theorem actual_normalized_connection_trace
    (b : PowerPBasis K p) (D : Derivation (frobeniusSubfield K p) K K)
    (hDt : D b.parameter = 1) (f : K) :
    LinearMap.trace (frobeniusSubfield K p) K (scalarDerivationConnection D f) = 0 := by
  letI : Module.Finite (frobeniusSubfield K p) K := Module.Finite.of_basis b.basis
  letI : Nonempty (Fin p) := ⟨⟨0, (Fact.out : p.Prime).pos⟩⟩
  rw [LinearMap.trace_eq_matrix_trace (frobeniusSubfield K p) b.basis,
    Matrix.trace_eq_neg_charpoly_coeff, LinearMap.charpoly_toMatrix,
    Fintype.card_fin, actual_normalized_connection_charpoly b D hDt f]
  have hp : 2 ≤ p := (Fact.out : p.Prime).two_le
  have hne : p - 1 ≠ p := by omega
  have hpos : p - 1 ≠ 0 := by omega
  simp [Polynomial.coeff_C, hne, hpos]

end Litt3.CartierAndSpin

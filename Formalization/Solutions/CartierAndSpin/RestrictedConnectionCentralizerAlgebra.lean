import Solutions.CartierAndSpin.PolynomialValueAlgebras
import Solutions.CartierAndSpin.RestrictedConnectionCentralizers

namespace Litt3.CartierAndSpin

open Polynomial Module Litt3.SharedTensors

variable {K : Type*} [Field K] {p : ℕ} [Fact p.Prime] [CharP K p]

/-- The ENTIRE actual Kp-linear connection commutant is the literal degree-p
curvature quotient algebra, with no field/reducedness premise. The
full minpoly and cyclicity are derived from the actual p-basis. -/
noncomputable def actualConnectionCentralizerAlgebraEquiv
    (b : PowerPBasis K p) (D : Derivation (frobeniusSubfield K p) K K)
    (hDt : D b.parameter = 1) (f : K) :
    AdjoinRoot ((X : (frobeniusSubfield K p)[X]) ^ p +
      C (actualConnectionCurvature b D hDt f)) ≃ₐ[frobeniusSubfield K p]
      Subalgebra.centralizer (frobeniusSubfield K p)
        ({scalarDerivationConnection D f} : Set (Module.End (frobeniusSubfield K p) K)) :=
  (AdjoinRoot.algEquivOfEq (frobeniusSubfield K p) _ _
    (actual_normalized_connection_minpoly b D hDt f).symm).trans
      ((actualPolynomialValueAlgebraEquiv (K := frobeniusSubfield K p)
        (scalarDerivationConnection D f)).trans
        (Subalgebra.equivOfEq _ _ (actual_normalized_connection_centralizer b D hDt f).symm))

/-- The literal adjoined root maps to the SAME ORIGINAL connection. -/
theorem actual_connection_centralizer_algebra_equiv_root
    (b : PowerPBasis K p) (D : Derivation (frobeniusSubfield K p) K K)
    (hDt : D b.parameter = 1) (f : K) :
    (actualConnectionCentralizerAlgebraEquiv b D hDt f
      (AdjoinRoot.root ((X : (frobeniusSubfield K p)[X]) ^ p +
        C (actualConnectionCurvature b D hDt f)))).val =
      scalarDerivationConnection D f := by
  unfold actualConnectionCentralizerAlgebraEquiv
  rw [AlgEquiv.trans_apply, AdjoinRoot.algEquivOfEq_root, AlgEquiv.trans_apply]
  change (actualPolynomialValueAlgebraEquiv (scalarDerivationConnection D f)
    (AdjoinRoot.mk _ X)).val = _
  rw [actual_polynomial_value_algebra_equiv_mk, Polynomial.aeval_X]

/-- Every ORIGINAL polynomial class maps to its literal operator value,
not just to a noncanonical isomorphic algebra. -/
theorem actual_connection_centralizer_algebra_equiv_mk
    (b : PowerPBasis K p) (D : Derivation (frobeniusSubfield K p) K K)
    (hDt : D b.parameter = 1) (f : K) (P : (frobeniusSubfield K p)[X]) :
    (actualConnectionCentralizerAlgebraEquiv b D hDt f
      (AdjoinRoot.mk ((X : (frobeniusSubfield K p)[X]) ^ p +
        C (actualConnectionCurvature b D hDt f)) P)).val =
      aeval (scalarDerivationConnection D f) P := by
  let e := actualConnectionCentralizerAlgebraEquiv b D hDt f
  let map := (Subalgebra.val _).comp e.toAlgHom
  have hroot : map (AdjoinRoot.root ((X : (frobeniusSubfield K p)[X]) ^ p +
      C (actualConnectionCurvature b D hDt f))) = scalarDerivationConnection D f :=
    actual_connection_centralizer_algebra_equiv_root b D hDt f
  change map (AdjoinRoot.mk _ P) = _
  rw [← AdjoinRoot.aeval_eq, ← Polynomial.aeval_algHom_apply, hroot]

/-- The whole actual commutant has dimension p, derived from the
literal quotient rather than a supplied coordinate count. -/
theorem actual_normalized_connection_centralizer_finrank
    (b : PowerPBasis K p) (D : Derivation (frobeniusSubfield K p) K K)
    (hDt : D b.parameter = 1) (f : K) :
    Module.finrank (frobeniusSubfield K p)
      (Subalgebra.centralizer (frobeniusSubfield K p)
        ({scalarDerivationConnection D f} : Set (Module.End (frobeniusSubfield K p) K))) = p := by
  rw [← (actualConnectionCentralizerAlgebraEquiv b D hDt f).toLinearEquiv.finrank_eq]
  change Module.finrank (frobeniusSubfield K p)
    ((frobeniusSubfield K p)[X] ⧸ Ideal.span
      {((X : (frobeniusSubfield K p)[X]) ^ p + C (actualConnectionCurvature b D hDt f))}) = p
  rw [finrank_quotient_span_eq_natDegree, Polynomial.natDegree_X_pow_add_C]

end Litt3.CartierAndSpin

import Solutions.CartierAndSpin.TruncatedRestrictedConnection
import Solutions.SharedTensors.TaylorPBasisConnection

namespace Litt3.CartierAndSpin

open Polynomial
open Litt3.SharedTensors

variable {K : Type*} [Field K] {p : ℕ} [Fact p.Prime] [CharP K p]

/-- The actual evaluation at epsilon=0 on the complete literal quotient. -/
noncomputable def truncatedPolynomialConstant : TruncatedPolynomialAlgebra K p →ₐ[K] K :=
  AdjoinRoot.liftHom ((X : K[X]) ^ p) 0 (by simp [(Fact.out : p.Prime).ne_zero])

theorem truncated_polynomial_constant_mk (P : K[X]) :
    truncatedPolynomialConstant (p := p)
      (AdjoinRoot.mk ((X : K[X]) ^ p) P) = P.coeff 0 := by
  change aeval (0 : K) P = P.coeff 0
  simp [← Polynomial.coeff_zero_eq_eval_zero]

theorem p_basis_taylor_constant (b : PowerPBasis K p) (a : K) :
    truncatedPolynomialConstant (p := p) (pBasisTaylorHom b a) = a := by
  rw [pBasisTaylorHom_eq_polynomial, truncated_polynomial_constant_mk,
    pBasisTaylorPolynomial_constant]

theorem p_basis_taylor_derivation_iterate (b : PowerPBasis K p)
    (D : Derivation (frobeniusSubfield K p) K K) (hDt : D b.parameter = 1)
    (a : K) (n : ℕ) :
    (truncatedPolynomialDerivation K p)^[n] (pBasisTaylorHom b a) =
      pBasisTaylorHom b (D^[n] a) := by
  induction n with
  | zero => rfl
  | succ n ih =>
    rw [Function.iterate_succ_apply', ih, pBasisTaylorHom_derivative b D hDt,
      Function.iterate_succ_apply']

/-- The exact top Taylor coefficient is minus the (p-1)st ORIGINAL
normalized derivative, over any prime-characteristic field. -/
theorem p_basis_taylor_top_eq_neg_derivative (b : PowerPBasis K p)
    (D : Derivation (frobeniusSubfield K p) K K) (hDt : D b.parameter = 1) (f : K) :
    (pBasisTaylorPolynomial b f).coeff (p - 1) = -(D^[p - 1] f) := by
  have h := p_basis_taylor_derivation_iterate b D hDt f (p - 1)
  rw [pBasisTaylorHom_eq_polynomial, truncated_polynomial_derivation_iterate_mk] at h
  have hc := congrArg (truncatedPolynomialConstant (p := p)) h
  rw [truncated_polynomial_constant_mk, p_basis_taylor_constant,
    Polynomial.coeff_iterate_derivative] at hc
  have hwilson : ((p - 1).factorial : K) = -1 := by
    have hw := congrArg (ZMod.castHom (dvd_refl p) K) (ZMod.wilsons_lemma p)
    simpa only [map_natCast, map_neg, map_one] using hw
  simp only [Nat.zero_add, Nat.descFactorial_self, nsmul_eq_mul, hwilson,
    neg_one_mul] at hc
  exact neg_eq_iff_eq_neg.mp hc

theorem p_basis_taylor_connection_iterate (b : PowerPBasis K p)
    (D : Derivation (frobeniusSubfield K p) K K) (hDt : D b.parameter = 1)
    (f a : K) (n : ℕ) :
    pBasisTaylorHom b ((pBasisLogarithmicConnection D f)^[n] a) =
      (scalarDerivationConnection (truncatedPolynomialDerivation K p)
        (pBasisTaylorHom b f))^[n] (pBasisTaylorHom b a) := by
  induction n with
  | zero => rfl
  | succ n ih =>
    rw [Function.iterate_succ_apply', Function.iterate_succ_apply']
    change pBasisTaylorHom b
        (D ((pBasisLogarithmicConnection D f)^[n] a) -
          f * (pBasisLogarithmicConnection D f)^[n] a) = _
    rw [map_sub, map_mul, ← pBasisTaylorHom_derivative b D hDt, ih]
    rfl

/-- The full restricted connection formula on an ACTUAL arbitrary
single-p-basis field and its ORIGINAL normalized derivation:
(D-f)^p(a)=-(D^(p-1)f+f^p)*a. Nothing about p-curvature, a solution,
perfectness of K, finite generation, or matrix singularity is assumed.
The complete symbolic Taylor quotient calculation descends through its
actual constant evaluation, which is a left inverse to the Taylor map. -/
theorem actual_p_basis_restricted_connection_identity (b : PowerPBasis K p)
    (D : Derivation (frobeniusSubfield K p) K K) (hDt : D b.parameter = 1)
    (f a : K) :
    (pBasisLogarithmicConnection D f)^[p] a = -(D^[p - 1] f + f ^ p) * a := by
  have h := p_basis_taylor_connection_iterate b D hDt f a p
  rw [pBasisTaylorHom_eq_polynomial b f, truncated_connection_prime_iterate] at h
  have hc := congrArg (truncatedPolynomialConstant (p := p)) h
  rw [p_basis_taylor_constant, map_mul, p_basis_taylor_constant,
    AlgHom.commutes, pBasisTaylorPolynomial_constant,
    p_basis_taylor_top_eq_neg_derivative b D hDt] at hc
  simp only [Algebra.algebraMap_self_apply] at hc
  linear_combination hc

end Litt3.CartierAndSpin

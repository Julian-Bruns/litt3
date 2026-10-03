import Solutions.SharedTensors.TaylorPBasisAlgebra
import Solutions.CartierAndSpin.TruncatedLogarithmicODE
import Mathlib.RingTheory.Flat.Basic

namespace Litt3.SharedTensors

open Polynomial Module TensorProduct
open Litt3.CartierAndSpin

variable {K : Type*} [Field K] {p : ℕ} [Fact p.Prime] [CharP K p]

theorem pBasisTaylorHom_eq_polynomial (b : PowerPBasis K p) (f : K) :
    pBasisTaylorHom b f =
      AdjoinRoot.mk ((X : K[X]) ^ p) (pBasisTaylorPolynomial b f) := by
  classical
  conv_lhs => rw [← b.basis.sum_repr f]
  simp only [map_sum, map_smul, b.basis_eq_power, map_pow,
    pBasisTaylorHom_parameter]
  rw [pBasisTaylorPolynomial, map_sum]
  apply Finset.sum_congr rfl
  intro i _
  rw [map_mul, map_pow, map_add, AdjoinRoot.mk_X, AdjoinRoot.mk_C]
  rw [Algebra.smul_def, AdjoinRoot.mk_C]
  change algebraMap (frobeniusSubfield K p) (TruncatedPolynomialAlgebra K p)
      (b.basis.repr f i) * pBasisTaylorParameter b ^ i.val =
    algebraMap K (TruncatedPolynomialAlgebra K p) (b.basis.repr f i : K) *
      (AdjoinRoot.root ((X : K[X]) ^ p) +
        algebraMap K (TruncatedPolynomialAlgebra K p) b.parameter) ^ i.val
  rw [IsScalarTower.algebraMap_apply (frobeniusSubfield K p) K
    (TruncatedPolynomialAlgebra K p)]
  change algebraMap K (TruncatedPolynomialAlgebra K p) (b.basis.repr f i : K) *
      pBasisTaylorParameter b ^ i.val = _
  simp only [pBasisTaylorParameter, add_comm]

theorem pBasisTaylorParameter_derivative (b : PowerPBasis K p) :
    truncatedPolynomialDerivation K p (pBasisTaylorParameter b) = 1 := by
  rw [pBasisTaylorParameter, map_add]
  have hc := (truncatedPolynomialDerivation K p).map_algebraMap b.parameter
  rw [hc, zero_add, ← AdjoinRoot.mk_X, truncated_polynomial_derivation_mk]
  simp

/-- The actual Taylor algebra map intertwines the ORIGINAL normalized
p-basis derivation with the entire literal quotient derivative. -/
theorem pBasisTaylorHom_derivative (b : PowerPBasis K p)
    (D : Derivation (frobeniusSubfield K p) K K)
    (hDt : D b.parameter = 1) (a : K) :
    truncatedPolynomialDerivation K p (pBasisTaylorHom b a) =
      pBasisTaylorHom b (D a) := by
  obtain ⟨P, rfl⟩ := b.toPowerBasis.exists_eq_aeval' a
  have hD := D.map_aeval P b.parameter
  rw [hDt] at hD
  have hA := ((truncatedPolynomialDerivation K p).restrictScalars
    (frobeniusSubfield K p)).map_aeval P (pBasisTaylorParameter b)
  simp only [Derivation.restrictScalars_apply] at hA
  rw [pBasisTaylorParameter_derivative] at hA
  change truncatedPolynomialDerivation K p
      (pBasisTaylorHom b (aeval b.parameter P)) =
    pBasisTaylorHom b (D (aeval b.parameter P))
  rw [hD]
  simp only [smul_eq_mul, mul_one]
  rw [← Polynomial.aeval_algHom_apply (pBasisTaylorHom b) b.parameter P,
    ← Polynomial.aeval_algHom_apply (pBasisTaylorHom b) b.parameter P.derivative,
    pBasisTaylorHom_parameter]
  simpa only [smul_eq_mul, mul_one] using hA

/-- The original connection is a genuine linear operator over the
literal field of p-th powers. -/
noncomputable def pBasisLogarithmicConnection
    (D : Derivation (frobeniusSubfield K p) K K) (f : K) :
    K →ₗ[frobeniusSubfield K p] K :=
  D.toLinearMap - LinearMap.mulLeft (frobeniusSubfield K p) f

theorem pBasisTaylorTensorHom_connection (b : PowerPBasis K p)
    (D : Derivation (frobeniusSubfield K p) K K)
    (hDt : D b.parameter = 1) (f : K)
    (z : K ⊗[frobeniusSubfield K p] K) :
    pBasisTaylorTensorHom b ((pBasisLogarithmicConnection D f).baseChange K z) =
      truncatedPolynomialDerivation K p (pBasisTaylorTensorHom b z) -
        pBasisTaylorHom b f * pBasisTaylorTensorHom b z := by
  induction z using TensorProduct.induction_on with
  | zero => simp
  | add a c ha hc =>
    simp only [map_add, mul_add]
    rw [ha, hc]
    abel
  | tmul a c =>
    rw [LinearMap.baseChange_tmul]
    change pBasisTaylorTensorHom b (a ⊗ₜ (D c - f * c)) = _
    rw [pBasisTaylorTensorHom_tmul, map_sub, map_mul,
      pBasisTaylorTensorHom_tmul, Derivation.leibniz,
      (truncatedPolynomialDerivation K p).map_algebraMap,
      pBasisTaylorHom_derivative b D hDt]
    simp only [smul_eq_mul, zero_mul, add_zero]
    ring

/-- A genuine solution in the entire literal truncated algebra forces a
nonzero kernel in the ORIGINAL function field. Descent uses the actual
Taylor isomorphism and flatness of field extension, with no supplied
matrix singularity or p-curvature hypothesis. -/
theorem descended_connection_kernel (b : PowerPBasis K p)
    (D : Derivation (frobeniusSubfield K p) K K)
    (hDt : D b.parameter = 1) (f : K)
    (hfixed : rationalCartierCoefficient K p b f = f) :
    ∃ u : K, u ≠ 0 ∧ D u = f * u := by
  classical
  letI : Nontrivial (TruncatedPolynomialAlgebra K p) :=
    AdjoinRoot.nontrivial ((X : K[X]) ^ p) (by
      rw [degree_X_pow]
      exact_mod_cast (Fact.out : p.Prime).ne_zero)
  obtain ⟨U, hU⟩ := truncated_logarithmic_ode_solution (pBasisTaylorPolynomial b f)
    ((pBasisTaylorPolynomial_logarithmic_obstruction_iff b f).mpr hfixed)
  rw [← pBasisTaylorHom_eq_polynomial] at hU
  by_contra hnone
  have hL : Function.Injective (pBasisLogarithmicConnection D f) := by
    intro a c hac
    have hker : pBasisLogarithmicConnection D f (a - c) = 0 := by
      rw [map_sub, hac, sub_self]
    have heq : D (a - c) = f * (a - c) := sub_eq_zero.mp hker
    by_contra hane
    exact hnone ⟨a - c, sub_ne_zero.mpr hane, heq⟩
  have hbase : Function.Injective ((pBasisLogarithmicConnection D f).baseChange K) :=
    Module.Flat.lTensor_preserves_injective_linearMap _ hL
  let e := pBasisTaylorTensorEquiv b
  have hz : (pBasisLogarithmicConnection D f).baseChange K (e.symm U.val) = 0 := by
    apply (pBasisTaylorTensorHom_bijective b).1
    rw [map_zero, pBasisTaylorTensorHom_connection b D hDt]
    change truncatedPolynomialDerivation K p (e (e.symm U.val)) -
      pBasisTaylorHom b f * e (e.symm U.val) = 0
    rw [e.apply_symm_apply, hU, sub_self]
  have hzero : e.symm U.val = 0 := hbase (hz.trans (map_zero _).symm)
  have hzeroU : U.val = 0 := by
    simpa using congrArg e hzero
  exact U.ne_zero hzeroU

end Litt3.SharedTensors

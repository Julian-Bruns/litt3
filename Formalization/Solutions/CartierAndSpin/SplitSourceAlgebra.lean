import Definitions.CartierAndSpin.SplitSourceAlgebra
import Solutions.CartierAndSpin.SplitResidues
import Mathlib.Algebra.Polynomial.RingDivision
import Mathlib.RingTheory.Coprime.Lemmas
import Mathlib.RingTheory.Trace.Basic
import Mathlib.Tactic

/-!
# The actual split source algebra and its trace

Evaluation identifies the quotient by the complete simple-root polynomial
with the product of its root fields. Lagrange interpolation proves
surjectivity; coprime linear factors prove the exact kernel. This explicitly
retains disconnected source algebras.
-/

namespace Litt3.CartierAndSpin

open Polynomial Finset Module

variable {K ι : Type*} [Field K] [Fintype ι]

omit [Fintype ι] in
theorem splitPolynomialEvaluation_apply (node : ι → K) (P : K[X]) (i : ι) :
    splitPolynomialEvaluation node P i = P.eval (node i) := by
  simp [splitPolynomialEvaluation, Polynomial.aeval_def]

theorem splitPolynomialEvaluation_surjective (node : ι → K)
    (hinj : Function.Injective node) : Function.Surjective (splitPolynomialEvaluation node) := by
  classical
  intro values
  refine ⟨Lagrange.interpolate univ node values, ?_⟩
  funext i
  rw [splitPolynomialEvaluation_apply]
  exact Lagrange.eval_interpolate_at_node values hinj.injOn (mem_univ i)

theorem splitPolynomialEvaluation_kernel (node : ι → K) (hinj : Function.Injective node) :
    RingHom.ker (splitPolynomialEvaluation node).toRingHom =
      Ideal.span ({Lagrange.nodal univ node} : Set K[X]) := by
  classical
  ext P
  rw [Ideal.mem_span_singleton]
  constructor
  · intro hzero
    have hnode (i : ι) : P.eval (node i) = 0 := by
      have h := congrFun hzero i
      simpa only [splitPolynomialEvaluation_apply, Pi.zero_apply] using h
    unfold Lagrange.nodal
    apply Finset.prod_dvd_of_coprime
    · intro i hi j hj hij
      exact Polynomial.pairwise_coprime_X_sub_C hinj hij
    · intro i hi
      exact Polynomial.dvd_iff_isRoot.mpr (hnode i)
  · intro hdivides
    change splitPolynomialEvaluation node P = 0
    funext i
    rw [splitPolynomialEvaluation_apply]
    exact Polynomial.eval_eq_zero_of_dvd_of_eval_eq_zero hdivides
      (Lagrange.eval_nodal_at_node (mem_univ i))

/-- An actual algebra equivalence, not an assumed splitting isomorphism. -/
noncomputable def splitPolynomialQuotientEquiv (node : ι → K)
    (hinj : Function.Injective node) :
    (K[X] ⧸ Ideal.span ({Lagrange.nodal univ node} : Set K[X])) ≃ₐ[K] (ι → K) :=
  (Ideal.quotientEquivAlgOfEq K (splitPolynomialEvaluation_kernel node hinj).symm).trans
    (Ideal.quotientKerAlgEquivOfSurjective (splitPolynomialEvaluation_surjective node hinj))

theorem splitPolynomialQuotientEquiv_mk (node : ι → K)
    (hinj : Function.Injective node) (P : K[X]) (i : ι) :
    splitPolynomialQuotientEquiv node hinj (Ideal.Quotient.mk _ P) i = P.eval (node i) := by
  rw [splitPolynomialQuotientEquiv, AlgEquiv.trans_apply,
    Ideal.quotientEquivAlgOfEq_mk]
  exact (congrFun (Ideal.quotientKerAlgEquivOfSurjective_mk
    (f := splitPolynomialEvaluation node)
    (splitPolynomialEvaluation_surjective node hinj) P) i).trans
      (splitPolynomialEvaluation_apply node P i)

theorem split_product_algebra_trace (value : ι → K) :
    Algebra.trace K (ι → K) value = ∑ i, value i := by
  classical
  rw [Algebra.trace_eq_matrix_trace (Pi.basisFun K ι), Matrix.trace]
  apply sum_congr rfl
  intro i hi
  simp [Algebra.leftMulMatrix]

/-- Every trace in the actual split polynomial quotient is its root sum. -/
theorem split_polynomial_quotient_trace_eq_sum (node : ι → K)
    (hinj : Function.Injective node)
    (value : K[X] ⧸ Ideal.span ({Lagrange.nodal univ node} : Set K[X])) :
    Algebra.trace K _ value = ∑ i, splitPolynomialQuotientEquiv node hinj value i := by
  rw [← Algebra.trace_eq_of_algEquiv (splitPolynomialQuotientEquiv node hinj),
    split_product_algebra_trace]

section GeneralSourceUnit

variable {A : Type*} [CommRing A] [Algebra K A]

/-- In every actual source algebra satisfying F=phi*H+tau=0, the factor
phi is a unit when tau is nonzero. No field or connectedness of A is needed. -/
theorem source_phi_isUnit (q : K[X] →ₐ[K] A) (F phi H : K[X]) (tau : K)
    (htau : tau ≠ 0) (hsource : F = phi * H + C tau) (hzero : q F = 0) :
    IsUnit (q phi) := by
  have h : q phi * q H + algebraMap K A tau = 0 := by
    rw [hsource, map_add, map_mul] at hzero
    simpa only [Polynomial.C_eq_algebraMap, AlgHom.commutes] using hzero
  have hproduct : q phi * q H = -algebraMap K A tau := eq_neg_of_add_eq_zero_left h
  apply isUnit_iff_exists_inv.mpr
  refine ⟨q H * algebraMap K A (-tau⁻¹), ?_⟩
  rw [← mul_assoc, hproduct, ← map_neg, ← map_mul]
  simp [htau]

/-- Trace against an actual unit in any split algebra is the sum of the
corresponding pointwise fractions. The splitting equivalence is supplied
explicitly and need not describe a connected algebra. -/
theorem split_algebra_trace_unit_inverse
    (equiv : A ≃ₐ[K] (ι → K)) (value : A) (unit : Aˣ) (j : ℕ) :
    Algebra.trace K A (value ^ j * (↑unit⁻¹ : A)) =
      ∑ i, (equiv value i) ^ j / equiv (unit : A) i := by
  classical
  rw [← Algebra.trace_eq_of_algEquiv equiv, split_product_algebra_trace]
  apply sum_congr rfl
  intro i hi
  let evaluation : A →+* K := (Pi.evalRingHom (fun _ : ι => K) i).comp equiv.toRingHom
  change evaluation (value ^ j * (↑unit⁻¹ : A)) =
    evaluation value ^ j / evaluation (unit : A)
  rw [map_mul, map_pow, map_units_inv, div_eq_mul_inv]

theorem split_algebra_trace_unit_inverse_power
    (equiv : A ≃ₐ[K] (ι → K)) (value : A) (unit : Aˣ) (j n : ℕ) :
    Algebra.trace K A (value ^ j * (↑unit⁻¹ : A) ^ n) =
      ∑ i, (equiv value i) ^ j / (equiv (unit : A) i) ^ n := by
  classical
  rw [← Algebra.trace_eq_of_algEquiv equiv, split_product_algebra_trace]
  apply sum_congr rfl
  intro i hi
  let evaluation : A →+* K := (Pi.evalRingHom (fun _ : ι => K) i).comp equiv.toRingHom
  change evaluation (value ^ j * (↑unit⁻¹ : A) ^ n) =
    evaluation value ^ j / evaluation (unit : A) ^ n
  rw [map_mul, map_pow, map_pow, map_units_inv, inv_pow, div_eq_mul_inv]

end GeneralSourceUnit

/-- The first source moment is a theorem about the actual quotient trace,
once the source is split. Its denominator is represented by an actual unit. -/
theorem split_source_quotient_weighted_trace_zero (node : ι → K)
    (hinj : Function.Injective node) (F phi H : K[X]) (c tau : K) (hc : c ≠ 0)
    (hFsplit : F = C c * Lagrange.nodal univ node)
    (hFsource : F = phi * H + C tau) (hphi : phi.derivative = 0)
    (unit : (K[X] ⧸ Ideal.span ({Lagrange.nodal univ node} : Set K[X]))ˣ)
    (hunit : (unit : K[X] ⧸ Ideal.span ({Lagrange.nodal univ node} : Set K[X])) =
      Ideal.Quotient.mk _ phi)
    (j : ℕ) (hdegree : (X ^ j * H.derivative).degree < ↑(Fintype.card ι - 1)) :
    Algebra.trace K _ ((Ideal.Quotient.mk _ X) ^ j * (↑unit⁻¹ :
      K[X] ⧸ Ideal.span ({Lagrange.nodal univ node} : Set K[X]))) = 0 := by
  classical
  rw [split_algebra_trace_unit_inverse (splitPolynomialQuotientEquiv node hinj), hunit]
  simp_rw [splitPolynomialQuotientEquiv_mk, Polynomial.eval_X]
  exact split_source_weighted_moment_zero univ node hinj.injOn F phi H c tau hc
    hFsplit hFsource hphi j (by simpa using hdegree)

/-- The unit denominator is constructed in the actual source quotient.
The entire first characteristic-p trace-moment family then follows with
its numerator degree hypotheses proved from the source presentation. -/
theorem split_source_quotient_first_moments (node : ι → K)
    (hinj : Function.Injective node) (F H : K[X]) (p : ℕ) [CharP K p]
    (q tau c : K) (hp : 0 < p) (hH : H ≠ 0) (htau : tau ≠ 0) (hc : c ≠ 0)
    (hFsplit : F = C c * Lagrange.nodal univ node)
    (hsource : F = (X ^ p + C q) * H + C tau) :
    ∃ unit : (K[X] ⧸ Ideal.span ({Lagrange.nodal univ node} : Set K[X]))ˣ,
      (unit : K[X] ⧸ Ideal.span ({Lagrange.nodal univ node} : Set K[X])) =
        Ideal.Quotient.mk _ (X ^ p + C q) ∧
      ∀ j < p, Algebra.trace K _ ((Ideal.Quotient.mk _ X) ^ j * (↑unit⁻¹ :
        K[X] ⧸ Ideal.span ({Lagrange.nodal univ node} : Set K[X]))) = 0 := by
  classical
  let quotient := Ideal.Quotient.mkₐ K (Ideal.span ({Lagrange.nodal univ node} : Set K[X]))
  have hnodal : quotient (Lagrange.nodal univ node) = 0 := by
    apply Ideal.Quotient.eq_zero_iff_mem.mpr
    exact Ideal.subset_span (Set.mem_singleton _)
  have hFzero : quotient F = 0 := by rw [hFsplit, map_mul, hnodal, mul_zero]
  obtain ⟨unit, hunit⟩ := source_phi_isUnit quotient F (X ^ p + C q) H tau htau hsource hFzero
  refine ⟨unit, hunit, ?_⟩
  intro j hj
  have hdegree := source_low_moment_numerator_degree F H p q tau hp hH hsource j hj
  have hnat : F.natDegree = Fintype.card ι := by
    rw [hFsplit, Polynomial.natDegree_C_mul hc, Lagrange.natDegree_nodal, Finset.card_univ]
  rw [hnat] at hdegree
  exact split_source_quotient_weighted_trace_zero node hinj F (X ^ p + C q) H c tau hc
    hFsplit hsource (inseparableSourceFactor_derivative p q) unit hunit j hdegree

end Litt3.CartierAndSpin

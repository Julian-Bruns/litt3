import Solutions.Deformations.SplitQuadraticAlgebra
import Solutions.Deformations.SurjectiveRelationQuotients
import Mathlib.LinearAlgebra.FiniteDimensional.Basic
import Mathlib.LinearAlgebra.Dimension.RankNullity

set_option maxHeartbeats 800000
set_option synthInstance.maxHeartbeats 100000

namespace Litt3.Deformations

section Socle

variable {K S : Type*} [Field K] [CommRing S] [Algebra K S]

/-- A literal principal ideal whose generator has only scalar multiples
is the same original one-dimensional coefficient submodule. -/
theorem balanced_prepared_principal_ideal_scalar_span (z : S)
    (scalar : ∀ a : S, ∃ c : K, a * z = c • z) :
    (Ideal.span ({z} : Set S)).restrictScalars K = Submodule.span K ({z} : Set S) := by
  ext x
  constructor
  · intro hx
    obtain ⟨a, rfl⟩ := Ideal.mem_span_singleton'.mp hx
    obtain ⟨c, hc⟩ := scalar a
    rw [hc]
    exact Submodule.smul_mem _ c (Submodule.subset_span (Set.mem_singleton _))
  · intro hx
    obtain ⟨c, rfl⟩ := Submodule.mem_span_singleton.mp hx
    exact ((Ideal.span ({z} : Set S)).restrictScalars K).smul_mem c
      (Ideal.subset_span (Set.mem_singleton _))

/-- Quotienting an actual finite algebra by its nonzero scalar socle
removes exactly one dimension. This is an ideal quotient, not a supplied
rank or length conclusion. -/
theorem balanced_prepared_socle_quotient_finrank [Module.Finite K S]
    (z : S) (nonzero : z ≠ 0) (scalar : ∀ a : S, ∃ c : K, a * z = c • z) :
    Module.finrank K (S ⧸ Ideal.span ({z} : Set S)) = Module.finrank K S - 1 := by
  have hdim : Module.finrank K (Ideal.span ({z} : Set S)) = 1 := by
    change Module.finrank K ((Ideal.span ({z} : Set S)).restrictScalars K) = 1
    rw [balanced_prepared_principal_ideal_scalar_span z scalar]
    exact finrank_span_singleton nonzero
  rw [Submodule.finrank_quotient, hdim]

end Socle

section Root

variable {K A : Type*} [Field K] [CommRing A] [Algebra K A]

/-- Scalar socle action and annihilation by the ORIGINAL quadratic
root imply scalar action of the whole original root algebra. -/
theorem balanced_prepared_root_scalar_action (g : A) (z : SplitQuadraticAlgebra g)
    (constant : ∀ a : A, ∃ c : K, algebraMap A (SplitQuadraticAlgebra g) a * z = c • z)
    (root : AdjoinRoot.root (splitQuadraticPolynomial g) * z = 0) :
    ∀ s : SplitQuadraticAlgebra g, ∃ c : K, s * z = c • z := by
  intro s
  induction s using AdjoinRoot.induction_on with
  | ih P =>
    induction P using Polynomial.induction_on' with
    | add P Q hP hQ =>
      obtain ⟨a, ha⟩ := hP
      obtain ⟨b, hb⟩ := hQ
      refine ⟨a + b, ?_⟩
      rw [map_add, add_mul, ha, hb, add_smul]
    | monomial n a =>
      cases n with
      | zero =>
        simpa only [Polynomial.monomial_zero_left, AdjoinRoot.mk_C,
          ← AdjoinRoot.algebraMap_eq] using constant a
      | succ n =>
        refine ⟨0, ?_⟩
        rw [← Polynomial.C_mul_X_pow_eq_monomial, map_mul, map_pow, AdjoinRoot.mk_X,
          pow_succ]
        simp only [mul_assoc, root, mul_zero, zero_smul]

/-- The actual coefficient of the original quadratic root detects a
nonzero scalar multiple. Monicity proves this even over a nonreduced base. -/
theorem balanced_prepared_root_scalar_nonzero [Nontrivial A] (g v : A) (nonzero : v ≠ 0) :
    algebraMap A (SplitQuadraticAlgebra g) v *
      AdjoinRoot.root (splitQuadraticPolynomial g) ≠ 0 := by
  intro hz
  have h := congrArg (AdjoinRoot.modByMonicHom (split_quadratic_polynomial_monic g)) hz
  have original : algebraMap A (SplitQuadraticAlgebra g) v *
      AdjoinRoot.root (splitQuadraticPolynomial g) =
      AdjoinRoot.mk (splitQuadraticPolynomial g) (Polynomial.C v * Polynomial.X) := by
    rw [map_mul, AdjoinRoot.mk_X, AdjoinRoot.mk_C, AdjoinRoot.algebraMap_eq]
  rw [original, AdjoinRoot.modByMonicHom_mk, map_zero] at h
  have small : (Polynomial.C v * Polynomial.X).degree < (splitQuadraticPolynomial g).degree := by
    rw [Polynomial.degree_C_mul_X nonzero]
    rw [Polynomial.degree_eq_natDegree (split_quadratic_polynomial_monic g).ne_zero]
    simp [splitQuadraticPolynomial]
  rw [(Polynomial.modByMonic_eq_self_iff (split_quadratic_polynomial_monic g)).mpr small] at h
  have hc := congrArg (fun P : Polynomial A => P.coeff 1) h
  exact nonzero (by simpa using hc)

/-- The retained ORIGINAL odd root power generates a genuine nonzero
one-dimensional ideal when the actual base coefficient has a nonzero
top socle power. No relation is declared redundant. -/
theorem balanced_prepared_split_quotient_finrank [Nontrivial A] [Module.Finite K A]
    (g : A) (m : ℕ) (top : (-g) ^ m ≠ 0) (cutoff : g ^ (m + 1) = 0)
    (scalar : ∀ a : A, ∃ c : K, a * (-g) ^ m = c • ((-g) ^ m)) :
    Module.finrank K (SplitQuadraticAlgebra g ⧸
      Ideal.span ({AdjoinRoot.root (splitQuadraticPolynomial g) ^ (2 * m + 1)} :
        Set (SplitQuadraticAlgebra g))) = 2 * Module.finrank K A - 1 := by
  let S := SplitQuadraticAlgebra g
  letI : Module.Finite A S := (split_quadratic_polynomial_monic g).finite_adjoinRoot
  letI : Module.Finite K S := Module.Finite.trans A S
  let z : S := AdjoinRoot.root (splitQuadraticPolynomial g) ^ (2 * m + 1)
  have hz : z = algebraMap A S ((-g) ^ m) * AdjoinRoot.root (splitQuadraticPolynomial g) := by
    dsimp only [z]
    rw [split_quadratic_root_odd_power, ← map_neg, ← map_pow]
  have nonzero : z ≠ 0 := by rw [hz]; exact balanced_prepared_root_scalar_nonzero g _ top
  have constants : ∀ a : A, ∃ c : K, algebraMap A S a * z = c • z := by
    intro a
    obtain ⟨c, hc⟩ := scalar a
    refine ⟨c, ?_⟩
    rw [Algebra.smul_def] at hc
    rw [hz, ← mul_assoc, ← map_mul, hc, map_mul,
      ← IsScalarTower.algebraMap_apply K A S, Algebra.smul_def, mul_assoc]
  have root : AdjoinRoot.root (splitQuadraticPolynomial g) * z = 0 := by
    rw [hz]
    calc
      _ = algebraMap A S ((-g) ^ m) * AdjoinRoot.root (splitQuadraticPolynomial g) ^ 2 := by ring
      _ = algebraMap A S ((-g) ^ m) * -algebraMap A S g := by rw [split_quadratic_root_square]
      _ = -algebraMap A S ((-1) ^ m * g ^ (m + 1)) := by
        rw [neg_pow]
        simp only [pow_succ, map_mul, map_pow]
        ring
      _ = 0 := by rw [cutoff, mul_zero, map_zero, neg_zero]
  rw [balanced_prepared_socle_quotient_finrank z nonzero
    (balanced_prepared_root_scalar_action g z constants root), split_quadratic_finrank K]

end Root

end Litt3.Deformations

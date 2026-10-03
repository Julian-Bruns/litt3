import Theorems.Deformations.TruncatedCoefficientRing
import Solutions.Deformations.NilpotentPerturbation
import Mathlib.Algebra.Polynomial.Div

namespace Litt3.Deformations

open Polynomial

variable {k : Type*} [CommRing k]

theorem truncated_parameter_pow (N : ℕ) :
    truncatedParameter k N ^ N = 0 := by
  have h := AdjoinRoot.eval₂_root ((X : Polynomial k) ^ N)
  simpa only [Polynomial.eval₂_pow, Polynomial.eval₂_X] using h

theorem truncated_parameter_nilpotent (N : ℕ) :
    IsNilpotent (truncatedParameter k N) := ⟨N, truncated_parameter_pow N⟩

@[simp] theorem truncated_residue_parameter (N : ℕ) (positive : 0 < N) :
    truncatedResidue k N positive (truncatedParameter k N) = 0 := by
  simp [truncatedResidue, truncatedParameter]

@[simp] theorem truncated_residue_constant (N : ℕ) (positive : 0 < N) (c : k) :
    truncatedResidue k N positive (AdjoinRoot.of ((X : Polynomial k) ^ N) c) = c := by
  simp only [truncatedResidue, AdjoinRoot.lift_of, RingHom.id_apply]

/-- Every actual element has its exact residue as constant part
and is divisible by the actual nilpotent parameter after subtraction. -/
theorem truncated_scalar_decomposition (N : ℕ) (positive : 0 < N)
    (x : TruncatedCoefficientRing k N) :
    ∃ y : TruncatedCoefficientRing k N,
      x = AdjoinRoot.of ((X : Polynomial k) ^ N) (truncatedResidue k N positive x) +
        truncatedParameter k N * y := by
  induction x using AdjoinRoot.induction_on ((X : Polynomial k) ^ N) with
  | ih P =>
    refine ⟨AdjoinRoot.mk ((X : Polynomial k) ^ N) P.divX, ?_⟩
    have h := congrArg (AdjoinRoot.mk ((X : Polynomial k) ^ N)) (X_mul_divX_add P)
    have hr : truncatedResidue k N positive
        (AdjoinRoot.mk ((X : Polynomial k) ^ N) P) = P.coeff 0 := by
      simp [truncatedResidue]
    rw [hr]
    simpa only [map_add, map_mul, AdjoinRoot.mk_C, AdjoinRoot.mk_X, add_comm]
      using h.symm

theorem truncated_unit_criterion (N : ℕ) (positive : 0 < N) :
    Specifications.TruncatedUnitCriterion (k := k) N positive := by
  intro x
  constructor
  · exact fun hx => hx.map (truncatedResidue k N positive)
  · intro hx
    obtain ⟨y, hy⟩ := truncated_scalar_decomposition N positive x
    rw [hy]
    have hconstant := hx.map (AdjoinRoot.of ((X : Polynomial k) ^ N))
    have h := unit_survives_nilpotent_scalar _ hconstant (truncatedParameter k N)
      (truncated_parameter_nilpotent N) y
    simpa only [scalarPerturbation, smul_eq_mul] using h

/-- Actual matrix invertibility over k[z]/z^N is equivalent to
invertibility of its residue matrix. The coefficient ring may be
any commutative ring; a nonzero determinant over a field is one
special case. -/
theorem truncated_matrix_unit_criterion {ι : Type*} [Fintype ι] [DecidableEq ι]
    (N : ℕ) (positive : 0 < N) (A : Matrix ι ι (TruncatedCoefficientRing k N)) :
    IsUnit A ↔ IsUnit ((truncatedResidue k N positive).mapMatrix A) := by
  rw [Matrix.isUnit_iff_isUnit_det, Matrix.isUnit_iff_isUnit_det,
    ← (truncatedResidue k N positive).map_det A]
  exact truncated_unit_criterion N positive A.det

/-- The genuine truncated coefficient ring has precisely N
dimensions over its coefficient field, including the zero ring
at length zero. -/
theorem truncated_coefficient_finrank {K : Type*} [Field K] (N : ℕ) :
    Module.finrank K (TruncatedCoefficientRing K N) = N := by
  have h := (AdjoinRoot.powerBasis' (Polynomial.monic_X_pow N :
    ((X : Polynomial K) ^ N).Monic)).finrank
  simpa only [AdjoinRoot.powerBasis', Polynomial.natDegree_X_pow] using h

end Litt3.Deformations

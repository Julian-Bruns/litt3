import Solutions.CartierAndSpin.CubicResidueMoments
import Definitions.CartierAndSpin.CriticalQuadratic
import Mathlib.FieldTheory.Separable

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K]

/-- The literal canonical critical quadratic is the actual cubic inverse
residue formula, retaining the infinity contribution in its last moment. -/
theorem critical_quadratic_eq_cubic_residue_reconstruction (D : K[X])
    (hdegree : D.natDegree = 3) (v rho : K) (mu : ℕ → K) :
    criticalQuadraticFromMoments v D rho mu =
      cubicResidueReconstruction D
        (fun j => if j = 2 then v * rho ^ 2 / D.coeff 3 - mu j else -mu j) := by
  have hD : D ≠ 0 := by intro hz; simp [hz] at hdegree
  have hleading : D.coeff 3 ≠ 0 := by
    rw [← hdegree, coeff_natDegree]
    exact leadingCoeff_ne_zero.mpr hD
  have hconstant : D.coeff 3 * (v * rho ^ 2 / D.coeff 3 - mu 2) +
      D.coeff 2 * (-mu 1) + D.coeff 1 * (-mu 0) =
      v * rho ^ 2 - D.coeff 3 * mu 2 - D.coeff 2 * mu 1 - D.coeff 1 * mu 0 := by
    field_simp [hleading]
    ring
  simp only [criticalQuadraticFromMoments, cubicResidueReconstruction,
    Nat.reduceEqDiff, ↓reduceIte]
  rw [hconstant]
  simp only [mul_neg, ← neg_add, map_neg]
  ring

/-- The exact congruence is equivalent to all three residue equations in
the actual critical quotient, without assuming critical separability. -/
theorem critical_cubic_residue_incidence_iff (F D U P : K[X])
    (hdegree : D.natDegree = 3) (hP : P.degree < D.degree)
    (unit : (AdjoinRoot D)ˣ) (hunit : (unit : AdjoinRoot D) = AdjoinRoot.mk D F)
    (hvalue : AdjoinRoot.mk D P = AdjoinRoot.mk D (U ^ 2) * (↑unit⁻¹ : AdjoinRoot D))
    (v rho : K) (mu : ℕ → K) :
    (D ∣ U ^ 2 - F * criticalQuadraticFromMoments v D rho mu) ↔
      (∀ j : ℕ, j < 3 → polynomialResidueMoment D P j =
        if j = 2 then v * rho ^ 2 / D.coeff 3 - mu j else -mu j) := by
  let z := fun j => if j = 2 then v * rho ^ 2 / D.coeff 3 - mu j else -mu j
  let Q := criticalQuadraticFromMoments v D rho mu
  have hQ : Q = cubicResidueReconstruction D z :=
    critical_quadratic_eq_cubic_residue_reconstruction D hdegree v rho mu
  have hD : D ≠ 0 := by intro hz; simp [hz] at hdegree
  have hQsmall : Q.degree < D.degree := by
    rw [hQ, degree_eq_natDegree hD, hdegree]
    exact cubic_residue_reconstruction_degree D z
  have hproduct : (unit : AdjoinRoot D) * AdjoinRoot.mk D P = AdjoinRoot.mk D (U ^ 2) := by
    rw [hvalue]
    calc
      (unit : AdjoinRoot D) *
          (AdjoinRoot.mk D (U ^ 2) * (↑unit⁻¹ : AdjoinRoot D)) =
          AdjoinRoot.mk D (U ^ 2) *
            ((unit : AdjoinRoot D) * (↑unit⁻¹ : AdjoinRoot D)) := by ring
      _ = _ := by simp
  have hcongruence : (D ∣ U ^ 2 - F * Q) ↔ AdjoinRoot.mk D P = AdjoinRoot.mk D Q := by
    rw [← AdjoinRoot.mk_eq_zero, map_sub, map_mul, sub_eq_zero]
    constructor
    · intro h
      apply unit.isUnit.mul_left_cancel
      rw [hproduct, hunit]
      exact h
    · intro h
      rw [← hunit, ← hproduct, h]
  have hrepresentatives : AdjoinRoot.mk D P = AdjoinRoot.mk D Q ↔ P = Q := by
    constructor
    · intro h
      obtain ⟨R, hR, hunique⟩ := source_quotient_reduced_polynomial D hD (AdjoinRoot.mk D P)
      exact (hunique P ⟨hP, rfl⟩).trans (hunique Q ⟨hQsmall, h.symm⟩).symm
    · intro h
      exact congrArg (AdjoinRoot.mk D) h
  change (D ∣ U ^ 2 - F * Q) ↔ ∀ j, j < 3 → polynomialResidueMoment D P j = z j
  rw [hcongruence, hrepresentatives, hQ]
  exact (cubic_residue_moment_equations_iff D P hdegree hP z).symm

/-- Actual coprimality constructs both the critical denominator unit and
the unique reduced critical representative; these are never inputs. -/
theorem critical_cubic_residue_representative_exists (F D U : K[X])
    (hdegree : D.natDegree = 3) (hcoprime : IsCoprime F D) :
    ∃ (unit : (AdjoinRoot D)ˣ) (P : K[X]),
      (unit : AdjoinRoot D) = AdjoinRoot.mk D F ∧ P.degree < D.degree ∧
      AdjoinRoot.mk D P = AdjoinRoot.mk D (U ^ 2) * (↑unit⁻¹ : AdjoinRoot D) ∧
      ∀ (v rho : K) (mu : ℕ → K),
        (D ∣ U ^ 2 - F * criticalQuadraticFromMoments v D rho mu) ↔
          (∀ j : ℕ, j < 3 → polynomialResidueMoment D P j =
            if j = 2 then v * rho ^ 2 / D.coeff 3 - mu j else -mu j) := by
  have hD : D ≠ 0 := by intro hz; simp [hz] at hdegree
  have hu : IsUnit (AdjoinRoot.mk D F) := by
    apply isCoprime_zero_right.mp
    simpa only [AdjoinRoot.mk_self] using hcoprime.map (AdjoinRoot.mk D)
  obtain ⟨unit, hunit⟩ := hu
  obtain ⟨P, ⟨hP, hvalue⟩, _⟩ := source_quotient_reduced_polynomial D hD
    (AdjoinRoot.mk D (U ^ 2) * (↑unit⁻¹ : AdjoinRoot D))
  exact ⟨unit, P, hunit, hP, hvalue,
    critical_cubic_residue_incidence_iff F D U P hdegree hP unit hunit hvalue⟩

end Litt3.CartierAndSpin

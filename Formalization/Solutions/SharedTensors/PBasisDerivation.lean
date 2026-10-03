import Solutions.SharedTensors.FrobeniusCoordinates
import Mathlib.RingTheory.PowerBasis
import Mathlib.RingTheory.Derivation.Basic
import Mathlib.RingTheory.Derivation.MapCoeffs

namespace Litt3.SharedTensors

open Polynomial Module

variable {K : Type*} [Field K] {p : ℕ} [Fact p.Prime] [CharP K p]

/-- A literal p-basis is a genuine power basis over the actual p-th powers. -/
noncomputable def PowerPBasis.toPowerBasis (b : PowerPBasis K p) :
    PowerBasis (frobeniusSubfield K p) K where
  gen := b.parameter
  dim := p
  basis := b.basis
  basis_eq_pow := b.basis_eq_power

theorem p_basis_minpoly (b : PowerPBasis K p) :
    minpoly (frobeniusSubfield K p) b.parameter =
      X ^ p - C (frobeniusImageEquiv K p b.parameter) := by
  refine minpoly.eq_of_linearIndependent (frobeniusSubfield K p) b.parameter
    (monic_X_pow_sub_C _ (Fact.out : p.Prime).ne_zero) ?_ p
    (degree_X_pow_sub_C (Fact.out : p.Prime).pos _) ?_
  · simp only [map_sub, map_pow, aeval_X, aeval_C]
    change b.parameter ^ p - (frobeniusImageEquiv K p b.parameter : K) = 0
    rw [frobeniusImageEquiv_coe, sub_self]
  · simpa only [← b.basis_eq_power] using b.basis.linearIndependent

/-- The actual minimal polynomial has zero derivative. -/
theorem p_basis_minpoly_derivative (b : PowerPBasis K p) :
    (minpoly (frobeniusSubfield K p) b.parameter).derivative = 0 := by
  rw [p_basis_minpoly]
  have hp : (p : frobeniusSubfield K p) = 0 := by
    apply Subtype.ext
    exact CharP.cast_eq_zero K p
  simp [derivative_X_pow, hp]

/-- Construct the actual normalized derivation through the entire field
quotient. No derivation or nonzero differential is supplied as a premise. -/
theorem p_basis_normalized_derivation_exists (b : PowerPBasis K p) :
    ∃ D : Derivation (frobeniusSubfield K p) K K, D b.parameter = 1 := by
  let q : (frobeniusSubfield K p)[X] →ₐ[frobeniusSubfield K p] K := aeval b.parameter
  have hsurj : Function.Surjective q := by
    intro a
    obtain ⟨P, hP⟩ := b.toPowerBasis.exists_eq_aeval' a
    exact ⟨P, hP.symm⟩
  have hstable : ∀ P, q P = 0 → q (Polynomial.derivative' P) = 0 := by
    intro P hP
    have hdiv : minpoly (frobeniusSubfield K p) b.parameter ∣ P := minpoly.dvd _ _ hP
    obtain ⟨Q, rfl⟩ := hdiv
    change aeval b.parameter
      ((minpoly (frobeniusSubfield K p) b.parameter * Q).derivative) = 0
    rw [derivative_mul, p_basis_minpoly_derivative]
    simp only [zero_mul, zero_add, map_mul, minpoly.aeval, zero_mul]
  let D := Derivation.liftOfSurjective (f := q) hsurj hstable
  refine ⟨D, ?_⟩
  have hqx : q X = b.parameter := by simp [q]
  rw [← hqx]
  change Derivation.liftOfSurjective hsurj hstable (q X) = 1
  rw [Derivation.liftOfSurjective_apply]
  change aeval b.parameter X.derivative = 1
  simp

end Litt3.SharedTensors

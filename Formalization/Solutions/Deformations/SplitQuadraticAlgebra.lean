import Definitions.Deformations.SplitQuadraticAlgebra
import Mathlib.RingTheory.IsAdjoinRoot
import Mathlib.LinearAlgebra.Dimension.Free
import Mathlib.RingTheory.Length
import Mathlib.Tactic

namespace Litt3.Deformations

variable {A : Type*} [CommRing A]

theorem split_quadratic_polynomial_monic (g : A) : (splitQuadraticPolynomial g).Monic :=
  Polynomial.monic_X_pow_add_C g (by omega)

/-- The actual quadratic quotient retains the exact original equation. -/
theorem split_quadratic_root_square (g : A) :
    AdjoinRoot.root (splitQuadraticPolynomial g) ^ 2 =
      -algebraMap A (SplitQuadraticAlgebra g) g := by
  have equation := AdjoinRoot.eval₂_root (splitQuadraticPolynomial g)
  have square : AdjoinRoot.root (splitQuadraticPolynomial g) ^ 2 +
      algebraMap A (SplitQuadraticAlgebra g) g = 0 := by
    simpa only [splitQuadraticPolynomial, Polynomial.eval₂_add, Polynomial.eval₂_pow,
      Polynomial.eval₂_X, Polynomial.eval₂_C, ← AdjoinRoot.algebraMap_eq] using equation
  exact eq_neg_of_add_eq_zero_left square

/-- Every odd root power has its exact literal base coefficient. -/
theorem split_quadratic_root_odd_power (g : A) (m : ℕ) :
    AdjoinRoot.root (splitQuadraticPolynomial g) ^ (2 * m + 1) =
      (-algebraMap A (SplitQuadraticAlgebra g) g) ^ m *
        AdjoinRoot.root (splitQuadraticPolynomial g) := by
  rw [pow_succ, pow_mul, split_quadratic_root_square]

/-- Nilpotence of the actual base coefficient makes the odd-power
relation redundant, uniformly over every commutative base ring. -/
theorem split_quadratic_root_odd_power_zero (g : A) (m : ℕ) (nilpotent : g ^ m = 0) :
    AdjoinRoot.root (splitQuadraticPolynomial g) ^ (2 * m + 1) = 0 := by
  rw [split_quadratic_root_odd_power, neg_pow, ← map_pow, nilpotent, map_zero, mul_zero, zero_mul]

/-- The literal two-generator relation ideal equals the single
quadratic relation ideal whenever the odd power is redundant. -/
theorem split_quadratic_odd_relation_ideal (g : A) (m : ℕ) (nilpotent : g ^ m = 0) :
    Ideal.span ({splitQuadraticPolynomial g, Polynomial.X ^ (2 * m + 1)} : Set (Polynomial A)) =
      Ideal.span ({splitQuadraticPolynomial g} : Set (Polynomial A)) := by
  apply Ideal.span_pair_eq_span_left_iff_dvd.mpr
  apply AdjoinRoot.mk_eq_zero.mp
  rw [map_pow, AdjoinRoot.mk_X]
  exact split_quadratic_root_odd_power_zero g m nilpotent

/-- A precise ideal-level nilpotence input suffices for the source's
quadratic redundancy argument; the surrounding formal splitting is
separate and is not supplied as a length conclusion. -/
theorem split_quadratic_odd_relation_of_ideal_cutoff (g : A) (J : Ideal A) (m : ℕ)
    (quadratic : g ∈ J ^ 2) (cutoff : J ^ (2 * m) = ⊥) :
    Ideal.span ({splitQuadraticPolynomial g, Polynomial.X ^ (2 * m + 1)} : Set (Polynomial A)) =
      Ideal.span ({splitQuadraticPolynomial g} : Set (Polynomial A)) := by
  apply split_quadratic_odd_relation_ideal g m
  have member := Ideal.pow_mem_pow quadratic m
  rw [← pow_mul, cutoff, Ideal.mem_bot] at member
  exact member

section Dimension

variable [Nontrivial A]

/-- The actual relative quadratic quotient is free of exact rank two. -/
theorem split_quadratic_relative_finrank (g : A) :
    Module.finrank A (SplitQuadraticAlgebra g) = 2 := by
  simpa only [SplitQuadraticAlgebra, splitQuadraticPolynomial, Polynomial.natDegree_X_pow_add_C]
    using finrank_quotient_span_eq_natDegree' (split_quadratic_polynomial_monic g)

variable (K : Type*) [Field K] [Algebra K A]

/-- The genuine quadratic quotient doubles the unchanged base algebra's
dimension, with no field or reducedness assumption on that base algebra. -/
theorem split_quadratic_finrank (g : A) :
    Module.finrank K (SplitQuadraticAlgebra g) = 2 * Module.finrank K A := by
  letI : Module.Free A (SplitQuadraticAlgebra g) :=
    (split_quadratic_polynomial_monic g).free_adjoinRoot
  rw [← Module.finrank_mul_finrank K A (SplitQuadraticAlgebra g),
    split_quadratic_relative_finrank, mul_comm]

end Dimension

end Litt3.Deformations

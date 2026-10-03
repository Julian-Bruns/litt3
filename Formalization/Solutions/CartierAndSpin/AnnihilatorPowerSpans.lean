import Mathlib.RingTheory.PowerBasis
import Mathlib.LinearAlgebra.Matrix.Charpoly.Coeff
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

open Polynomial

variable {R A : Type*} [CommRing R] [Nontrivial R] [Ring A] [Algebra R A]

/-- Every power lies in the actual span below the degree of any
monic annihilating polynomial. This works in arbitrary noncommutative
algebras and uses exact polynomial division. -/
theorem power_mem_span_of_monic_annihilator (a : A) (P : R[X])
    (hP : P.Monic) (hroot : aeval a P = 0) (n : ℕ) :
    a ^ n ∈ Submodule.span R (Set.range fun i : Fin P.natDegree => a ^ i.val) := by
  apply PowerBasis.mem_span_pow'.mpr
  refine ⟨X ^ n %ₘ P,
    (degree_modByMonic_lt _ hP).trans_le degree_le_natDegree, ?_⟩
  have h := congrArg (aeval a) (modByMonic_add_div (X ^ n) hP)
  simp only [map_add, map_mul, hroot, zero_mul, add_zero, map_pow, aeval_X] at h
  exact h.symm

variable {m : Type*} [Fintype m] [DecidableEq m]

theorem matrix_power_mem_initial_span (A : Matrix m m R) (n : ℕ) :
    A ^ n ∈ Submodule.span R (Set.range fun i : Fin (Fintype.card m) => A ^ i.val) := by
  have h := power_mem_span_of_monic_annihilator A A.charpoly A.charpoly_monic
    A.aeval_self_charpoly n
  rw [Matrix.charpoly_natDegree_eq_dim A] at h
  exact h

end Litt3.CartierAndSpin

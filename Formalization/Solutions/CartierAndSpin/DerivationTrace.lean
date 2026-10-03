import Mathlib.RingTheory.Trace.Basic
import Mathlib.RingTheory.Derivation.Basic
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

open Finset Module

variable {R K A ι : Type*} [CommRing R] [CommRing K] [Algebra R K]
  [CommRing A] [Algebra K A] [Algebra R A] [Fintype ι]

/-- The derivative of coordinates consists of the base derivative and
the matrix of derivatives of the basis. This is an actual derivation identity. -/
theorem derivation_basis_coordinates (D : Derivation R K K) (E : Derivation R A A)
    (compatible : ∀ c : K, E (algebraMap K A c) = algebraMap K A (D c))
    (basis : Basis ι K A) (x : A) (i : ι) :
    basis.repr (E x) i = D (basis.repr x i) +
      ∑ j, basis.repr x j * basis.repr (E (basis j)) i := by
  classical
  have hexpand : E x = (∑ j, D (basis.repr x j) • basis j) +
      ∑ j, basis.repr x j • E (basis j) := by
    rw (occs := [1]) [← basis.sum_repr x]
    rw [map_sum, ← sum_add_distrib]
    apply sum_congr rfl
    intro j hj
    simp only [Algebra.smul_def, E.leibniz, compatible,
      Algebra.algebraMap_self, RingHom.id_apply]
    ring
  rw [hexpand, map_add, Finsupp.add_apply]
  rw [congrFun (basis.repr_sum_self (fun j => D (basis.repr x j))) i]
  simp only [map_sum, map_smul, Finsupp.finset_sum_apply,
    Finsupp.smul_apply, smul_eq_mul]

/-- Algebra trace commutes with every actual extension of a base
derivation on a finite free algebra. The connection terms cancel by
interchanging the two finite indices. No separability is needed here. -/
theorem algebra_trace_derivation (D : Derivation R K K) (E : Derivation R A A)
    (compatible : ∀ c : K, E (algebraMap K A c) = algebraMap K A (D c))
    (basis : Basis ι K A) (x : A) :
    Algebra.trace K A (E x) = D (Algebra.trace K A x) := by
  classical
  let matrix := Algebra.leftMulMatrix basis x
  have hcoordinate (i : ι) :
      basis.repr (E x * basis i) i +
        (∑ j, matrix i j * basis.repr (E (basis i)) j) =
      D (matrix i i) + (∑ j, matrix j i * basis.repr (E (basis j)) i) := by
    have h := derivation_basis_coordinates D E compatible basis (x * basis i) i
    rw [E.leibniz] at h
    simp only [smul_eq_mul, map_add, Finsupp.add_apply] at h
    have hmul := congrFun (Algebra.leftMulMatrix_mulVec_repr basis x (E (basis i))) i
    change (∑ j, matrix i j * basis.repr (E (basis i)) j) =
      basis.repr (x * E (basis i)) i at hmul
    rw [← hmul] at h
    simp only [matrix, Algebra.leftMulMatrix_eq_repr_mul] at h ⊢
    simpa only [mul_comm (basis i) (E x), add_comm] using h
  have hsum := Finset.sum_congr rfl (fun i (_hi : i ∈ univ) => hcoordinate i)
  simp only [sum_add_distrib] at hsum
  have hcross : (∑ i, ∑ j, matrix j i * basis.repr (E (basis j)) i) =
      ∑ i, ∑ j, matrix i j * basis.repr (E (basis i)) j := by
    exact sum_comm
  rw [hcross] at hsum
  have hcancel := add_right_cancel hsum
  rw [Algebra.trace_eq_matrix_trace basis, Algebra.trace_eq_matrix_trace basis,
    Matrix.trace, Matrix.trace, map_sum]
  change (∑ i, Algebra.leftMulMatrix basis (E x) i i) = ∑ i, D (matrix i i)
  simpa only [Algebra.leftMulMatrix_eq_repr_mul] using hcancel

end Litt3.CartierAndSpin

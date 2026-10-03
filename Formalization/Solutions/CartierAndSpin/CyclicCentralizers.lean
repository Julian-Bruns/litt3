import Mathlib.LinearAlgebra.Basis.Defs
import Mathlib.Algebra.Polynomial.AlgebraMap
import Mathlib.Algebra.Algebra.Subalgebra.Basic

namespace Litt3.CartierAndSpin

open Polynomial Module

variable {R V : Type*} [CommRing R] [AddCommGroup V] [Module R V]

/-- On an ACTUAL cyclic basis, two commuting operators are equal
exactly when their values on the original cyclic vector agree. This
holds over every commutative ring, including zero divisors. -/
theorem commuting_operators_eq_of_cyclic_value
    {n : ℕ} (T E F : Module.End R V) (v : V)
    (B : Basis (Fin n) R V) (hB : ∀ i, B i = (T ^ (i : ℕ)) v)
    (hTE : Commute T E) (hTF : Commute T F) (hvalue : E v = F v) : E = F := by
  apply B.ext
  intro i
  rw [hB i]
  calc
    E ((T ^ (i : ℕ)) v) = (T ^ (i : ℕ)) (E v) :=
      congrArg (fun P : Module.End R V => P v) (hTE.pow_left (i : ℕ)).eq.symm
    _ = (T ^ (i : ℕ)) (F v) := congrArg (T ^ (i : ℕ)) hvalue
    _ = F ((T ^ (i : ℕ)) v) :=
      congrArg (fun P : Module.End R V => P v) (hTF.pow_left (i : ℕ)).eq

/-- Actual polynomial values commute with their original operator;
the coefficient image is the true central algebra map. -/
theorem operator_commutes_polynomial_value
    (T : Module.End R V) (P : R[X]) : Commute T (aeval T P) := by
  change T * aeval T P = aeval T P * T
  calc
    _ = aeval T (X * P) := by rw [map_mul, Polynomial.aeval_X]
    _ = aeval T (P * X) := congrArg (aeval T) (mul_comm X P)
    _ = _ := by rw [map_mul, Polynomial.aeval_X]

/-- For a true cyclic basis, EVERY commuting operator is an actual
polynomial in the original operator. No field, characteristic, matrix,
finite-rank certificate or polynomial representation is assumed. -/
theorem cyclic_basis_commuting_operator_is_polynomial
    {n : ℕ} (T E : Module.End R V) (v : V)
    (B : Basis (Fin n) R V) (hB : ∀ i, B i = (T ^ (i : ℕ)) v)
    (hTE : Commute T E) : ∃ P : R[X], E = aeval T P := by
  classical
  let P : R[X] := ∑ i : Fin n, C (B.repr (E v) i) * X ^ (i : ℕ)
  have hvalue : aeval T P v = E v := by
    simp only [P, map_sum, map_mul, Polynomial.aeval_C,
      Polynomial.aeval_X_pow, LinearMap.sum_apply, Module.End.mul_apply,
      Algebra.algebraMap_eq_smul_one, LinearMap.smul_apply, Module.End.one_apply]
    simpa only [← hB] using B.sum_repr (E v)
  exact ⟨P, commuting_operators_eq_of_cyclic_value T E (aeval T P) v B hB
    hTE (operator_commutes_polynomial_value T P) hvalue.symm⟩

/-- The ENTIRE literal centralizer is the actual polynomial-evaluation
subalgebra, over any commutative ring with the original cyclic basis. -/
theorem cyclic_basis_centralizer_eq_polynomial_range
    {n : ℕ} (T : Module.End R V) (v : V)
    (B : Basis (Fin n) R V) (hB : ∀ i, B i = (T ^ (i : ℕ)) v) :
    Subalgebra.centralizer R ({T} : Set (Module.End R V)) = (aeval T).range := by
  ext E
  rw [Subalgebra.mem_centralizer_iff, AlgHom.mem_range]
  constructor
  · intro h
    obtain ⟨P, hP⟩ := cyclic_basis_commuting_operator_is_polynomial T E v B hB
      (h T (Set.mem_singleton T))
    exact ⟨P, hP.symm⟩
  · rintro ⟨P, rfl⟩ S hS
    have hST : S = T := Set.mem_singleton_iff.mp hS
    subst S
    exact (operator_commutes_polynomial_value T P).eq

end Litt3.CartierAndSpin

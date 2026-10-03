import Solutions.Deformations.NilpotentBlockDecomposition
import Solutions.Deformations.TruncatedCoefficientRing
import Mathlib.LinearAlgebra.Pi

namespace Litt3.Deformations

open Polynomial
open scoped DirectSum

universe u v

variable {k : Type u} [Field k] {V : Type v} [AddCommGroup V] [Module k V]

/-- Primary decomposition gives actual truncated quotient blocks and
their actual operator action. Every length is bounded by the supplied
global nilpotence exponent; zero summands are allowed here. -/
theorem nilpotent_quotient_blocks [FiniteDimensional k V]
    (T : V →ₗ[k] V) (N : ℕ) (nilpotent : T ^ N = 0) :
    ∃ (d : ℕ) (length : Fin d → ℕ), (∀ i, length i ≤ N) ∧
      ∃ e : V ≃ₗ[k] (∀ i, TruncatedCoefficientRing k (length i)),
        ∀ v i, e (T v) i = truncatedParameter k (length i) * e v i := by
  classical
  obtain ⟨d, length, ⟨primary⟩⟩ :=
    nilpotent_polynomial_module_decomposition T N nilpotent
  let E := primary.trans (DirectSum.linearEquivFunOnFintype k[X] (Fin d)
    (fun i => k[X] ⧸ Submodule.span k[X] {(X : k[X]) ^ length i}))
  let e : V ≃ₗ[k] (∀ i, TruncatedCoefficientRing k (length i)) :=
    (Module.AEval'.of T).trans (E.restrictScalars k)
  have torsion : ∀ x : Module.AEval' T, (X ^ N : k[X]) • x = 0 := by
    intro x
    obtain ⟨v, rfl⟩ := (Module.AEval'.of T).surjective x
    rw [Module.AEval'.X_pow_smul_of, nilpotent]
    change (Module.AEval'.of T) ((0 : V →ₗ[k] V) v) = 0
    simp
  have bound : ∀ i, length i ≤ N := by
    intro i
    let y : ∀ i : Fin d, k[X] ⧸ Submodule.span k[X] {(X : k[X]) ^ length i} :=
      fun _ => Submodule.Quotient.mk 1
    have h := E.map_smul (X ^ N : k[X]) (E.symm y)
    rw [torsion, E.map_zero, E.apply_symm_apply] at h
    have hi := congrFun h i
    change (0 : k[X] ⧸ Submodule.span k[X] {(X : k[X]) ^ length i}) =
      (X ^ N : k[X]) • Submodule.Quotient.mk (1 : k[X]) at hi
    rw [← Submodule.Quotient.mk_smul, smul_eq_mul, mul_one] at hi
    change (0 : TruncatedCoefficientRing k (length i)) =
      AdjoinRoot.mk ((X : k[X]) ^ length i) ((X : k[X]) ^ N) at hi
    have divides := AdjoinRoot.mk_eq_zero.mp hi.symm
    have degree := Polynomial.natDegree_le_of_dvd divides (pow_ne_zero N Polynomial.X_ne_zero)
    simpa only [Polynomial.natDegree_X_pow] using degree
  refine ⟨d, length, bound, e, ?_⟩
  intro v i
  have h := E.map_smul (X : k[X]) ((Module.AEval'.of T) v)
  rw [Module.AEval'.X_smul_of] at h
  have hi := congrFun h i
  exact hi

end Litt3.Deformations

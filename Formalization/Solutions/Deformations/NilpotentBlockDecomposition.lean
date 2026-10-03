import Mathlib.Algebra.Module.PID
import Mathlib.Algebra.Polynomial.Module.AEval
import Mathlib.Algebra.Polynomial.RingDivision
import Definitions.Deformations.TruncatedCoefficientRing

namespace Litt3.Deformations

open Polynomial
open scoped DirectSum

universe u v

variable {k : Type u} [Field k] {V : Type v} [AddCommGroup V] [Module k V]

/-- Global nilpotence of the actual operator gives actual primary torsion
in its polynomial module, rather than an assumed block decomposition. -/
theorem nilpotent_polynomial_module_torsion (T : V →ₗ[k] V) (N : ℕ)
    (nilpotent : T ^ N = 0) :
    Module.IsTorsion' (Module.AEval' T) (Submonoid.powers (X : k[X])) := by
  rw [Submodule.isTorsion'_powers_iff]
  intro x
  refine ⟨N, ?_⟩
  obtain ⟨v, rfl⟩ := (Module.AEval'.of T).surjective x
  rw [Module.AEval'.X_pow_smul_of, nilpotent]
  change (Module.AEval'.of T) ((0 : V →ₗ[k] V) v) = 0
  simp

/-- The actual polynomial-module primary decomposition of any finite
dimensional nilpotent operator, over an arbitrary field. Zero summands
are still allowed at this intermediate statement. -/
theorem nilpotent_polynomial_module_decomposition [FiniteDimensional k V]
    (T : V →ₗ[k] V) (N : ℕ) (nilpotent : T ^ N = 0) :
    ∃ (d : ℕ) (length : Fin d → ℕ),
      Nonempty ((Module.AEval' T) ≃ₗ[k[X]]
        ⨁ i : Fin d, k[X] ⧸ Submodule.span k[X] {(X : k[X]) ^ length i}) := by
  exact Module.torsion_by_prime_power_decomposition (Polynomial.irreducible_X (R := k))
    (nilpotent_polynomial_module_torsion T N nilpotent)

end Litt3.Deformations

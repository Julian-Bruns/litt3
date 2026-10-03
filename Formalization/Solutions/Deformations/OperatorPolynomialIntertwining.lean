import Mathlib.Algebra.Polynomial.Module.Basic

namespace Litt3.Deformations

open Polynomial

variable {R M N : Type*} [CommRing R] [AddCommGroup M] [Module R M]
    [AddCommGroup N] [Module R N]

/-- An actual linear intertwiner retains every actual operator power. -/
theorem linear_map_intertwining_powers (f : M →ₗ[R] N) (A : Module.End R M)
    (B : Module.End R N) (commute : ∀ v, f (A v) = B (f v)) (n : ℕ) (v : M) :
    f ((A ^ n) v) = (B ^ n) (f v) := by
  induction n with
  | zero => rfl
  | succ n induction =>
    rw [pow_succ', Module.End.mul_apply, commute, induction]
    rw [pow_succ', Module.End.mul_apply]

/-- The actual original polynomial action is retained by an actual
linear intertwiner. Neither polynomial action is replaced by a model. -/
theorem linear_map_intertwining_polynomial (f : M →ₗ[R] N) (A : Module.End R M)
    (B : Module.End R N) (commute : ∀ v, f (A v) = B (f v)) (P : R[X]) (v : M) :
    f (Polynomial.aeval A P v) = Polynomial.aeval B P (f v) := by
  induction P using Polynomial.induction_on' with
  | add P Q induction induction' =>
    simp only [map_add, LinearMap.add_apply, induction, induction']
  | monomial n c =>
    simp only [Polynomial.aeval_monomial, Module.End.mul_apply,
      Module.algebraMap_end_apply, map_smul,
      linear_map_intertwining_powers f A B commute]

end Litt3.Deformations

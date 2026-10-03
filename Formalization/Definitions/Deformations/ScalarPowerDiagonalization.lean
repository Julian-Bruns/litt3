import Definitions.Deformations.DiagonalScalarQuotient

namespace Litt3.Deformations

variable {R M : Type*} [CommRing R] [AddCommGroup M] [Module R M]

/-- An actual two-basis scalar-power diagonalization of the original
operator. This contains literal maps and a full operator identity;
it does not assume any factor counts or cokernel conclusion. -/
structure ScalarPowerDiagonalization (r : R) (d N : ℕ) (A : Module.End R M) where
  source : M ≃ₗ[R] (Fin d → R)
  target : M ≃ₗ[R] (Fin d → R)
  exponent : Fin d → ℕ
  exponent_bound : ∀ i, exponent i ≤ N
  equation : ∀ v : Fin d → R,
    target (A (source.symm v)) =
      diagonalScalarOperator (M := fun _ : Fin d => R) (fun i => r ^ exponent i) v

end Litt3.Deformations

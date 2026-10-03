import Solutions.Deformations.FormalCyclicGeneration
import Solutions.Deformations.PolynomialCyclicCompletion
import Mathlib.LinearAlgebra.Pi
import Mathlib.Logic.Equiv.Fin.Basic

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- Literal finite coordinates on the original polynomial quotient,
obtained from full cyclic division and the actual coefficient basis. -/
noncomputable def polynomialFiniteCoordinates (p a f : ℕ) [Fact p.Prime]
    (vanish : (p : R) ^ (a + 1) = 0)
    (basis : K ≃ₗ[R] (Fin f → R)) :
    PolynomialCyclicModule (R := R) (K := K) p a ≃ₗ[R] (Fin (p ^ a * f) → R) :=
  ((polynomialCyclicCompletionEquiv (K := K) p a vanish).trans
    (formalCyclicCoordinates (K := K) p a vanish)).trans
      ((LinearEquiv.piCongrRight fun _ : Fin (p ^ a) => basis).trans
        ((LinearEquiv.curry R R (Fin (p ^ a)) (Fin f)).symm.trans
          (LinearEquiv.piCongrLeft R (fun _ : Fin (p ^ a * f) => R) finProdFinEquiv)))

end Litt3.Deformations

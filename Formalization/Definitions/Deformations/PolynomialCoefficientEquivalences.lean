import Definitions.Deformations.PolynomialCyclicGeneration
import Mathlib.LinearAlgebra.Finsupp.Defs

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- The original coefficient automorphism on literal polynomials. -/
noncomputable def polynomialCoefficientEquiv (Phi : K ≃ₗ[R] K) :
    PolynomialModule R K ≃ₗ[R] PolynomialModule R K :=
  Finsupp.mapRange.linearEquiv Phi

end Litt3.Deformations

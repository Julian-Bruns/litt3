import Mathlib.LinearAlgebra.BilinearForm.Orthogonal
import Mathlib.LinearAlgebra.Pi

namespace Litt3.CartierAndSpin

variable {K : Type*} [CommRing K]

def coupledDifferenceQuadratic (x : Fin 3 → K) : K :=
  x 0 * x 1 + x 0 * x 2 + x 1 * x 2

/-- Twice the polar pairing, written without a division by two. -/
def coupledDifferenceBilinear : LinearMap.BilinForm K (Fin 3 → K) :=
  (LinearMap.proj 0 : (Fin 3 → K) →ₗ[K] K).smulRight
    (LinearMap.proj 1 : (Fin 3 → K) →ₗ[K] K) +
  (LinearMap.proj 1 : (Fin 3 → K) →ₗ[K] K).smulRight
    (LinearMap.proj 0 : (Fin 3 → K) →ₗ[K] K) +
  (LinearMap.proj 0 : (Fin 3 → K) →ₗ[K] K).smulRight
    (LinearMap.proj 2 : (Fin 3 → K) →ₗ[K] K) +
  (LinearMap.proj 2 : (Fin 3 → K) →ₗ[K] K).smulRight
    (LinearMap.proj 0 : (Fin 3 → K) →ₗ[K] K) +
  (LinearMap.proj 1 : (Fin 3 → K) →ₗ[K] K).smulRight
    (LinearMap.proj 2 : (Fin 3 → K) →ₗ[K] K) +
  (LinearMap.proj 2 : (Fin 3 → K) →ₗ[K] K).smulRight
    (LinearMap.proj 1 : (Fin 3 → K) →ₗ[K] K)

end Litt3.CartierAndSpin

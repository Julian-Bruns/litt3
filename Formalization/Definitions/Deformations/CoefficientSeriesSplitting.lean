import Mathlib.LinearAlgebra.Pi

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- The actual formal coefficient sequence module. -/
abbrev CoefficientSeries := ℕ → K

def coefficientSeriesTail (h : ℕ) : CoefficientSeries (K := K) →ₗ[R] CoefficientSeries (K := K) where
  toFun v n := v (n + h)
  map_add' _ _ := rfl
  map_smul' _ _ := rfl

def coefficientSeriesShift (h : ℕ) : CoefficientSeries (K := K) →ₗ[R] CoefficientSeries (K := K) where
  toFun v n := if h ≤ n then v (n - h) else 0
  map_add' v w := by
    funext n
    by_cases bound : h ≤ n <;> simp [bound]
  map_smul' c v := by
    funext n
    by_cases bound : h ≤ n <;> simp [bound]

def coefficientSeriesPrefix (h : ℕ) : CoefficientSeries (K := K) →ₗ[R] (Fin h → K) where
  toFun v n := v n.1
  map_add' _ _ := rfl
  map_smul' _ _ := rfl

def coefficientSeriesPrefixSection (h : ℕ) : (Fin h → K) →ₗ[R] CoefficientSeries (K := K) where
  toFun v n := if bound : n < h then v ⟨n, bound⟩ else 0
  map_add' v w := by
    funext n
    by_cases bound : n < h <;> simp [bound]
  map_smul' c v := by
    funext n
    by_cases bound : n < h <;> simp [bound]

end Litt3.Deformations

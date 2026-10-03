import Definitions.Deformations.CoefficientSeriesSplitting
import Mathlib.Algebra.Polynomial.Module.Basic

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- The literal polynomial submodule of full coefficient sequences:
the coefficients vanish above some finite degree. -/
def polynomialCoefficientSeries : Submodule R (CoefficientSeries (K := K)) where
  carrier := {v | ∃ N : ℕ, ∀ m, N ≤ m → v m = 0}
  zero_mem' := ⟨0, by simp⟩
  add_mem' := by
    rintro v w ⟨N, bound⟩ ⟨M, bound'⟩
    refine ⟨max N M, ?_⟩
    intro m high
    simp only [Pi.add_apply, bound m ((le_max_left _ _).trans high),
      bound' m ((le_max_right _ _).trans high), zero_add]
  smul_mem' := by
    rintro c v ⟨N, bound⟩
    refine ⟨N, ?_⟩
    intro m high
    simp only [Pi.smul_apply, bound m high, smul_zero]

def polynomialSeriesShift (h : ℕ) :
    Module.End R (polynomialCoefficientSeries (R := R) (K := K)) where
  toFun v := ⟨coefficientSeriesShift (R := R) h v, by
    obtain ⟨N, bound⟩ := v.2
    refine ⟨N + h, ?_⟩
    intro m high
    have lower : h ≤ m := by omega
    have residual : N ≤ m - h := by omega
    change (if h ≤ m then (v : CoefficientSeries (K := K)) (m - h) else 0) = 0
    rw [if_pos lower]
    exact bound _ residual⟩
  map_add' v w := Subtype.ext ((coefficientSeriesShift (R := R) h).map_add
    (v : CoefficientSeries (K := K)) (w : CoefficientSeries (K := K)))
  map_smul' c v := by
    apply Subtype.ext
    change coefficientSeriesShift (R := R) h (c • (v : CoefficientSeries (K := K))) =
      c • coefficientSeriesShift (R := R) h (v : CoefficientSeries (K := K))
    exact (coefficientSeriesShift (R := R) h).map_smul c (v : CoefficientSeries (K := K))

def polynomialSeriesTail (h : ℕ) :
    Module.End R (polynomialCoefficientSeries (R := R) (K := K)) where
  toFun v := ⟨coefficientSeriesTail (R := R) h v, by
    obtain ⟨N, bound⟩ := v.2
    refine ⟨N, ?_⟩
    intro m high
    exact bound (m + h) (by omega)⟩
  map_add' v w := Subtype.ext ((coefficientSeriesTail (R := R) h).map_add
    (v : CoefficientSeries (K := K)) (w : CoefficientSeries (K := K)))
  map_smul' c v := by
    apply Subtype.ext
    change coefficientSeriesTail (R := R) h (c • (v : CoefficientSeries (K := K))) =
      c • coefficientSeriesTail (R := R) h (v : CoefficientSeries (K := K))
    exact (coefficientSeriesTail (R := R) h).map_smul c (v : CoefficientSeries (K := K))

def polynomialSeriesPrefix (h : ℕ) :
    polynomialCoefficientSeries (R := R) (K := K) →ₗ[R] (Fin h → K) :=
  (coefficientSeriesPrefix h).comp (polynomialCoefficientSeries (R := R) (K := K)).subtype

def polynomialSeriesPrefixSection (h : ℕ) :
    (Fin h → K) →ₗ[R] polynomialCoefficientSeries (R := R) (K := K) where
  toFun v := ⟨coefficientSeriesPrefixSection (R := R) h v, by
    refine ⟨h, ?_⟩
    intro m high
    change (if bound : m < h then v ⟨m, bound⟩ else 0) = 0
    exact dif_neg (Nat.not_lt.mpr high)⟩
  map_add' v w := Subtype.ext ((coefficientSeriesPrefixSection (R := R) h).map_add v w)
  map_smul' c v := Subtype.ext ((coefficientSeriesPrefixSection (R := R) h).map_smul c v)

def polynomialSeriesCorrection (C : Module.End R (CoefficientSeries (K := K)))
    (preserve : ∀ v : polynomialCoefficientSeries (R := R) (K := K),
      C v ∈ polynomialCoefficientSeries (R := R) (K := K)) :
    Module.End R (polynomialCoefficientSeries (R := R) (K := K)) where
  toFun v := ⟨C v, preserve v⟩
  map_add' v w := Subtype.ext (C.map_add
    (v : CoefficientSeries (K := K)) (w : CoefficientSeries (K := K)))
  map_smul' c v := by
    apply Subtype.ext
    change C (c • (v : CoefficientSeries (K := K))) = c • C (v : CoefficientSeries (K := K))
    exact C.map_smul c (v : CoefficientSeries (K := K))

end Litt3.Deformations

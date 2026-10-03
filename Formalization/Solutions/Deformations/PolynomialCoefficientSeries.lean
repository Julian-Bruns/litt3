import Definitions.Deformations.PolynomialCoefficientSeries
import Solutions.Deformations.CoefficientSeriesSplitting

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- The actual standard polynomial module embeds as precisely the
literal polynomial coefficient sequences. -/
noncomputable def polynomialCoefficientInclusion :
    PolynomialModule R K →ₗ[R] polynomialCoefficientSeries (R := R) (K := K) where
  toFun u := ⟨u, by
    classical
    refine ⟨(u : ℕ →₀ K).support.sup id + 1, ?_⟩
    intro m high
    by_contra nonzero
    have member := Finsupp.mem_support_iff.mpr nonzero
    have lower : m ≤ (u : ℕ →₀ K).support.sup id := Finset.le_sup (f := id) member
    omega⟩
  map_add' v w := Subtype.ext (funext (fun _ => rfl))
  map_smul' c v := Subtype.ext (funext (fun _ => rfl))

theorem polynomial_coefficient_inclusion_bijective :
    Function.Bijective (polynomialCoefficientInclusion (R := R) (K := K)) := by
  classical
  constructor
  · intro v w same
    apply Finsupp.ext
    intro m
    exact congrArg (fun u : polynomialCoefficientSeries (R := R) (K := K) => u.val m) same
  · intro v
    obtain ⟨N, bound⟩ := v.2
    let u : ℕ →₀ K := Finsupp.onFinset (Finset.range N) v (by
      intro m nonzero
      apply Finset.mem_range.mpr
      by_contra notHigh
      exact nonzero (bound m (Nat.le_of_not_gt notHigh)))
    exact ⟨u, Subtype.ext (funext (fun _ => rfl))⟩

noncomputable def polynomialCoefficientSeriesEquiv :
    PolynomialModule R K ≃ₗ[R] polynomialCoefficientSeries (R := R) (K := K) :=
  LinearEquiv.ofBijective polynomialCoefficientInclusion polynomial_coefficient_inclusion_bijective

@[simp] theorem polynomial_series_tail_shift (h : ℕ)
    (v : polynomialCoefficientSeries (R := R) (K := K)) :
    polynomialSeriesTail (R := R) h (polynomialSeriesShift (R := R) h v) = v := by
  apply Subtype.ext
  exact coefficient_series_tail_shift (R := R) h (v : CoefficientSeries (K := K))

@[simp] theorem polynomial_series_prefix_section (h : ℕ) (v : Fin h → K) :
    polynomialSeriesPrefix (R := R) h (polynomialSeriesPrefixSection (R := R) h v) = v :=
  coefficient_series_prefix_section (R := R) h v

@[simp] theorem polynomial_series_tail_section (h : ℕ) (v : Fin h → K) :
    polynomialSeriesTail (R := R) h (polynomialSeriesPrefixSection (R := R) h v) = 0 := by
  apply Subtype.ext
  exact coefficient_series_tail_prefix_section (R := R) h v

theorem polynomial_series_recompose (h : ℕ)
    (v : polynomialCoefficientSeries (R := R) (K := K)) :
    polynomialSeriesPrefixSection (R := R) h (polynomialSeriesPrefix (R := R) h v) +
      polynomialSeriesShift (R := R) h (polynomialSeriesTail (R := R) h v) = v := by
  apply Subtype.ext
  exact coefficient_series_recompose (R := R) h (v : CoefficientSeries (K := K))

end Litt3.Deformations

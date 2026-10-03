import Definitions.Deformations.NilpotentSeriesPreparation
import Solutions.Deformations.CoefficientSeriesSplitting
import Solutions.Deformations.NilpotentPerturbation

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]
    (h : ℕ) (parameter : R) (nilpotent : IsNilpotent parameter)
    (correction : CoefficientSeries (K := K) →ₗ[R] CoefficientSeries (K := K))

include nilpotent in
theorem prepared_series_tail_unit :
    IsUnit ((coefficientSeriesTail h).comp (preparedSeriesOperator h parameter correction)) := by
  have identity : (coefficientSeriesTail h).comp (preparedSeriesOperator h parameter correction) =
      1 + parameter • (coefficientSeriesTail h).comp correction := by
    apply LinearMap.ext
    intro v
    simp [preparedSeriesOperator, LinearMap.comp_apply]
  rw [identity]
  exact unit_survives_nilpotent_scalar (1 : Module.End R (CoefficientSeries (K := K)))
    isUnit_one parameter nilpotent ((coefficientSeriesTail h).comp correction)

noncomputable def preparedSeriesTailEquiv :
    CoefficientSeries (K := K) ≃ₗ[R] CoefficientSeries (K := K) :=
  LinearEquiv.ofBijective ((coefficientSeriesTail h).comp
    (preparedSeriesOperator h parameter correction))
    ((Module.End.isUnit_iff _).mp (prepared_series_tail_unit h parameter nilpotent correction))

@[simp] theorem prepared_series_tail_equiv_apply (v : CoefficientSeries (K := K)) :
    preparedSeriesTailEquiv h parameter nilpotent correction v =
      coefficientSeriesTail (R := R) h (preparedSeriesOperator h parameter correction v) := rfl

include nilpotent in
/-- Distinguished division exists uniquely for every full formal
sequence. The proof uses a nilpotent inverse, and works in arbitrary
module rank over every commutative coefficient ring. -/
theorem prepared_series_reconstruction_bijective :
    Function.Bijective (preparedSeriesReconstruction h parameter correction) := by
  constructor
  · rintro ⟨r, g⟩ ⟨r', g'⟩ same
    change coefficientSeriesPrefixSection (R := R) h r + preparedSeriesOperator h parameter correction g =
      coefficientSeriesPrefixSection (R := R) h r' + preparedSeriesOperator h parameter correction g' at same
    have tails := congrArg (coefficientSeriesTail (R := R) h) same
    simp only [map_add, coefficient_series_tail_prefix_section, zero_add] at tails
    have quotient : g = g' := (preparedSeriesTailEquiv h parameter nilpotent correction).injective tails
    subst g'
    have prefixes := congrArg (coefficientSeriesPrefix (R := R) h) (add_right_cancel same)
    simp only [coefficient_series_prefix_section] at prefixes
    exact Prod.ext prefixes rfl
  · intro v
    let quotient := (preparedSeriesTailEquiv h parameter nilpotent correction).symm
      (coefficientSeriesTail (R := R) h v)
    let residual := v - preparedSeriesOperator h parameter correction quotient
    have tail_zero : coefficientSeriesTail (R := R) h residual = 0 := by
      change coefficientSeriesTail h (v - preparedSeriesOperator h parameter correction
        ((preparedSeriesTailEquiv h parameter nilpotent correction).symm (coefficientSeriesTail h v))) = 0
      rw [map_sub, ← prepared_series_tail_equiv_apply h parameter nilpotent correction,
        LinearEquiv.apply_symm_apply, sub_self]
    refine ⟨⟨coefficientSeriesPrefix (R := R) h residual, quotient⟩, ?_⟩
    change coefficientSeriesPrefixSection (R := R) h (coefficientSeriesPrefix (R := R) h residual) +
      preparedSeriesOperator h parameter correction quotient = v
    rw [coefficient_series_eq_prefix_of_tail_zero h residual tail_zero]
    exact sub_add_cancel _ _

noncomputable def preparedSeriesDivisionEquiv :
    CoefficientSeries (K := K) ≃ₗ[R] ((Fin h → K) × CoefficientSeries (K := K)) :=
  (LinearEquiv.ofBijective (preparedSeriesReconstruction h parameter correction)
    (prepared_series_reconstruction_bijective h parameter nilpotent correction)).symm

end Litt3.Deformations

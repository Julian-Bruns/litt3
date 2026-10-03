import Definitions.Deformations.PolynomialSeriesPreparation
import Solutions.Deformations.PolynomialCoefficientSeries
import Solutions.Deformations.NilpotentSeriesQuotient

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]
    (h : ℕ) (parameter : R) (nilpotent : IsNilpotent parameter)
    (C : Module.End R (CoefficientSeries (K := K)))
    (preserve : ∀ v : polynomialCoefficientSeries (R := R) (K := K),
      C v ∈ polynomialCoefficientSeries (R := R) (K := K))

include nilpotent in
theorem polynomial_prepared_tail_unit :
    IsUnit ((polynomialSeriesTail h).comp (polynomialPreparedSeriesOperator h parameter C preserve)) := by
  have identity : (polynomialSeriesTail h).comp (polynomialPreparedSeriesOperator h parameter C preserve) =
      1 + parameter • (polynomialSeriesTail h).comp (polynomialSeriesCorrection C preserve) := by
    apply LinearMap.ext
    intro v
    simp [polynomialPreparedSeriesOperator, LinearMap.comp_apply]
  rw [identity]
  exact unit_survives_nilpotent_scalar (1 : Module.End R (polynomialCoefficientSeries (R := R) (K := K)))
    isUnit_one parameter nilpotent ((polynomialSeriesTail h).comp (polynomialSeriesCorrection C preserve))

noncomputable def polynomialPreparedTailEquiv :
    polynomialCoefficientSeries (R := R) (K := K) ≃ₗ[R]
      polynomialCoefficientSeries (R := R) (K := K) :=
  LinearEquiv.ofBijective ((polynomialSeriesTail h).comp
    (polynomialPreparedSeriesOperator h parameter C preserve))
    ((Module.End.isUnit_iff _).mp (polynomial_prepared_tail_unit h parameter nilpotent C preserve))

include nilpotent in
/-- The complete actual distinguished division preserves the actual
polynomial submodule whenever the original correction does. Arbitrary
coefficient rank and noncommuting coefficient operators are allowed. -/
theorem polynomial_prepared_reconstruction_bijective :
    Function.Bijective (polynomialPreparedSeriesReconstruction h parameter C preserve) := by
  constructor
  · rintro ⟨r, g⟩ ⟨r', g'⟩ same
    change polynomialSeriesPrefixSection (R := R) h r + polynomialPreparedSeriesOperator h parameter C preserve g =
      polynomialSeriesPrefixSection (R := R) h r' + polynomialPreparedSeriesOperator h parameter C preserve g' at same
    have tails := congrArg (polynomialSeriesTail (R := R) h) same
    simp only [map_add, polynomial_series_tail_section, zero_add] at tails
    have quotient : g = g' := (polynomialPreparedTailEquiv h parameter nilpotent C preserve).injective tails
    subst g'
    have prefixes := congrArg (polynomialSeriesPrefix (R := R) h) (add_right_cancel same)
    simp only [polynomial_series_prefix_section] at prefixes
    exact Prod.ext prefixes rfl
  · intro v
    let quotient := (polynomialPreparedTailEquiv h parameter nilpotent C preserve).symm
      (polynomialSeriesTail (R := R) h v)
    let residual := v - polynomialPreparedSeriesOperator h parameter C preserve quotient
    have tail_zero : polynomialSeriesTail (R := R) h residual = 0 := by
      change polynomialSeriesTail h (v - polynomialPreparedSeriesOperator h parameter C preserve
        ((polynomialPreparedTailEquiv h parameter nilpotent C preserve).symm (polynomialSeriesTail h v))) = 0
      rw [map_sub]
      change polynomialSeriesTail h v - polynomialPreparedTailEquiv h parameter nilpotent C preserve
        ((polynomialPreparedTailEquiv h parameter nilpotent C preserve).symm (polynomialSeriesTail h v)) = 0
      rw [LinearEquiv.apply_symm_apply, sub_self]
    have reconstruct := polynomial_series_recompose (R := R) h residual
    rw [tail_zero, map_zero, add_zero] at reconstruct
    refine ⟨⟨polynomialSeriesPrefix (R := R) h residual, quotient⟩, ?_⟩
    change polynomialSeriesPrefixSection (R := R) h (polynomialSeriesPrefix (R := R) h residual) +
      polynomialPreparedSeriesOperator h parameter C preserve quotient = v
    rw [reconstruct]
    exact sub_add_cancel _ _

noncomputable def polynomialPreparedDivisionEquiv :
    polynomialCoefficientSeries (R := R) (K := K) ≃ₗ[R]
      ((Fin h → K) × polynomialCoefficientSeries (R := R) (K := K)) :=
  (LinearEquiv.ofBijective (polynomialPreparedSeriesReconstruction h parameter C preserve)
    (polynomial_prepared_reconstruction_bijective h parameter nilpotent C preserve)).symm

noncomputable def polynomialPreparedRemainder :
    polynomialCoefficientSeries (R := R) (K := K) →ₗ[R] (Fin h → K) :=
  (LinearMap.fst R _ _).comp (polynomialPreparedDivisionEquiv h parameter nilpotent C preserve).toLinearMap

theorem polynomial_prepared_division_reconstruct
    (v : polynomialCoefficientSeries (R := R) (K := K)) :
    polynomialSeriesPrefixSection (R := R) h
      (polynomialPreparedDivisionEquiv h parameter nilpotent C preserve v).1 +
      polynomialPreparedSeriesOperator h parameter C preserve
        (polynomialPreparedDivisionEquiv h parameter nilpotent C preserve v).2 = v :=
  (polynomialPreparedDivisionEquiv h parameter nilpotent C preserve).symm_apply_apply v

theorem polynomial_prepared_division_reconstruction (r : Fin h → K)
    (g : polynomialCoefficientSeries (R := R) (K := K)) :
    polynomialPreparedDivisionEquiv h parameter nilpotent C preserve
      (polynomialSeriesPrefixSection (R := R) h r + polynomialPreparedSeriesOperator h parameter C preserve g) =
      (r, g) :=
  (polynomialPreparedDivisionEquiv h parameter nilpotent C preserve).apply_symm_apply (r, g)

@[simp] theorem polynomial_prepared_remainder_section (r : Fin h → K) :
    polynomialPreparedRemainder h parameter nilpotent C preserve
      (polynomialSeriesPrefixSection (R := R) h r) = r := by
  have identity := congrArg Prod.fst (polynomial_prepared_division_reconstruction h parameter nilpotent C preserve r 0)
  simpa only [map_zero, add_zero] using identity

@[simp] theorem polynomial_prepared_remainder_operator
    (g : polynomialCoefficientSeries (R := R) (K := K)) :
    polynomialPreparedRemainder h parameter nilpotent C preserve
      (polynomialPreparedSeriesOperator h parameter C preserve g) = 0 := by
  have identity := congrArg Prod.fst (polynomial_prepared_division_reconstruction h parameter nilpotent C preserve 0 g)
  simpa only [map_zero, zero_add] using identity

theorem polynomial_prepared_remainder_kernel :
    LinearMap.ker (polynomialPreparedRemainder h parameter nilpotent C preserve) =
      LinearMap.range (polynomialPreparedSeriesOperator h parameter C preserve) := by
  ext v
  constructor
  · intro zero
    have remainder : (polynomialPreparedDivisionEquiv h parameter nilpotent C preserve v).1 = 0 := zero
    have identity := polynomial_prepared_division_reconstruct h parameter nilpotent C preserve v
    rw [remainder, map_zero, zero_add] at identity
    exact ⟨_, identity⟩
  · rintro ⟨g, rfl⟩
    exact polynomial_prepared_remainder_operator h parameter nilpotent C preserve g

noncomputable def polynomialPreparedQuotientEquiv :
    (polynomialCoefficientSeries (R := R) (K := K) ⧸
      LinearMap.range (polynomialPreparedSeriesOperator h parameter C preserve)) ≃ₗ[R] (Fin h → K) :=
  (Submodule.quotEquivOfEq _ _ (polynomial_prepared_remainder_kernel h parameter nilpotent C preserve).symm).trans
    ((polynomialPreparedRemainder h parameter nilpotent C preserve).quotKerEquivOfSurjective
      (fun r => ⟨polynomialSeriesPrefixSection (R := R) h r,
        polynomial_prepared_remainder_section h parameter nilpotent C preserve r⟩))

end Litt3.Deformations

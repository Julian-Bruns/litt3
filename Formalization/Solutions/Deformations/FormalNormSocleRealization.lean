import Solutions.Deformations.SeriesLastMonomial
import Solutions.Deformations.FormalPreparedImages
import Solutions.Deformations.FormalCyclicReduction
import Solutions.Deformations.SeriesPowerCancellation

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- Every original q−1 socle coefficient is realized by an actual
full kernel primitive. This is an explicit original relation-witness
construction; no dimension or cardinality comparison is used. -/
theorem formal_norm_socle_realization (p a n : ℕ) [Fact p.Prime]
    (characteristic : 2 * (n + 1) < p) (bound : n + 1 ≤ p ^ a)
    (vanish : (p : R) ^ (a + 1) = 0)
    (C : Module.End R (CoefficientSeries (K := K)))
    (commute : Commute C (coefficientSeriesShift 1)) (theta : K) :
    ∃ w z : CoefficientSeries (K := K),
      preparedSeriesOperator (n + 1) (p : R) C w = formalCyclicRelation (R := R) p a z ∧
      scalarCoefficientReduction (p : R) w =
        coefficientSeriesShift (R := R) (p ^ a - 1)
          (coefficientSeriesConstant (R := R)
            ((coefficientScalarRange (K := K) (p : R)).mkQ theta)) := by
  let A := preparedSeriesOperator (n + 1) (p : R) C
  let q := (LinearMap.range A).mkQ
  let E := preparedSeriesQuotientAugmentation (n + 1) (p : R) C
    (prepared_series_operator_commute_shift (n + 1) (p : R) C commute)
  let z := coefficientSeriesShift (R := R) n (coefficientSeriesConstant (R := R) theta)
  have coordinates : preparedSeriesQuotientEquiv (n + 1) (p : R) ⟨a + 1, vanish⟩ C (q z) =
      (fun j : Fin (n + 1) => if j.val = n then theta else 0) := by
    change preparedSeriesRemainder (n + 1) (p : R) ⟨a + 1, vanish⟩ C z = _
    dsimp only [z]
    rw [coefficient_series_monomial_as_section (n + 1) n (Nat.lt_succ_self n),
      prepared_series_remainder_section]
  have relationZero : preparedSeriesCyclicRelation (n + 1) p a C
      (prepared_series_operator_commute_shift (n + 1) (p : R) C commute) (q z) = 0 := by
    apply (prepared_cyclic_relation_zero_coordinates p a (n + 1) (Nat.zero_lt_succ n)
      characteristic bound vanish C commute (q z)).mpr
    rw [coordinates, LinearMap.smul_apply, finite_coefficient_shift_last, smul_zero]
  have originalZero : q (formalCyclicRelation (R := R) p a z) = 0 := by
    rw [prepared_quotient_original_relation (n + 1) p a C commute]
    change integralCyclicNormValue (R := R) p a E (E (q z)) = 0
    have central := integral_cyclic_norm_commute E E (Commute.refl E) p a
    change ((1 + E) ^ (p ^ a) - 1) (q z) = 0 at relationZero
    rw [integral_cyclic_relation_norm (R := R), central.eq, Module.End.mul_apply] at relationZero
    exact relationZero
  obtain ⟨w, same⟩ := (Submodule.Quotient.mk_eq_zero _).mp originalZero
  refine ⟨w, z, same, ?_⟩
  have reduced := congrArg (scalarCoefficientReduction (p : R)) same
  simp only [A, preparedSeriesOperator, LinearMap.add_apply, LinearMap.smul_apply,
    map_add, scalar_coefficient_reduction_kills, add_zero, scalar_coefficient_reduction_shift,
    formal_cyclic_relation_scalar_reduction] at reduced
  rw [coefficient_series_shift_equation (n + 1) (p ^ a) bound _ _ reduced]
  change coefficientSeriesShift (R := R) (p ^ a - (n + 1))
    (scalarCoefficientReduction (p : R)
      (coefficientSeriesShift (R := R) n (coefficientSeriesConstant (R := R) theta))) = _
  rw [scalar_coefficient_reduction_shift, scalar_coefficient_reduction_constant,
    ← Module.End.mul_apply]
  change ((coefficientSeriesShift (R := R) (p ^ a - (n + 1))).comp
    (coefficientSeriesShift n)) _ = _
  rw [coefficient_series_shift_comp]
  have exponent : p ^ a - (n + 1) + n = p ^ a - 1 := by omega
  rw [exponent]

end Litt3.Deformations

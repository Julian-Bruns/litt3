import Solutions.Deformations.PreparedAffineNormKernel
import Solutions.Deformations.FormalPreparedImages
import Solutions.Deformations.FormalCyclicReduction
import Solutions.Deformations.SeriesPowerCancellation

namespace Litt3.Deformations

/-- Every original full-series representative solving the literal
cyclic norm equation reduces to the original q−1 socle. The actual
relation witness, full prepared quotient, scalar kernel and exact
coefficient reduction are retained; no cardinality argument is used. -/
theorem formal_norm_primitive_necessity (p a n : ℕ) [Fact p.Prime]
    (K : Type*) [AddCommGroup K] [Module (ZMod (p ^ (a + 1))) K]
    [Module.Free (ZMod (p ^ (a + 1))) K]
    (characteristic : 2 * (n + 1) < p) (bound : n + 1 ≤ p ^ a)
    (C : Module.End (ZMod (p ^ (a + 1))) (CoefficientSeries (K := K)))
    (commute : Commute C (coefficientSeriesShift 1))
    (eta : K) (w z : CoefficientSeries (K := K))
    (equation : preparedSeriesOperator (n + 1) (p : ZMod (p ^ (a + 1))) C w =
      formalCyclicNorm (R := ZMod (p ^ (a + 1))) p a
        (coefficientSeriesConstant (R := ZMod (p ^ (a + 1))) eta) +
      formalCyclicRelation (R := ZMod (p ^ (a + 1))) p a z) :
    (coefficientScalarRange (K := K) (p : ZMod (p ^ (a + 1)))).mkQ eta = 0 ∧
      ∀ m : ℕ, m + 1 < p ^ a →
        (coefficientScalarRange (K := K) (p : ZMod (p ^ (a + 1)))).mkQ (w m) = 0 := by
  let R := ZMod (p ^ (a + 1))
  have vanish : (p : R) ^ (a + 1) = 0 := by
    rw [← Nat.cast_pow]
    exact (ZMod.natCast_eq_zero_iff _ _).mpr dvd_rfl
  let A := preparedSeriesOperator (n + 1) (p : R) C
  let q := (LinearMap.range A).mkQ
  let E := preparedSeriesQuotientAugmentation (n + 1) (p : R) C
    (prepared_series_operator_commute_shift (n + 1) (p : R) C commute)
  have zero : q (A w) = 0 := (Submodule.Quotient.mk_eq_zero _).mpr ⟨w, rfl⟩
  have original := congrArg q equation
  have normZero : integralCyclicNormValue (R := R) p a E
      (q (coefficientSeriesConstant (R := R) eta) + E (q z)) = 0 := by
    rw [zero, map_add, prepared_quotient_original_norm (n + 1) p a C commute,
      prepared_quotient_original_relation (n + 1) p a C commute] at original
    rw [map_add]
    exact original.symm
  have scalarCoordinates := (prepared_affine_norm_zero_coordinates p a n characteristic bound
    vanish C commute eta (q z)).mp normZero
  obtain ⟨etaZero, lowerCoordinates⟩ := (finite_shift_affine_scalar_zero n ((p : R) ^ a) eta _).mp
    scalarCoordinates
  have etaReduction : (coefficientScalarRange (K := K) (p : R)).mkQ eta = 0 :=
    free_zmod_last_scalar_reduction_zero p a (Fact.out : p.Prime).pos K eta etaZero
  have witnessLow : ∀ m : ℕ, m + 1 < n + 1 → scalarCoefficientReduction (p : R) z m = 0 := by
    intro m small
    have lower : m < n := by omega
    let j : Fin n := ⟨m, lower⟩
    have coordinateZero := lowerCoordinates j
    have reduction := free_zmod_last_scalar_reduction_zero p a (Fact.out : p.Prime).pos K _ coordinateZero
    change (coefficientScalarRange (K := K) (p : R)).mkQ (z j.castSucc.val) = 0
    rw [← prepared_series_remainder_scalar_reduction (n + 1) (p : R) ⟨a + 1, vanish⟩ C z j.castSucc]
    exact reduction
  have constantZero : scalarCoefficientReduction (p : R) (coefficientSeriesConstant (R := R) eta) = 0 := by
    funext m
    change (coefficientScalarRange (K := K) (p : R)).mkQ (if m = 0 then eta else 0) = 0
    by_cases isZero : m = 0 <;> simp [isZero, etaReduction]
  have reduced := congrArg (scalarCoefficientReduction (p : R)) equation
  change scalarCoefficientReduction (p : R) (A w) = _ at reduced
  simp only [A, preparedSeriesOperator, LinearMap.add_apply, LinearMap.smul_apply,
    map_add, scalar_coefficient_reduction_kills, add_zero, scalar_coefficient_reduction_shift,
    formal_cyclic_norm_scalar_reduction, formal_cyclic_relation_scalar_reduction,
    constantZero, map_zero, zero_add] at reduced
  refine ⟨etaReduction, ?_⟩
  exact coefficient_series_shift_equation_socle (R := R) (n + 1) (p ^ a) bound
    (scalarCoefficientReduction (p : R) w) (scalarCoefficientReduction (p : R) z) reduced witnessLow

end Litt3.Deformations

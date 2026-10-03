import Solutions.Deformations.FormalCyclicPresentation
import Solutions.Deformations.FreeScalarKernel

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- Solvability for the original literal cyclic presentation is
equivalent to the exact top-scalar annihilator condition. No finite
rank, dimension or Smith-factor argument is used. -/
theorem formal_cyclic_norm_solvable_iff_top_scalar (p a n : ℕ) [Fact p.Prime]
    (characteristic : 2 * (n + 1) < p) (bound : n + 1 ≤ p ^ a)
    (vanish : (p : R) ^ (a + 1) = 0)
    (correction : Module.End R (CoefficientSeries (K := K)))
    (commute : Commute correction (coefficientSeriesShift 1)) (eta : K) :
    (∃ v, formalPreparedCyclicOperator (n + 1) p a correction
      (cyclic_relation_commute _ _
        (prepared_series_operator_commute_shift (n + 1) (p : R) correction commute) (p ^ a)).symm v =
        (LinearMap.range (formalCyclicRelation (R := R) (K := K) p a)).mkQ
          (formalCyclicNorm (R := R) p a (coefficientSeriesConstant (R := R) eta))) ↔
      (p : R) ^ a • eta = 0 := by
  let A := formalPreparedCyclicOperator (n + 1) p a correction
    (cyclic_relation_commute _ _
      (prepared_series_operator_commute_shift (n + 1) (p : R) correction commute) (p ^ a)).symm
  let e := formalSeriesCyclicCokernelEquiv p a n characteristic bound vanish correction commute
  let target := (LinearMap.range (formalCyclicRelation (R := R) (K := K) p a)).mkQ
    (formalCyclicNorm (R := R) p a (coefficientSeriesConstant (R := R) eta))
  have normal : e ((LinearMap.range A).mkQ target) = ((p : R) ^ a • eta, 0) :=
    formal_cyclic_norm_constant_class p a n characteristic bound vanish correction commute eta
  calc
    (∃ v, A v = target) ↔ target ∈ LinearMap.range A := Iff.rfl
    _ ↔ (LinearMap.range A).mkQ target = 0 := (Submodule.Quotient.mk_eq_zero _).symm
    _ ↔ e ((LinearMap.range A).mkQ target) = 0 := by
      constructor
      · intro zero
        rw [zero, map_zero]
      · intro zero
        apply e.injective
        simpa only [map_zero] using zero
    _ ↔ (p : R) ^ a • eta = 0 := by rw [normal]; simp

/-- On every actual free p-power integer coefficient module, the
original literal prepared cyclic norm equation is soluble exactly
for actual p-multiple constants, including infinite rank. -/
theorem formal_cyclic_norm_solvable_free_zmod (p a n : ℕ) [Fact p.Prime]
    (K : Type*) [AddCommGroup K] [Module (ZMod (p ^ (a + 1))) K]
    [Module.Free (ZMod (p ^ (a + 1))) K]
    (characteristic : 2 * (n + 1) < p) (bound : n + 1 ≤ p ^ a)
    (correction : Module.End (ZMod (p ^ (a + 1))) (CoefficientSeries (K := K)))
    (commute : Commute correction (coefficientSeriesShift 1)) (eta : K) :
    (∃ v, formalPreparedCyclicOperator (n + 1) p a correction
      (cyclic_relation_commute _ _
        (prepared_series_operator_commute_shift (n + 1)
          (p : ZMod (p ^ (a + 1))) correction commute) (p ^ a)).symm v =
        (LinearMap.range (formalCyclicRelation (R := ZMod (p ^ (a + 1))) (K := K) p a)).mkQ
          (formalCyclicNorm (R := ZMod (p ^ (a + 1))) p a
            (coefficientSeriesConstant (R := ZMod (p ^ (a + 1))) eta))) ↔
      eta ∈ coefficientScalarRange (p : ZMod (p ^ (a + 1))) := by
  have vanish : (p : ZMod (p ^ (a + 1))) ^ (a + 1) = 0 := by
    rw [← Nat.cast_pow]
    exact (ZMod.natCast_eq_zero_iff _ _).mpr dvd_rfl
  rw [formal_cyclic_norm_solvable_iff_top_scalar p a n characteristic bound vanish correction commute]
  change eta ∈ LinearMap.ker
    ((p : ZMod (p ^ (a + 1))) ^ a • (LinearMap.id : K →ₗ[ZMod (p ^ (a + 1))] K)) ↔ _
  rw [free_zmod_last_power_kernel p a (Fact.out : p.Prime).pos K]
  rfl

end Litt3.Deformations

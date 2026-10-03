import Definitions.Deformations.FormalCyclicGeneration
import Solutions.Deformations.FormalCyclicPreparation
import Solutions.Deformations.PreparedQuotientCoordinates
import Solutions.Deformations.CoefficientSeriesMonomials

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- The constructed full coefficient coordinates on the literal cyclic quotient. -/
noncomputable def formalCyclicCoordinates (p a : ℕ) [Fact p.Prime]
    (vanish : (p : R) ^ (a + 1) = 0) :
    FormalCyclicModule (R := R) (K := K) p a ≃ₗ[R] (Fin (p ^ a) → K) :=
  (Submodule.quotEquivOfEq _ _ (congrArg LinearMap.range
    (formal_cyclic_relation_prepared (R := R) (K := K) p a Fact.out))).trans
    (preparedSeriesQuotientEquiv (p ^ a) (p : R) ⟨a + 1, vanish⟩
      (formalCyclicCorrection (R := R) (K := K) p a))

theorem formal_cyclic_coordinates_symm (p a : ℕ) [Fact p.Prime]
    (vanish : (p : R) ^ (a + 1) = 0) (c : Fin (p ^ a) → K) :
    (formalCyclicCoordinates (K := K) p a vanish).symm c =
      (LinearMap.range (formalCyclicRelation (R := R) (K := K) p a)).mkQ
        (coefficientSeriesPrefixSection (R := R) (p ^ a) c) := by
  apply (formalCyclicCoordinates (K := K) p a vanish).injective
  rw [LinearEquiv.apply_symm_apply]
  change c = preparedSeriesRemainder (p ^ a) (p : R) ⟨a + 1, vanish⟩
    (formalCyclicCorrection (R := R) (K := K) p a)
      (coefficientSeriesPrefixSection (R := R) (p ^ a) c)
  exact (prepared_series_remainder_section _ _ _ _ c).symm

theorem formal_cyclic_augmentation_power_constant (p a j : ℕ) (eta : K) :
    (formalCyclicAugmentation (R := R) (K := K) p a ^ j)
      (formalCyclicConstant (R := R) (K := K) p a eta) =
      (LinearMap.range (formalCyclicRelation (R := R) (K := K) p a)).mkQ
        (coefficientSeriesShift (R := R) j (coefficientSeriesConstant (R := R) eta)) := by
  rw [formalCyclicConstant, LinearMap.comp_apply, formalCyclicAugmentation,
    commuting_range_quotient_pow_apply_mk, coefficient_series_shift_power]

/-- Every original cyclic coefficient class is a finite sum of the
actual augmentation powers of its actual constant coefficient generators.
The generation property is deduced from full preparation, at arbitrary rank. -/
theorem formal_cyclic_power_generation (p a : ℕ) [Fact p.Prime]
    (vanish : (p : R) ^ (a + 1) = 0)
    (v : FormalCyclicModule (R := R) (K := K) p a) :
    ∃ c : Fin (p ^ a) → K,
      v = ∑ j : Fin (p ^ a), (formalCyclicAugmentation (R := R) (K := K) p a ^ j.val)
        (formalCyclicConstant (R := R) (K := K) p a (c j)) := by
  refine ⟨formalCyclicCoordinates (K := K) p a vanish v, ?_⟩
  have reconstruction := (formalCyclicCoordinates (K := K) p a vanish).symm_apply_apply v
  rw [formal_cyclic_coordinates_symm, coefficient_series_section_sum, map_sum] at reconstruction
  simpa only [formal_cyclic_augmentation_power_constant] using reconstruction.symm

end Litt3.Deformations

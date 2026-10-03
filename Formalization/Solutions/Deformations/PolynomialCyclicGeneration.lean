import Definitions.Deformations.PolynomialCyclicGeneration
import Solutions.Deformations.PolynomialCyclicCompletion
import Solutions.Deformations.FormalCyclicGeneration

namespace Litt3.Deformations

open Polynomial

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

theorem polynomial_coefficient_full_map_shift (u : PolynomialModule R K) :
    polynomialCoefficientFullMap (R := R) (polynomialCoefficientShift (R := R) u) =
      coefficientSeriesShift (R := R) 1 (polynomialCoefficientFullMap (R := R) u) := by
  simpa only [PolynomialModule.smul_def, Polynomial.aeval_X, polynomialCoefficientShift]
    using polynomial_coefficient_full_map_X (R := R) u

theorem polynomial_coefficient_full_map_constant (eta : K) :
    polynomialCoefficientFullMap (R := R) (PolynomialModule.lsingle R 0 eta) =
      coefficientSeriesConstant (R := R) eta := by
  funext n
  simp [polynomial_coefficient_full_map_apply, PolynomialModule.lsingle_apply,
    coefficientSeriesConstant, eq_comm]

/-- The completion intertwines the actual original augmentations. -/
theorem polynomial_cyclic_completion_augmentation (p a : ℕ) [Fact p.Prime]
    (vanish : (p : R) ^ (a + 1) = 0)
    (v : PolynomialCyclicModule (R := R) (K := K) p a) :
    polynomialCyclicCompletionEquiv (K := K) p a vanish
      (polynomialCyclicAugmentation (R := R) (K := K) p a v) =
      formalCyclicAugmentation (R := R) (K := K) p a
        (polynomialCyclicCompletionEquiv (K := K) p a vanish v) := by
  obtain ⟨u, rfl⟩ := (LinearMap.range (polynomialCyclicOperator (R := R) (K := K) p a)).mkQ_surjective v
  rw [polynomialCyclicAugmentation, commuting_range_quotient_apply_mk,
    polynomial_cyclic_completion_equiv_mk, polynomial_cyclic_completion_equiv_mk,
    formalCyclicAugmentation, commuting_range_quotient_apply_mk,
    polynomial_coefficient_full_map_shift]

theorem polynomial_cyclic_completion_constant (p a : ℕ) [Fact p.Prime]
    (vanish : (p : R) ^ (a + 1) = 0) (eta : K) :
    polynomialCyclicCompletionEquiv (K := K) p a vanish
      (polynomialCyclicConstant (R := R) (K := K) p a eta) =
      formalCyclicConstant (R := R) (K := K) p a eta := by
  rw [polynomialCyclicConstant, LinearMap.comp_apply, polynomial_cyclic_completion_equiv_mk,
    polynomial_coefficient_full_map_constant]
  rfl

/-- The original polynomial norm and its original coefficient target
are retained literally under completion. -/
theorem polynomial_cyclic_completion_norm_constant (p a : ℕ) [Fact p.Prime]
    (vanish : (p : R) ^ (a + 1) = 0) (eta : K) :
    polynomialCyclicCompletionEquiv (K := K) p a vanish
      ((LinearMap.range (polynomialCyclicOperator (R := R) (K := K) p a)).mkQ
        (polynomialCyclicNormOperator (R := R) (K := K) p a (PolynomialModule.lsingle R 0 eta))) =
      (LinearMap.range (formalCyclicRelation (R := R) (K := K) p a)).mkQ
        (formalCyclicNorm (R := R) p a (coefficientSeriesConstant (R := R) eta)) := by
  rw [polynomial_cyclic_completion_equiv_mk, polynomialCyclicNormOperator,
    polynomial_scalar_operator_apply, polynomial_coefficient_full_map_smul,
    cyclic_group_norm_aeval, polynomial_coefficient_full_map_constant]
  rfl

end Litt3.Deformations

import Definitions.Deformations.PolynomialCoefficientEquivalences
import Solutions.Deformations.PolynomialCyclicGeneration
import Solutions.Deformations.CoefficientSeriesMaps
import Solutions.Deformations.CommutingQuotientOperators
import Solutions.Deformations.MixedComparisonCommutation

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

theorem polynomial_coefficient_full_map_injective :
    Function.Injective (polynomialCoefficientFullMap (R := R) (K := K)) := by
  intro u v same
  apply Finsupp.ext
  intro n
  exact congrFun same n

theorem polynomial_coefficient_equiv_full_map (Phi : K ≃ₗ[R] K) (u : PolynomialModule R K) :
    polynomialCoefficientFullMap (R := R) (polynomialCoefficientEquiv Phi u) =
      coefficientSeriesEquiv Phi (polynomialCoefficientFullMap (R := R) u) := by
  funext n
  rfl

theorem polynomial_coefficient_equiv_commute_shift (Phi : K ≃ₗ[R] K) :
    Commute (polynomialCoefficientEquiv Phi).toLinearMap
      (polynomialCoefficientShift (R := R) (K := K)) := by
  apply LinearMap.ext
  intro u
  apply polynomial_coefficient_full_map_injective
  change polynomialCoefficientFullMap (R := R)
      (polynomialCoefficientEquiv Phi (polynomialCoefficientShift (R := R) u)) =
    polynomialCoefficientFullMap (R := R)
      (polynomialCoefficientShift (R := R) (polynomialCoefficientEquiv Phi u))
  rw [polynomial_coefficient_equiv_full_map, polynomial_coefficient_full_map_shift,
    polynomial_coefficient_full_map_shift, polynomial_coefficient_equiv_full_map]
  exact LinearMap.congr_fun (coefficient_series_equiv_commute_shift Phi 1).eq _

theorem polynomial_coefficient_equiv_commute_relation (p a : ℕ) (Phi : K ≃ₗ[R] K) :
    Commute (polynomialCoefficientEquiv Phi).toLinearMap
      (polynomialCyclicOperator (R := R) (K := K) p a) := by
  unfold polynomialCyclicOperator polynomialScalarOperator cyclicGroupPolynomial
  simp only [map_sub, map_pow, map_add, map_one, Polynomial.aeval_X]
  exact cyclic_relation_commute _ _ (polynomial_coefficient_equiv_commute_shift Phi) (p ^ a)

theorem polynomial_coefficient_equiv_conjugate_relation (p a : ℕ) (Phi : K ≃ₗ[R] K) :
    (polynomialCoefficientEquiv Phi).conj (polynomialCyclicOperator (R := R) (K := K) p a) =
      polynomialCyclicOperator (R := R) (K := K) p a := by
  apply LinearMap.ext
  intro u
  rw [LinearEquiv.conj_apply_apply]
  have point := LinearMap.congr_fun (polynomial_coefficient_equiv_commute_relation p a Phi).eq
    ((polynomialCoefficientEquiv Phi).symm u)
  simpa only [Module.End.mul_apply, LinearEquiv.coe_coe, LinearEquiv.apply_symm_apply] using point

/-- The actual coefficient automorphism on the actual original cyclic
polynomial module; its relation-preserving action is proved. -/
noncomputable def polynomialCyclicCoefficientEquiv (p a : ℕ) (Phi : K ≃ₗ[R] K) :
    PolynomialCyclicModule (R := R) (K := K) p a ≃ₗ[R]
      PolynomialCyclicModule (R := R) (K := K) p a :=
  Submodule.Quotient.equiv _ _ (polynomialCoefficientEquiv Phi)
    ((linear_equiv_map_range_conjugate _ _).trans
      (congrArg LinearMap.range (polynomial_coefficient_equiv_conjugate_relation p a Phi)))

theorem polynomial_cyclic_coefficient_equiv_mk (p a : ℕ) (Phi : K ≃ₗ[R] K)
    (u : PolynomialModule R K) :
    polynomialCyclicCoefficientEquiv p a Phi
      ((LinearMap.range (polynomialCyclicOperator (R := R) (K := K) p a)).mkQ u) =
      (LinearMap.range (polynomialCyclicOperator (R := R) (K := K) p a)).mkQ
        (polynomialCoefficientEquiv Phi u) := rfl

theorem polynomial_cyclic_coefficient_equiv_commute (p a : ℕ) (Phi : K ≃ₗ[R] K) :
    Commute (polynomialCyclicCoefficientEquiv p a Phi).toLinearMap
      (polynomialCyclicAugmentation (R := R) (K := K) p a) := by
  apply LinearMap.ext
  intro v
  obtain ⟨u, rfl⟩ := (LinearMap.range (polynomialCyclicOperator (R := R) (K := K) p a)).mkQ_surjective v
  simp only [Module.End.mul_apply, LinearEquiv.coe_coe, polynomialCyclicAugmentation,
    commuting_range_quotient_apply_mk, polynomial_cyclic_coefficient_equiv_mk]
  exact congrArg (LinearMap.range (polynomialCyclicOperator (R := R) (K := K) p a)).mkQ
    (LinearMap.congr_fun (polynomial_coefficient_equiv_commute_shift Phi).eq u)

end Litt3.Deformations

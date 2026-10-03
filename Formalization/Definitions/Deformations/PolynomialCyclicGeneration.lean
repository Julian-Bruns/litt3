import Definitions.Deformations.PolynomialCyclicPresentation
import Definitions.Deformations.CommutingRangeQuotient
import Solutions.Deformations.QuotientCyclicRelation

namespace Litt3.Deformations

open Polynomial

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- The actual original polynomial multiplication by e. -/
noncomputable def polynomialCoefficientShift : Module.End R (PolynomialModule R K) :=
  Finsupp.lmapDomain K R Nat.succ

theorem polynomial_cyclic_relation_commute_shift (p a : ℕ) :
    Commute (polynomialCyclicOperator (R := R) (K := K) p a)
      (polynomialCoefficientShift (R := R) (K := K)) := by
  unfold polynomialCyclicOperator polynomialScalarOperator cyclicGroupPolynomial
  simp only [map_sub, map_pow, map_add, map_one, Polynomial.aeval_X]
  exact (cyclic_relation_commute _ _
    (Commute.refl (polynomialCoefficientShift (R := R) (K := K))) (p ^ a)).symm

/-- Original multiplication by e on the original cyclic polynomial quotient. -/
noncomputable def polynomialCyclicAugmentation (p a : ℕ) :
    Module.End R (PolynomialCyclicModule (R := R) (K := K) p a) :=
  commutingRangeQuotientEnd (polynomialCyclicOperator (R := R) (K := K) p a)
    polynomialCoefficientShift (polynomial_cyclic_relation_commute_shift p a)

/-- Original constant coefficients, with no selected basis. -/
noncomputable def polynomialCyclicConstant (p a : ℕ) :
    K →ₗ[R] PolynomialCyclicModule (R := R) (K := K) p a :=
  (LinearMap.range (polynomialCyclicOperator (R := R) (K := K) p a)).mkQ.comp
    (PolynomialModule.lsingle R 0)

end Litt3.Deformations

import Definitions.Deformations.FormalCyclicPresentation
import Solutions.Deformations.QuotientCyclicRelation

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- The actual original full cyclic coefficient module. -/
abbrev FormalCyclicModule (p a : ℕ) := CoefficientSeries (K := K) ⧸
  LinearMap.range (formalCyclicRelation (R := R) (K := K) p a)

theorem formal_cyclic_relation_commute_shift (p a : ℕ) :
    Commute (formalCyclicRelation (R := R) (K := K) p a)
      (coefficientSeriesShift 1) :=
  (cyclic_relation_commute _ _ (Commute.refl (coefficientSeriesShift (R := R) (K := K) 1))
    (p ^ a)).symm

/-- The augmentation induced by the original shift on the original quotient. -/
def formalCyclicAugmentation (p a : ℕ) :
    Module.End R (FormalCyclicModule (R := R) (K := K) p a) :=
  commutingRangeQuotientEnd (formalCyclicRelation (R := R) (K := K) p a)
    (coefficientSeriesShift 1) (formal_cyclic_relation_commute_shift p a)

/-- The actual constant coefficient generator in the original quotient. -/
def formalCyclicConstant (p a : ℕ) : K →ₗ[R] FormalCyclicModule (R := R) (K := K) p a :=
  (LinearMap.range (formalCyclicRelation (R := R) (K := K) p a)).mkQ.comp
    (coefficientSeriesConstant (R := R))

end Litt3.Deformations

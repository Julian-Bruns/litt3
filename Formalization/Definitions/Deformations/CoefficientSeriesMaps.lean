import Definitions.Deformations.CoefficientSeriesSplitting

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- The actual coefficientwise action of an arbitrary original
coefficient endomorphism. The coefficient endomorphisms can be
noncommutative; no matrix or chosen basis is introduced. -/
def coefficientSeriesMap (f : Module.End R K) : Module.End R (CoefficientSeries (K := K)) where
  toFun v n := f (v n)
  map_add' v w := funext (fun n => f.map_add (v n) (w n))
  map_smul' c v := funext (fun n => f.map_smul c (v n))

/-- The actual original coefficient automorphism acts on all full
sequences without identifying it with a chosen scalar twist. -/
def coefficientSeriesEquiv (Phi : K ≃ₗ[R] K) :
    CoefficientSeries (K := K) ≃ₗ[R] CoefficientSeries (K := K) where
  toFun v n := Phi (v n)
  invFun v n := Phi.symm (v n)
  left_inv v := funext (fun n => Phi.symm_apply_apply (v n))
  right_inv v := funext (fun n => Phi.apply_symm_apply (v n))
  map_add' v w := funext (fun n => Phi.map_add (v n) (w n))
  map_smul' c v := funext (fun n => Phi.map_smul c (v n))

end Litt3.Deformations

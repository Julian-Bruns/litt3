import Definitions.Deformations.WeightedGeneratorFiltration
import Mathlib.Algebra.MvPolynomial.Basic

namespace Litt3.Deformations

open scoped BigOperators

/-- A literal polynomial lift through arbitrary coefficient choices,
retaining the original augmentation generators. No mixed-characteristic
coefficient ring section is presumed. -/
noncomputable def polynomialCoefficientLift {k R A I : Type*}
    [CommRing k] [CommRing R] [CommRing A] [Algebra R A] [Fintype I]
    (lift : k → R) (e : I → A) (f : MvPolynomial I k) : A :=
  ∑ m ∈ f.support, lift (f.coeff m) • generatorMonomial e (fun i => m i)

end Litt3.Deformations

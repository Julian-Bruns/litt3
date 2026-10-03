import Mathlib.RingTheory.MvPolynomial.Homogeneous
import Mathlib.Algebra.MvPolynomial.Eval

namespace Litt3.QuotientGeometry.Targets

def HomogeneousEvaluationScaling : Prop :=
  ∀ (R S σ : Type) [CommSemiring R] [CommSemiring S] [Fintype σ]
    (H : MvPolynomial σ R) (n : ℕ), H.IsHomogeneous n →
    ∀ (coefficients : R →+* S) (values : σ → S) (scalar : S),
      H.eval₂ coefficients (fun i => scalar * values i) =
        scalar ^ n * H.eval₂ coefficients values

end Litt3.QuotientGeometry.Targets

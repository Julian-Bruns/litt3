import Solutions.Deformations.WeightedInitialPolynomialMap

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (k : Type*) [CommRing k] [Nontrivial k]

theorem weighted_initial_polynomial_single (q : ℕ) (large : 1 < q) (r d : ℕ)
    (alpha : Fin r → Fin q) (c : k) :
    weightedInitialPolynomial k q large r d (Pi.single alpha c) =
      c • weightedRootPolynomialBasis k q large r
        (basisWeightExponent (q - 1) d (∑ i, (alpha i).val), alpha) := by
  classical
  simp [weightedInitialPolynomial, Pi.single_apply]

end Litt3.Deformations

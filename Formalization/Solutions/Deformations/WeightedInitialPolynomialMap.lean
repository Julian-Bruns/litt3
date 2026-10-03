import Solutions.Deformations.WeightedInitialPolynomial

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (k : Type*) [CommRing k] [Nontrivial k]

/-- The actual original normal-array parameter representative is a
genuine coefficient-linear map. -/
noncomputable def weightedInitialPolynomialLinear (q : ℕ) (large : 1 < q) (r d : ℕ) :
    ((Fin r → Fin q) → k) →ₗ[k] weightedRootProduct (Polynomial k) q Polynomial.X r where
  toFun := weightedInitialPolynomial k q large r d
  map_add' c e := by
    simp only [weightedInitialPolynomial, Pi.add_apply, add_smul, Finset.sum_add_distrib]
  map_smul' a c := by
    simp only [weightedInitialPolynomial, Pi.smul_apply, Finset.smul_sum, smul_smul,
      smul_eq_mul, RingHom.id_apply]

end Litt3.Deformations

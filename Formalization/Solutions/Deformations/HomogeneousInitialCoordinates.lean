import Solutions.Deformations.WeightedInitialPolynomial

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (k : Type*) [CommRing k] [Nontrivial k]

noncomputable def homogeneousInitialCoordinates (q : ℕ) (large : 1 < q) (N r d : ℕ)
    (Z : weightedRootProduct (Polynomial k) q Polynomial.X r) (alpha : Fin r → Fin q) : k := by
  classical
  exact if wittWeightActive (q - 1) d (∑ i, (alpha i).val) N then
    (weightedRootPolynomialBasis k q large r).repr Z
      (basisWeightExponent (q - 1) d (∑ i, (alpha i).val), alpha)
  else 0

theorem homogeneous_initial_coordinates_supported (q : ℕ) (large : 1 < q) (N r d : ℕ)
    (Z : weightedRootProduct (Polynomial k) q Polynomial.X r) :
    ∀ alpha, ¬ wittWeightActive (q - 1) d (∑ i, (alpha i).val) N →
      homogeneousInitialCoordinates k q large N r d Z alpha = 0 := by
  intro alpha inactive
  simp only [homogeneousInitialCoordinates, if_neg inactive]

theorem homogeneous_initial_coordinates_match (q : ℕ) (large : 1 < q) (N r d : ℕ)
    (Z : weightedRootProduct (Polynomial k) q Polynomial.X r)
    (homogeneous : Z ∈ weightedRootHomogeneousComponent k q large r d)
    (alpha : Fin r → Fin q) (j : ℕ) (nonterminal : j < N) :
    (weightedRootPolynomialBasis k q large r).repr Z (j, alpha) =
      (weightedRootPolynomialBasis k q large r).repr
        (weightedInitialPolynomial k q large r d (homogeneousInitialCoordinates k q large N r d Z))
          (j, alpha) := by
  classical
  rw [weighted_initial_polynomial_coordinate]
  by_cases sameExponent : j = basisWeightExponent (q - 1) d (∑ i, (alpha i).val)
  · rw [if_pos sameExponent]
    by_cases active : wittWeightActive (q - 1) d (∑ i, (alpha i).val) N
    · simp only [homogeneousInitialCoordinates, if_pos active, ← sameExponent]
    · simp only [homogeneousInitialCoordinates, if_neg active]
      by_contra nonzero
      have weight := (weighted_root_homogeneous_membership k q large r d Z).mp homogeneous
        (j, alpha) nonzero
      exact active ⟨by simpa only [rootPolynomialWeight, ← sameExponent] using weight,
        by simpa only [← sameExponent] using nonterminal⟩
  · rw [if_neg sameExponent]
    by_contra nonzero
    have weight := (weighted_root_homogeneous_membership k q large r d Z).mp homogeneous
      (j, alpha) nonzero
    have exponent := basis_weight_exact_exponent (q - 1) d (∑ i, (alpha i).val) j
      (by omega) (by simpa only [rootPolynomialWeight] using weight.symm)
    exact sameExponent exponent.symm

/-- Every actual homogeneous parameter class is represented by exactly
the surviving original normal coordinates, modulo literal precision. -/
theorem homogeneous_initial_coordinates_truncation (q : ℕ) (large : 1 < q)
    (N : ℕ) (positive : 0 < N) (r d : ℕ)
    (Z : weightedRootProduct (Polynomial k) q Polynomial.X r)
    (homogeneous : Z ∈ weightedRootHomogeneousComponent k q large r d) :
    weightedRootTruncation k q N positive r
      (weightedInitialPolynomial k q large r d (homogeneousInitialCoordinates k q large N r d Z)) =
      weightedRootTruncation k q N positive r Z := by
  apply sub_eq_zero.mp
  rw [← map_sub, weighted_root_truncation_kernel k q large N positive r]
  intro alpha
  rw [Polynomial.X_pow_dvd_iff]
  intro j bound
  rw [map_sub, Finsupp.sub_apply, Polynomial.coeff_sub,
    ← weighted_root_polynomial_basis_coordinate,
    ← weighted_root_polynomial_basis_coordinate,
    ← homogeneous_initial_coordinates_match k q large N r d Z homogeneous alpha j bound,
    sub_self]

end Litt3.Deformations

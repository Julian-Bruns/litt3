import Solutions.Deformations.WeightedRootHomogeneousGenerators
import Solutions.Deformations.WeightedRootPolynomialEvaluation

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (k : Type*) [CommRing k] [Nontrivial k]

/-- Every original homogeneous polynomial maps into its actual exact
weight component in the literal untruncated source quotient. -/
theorem weighted_root_polynomial_homogeneous (q : ℕ) (large : 1 < q) (r n : ℕ)
    (p : MvPolynomial (Fin r) k) (homogeneous : p.IsHomogeneous n) :
    weightedRootPolynomialEvaluation q (Polynomial.X : Polynomial k) r
      (MvPolynomial.map Polynomial.C p) ∈ weightedRootHomogeneousComponent k q large r n := by
  classical
  change MvPolynomial.eval₂ (algebraMap (Polynomial k)
    (weightedRootProduct (Polynomial k) q Polynomial.X r))
      (weightedRootProductParameter (Polynomial k) q Polynomial.X r)
      (MvPolynomial.map Polynomial.C p) ∈ _
  rw [MvPolynomial.eval₂_map]
  change p.eval₂ (algebraMap k (weightedRootProduct (Polynomial k) q Polynomial.X r))
    (weightedRootProductParameter (Polynomial k) q Polynomial.X r) ∈ _
  rw [MvPolynomial.eval₂_eq']
  apply Submodule.sum_mem
  intro alpha member
  have degree := homogeneous (MvPolynomial.mem_support_iff.mp member)
  change (Finsupp.weight (fun _ : Fin r => (1 : ℕ))) alpha = n at degree
  rw [← Finsupp.degree_eq_weight_one, Finsupp.degree_eq_sum] at degree
  rw [← Algebra.smul_def]
  apply Submodule.smul_mem
  rw [← degree]
  apply weighted_root_homogeneous_prod k q large r Finset.univ _ (fun i => alpha i)
  intro i _
  simpa only [one_mul] using weighted_root_homogeneous_pow k q large r 1 _
    (weighted_root_homogeneous_parameter k q large r i) (alpha i)

end Litt3.Deformations

import Solutions.Deformations.ElementaryPrimeWittPolynomial
import Solutions.Deformations.ElementaryPrimeWittWeightProducts
import Solutions.Deformations.WeightedRootPolynomialHomogeneous

set_option maxHeartbeats 1000000

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (p N : ℕ) [Fact p.Prime] [Fact (0 < N)]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Nontrivial (TruncatedWittVector p N k) :=
  truncated_witt_nontrivial p N (Fact.out : 0 < N) k

/-- A literal low-degree original monomial with an actual Teichmüller
coefficient has exactly its unchanged original parameter initial form. -/
theorem elementary_prime_witt_small_monomial_initial (r d : ℕ) (small : d < p)
    (m : Fin r →₀ ℕ) (degree : (∑ i, m i) = d) (c : k) :
    ∃ member : WittVector.truncate N (WittVector.teichmuller p c) •
        generatorMonomial (elementaryAugmentationParameter (R := TruncatedWittVector p N k) p r)
          (fun i => m i) ∈
        elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r d,
      elementaryPrimeWittAssociatedMap p N k r d ⟨_, member⟩ =
        elementaryPrimeAssociatedScalar p N k r c *
          weightedRootTruncation k p N (Fact.out : 0 < N) r
            (∏ i, weightedRootProductParameter (Polynomial k) p Polynomial.X r i ^ m i) := by
  classical
  have bounds : ∀ i, m i < p := by
    intro i
    have bounded : m i ≤ ∑ j, m j :=
      Finset.single_le_sum (fun j _ => Nat.zero_le (m j)) (Finset.mem_univ i)
    omega
  let alpha : Fin r → Fin p := fun i => ⟨m i, bounds i⟩
  have normal : generatorMonomial
      (elementaryAugmentationParameter (R := TruncatedWittVector p N k) p r) (fun i => m i) =
      elementaryAugmentationBasis p (by have := (Fact.out : p.Prime).two_le; omega) r alpha := by
    rw [elementary_augmentation_basis_apply]
    rfl
  have basisMember : elementaryAugmentationBasis (R := TruncatedWittVector p N k)
      p (by have := (Fact.out : p.Prime).two_le; omega) r alpha ∈
      elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r d := by
    apply Submodule.subset_span
    refine ⟨0, alpha, ?_, ?_⟩
    · simpa only [Nat.mul_zero, zero_add, alpha] using degree.ge
    · simp only [pow_zero, one_smul]
  let t := WittVector.truncate N (WittVector.teichmuller p c)
  have member : t • generatorMonomial
      (elementaryAugmentationParameter (R := TruncatedWittVector p N k) p r) (fun i => m i) ∈
      elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r d := by
    rw [normal]
    exact Submodule.smul_mem _ t basisMember
  refine ⟨member, ?_⟩
  have atom := elementary_prime_witt_associated_atom_at p N k r d 0 alpha
    (by simpa only [Nat.mul_zero, zero_add, alpha] using degree.symm)
    (by simpa only [pow_zero, one_smul] using basisMember)
  simp only [pow_zero, one_smul] at atom
  have scalar := elementary_prime_witt_associated_map_scalar p N k r d t ⟨_, basisMember⟩
  have residue : truncatedWittResidue p N (Fact.out : 0 < N) k t = c := by
    rw [truncated_witt_residue_truncate, WittVector.teichmuller_coeff_zero]
  rw [residue, atom] at scalar
  simpa only [normal, weighted_root_polynomial_basis_apply, pow_zero, one_smul,
    weighted_root_product_basis_apply, alpha] using scalar

/-- The actual unchanged-generator Teichmüller lift of every homogeneous
polynomial of degree below five has the literal source polynomial as
its actual initial class. No coefficient-ring section is used. -/
theorem elementary_prime_witt_small_polynomial_initial (r d : ℕ) (small : d < p)
    (f : MvPolynomial (Fin r) k) (homogeneous : f.IsHomogeneous d)
    (member : elementaryPrimeWittPolynomialLift p N k r f ∈
      elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r d) :
    elementaryPrimeWittAssociatedMap p N k r d ⟨_, member⟩ =
      weightedRootTruncation k p N (Fact.out : 0 < N) r
        (weightedRootPolynomialEvaluation p Polynomial.X r (MvPolynomial.map Polynomial.C f)) := by
  classical
  have degrees : ∀ m ∈ f.support, (∑ i, m i) = d := by
    intro m supported
    have weight := homogeneous (MvPolynomial.mem_support_iff.mp supported)
    change (Finsupp.weight (fun _ : Fin r => (1 : ℕ))) m = d at weight
    rwa [← Finsupp.degree_eq_weight_one, Finsupp.degree_eq_sum] at weight
  let term : f.support → elementaryNormalWeightFiltration (TruncatedWittVector p N k)
      p (by have := (Fact.out : p.Prime).two_le; omega) r d := fun m =>
    ⟨_, (elementary_prime_witt_small_monomial_initial p N k r d small m.val
      (degrees m.val m.property) (f.coeff m.val)).choose⟩
  have sumTerms : (∑ m : f.support, term m) =
      (⟨elementaryPrimeWittPolynomialLift p N k r f, member⟩ :
        elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r d) := by
    apply Subtype.ext
    simp only [Submodule.coe_sum, term, elementaryPrimeWittPolynomialLift, polynomialCoefficientLift]
    simpa only [Finset.sum_coe_sort] using
      Finset.sum_attach f.support (fun m => WittVector.truncate N
        (WittVector.teichmuller p (f.coeff m)) • generatorMonomial
          (elementaryAugmentationParameter (R := TruncatedWittVector p N k) p r) (fun i => m i))
  rw [← sumTerms, map_sum]
  change (∑ m : f.support, elementaryPrimeWittAssociatedMap p N k r d (term m)) =
    weightedRootTruncation k p N (Fact.out : 0 < N) r
      ((MvPolynomial.map Polynomial.C f).eval₂
        (algebraMap (Polynomial k) (weightedRootProduct (Polynomial k) p Polynomial.X r))
        (weightedRootProductParameter (Polynomial k) p Polynomial.X r))
  rw [MvPolynomial.eval₂_map]
  change (∑ m : f.support, elementaryPrimeWittAssociatedMap p N k r d (term m)) =
    weightedRootTruncation k p N (Fact.out : 0 < N) r
      (f.eval₂ (algebraMap k (weightedRootProduct (Polynomial k) p Polynomial.X r))
        (weightedRootProductParameter (Polynomial k) p Polynomial.X r))
  rw [MvPolynomial.eval₂_eq', map_sum]
  have targetSum : (∑ m ∈ f.support,
      weightedRootTruncation k p N (Fact.out : 0 < N) r
        (algebraMap k (weightedRootProduct (Polynomial k) p Polynomial.X r) (f.coeff m) *
          ∏ i, weightedRootProductParameter (Polynomial k) p Polynomial.X r i ^ m i)) =
      ∑ m : f.support, weightedRootTruncation k p N (Fact.out : 0 < N) r
        (algebraMap k (weightedRootProduct (Polynomial k) p Polynomial.X r) (f.coeff m.val) *
          ∏ i, weightedRootProductParameter (Polynomial k) p Polynomial.X r i ^ m.val i) := by
    exact (Finset.sum_coe_sort f.support _).symm
  rw [targetSum]
  apply Finset.sum_congr rfl
  intro m _
  have initial := (elementary_prime_witt_small_monomial_initial p N k r d small m.val
    (degrees m.val m.property) (f.coeff m.val)).choose_spec
  change elementaryPrimeWittAssociatedMap p N k r d (term m) = _ at initial
  rw [initial, map_mul]
  rfl

end Litt3.Deformations

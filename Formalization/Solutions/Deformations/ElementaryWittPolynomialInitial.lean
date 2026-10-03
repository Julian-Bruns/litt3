import Solutions.Deformations.ElementaryWittPolynomialLift
import Solutions.Deformations.ElementaryWittWeightProducts
import Solutions.Deformations.WeightedRootPolynomialHomogeneous

set_option maxHeartbeats 1000000

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (N : ℕ) [Fact (0 < N)]
variable (k : Type*) [Field k] [Fact (Nat.Prime 5)] [CharP k 5] [PerfectRing k 5]

local instance : Nontrivial (TruncatedWittVector 5 N k) :=
  truncated_witt_nontrivial 5 N (Fact.out : 0 < N) k

/-- A literal low-degree original monomial with an actual Teichmüller
coefficient has exactly its unchanged original parameter initial form. -/
theorem elementary_witt_small_monomial_initial (r d : ℕ) (small : d < 5)
    (m : Fin r →₀ ℕ) (degree : (∑ i, m i) = d) (c : k) :
    ∃ member : WittVector.truncate N (WittVector.teichmuller 5 c) •
        generatorMonomial (elementaryAugmentationParameter (R := TruncatedWittVector 5 N k) 5 r)
          (fun i => m i) ∈
        elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d,
      elementaryWittAssociatedMap N k r d ⟨_, member⟩ =
        elementaryAssociatedScalar N k r c *
          weightedRootTruncation k 5 N (Fact.out : 0 < N) r
            (∏ i, weightedRootProductParameter (Polynomial k) 5 Polynomial.X r i ^ m i) := by
  classical
  have bounds : ∀ i, m i < 5 := by
    intro i
    have bounded : m i ≤ ∑ j, m j :=
      Finset.single_le_sum (fun j _ => Nat.zero_le (m j)) (Finset.mem_univ i)
    omega
  let alpha : Fin r → Fin 5 := fun i => ⟨m i, bounds i⟩
  have normal : generatorMonomial
      (elementaryAugmentationParameter (R := TruncatedWittVector 5 N k) 5 r) (fun i => m i) =
      elementaryAugmentationBasis 5 (by omega) r alpha := by
    rw [elementary_augmentation_basis_apply]
    rfl
  have basisMember : elementaryAugmentationBasis (R := TruncatedWittVector 5 N k)
      5 (by omega) r alpha ∈
      elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d := by
    apply Submodule.subset_span
    refine ⟨0, alpha, ?_, ?_⟩
    · simpa only [Nat.mul_zero, zero_add, alpha] using degree.ge
    · simp only [pow_zero, one_smul]
  let t := WittVector.truncate N (WittVector.teichmuller 5 c)
  have member : t • generatorMonomial
      (elementaryAugmentationParameter (R := TruncatedWittVector 5 N k) 5 r) (fun i => m i) ∈
      elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d := by
    rw [normal]
    exact Submodule.smul_mem _ t basisMember
  refine ⟨member, ?_⟩
  have atom := elementary_witt_associated_atom_at N k r d 0 alpha
    (by simpa only [Nat.mul_zero, zero_add, alpha] using degree.symm)
    (by simpa only [pow_zero, one_smul] using basisMember)
  simp only [pow_zero, one_smul] at atom
  have scalar := elementary_witt_associated_map_scalar N k r d t ⟨_, basisMember⟩
  have residue : truncatedWittResidue 5 N (Fact.out : 0 < N) k t = c := by
    rw [truncated_witt_residue_truncate, WittVector.teichmuller_coeff_zero]
  rw [residue, atom] at scalar
  simpa only [normal, weighted_root_polynomial_basis_apply, pow_zero, one_smul,
    weighted_root_product_basis_apply, alpha] using scalar

/-- The actual unchanged-generator Teichmüller lift of every homogeneous
polynomial of degree below five has the literal source polynomial as
its actual initial class. No coefficient-ring section is used. -/
theorem elementary_witt_small_polynomial_initial (r d : ℕ) (small : d < 5)
    (f : MvPolynomial (Fin r) k) (homogeneous : f.IsHomogeneous d)
    (member : elementaryWittPolynomialLift N k r f ∈
      elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d) :
    elementaryWittAssociatedMap N k r d ⟨_, member⟩ =
      weightedRootTruncation k 5 N (Fact.out : 0 < N) r
        (weightedRootPolynomialEvaluation 5 Polynomial.X r (MvPolynomial.map Polynomial.C f)) := by
  classical
  have degrees : ∀ m ∈ f.support, (∑ i, m i) = d := by
    intro m supported
    have weight := homogeneous (MvPolynomial.mem_support_iff.mp supported)
    change (Finsupp.weight (fun _ : Fin r => (1 : ℕ))) m = d at weight
    rwa [← Finsupp.degree_eq_weight_one, Finsupp.degree_eq_sum] at weight
  let term : f.support → elementaryNormalWeightFiltration (TruncatedWittVector 5 N k)
      5 (by omega) r d := fun m =>
    ⟨_, (elementary_witt_small_monomial_initial N k r d small m.val
      (degrees m.val m.property) (f.coeff m.val)).choose⟩
  have sumTerms : (∑ m : f.support, term m) =
      (⟨elementaryWittPolynomialLift N k r f, member⟩ :
        elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d) := by
    apply Subtype.ext
    simp only [Submodule.coe_sum, term, elementaryWittPolynomialLift, polynomialCoefficientLift]
    simpa only [Finset.sum_coe_sort] using
      Finset.sum_attach f.support (fun m => WittVector.truncate N
        (WittVector.teichmuller 5 (f.coeff m)) • generatorMonomial
          (elementaryAugmentationParameter (R := TruncatedWittVector 5 N k) 5 r) (fun i => m i))
  rw [← sumTerms, map_sum]
  change (∑ m : f.support, elementaryWittAssociatedMap N k r d (term m)) =
    weightedRootTruncation k 5 N (Fact.out : 0 < N) r
      ((MvPolynomial.map Polynomial.C f).eval₂
        (algebraMap (Polynomial k) (weightedRootProduct (Polynomial k) 5 Polynomial.X r))
        (weightedRootProductParameter (Polynomial k) 5 Polynomial.X r))
  rw [MvPolynomial.eval₂_map]
  change (∑ m : f.support, elementaryWittAssociatedMap N k r d (term m)) =
    weightedRootTruncation k 5 N (Fact.out : 0 < N) r
      (f.eval₂ (algebraMap k (weightedRootProduct (Polynomial k) 5 Polynomial.X r))
        (weightedRootProductParameter (Polynomial k) 5 Polynomial.X r))
  rw [MvPolynomial.eval₂_eq', map_sum]
  have targetSum : (∑ m ∈ f.support,
      weightedRootTruncation k 5 N (Fact.out : 0 < N) r
        (algebraMap k (weightedRootProduct (Polynomial k) 5 Polynomial.X r) (f.coeff m) *
          ∏ i, weightedRootProductParameter (Polynomial k) 5 Polynomial.X r i ^ m i)) =
      ∑ m : f.support, weightedRootTruncation k 5 N (Fact.out : 0 < N) r
        (algebraMap k (weightedRootProduct (Polynomial k) 5 Polynomial.X r) (f.coeff m.val) *
          ∏ i, weightedRootProductParameter (Polynomial k) 5 Polynomial.X r i ^ m.val i) := by
    exact (Finset.sum_coe_sort f.support _).symm
  rw [targetSum]
  apply Finset.sum_congr rfl
  intro m _
  have initial := (elementary_witt_small_monomial_initial N k r d small m.val
    (degrees m.val m.property) (f.coeff m.val)).choose_spec
  change elementaryWittAssociatedMap N k r d (term m) = _ at initial
  rw [initial, map_mul]
  rfl

end Litt3.Deformations

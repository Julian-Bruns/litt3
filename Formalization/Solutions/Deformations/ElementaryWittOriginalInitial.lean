import Solutions.Deformations.ElementaryWittPolynomialInitial
import Solutions.Deformations.WeightedRootBaseMap

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (N : ℕ) [Fact (0 < N)]
variable (k : Type*) [Field k] [Fact (Nat.Prime 5)] [CharP k 5] [PerfectRing k 5]

local instance : Nontrivial (TruncatedWittVector 5 N k) :=
  truncated_witt_nontrivial 5 N (Fact.out : 0 < N) k
local instance : Nontrivial (TruncatedCoefficientRing k N) :=
  (truncatedResidue k N (Fact.out : 0 < N)).domain_nontrivial

/-- The actual original augmentation coordinate has exactly the
unchanged literal E_i as its genuine initial class. -/
theorem elementary_witt_original_parameter_initial (r : ℕ) (i : Fin r) :
    ∃ member : elementaryAugmentationParameter (R := TruncatedWittVector 5 N k) 5 r i ∈
        elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r 1,
      elementaryWittAssociatedMap N k r 1 ⟨_, member⟩ =
        weightedRootProductParameter (TruncatedCoefficientRing k N) 5 (truncatedParameter k N) r i := by
  classical
  let m : Fin r →₀ ℕ := Finsupp.single i 1
  have degree : (∑ j, m j) = 1 := by simp [m]
  obtain ⟨member, initial⟩ := elementary_witt_small_monomial_initial N k r 1 (by omega) m degree (1 : k)
  have source : WittVector.truncate N (WittVector.teichmuller 5 (1 : k)) •
      generatorMonomial (elementaryAugmentationParameter (R := TruncatedWittVector 5 N k) 5 r)
        (fun j => m j) = elementaryAugmentationParameter (R := TruncatedWittVector 5 N k) 5 r i := by
    simp [m, generatorMonomial, Finsupp.single_apply]
  have parameterMember : elementaryAugmentationParameter (R := TruncatedWittVector 5 N k) 5 r i ∈
      elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r 1 := source ▸ member
  refine ⟨parameterMember, ?_⟩
  have supplied : (⟨_, member⟩ : elementaryNormalWeightFiltration (TruncatedWittVector 5 N k)
      5 (by omega) r 1) = ⟨_, parameterMember⟩ := Subtype.ext source
  rw [supplied, map_one, one_mul] at initial
  have monomial : (∏ j, weightedRootProductParameter (Polynomial k) 5 Polynomial.X r j ^ m j) =
      weightedRootProductParameter (Polynomial k) 5 Polynomial.X r i := by
    simp [m, Finsupp.single_apply]
  rw [monomial] at initial
  exact initial.trans (weighted_root_base_map_parameter
    (AdjoinRoot.mk ((Polynomial.X : Polynomial k) ^ N)) 5 Polynomial.X r i)

/-- The actual prime has weight four and maps literally to the source
parameter tau at exactly the actual Witt coefficient precision. -/
theorem elementary_witt_original_prime_initial (r : ℕ) :
    ∃ member : (5 : AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5)) ∈
        elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r 4,
      elementaryWittAssociatedMap N k r 4 ⟨_, member⟩ =
        algebraMap (TruncatedCoefficientRing k N)
          (weightedRootProduct (TruncatedCoefficientRing k N) 5 (truncatedParameter k N) r)
            (truncatedParameter k N) := by
  classical
  let alpha : Fin r → Fin 5 := fun _ => 0
  obtain ⟨member, initial⟩ := elementary_witt_associated_atom N k r 1 alpha
  have degree : 4 * 1 + (∑ i, (alpha i).val) = 4 := by simp [alpha]
  have source : (5 : TruncatedWittVector 5 N k) ^ 1 •
      elementaryAugmentationBasis 5 (by omega) r alpha =
      (5 : AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5)) := by
    simp only [elementary_augmentation_basis_apply, alpha, Fin.val_zero, pow_zero,
      Finset.prod_const_one, pow_one, Algebra.smul_def, map_ofNat, mul_one]
  have parameterMember : (5 : AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5)) ∈
      elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r 4 := by
    simpa only [source, degree] using member
  refine ⟨parameterMember, ?_⟩
  have monomialMember : (5 : TruncatedWittVector 5 N k) ^ 1 •
      elementaryAugmentationBasis 5 (by omega) r alpha ∈
      elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r 4 := by
    rw [source]
    exact parameterMember
  have reindex := elementary_witt_associated_atom_at N k r 4 1 alpha degree.symm monomialMember
  have supplied : (⟨(5 : TruncatedWittVector 5 N k) ^ 1 •
      elementaryAugmentationBasis 5 (by omega) r alpha, monomialMember⟩ :
      elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r 4) =
      ⟨(5 : AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5)), parameterMember⟩ := Subtype.ext source
  rw [supplied] at reindex
  rw [reindex, weighted_root_polynomial_basis_apply, pow_one, weighted_root_product_basis_apply]
  simp only [alpha, Fin.val_zero, pow_zero, Finset.prod_const_one]
  rw [Algebra.smul_def, mul_one]
  exact weighted_root_base_map_coefficient (AdjoinRoot.mk ((Polynomial.X : Polynomial k) ^ N))
    5 Polynomial.X r Polynomial.X

end Litt3.Deformations

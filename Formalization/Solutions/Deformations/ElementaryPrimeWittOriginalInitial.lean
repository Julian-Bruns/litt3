import Solutions.Deformations.ElementaryPrimeWittPolynomialInitial
import Solutions.Deformations.WeightedRootBaseMap

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (p N : ℕ) [Fact p.Prime] [Fact (0 < N)]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Nontrivial (TruncatedWittVector p N k) :=
  truncated_witt_nontrivial p N (Fact.out : 0 < N) k
local instance : Nontrivial (TruncatedCoefficientRing k N) :=
  (truncatedResidue k N (Fact.out : 0 < N)).domain_nontrivial

/-- The actual original augmentation coordinate has exactly the
unchanged literal E_i as its genuine initial class. -/
theorem elementary_prime_witt_original_parameter_initial (r : ℕ) (i : Fin r) :
    ∃ member : elementaryAugmentationParameter (R := TruncatedWittVector p N k) p r i ∈
        elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r 1,
      elementaryPrimeWittAssociatedMap p N k r 1 ⟨_, member⟩ =
        weightedRootProductParameter (TruncatedCoefficientRing k N) p (truncatedParameter k N) r i := by
  classical
  let m : Fin r →₀ ℕ := Finsupp.single i 1
  have degree : (∑ j, m j) = 1 := by simp [m]
  obtain ⟨member, initial⟩ := elementary_prime_witt_small_monomial_initial p N k r 1 (by have := (Fact.out : p.Prime).two_le; omega) m degree (1 : k)
  have source : WittVector.truncate N (WittVector.teichmuller p (1 : k)) •
      generatorMonomial (elementaryAugmentationParameter (R := TruncatedWittVector p N k) p r)
        (fun j => m j) = elementaryAugmentationParameter (R := TruncatedWittVector p N k) p r i := by
    simp [m, generatorMonomial, Finsupp.single_apply]
  have parameterMember : elementaryAugmentationParameter (R := TruncatedWittVector p N k) p r i ∈
      elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r 1 := source ▸ member
  refine ⟨parameterMember, ?_⟩
  have supplied : (⟨_, member⟩ : elementaryNormalWeightFiltration (TruncatedWittVector p N k)
      p (by have := (Fact.out : p.Prime).two_le; omega) r 1) = ⟨_, parameterMember⟩ := Subtype.ext source
  rw [supplied, map_one, one_mul] at initial
  have monomial : (∏ j, weightedRootProductParameter (Polynomial k) p Polynomial.X r j ^ m j) =
      weightedRootProductParameter (Polynomial k) p Polynomial.X r i := by
    simp [m, Finsupp.single_apply]
  rw [monomial] at initial
  exact initial.trans (weighted_root_base_map_parameter
    (AdjoinRoot.mk ((Polynomial.X : Polynomial k) ^ N)) p Polynomial.X r i)

/-- The actual prime has weight four and maps literally to the source
parameter tau at exactly the actual Witt coefficient precision. -/
theorem elementary_prime_witt_original_prime_initial (r : ℕ) :
    ∃ member : (p : AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p)) ∈
        elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r (p - 1),
      elementaryPrimeWittAssociatedMap p N k r (p - 1) ⟨_, member⟩ =
        algebraMap (TruncatedCoefficientRing k N)
          (weightedRootProduct (TruncatedCoefficientRing k N) p (truncatedParameter k N) r)
            (truncatedParameter k N) := by
  classical
  let alpha : Fin r → Fin p := fun _ => 0
  obtain ⟨member, initial⟩ := elementary_prime_witt_associated_atom p N k r 1 alpha
  have degree : (p - 1) * 1 + (∑ i, (alpha i).val) = (p - 1) := by simp [alpha]
  have source : (p : TruncatedWittVector p N k) ^ 1 •
      elementaryAugmentationBasis p (by have := (Fact.out : p.Prime).two_le; omega) r alpha =
      (p : AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p)) := by
    simp only [elementary_augmentation_basis_apply, alpha, Fin.val_zero, pow_zero,
      Finset.prod_const_one, pow_one, Algebra.smul_def, map_natCast, mul_one]
  have parameterMember : (p : AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p)) ∈
      elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r (p - 1) := by
    simpa only [source, degree] using member
  refine ⟨parameterMember, ?_⟩
  have monomialMember : (p : TruncatedWittVector p N k) ^ 1 •
      elementaryAugmentationBasis p (by have := (Fact.out : p.Prime).two_le; omega) r alpha ∈
      elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r (p - 1) := by
    rw [source]
    exact parameterMember
  have reindex := elementary_prime_witt_associated_atom_at p N k r (p - 1) 1 alpha degree.symm monomialMember
  have supplied : (⟨(p : TruncatedWittVector p N k) ^ 1 •
      elementaryAugmentationBasis p (by have := (Fact.out : p.Prime).two_le; omega) r alpha, monomialMember⟩ :
      elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r (p - 1)) =
      ⟨(p : AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p)), parameterMember⟩ := Subtype.ext source
  rw [supplied] at reindex
  rw [reindex, weighted_root_polynomial_basis_apply, pow_one, weighted_root_product_basis_apply]
  simp only [alpha, Fin.val_zero, pow_zero, Finset.prod_const_one]
  rw [Algebra.smul_def, mul_one]
  exact weighted_root_base_map_coefficient (AdjoinRoot.mk ((Polynomial.X : Polynomial k) ^ N))
    p Polynomial.X r Polynomial.X

end Litt3.Deformations

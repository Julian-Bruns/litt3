import Solutions.Deformations.ElementaryWittAssociatedAtom
import Solutions.Deformations.ElementaryWeightStructure
import Solutions.Deformations.ElementaryWeightedInitialProduct

set_option maxHeartbeats 1000000

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (N : ℕ) [Fact (0 < N)]
variable (k : Type*) [Field k] [Fact (Nat.Prime 5)] [CharP k 5] [PerfectRing k 5]

local instance : Nontrivial (TruncatedWittVector 5 N k) :=
  truncated_witt_nontrivial 5 N (Fact.out : 0 < N) k

noncomputable def elementaryWittNormalTerm (r j : ℕ) (alpha : Fin r → Fin 5) :
    elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r
      (4 * j + ∑ i, (alpha i).val) :=
  ⟨(5 : TruncatedWittVector 5 N k) ^ j • elementaryAugmentationBasis 5 (by omega) r alpha,
    Submodule.subset_span ⟨j, alpha, le_rfl, rfl⟩⟩

noncomputable def elementaryWittWeightProduct (r d e : ℕ)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d)
    (y : elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r e) :
    elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r (d + e) :=
  ⟨x.val * y.val, elementary_five_normal_weight_mul (R := TruncatedWittVector 5 N k)
    r d e x.val y.val x.property y.property⟩

theorem elementary_witt_associated_atom_at (r d j : ℕ) (alpha : Fin r → Fin 5)
    (weight : d = 4 * j + ∑ i, (alpha i).val)
    (member : (5 : TruncatedWittVector 5 N k) ^ j •
      elementaryAugmentationBasis 5 (by omega) r alpha ∈
      elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d) :
    elementaryWittAssociatedMap N k r d ⟨_, member⟩ =
      weightedRootTruncation k 5 N (Fact.out : 0 < N) r
        (weightedRootPolynomialBasis k 5 (by omega) r (j, alpha)) := by
  subst d
  exact (elementary_witt_associated_atom N k r j alpha).choose_spec

/-- Genuine Witt multiplication of every pair of original weighted
normal generators is transported to literal parameter multiplication. -/
theorem elementary_witt_associated_normal_product (r j l : ℕ)
    (alpha beta : Fin r → Fin 5) :
    elementaryWittAssociatedMap N k r
        ((4 * j + ∑ i, (alpha i).val) + (4 * l + ∑ i, (beta i).val))
      (elementaryWittWeightProduct N k r _ _
        (elementaryWittNormalTerm N k r j alpha) (elementaryWittNormalTerm N k r l beta)) =
      elementaryWittAssociatedMap N k r (4 * j + ∑ i, (alpha i).val)
        (elementaryWittNormalTerm N k r j alpha) *
      elementaryWittAssociatedMap N k r (4 * l + ∑ i, (beta i).val)
        (elementaryWittNormalTerm N k r l beta) := by
  let t := ∑ i, rootNormalCarry 5 (alpha i) (beta i)
  let gamma := fun i => rootNormalProductExponent 5 (by omega) (alpha i) (beta i)
  let D := (4 * j + ∑ i, (alpha i).val) + (4 * l + ∑ i, (beta i).val)
  have weight : D = 4 * (j + l + t) + ∑ i, (gamma i).val := by
    have carry := weighted_root_normal_product_weight 5 (by omega) r alpha beta
    change 4 * t + (∑ i, (gamma i).val) = (∑ i, (alpha i).val) + ∑ i, (beta i).val at carry
    dsimp only [D]
    omega
  let z : elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r D :=
    ⟨(5 : TruncatedWittVector 5 N k) ^ (j + l + t) •
      elementaryAugmentationBasis 5 (by omega) r gamma,
      Submodule.subset_span ⟨j + l + t, gamma, weight.le, rfl⟩⟩
  have zImage := elementary_witt_associated_atom_at N k r D (j + l + t) gamma weight z.property
  have leftImage := elementary_witt_associated_atom_at N k r _ j alpha rfl
    (elementaryWittNormalTerm N k r j alpha).property
  have rightImage := elementary_witt_associated_atom_at N k r _ l beta rfl
    (elementaryWittNormalTerm N k r l beta).property
  change elementaryWittAssociatedMap N k r (4 * j + ∑ i, (alpha i).val)
    (elementaryWittNormalTerm N k r j alpha) = _ at leftImage
  change elementaryWittAssociatedMap N k r (4 * l + ∑ i, (beta i).val)
    (elementaryWittNormalTerm N k r l beta) = _ at rightImage
  have equal := (elementary_witt_associated_map_equal_iff N k r D
    (elementaryWittWeightProduct N k r _ _
      (elementaryWittNormalTerm N k r j alpha) (elementaryWittNormalTerm N k r l beta))
    ((-1 : TruncatedWittVector 5 N k) ^ t • z)).mpr
      (by simpa only [elementaryWittWeightProduct, elementaryWittNormalTerm,
        Submodule.coe_smul, t, gamma, D, z] using
        elementary_five_weighted_normal_initial_product (R := TruncatedWittVector 5 N k) r j l alpha beta)
  rw [equal, elementary_witt_associated_map_scalar, map_pow, map_neg, map_one, zImage,
    leftImage, rightImage]
  have original := weighted_root_polynomial_basis_product k 5 (by omega) r j l alpha beta
  have mapped := congrArg (weightedRootTruncation k 5 N (Fact.out : 0 < N) r) original
  rw [map_mul, Algebra.smul_def, map_mul] at mapped
  exact mapped.symm

end Litt3.Deformations

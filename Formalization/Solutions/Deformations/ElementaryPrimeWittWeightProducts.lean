import Solutions.Deformations.ElementaryPrimeWittAssociatedAtom
import Solutions.Deformations.ElementaryPrimeWeightStructure
import Solutions.Deformations.ElementaryPrimeWeightedInitialProduct

set_option maxHeartbeats 1000000

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (p N : ℕ) [Fact p.Prime] [Fact (0 < N)]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Nontrivial (TruncatedWittVector p N k) :=
  truncated_witt_nontrivial p N (Fact.out : 0 < N) k

noncomputable def elementaryPrimeWittNormalTerm (r j : ℕ) (alpha : Fin r → Fin p) :
    elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r
      ((p - 1) * j + ∑ i, (alpha i).val) :=
  ⟨(p : TruncatedWittVector p N k) ^ j • elementaryAugmentationBasis p (by have := (Fact.out : p.Prime).two_le; omega) r alpha,
    Submodule.subset_span ⟨j, alpha, le_rfl, rfl⟩⟩

noncomputable def elementaryPrimeWittWeightProduct (r d e : ℕ)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r d)
    (y : elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r e) :
    elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r (d + e) :=
  ⟨x.val * y.val, elementary_prime_normal_weight_mul p (Fact.out : p.Prime) (R := TruncatedWittVector p N k)
    r d e x.val y.val x.property y.property⟩

theorem elementary_prime_witt_associated_atom_at (r d j : ℕ) (alpha : Fin r → Fin p)
    (weight : d = (p - 1) * j + ∑ i, (alpha i).val)
    (member : (p : TruncatedWittVector p N k) ^ j •
      elementaryAugmentationBasis p (by have := (Fact.out : p.Prime).two_le; omega) r alpha ∈
      elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r d) :
    elementaryPrimeWittAssociatedMap p N k r d ⟨_, member⟩ =
      weightedRootTruncation k p N (Fact.out : 0 < N) r
        (weightedRootPolynomialBasis k p (by have := (Fact.out : p.Prime).two_le; omega) r (j, alpha)) := by
  subst d
  exact (elementary_prime_witt_associated_atom p N k r j alpha).choose_spec

/-- Genuine Witt multiplication of every pair of original weighted
normal generators is transported to literal parameter multiplication. -/
theorem elementary_prime_witt_associated_normal_product (r j l : ℕ)
    (alpha beta : Fin r → Fin p) :
    elementaryPrimeWittAssociatedMap p N k r
        (((p - 1) * j + ∑ i, (alpha i).val) + ((p - 1) * l + ∑ i, (beta i).val))
      (elementaryPrimeWittWeightProduct p N k r _ _
        (elementaryPrimeWittNormalTerm p N k r j alpha) (elementaryPrimeWittNormalTerm p N k r l beta)) =
      elementaryPrimeWittAssociatedMap p N k r ((p - 1) * j + ∑ i, (alpha i).val)
        (elementaryPrimeWittNormalTerm p N k r j alpha) *
      elementaryPrimeWittAssociatedMap p N k r ((p - 1) * l + ∑ i, (beta i).val)
        (elementaryPrimeWittNormalTerm p N k r l beta) := by
  let t := ∑ i, rootNormalCarry p (alpha i) (beta i)
  let gamma := fun i => rootNormalProductExponent p (by have := (Fact.out : p.Prime).two_le; omega) (alpha i) (beta i)
  let D := ((p - 1) * j + ∑ i, (alpha i).val) + ((p - 1) * l + ∑ i, (beta i).val)
  have weight : D = (p - 1) * (j + l + t) + ∑ i, (gamma i).val := by
    have carry := weighted_root_normal_product_weight p (by have := (Fact.out : p.Prime).two_le; omega) r alpha beta
    change (p - 1) * t + (∑ i, (gamma i).val) = (∑ i, (alpha i).val) + ∑ i, (beta i).val at carry
    dsimp only [D]
    ring_nf at carry ⊢
    omega
  let z : elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r D :=
    ⟨(p : TruncatedWittVector p N k) ^ (j + l + t) •
      elementaryAugmentationBasis p (by have := (Fact.out : p.Prime).two_le; omega) r gamma,
      Submodule.subset_span ⟨j + l + t, gamma, weight.le, rfl⟩⟩
  have zImage := elementary_prime_witt_associated_atom_at p N k r D (j + l + t) gamma weight z.property
  have leftImage := elementary_prime_witt_associated_atom_at p N k r _ j alpha rfl
    (elementaryPrimeWittNormalTerm p N k r j alpha).property
  have rightImage := elementary_prime_witt_associated_atom_at p N k r _ l beta rfl
    (elementaryPrimeWittNormalTerm p N k r l beta).property
  change elementaryPrimeWittAssociatedMap p N k r ((p - 1) * j + ∑ i, (alpha i).val)
    (elementaryPrimeWittNormalTerm p N k r j alpha) = _ at leftImage
  change elementaryPrimeWittAssociatedMap p N k r ((p - 1) * l + ∑ i, (beta i).val)
    (elementaryPrimeWittNormalTerm p N k r l beta) = _ at rightImage
  have equal := (elementary_prime_witt_associated_map_equal_iff p N k r D
    (elementaryPrimeWittWeightProduct p N k r _ _
      (elementaryPrimeWittNormalTerm p N k r j alpha) (elementaryPrimeWittNormalTerm p N k r l beta))
    ((-1 : TruncatedWittVector p N k) ^ t • z)).mpr
      (by simpa only [elementaryPrimeWittWeightProduct, elementaryPrimeWittNormalTerm,
        Submodule.coe_smul, t, gamma, D, z] using
        elementary_prime_weighted_normal_initial_product (R := TruncatedWittVector p N k) p r j l alpha beta)
  rw [equal, elementary_prime_witt_associated_map_scalar, map_pow, map_neg, map_one, zImage,
    leftImage, rightImage]
  have original := weighted_root_polynomial_basis_product k p (by have := (Fact.out : p.Prime).two_le; omega) r j l alpha beta
  have mapped := congrArg (weightedRootTruncation k p N (Fact.out : 0 < N) r) original
  rw [map_mul, Algebra.smul_def, map_mul] at mapped
  exact mapped.symm

end Litt3.Deformations

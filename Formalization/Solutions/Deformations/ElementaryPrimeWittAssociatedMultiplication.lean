import Solutions.Deformations.ElementaryPrimeWittWeightProducts
import Solutions.Deformations.WeightedMultiplicativeExtension
import Solutions.Deformations.ElementaryWeightStructure

set_option maxHeartbeats 1600000

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (p N : ℕ) [Fact p.Prime] [Fact (0 < N)]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Nontrivial (TruncatedWittVector p N k) :=
  truncated_witt_nontrivial p N (Fact.out : 0 < N) k

/-- Full genuine multiplication compatibility of the actual source
Witt associated-weight comparison, derived from literal generators,
actual residues and the original integral carry corrections. -/
theorem elementary_prime_witt_associated_map_multiplicative (r d e : ℕ)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r d)
    (y : elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r e) :
    elementaryPrimeWittAssociatedMap p N k r (d + e) (elementaryPrimeWittWeightProduct p N k r d e x y) =
      elementaryPrimeWittAssociatedMap p N k r d x * elementaryPrimeWittAssociatedMap p N k r e y := by
  let R := TruncatedWittVector p N k
  let B := elementaryAugmentationBasis (R := R) p (by have := (Fact.out : p.Prime).two_le; omega) r
  let degree := fun alpha : Fin r → Fin p => ∑ i, (alpha i).val
  let ρ := (elementaryPrimeAssociatedScalar p N k r).comp (truncatedWittResidue p N (Fact.out : 0 < N) k)
  apply weighted_multiplicative_extension B (p : R) (p - 1) degree
    (elementaryPrimeWittAssociatedMap p N k r) ρ
    (elementary_prime_normal_weight_mul p (Fact.out : p.Prime) r)
    (fun d t x => elementary_prime_witt_associated_map_scalar p N k r d t x)
    ?_ d e x y
  intro d e j l alpha beta leftBound rightBound
  let left : elementaryNormalWeightFiltration R p (by have := (Fact.out : p.Prime).two_le; omega) r d :=
    ⟨(p : R) ^ j • B alpha, Submodule.subset_span ⟨j, alpha, leftBound, rfl⟩⟩
  let right : elementaryNormalWeightFiltration R p (by have := (Fact.out : p.Prime).two_le; omega) r e :=
    ⟨(p : R) ^ l • B beta, Submodule.subset_span ⟨l, beta, rightBound, rfl⟩⟩
  change elementaryPrimeWittAssociatedMap p N k r (d + e) (elementaryPrimeWittWeightProduct p N k r d e left right) =
    elementaryPrimeWittAssociatedMap p N k r d left * elementaryPrimeWittAssociatedMap p N k r e right
  have productHigher (strict : d + e < ((p - 1) * j + degree alpha) + ((p - 1) * l + degree beta)) :
      elementaryPrimeWittAssociatedMap p N k r (d + e)
        (elementaryPrimeWittWeightProduct p N k r d e left right) = 0 := by
    apply (elementary_prime_witt_associated_map_kernel p N k r (d + e) _).mpr
    have own := elementary_prime_normal_weight_mul p (Fact.out : p.Prime) (R := R) r
      ((p - 1) * j + degree alpha) ((p - 1) * l + degree beta)
      ((p : R) ^ j • B alpha) ((p : R) ^ l • B beta)
      (Submodule.subset_span ⟨j, alpha, le_rfl, rfl⟩)
      (Submodule.subset_span ⟨l, beta, le_rfl, rfl⟩)
    exact elementary_normal_weight_antitone (R := R) p (by have := (Fact.out : p.Prime).two_le; omega) r (by have := (Fact.out : p.Prime).two_le; omega) own
  by_cases exactLeft : d = (p - 1) * j + degree alpha
  · by_cases exactRight : e = (p - 1) * l + degree beta
    · subst d
      subst e
      exact elementary_prime_witt_associated_normal_product p N k r j l alpha beta
    · have strict : e < (p - 1) * l + degree beta := by omega
      have rightZero : elementaryPrimeWittAssociatedMap p N k r e right = 0 := by
        apply (elementary_prime_witt_associated_map_kernel p N k r e right).mpr
        exact Submodule.subset_span ⟨l, beta, by change e + 1 ≤ (p - 1) * l + degree beta; omega, rfl⟩
      rw [rightZero, mul_zero, productHigher (by have := (Fact.out : p.Prime).two_le; omega)]
  · have strict : d < (p - 1) * j + degree alpha := by omega
    have leftZero : elementaryPrimeWittAssociatedMap p N k r d left = 0 := by
      apply (elementary_prime_witt_associated_map_kernel p N k r d left).mpr
      exact Submodule.subset_span ⟨j, alpha, by change d + 1 ≤ (p - 1) * j + degree alpha; omega, rfl⟩
    rw [leftZero, zero_mul, productHigher (by have := (Fact.out : p.Prime).two_le; omega)]

end Litt3.Deformations

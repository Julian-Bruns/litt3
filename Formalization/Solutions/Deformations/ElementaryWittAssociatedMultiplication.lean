import Solutions.Deformations.ElementaryWittWeightProducts
import Solutions.Deformations.WeightedMultiplicativeExtension

set_option maxHeartbeats 1600000

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (N : ℕ) [Fact (0 < N)]
variable (k : Type*) [Field k] [Fact (Nat.Prime 5)] [CharP k 5] [PerfectRing k 5]

local instance : Nontrivial (TruncatedWittVector 5 N k) :=
  truncated_witt_nontrivial 5 N (Fact.out : 0 < N) k

/-- Full genuine multiplication compatibility of the actual source
Witt associated-weight comparison, derived from literal generators,
actual residues and the original integral carry corrections. -/
theorem elementary_witt_associated_map_multiplicative (r d e : ℕ)
    (x : elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d)
    (y : elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r e) :
    elementaryWittAssociatedMap N k r (d + e) (elementaryWittWeightProduct N k r d e x y) =
      elementaryWittAssociatedMap N k r d x * elementaryWittAssociatedMap N k r e y := by
  let R := TruncatedWittVector 5 N k
  let B := elementaryAugmentationBasis (R := R) 5 (by omega) r
  let degree := fun alpha : Fin r → Fin 5 => ∑ i, (alpha i).val
  let ρ := (elementaryAssociatedScalar N k r).comp (truncatedWittResidue 5 N (Fact.out : 0 < N) k)
  apply weighted_multiplicative_extension B (5 : R) 4 degree
    (elementaryWittAssociatedMap N k r) ρ
    (elementary_five_normal_weight_mul r)
    (fun d t x => elementary_witt_associated_map_scalar N k r d t x)
    ?_ d e x y
  intro d e j l alpha beta leftBound rightBound
  let left : elementaryNormalWeightFiltration R 5 (by omega) r d :=
    ⟨(5 : R) ^ j • B alpha, Submodule.subset_span ⟨j, alpha, leftBound, rfl⟩⟩
  let right : elementaryNormalWeightFiltration R 5 (by omega) r e :=
    ⟨(5 : R) ^ l • B beta, Submodule.subset_span ⟨l, beta, rightBound, rfl⟩⟩
  change elementaryWittAssociatedMap N k r (d + e) (elementaryWittWeightProduct N k r d e left right) =
    elementaryWittAssociatedMap N k r d left * elementaryWittAssociatedMap N k r e right
  have productHigher (strict : d + e < (4 * j + degree alpha) + (4 * l + degree beta)) :
      elementaryWittAssociatedMap N k r (d + e)
        (elementaryWittWeightProduct N k r d e left right) = 0 := by
    apply (elementary_witt_associated_map_kernel N k r (d + e) _).mpr
    have own := elementary_five_normal_weight_mul (R := R) r
      (4 * j + degree alpha) (4 * l + degree beta)
      ((5 : R) ^ j • B alpha) ((5 : R) ^ l • B beta)
      (Submodule.subset_span ⟨j, alpha, le_rfl, rfl⟩)
      (Submodule.subset_span ⟨l, beta, le_rfl, rfl⟩)
    exact elementary_normal_weight_antitone (R := R) 5 (by omega) r (by omega) own
  by_cases exactLeft : d = 4 * j + degree alpha
  · by_cases exactRight : e = 4 * l + degree beta
    · subst d
      subst e
      exact elementary_witt_associated_normal_product N k r j l alpha beta
    · have strict : e < 4 * l + degree beta := by omega
      have rightZero : elementaryWittAssociatedMap N k r e right = 0 := by
        apply (elementary_witt_associated_map_kernel N k r e right).mpr
        exact Submodule.subset_span ⟨l, beta, by change e + 1 ≤ 4 * l + degree beta; omega, rfl⟩
      rw [rightZero, mul_zero, productHigher (by omega)]
  · have strict : d < 4 * j + degree alpha := by omega
    have leftZero : elementaryWittAssociatedMap N k r d left = 0 := by
      apply (elementary_witt_associated_map_kernel N k r d left).mpr
      exact Submodule.subset_span ⟨j, alpha, by change d + 1 ≤ 4 * j + degree alpha; omega, rfl⟩
    rw [leftZero, zero_mul, productHigher (by omega)]

end Litt3.Deformations

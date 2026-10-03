import Solutions.Deformations.ElementaryWittOperatorInitial
import Solutions.Deformations.ElementaryGradedHighImage

set_option maxHeartbeats 1400000

namespace Litt3.Deformations

open scoped WeightedRootPolynomialScalars

variable (r : ℕ) (k : Type*) [Field k] [Fact (Nat.Prime 5)] [CharP k 5] [PerfectRing k 5]

local instance : Fact (0 < r + 1) := ⟨by omega⟩
local instance : Nontrivial (TruncatedWittVector 5 (r + 1) k) :=
  truncated_witt_nontrivial 5 (r + 1) (by omega) k

/-- Every actual high-weight target has an actual additive correction
two weights lower, obtained from proved literal quadratic surjectivity
and the actual inverse coefficient Frobenius. -/
theorem elementary_witt_high_correction
    (L : AddMonoidAlgebra (TruncatedWittVector 5 (r + 1) k) (Fin r → ZMod 5) →+
      AddMonoidAlgebra (TruncatedWittVector 5 (r + 1) k) (Fin r → ZMod 5))
    (q : MvPolynomial (Fin r) k)
    (reduction : ElementaryWittQuadraticReduction (r + 1) k r L q)
    (anisotropic : ∀ a : Fin r → ZMod 5, a ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl 5) k (a i)) ≠ 0)
    (d : ℕ) (high : 4 * r + 2 ≤ d)
    (z : elementaryNormalWeightFiltration (TruncatedWittVector 5 (r + 1) k) 5 (by omega) r d) :
    ∃ x : elementaryNormalWeightFiltration (TruncatedWittVector 5 (r + 1) k)
        5 (by omega) r (d - 2),
      z.val - L x.val ∈ elementaryNormalWeightFiltration (TruncatedWittVector 5 (r + 1) k)
        5 (by omega) r (d + 1) := by
  let N := r + 1
  let e := d - 2
  obtain ⟨Z, homogeneous, zRepresentation⟩ :=
    (elementary_witt_associated_map_full_range N k r d
      (elementaryWittAssociatedMap N k r d z)).mp ⟨z, rfl⟩
  obtain ⟨T, tHomogeneous, image⟩ := elementary_graded_high_image k r d high q reduction.2.1
    anisotropic Z homogeneous
  obtain ⟨y, yRepresentation⟩ :=
    (elementary_witt_associated_map_full_range N k r e
      (weightedRootTruncation k 5 N (Fact.out : 0 < N) r T)).mpr ⟨T, tHomogeneous, rfl⟩
  let x := (elementaryWittFrobeniusWeight N k r e).symm y
  obtain ⟨lxMember, lxInitial⟩ := elementary_witt_operator_initial N k r e L q reduction x
  have index : e + 2 = d := by dsimp only [e]; omega
  have member : L x.val ∈
      elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d := by
    simpa only [index] using lxMember
  have initialAtD := (elementary_witt_associated_map_reindex N k r d (e + 2)
    index.symm (L x.val) member lxMember).trans lxInitial
  have frobenius : elementaryWittFrobeniusWeight N k r e x = y :=
    (elementaryWittFrobeniusWeight N k r e).apply_symm_apply y
  rw [frobenius, yRepresentation, ← map_mul] at initialAtD
  have exactClass : elementaryWittAssociatedMap N k r d ⟨L x.val, member⟩ =
      elementaryWittAssociatedMap N k r d z := by
    rw [initialAtD, image, zRepresentation]
  refine ⟨x, ?_⟩
  exact (elementary_witt_associated_map_equal_iff N k r d z ⟨L x.val, member⟩).mp exactClass.symm

end Litt3.Deformations

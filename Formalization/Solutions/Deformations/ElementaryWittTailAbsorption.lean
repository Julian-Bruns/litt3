import Solutions.Deformations.ElementaryWittHighCorrection
import Solutions.Deformations.ElementaryWeightedNormal
import Solutions.Deformations.FilteredAdditiveLifting

set_option maxHeartbeats 1400000

namespace Litt3.Deformations

variable (r : ℕ) (k : Type*) [Field k] [Fact (Nat.Prime 5)] [CharP k 5] [PerfectRing k 5]

local instance : Fact (0 < r + 1) := ⟨by omega⟩
local instance : Nontrivial (TruncatedWittVector 5 (r + 1) k) :=
  truncated_witt_nontrivial 5 (r + 1) (by omega) k

/-- Full actual tail absorption in the original Witt algebra. The
operator is only additive; corrections are constructed from genuine
graded surjectivity and terminate at the actual nilpotent cutoff. -/
theorem elementary_witt_tail_absorption (positive : 0 < r)
    (L : AddMonoidAlgebra (TruncatedWittVector 5 (r + 1) k) (Fin r → ZMod 5) →+
      AddMonoidAlgebra (TruncatedWittVector 5 (r + 1) k) (Fin r → ZMod 5))
    (q : MvPolynomial (Fin r) k)
    (reduction : ElementaryWittQuadraticReduction (r + 1) k r L q)
    (anisotropic : ∀ a : Fin r → ZMod 5, a ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl 5) k (a i)) ≠ 0)
    (z : AddMonoidAlgebra (TruncatedWittVector 5 (r + 1) k) (Fin r → ZMod 5))
    (member : z ∈ elementaryNormalWeightFiltration (TruncatedWittVector 5 (r + 1) k)
      5 (by omega) r (4 * r + 2)) :
    ∃ x : AddMonoidAlgebra (TruncatedWittVector 5 (r + 1) k) (Fin r → ZMod 5),
      x ∈ elementaryNormalWeightFiltration (TruncatedWittVector 5 (r + 1) k)
        5 (by omega) r (4 * r) ∧ L x = z := by
  let R := TruncatedWittVector 5 (r + 1) k
  let F := fun d => (elementaryNormalWeightFiltration R 5 (by omega) r d).toAddSubgroup
  let D := (elementaryNormalWeightFiltration R 5 (by omega) r (4 * r)).toAddSubgroup
  have cutoff : elementaryNormalWeightFiltration R 5 (by omega) r (8 * r + 1) = ⊥ := by
    rw [elementary_five_normal_weights_eq]
    exact elementary_witt_weighted_cutoff r k (8 * r + 1) (by omega)
  apply filtered_additive_exact_lift F D L (4 * r + 2) (8 * r + 1) (by omega) ?_ ?_ z member
  · change (elementaryNormalWeightFiltration R 5 (by omega) r (8 * r + 1)).toAddSubgroup = ⊥
    rw [cutoff]
    rfl
  · intro d high _ y yMember
    obtain ⟨x, corrected⟩ := elementary_witt_high_correction r k L q reduction anisotropic d high ⟨y, yMember⟩
    refine ⟨x.val, ?_, corrected⟩
    exact elementary_normal_weight_antitone (R := R) 5 (by omega) r (by omega) x.property

end Litt3.Deformations

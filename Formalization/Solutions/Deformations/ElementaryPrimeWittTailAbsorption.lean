import Solutions.Deformations.ElementaryPrimeWittHighCorrection
import Solutions.Deformations.ElementaryPrimeWeightStructure
import Solutions.Deformations.TruncatedWittMaps
import Solutions.Deformations.FilteredAdditiveLifting

set_option maxHeartbeats 1400000

namespace Litt3.Deformations

variable (p r a : ℕ) [Fact p.Prime]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Fact (0 < r + 1) := ⟨by omega⟩
local instance : Nontrivial (TruncatedWittVector p (r + 1) k) :=
  truncated_witt_nontrivial p (r + 1) (by have := (Fact.out : p.Prime).two_le; omega) k

/-- Full actual tail absorption in the original Witt algebra. The
operator is only additive; corrections are constructed from genuine
graded surjectivity and terminate at the actual nilpotent cutoff. -/
theorem elementary_prime_witt_tail_absorption
    (principalPositive : 0 < a) (degreeBound : a + 1 ≤ p - 1) (positive : 0 < r)
    (L : AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p) →+
      AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p))
    (q : MvPolynomial (Fin r) k)
    (reduction : ElementaryPrimeWittReduction p (r + 1) k r a L q)
    (anisotropic : ∀ a : Fin r → ZMod p, a ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl p) k (a i)) ≠ 0)
    (z : AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p))
    (member : z ∈ elementaryNormalWeightFiltration (TruncatedWittVector p (r + 1) k)
      p (by have := (Fact.out : p.Prime).two_le; omega) r ((p - 1) * r + a)) :
    ∃ x : AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p),
      x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p (r + 1) k)
        p (by have := (Fact.out : p.Prime).two_le; omega) r ((p - 1) * r) ∧ L x = z := by
  let R := TruncatedWittVector p (r + 1) k
  let F := fun d => (elementaryNormalWeightFiltration R p (by have := (Fact.out : p.Prime).two_le; omega) r d).toAddSubgroup
  let D := (elementaryNormalWeightFiltration R p (by have := (Fact.out : p.Prime).two_le; omega) r ((p - 1) * r)).toAddSubgroup
  have cutoff : elementaryNormalWeightFiltration R p (by have := (Fact.out : p.Prime).two_le; omega) r (2 * ((p - 1) * r) + 1) = ⊥ := by
    apply elementary_prime_normal_weight_cutoff p (Fact.out : p.Prime) r (r + 1)
      (by omega) (truncated_witt_top_power_zero p (r + 1) k)
    simp only [Nat.add_sub_cancel]
    omega
  have first : p - 1 ≤ (p - 1) * r := Nat.le_mul_of_pos_right (p - 1) positive
  apply filtered_additive_exact_lift F D L ((p - 1) * r + a) (2 * ((p - 1) * r) + 1) (by omega) ?_ ?_ z member
  · change (elementaryNormalWeightFiltration R p (by have := (Fact.out : p.Prime).two_le; omega) r (2 * ((p - 1) * r) + 1)).toAddSubgroup = ⊥
    rw [cutoff]
    rfl
  · intro d high _ y yMember
    obtain ⟨x, corrected⟩ := elementary_prime_witt_high_correction p r a k principalPositive degreeBound L q reduction anisotropic d high ⟨y, yMember⟩
    refine ⟨x.val, ?_, corrected⟩
    exact elementary_normal_weight_antitone (R := R) p (by have := (Fact.out : p.Prime).two_le; omega) r (by have := (Fact.out : p.Prime).two_le; omega) x.property

end Litt3.Deformations

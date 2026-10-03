import Solutions.Deformations.ElementaryPrimeWittTailAbsorption

namespace Litt3.Deformations

variable (p r a : ℕ) [Fact p.Prime]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Fact (0 < r + 1) := ⟨by omega⟩
local instance : Nontrivial (TruncatedWittVector p (r + 1) k) :=
  truncated_witt_nontrivial p (r + 1) (by have := (Fact.out : p.Prime).two_le; omega) k

/-- The actual finite correction algorithm retains every additional weight
of the target. Thus later norm corrections preserve a prescribed leading
norm coefficient, instead of returning only an undifferentiated tail lift. -/
theorem elementary_prime_witt_refined_tail_absorption
    (principalPositive : 0 < a) (degreeBound : a + 1 ≤ p - 1)
    (L : AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p) →+
      AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p))
    (q : MvPolynomial (Fin r) k)
    (reduction : ElementaryPrimeWittReduction p (r + 1) k r a L q)
    (anisotropic : ∀ v : Fin r → ZMod p, v ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl p) k (v i)) ≠ 0)
    (start : ℕ) (high : (p - 1) * r + a ≤ start)
    (belowCutoff : start ≤ 2 * ((p - 1) * r) + 1)
    (z : AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p))
    (member : z ∈ elementaryNormalWeightFiltration (TruncatedWittVector p (r + 1) k)
      p (by have := (Fact.out : p.Prime).two_le; omega) r start) :
    ∃ x : AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p),
      x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p (r + 1) k)
        p (by have := (Fact.out : p.Prime).two_le; omega) r (start - a) ∧ L x = z := by
  let R := TruncatedWittVector p (r + 1) k
  let F := fun d => (elementaryNormalWeightFiltration R p
    (by have := (Fact.out : p.Prime).two_le; omega) r d).toAddSubgroup
  let D := (elementaryNormalWeightFiltration R p
    (by have := (Fact.out : p.Prime).two_le; omega) r (start - a)).toAddSubgroup
  have cutoff : elementaryNormalWeightFiltration R p
      (by have := (Fact.out : p.Prime).two_le; omega) r (2 * ((p - 1) * r) + 1) = ⊥ := by
    apply elementary_prime_normal_weight_cutoff p (Fact.out : p.Prime) r (r + 1)
      (by omega) (truncated_witt_top_power_zero p (r + 1) k)
    simp only [Nat.add_sub_cancel]
    omega
  apply filtered_additive_exact_lift F D L start (2 * ((p - 1) * r) + 1)
    belowCutoff ?_ ?_ z member
  · change (elementaryNormalWeightFiltration R p
      (by have := (Fact.out : p.Prime).two_le; omega) r (2 * ((p - 1) * r) + 1)).toAddSubgroup = ⊥
    rw [cutoff]
    rfl
  · intro d afterStart _ y yMember
    obtain ⟨x, corrected⟩ := elementary_prime_witt_high_correction p r a k
      principalPositive degreeBound L q reduction anisotropic d (by omega) ⟨y, yMember⟩
    refine ⟨x.val, ?_, corrected⟩
    exact elementary_normal_weight_antitone (R := R) p
      (by have := (Fact.out : p.Prime).two_le; omega) r
      (by omega) x.property

end Litt3.Deformations

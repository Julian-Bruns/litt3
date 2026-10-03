import Solutions.Deformations.ElementaryPrimeWittPreimageBound

namespace Litt3.Deformations

variable (p r a : ℕ) [Fact p.Prime]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Fact (0 < r + 1) := ⟨by omega⟩
local instance : Nontrivial (TruncatedWittVector p (r + 1) k) :=
  truncated_witt_nontrivial p (r + 1) (by omega) k

/-- The known original target weight bounds every final-precision preimage
up to the exact norm weight; all lower cancellations are excluded. -/
theorem elementary_prime_witt_final_preimage_bound
    (large : 2 < p) (principalPositive : 0 < a) (degreeBound : a + 1 ≤ p - 1)
    (t b : ℕ) (sourceBound : b ≤ (p - 1) * r) (imageBound : b + a ≤ t)
    (L : AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p) →+
      AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p))
    (q : MvPolynomial (Fin r) k)
    (reduction : ElementaryPrimeWittReduction p (r + 1) k r a L q)
    (anisotropic : ∀ v : Fin r → ZMod p, v ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl p) k (v i)) ≠ 0)
    (x : AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p))
    (target : L x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p (r + 1) k)
      p (Fact.out : p.Prime).pos r t) :
    x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p (r + 1) k)
      p (Fact.out : p.Prime).pos r b := by
  have advance : ∀ d, d ≤ b →
      x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p (r + 1) k)
        p (Fact.out : p.Prime).pos r d := by
    intro d
    induction d with
    | zero =>
      intro _
      rw [elementary_normal_weight_initial]
      exact Submodule.mem_top
    | succ d induction =>
      intro bound
      apply elementary_prime_witt_preimage_step p r a k large principalPositive degreeBound
        L q reduction anisotropic d (by omega) ⟨x, induction (by omega)⟩
      exact elementary_normal_weight_antitone (R := TruncatedWittVector p (r + 1) k)
        p (Fact.out : p.Prime).pos r (by omega) target
  exact advance b le_rfl

end Litt3.Deformations

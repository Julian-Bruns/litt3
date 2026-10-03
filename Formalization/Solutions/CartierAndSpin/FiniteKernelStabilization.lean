import Mathlib.LinearAlgebra.Dimension.Finrank
import Mathlib.LinearAlgebra.FiniteDimensional.Basic
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

variable {k M : Type*} [Field k] [AddCommGroup M] [Module k M] [FiniteDimensional k M]

/-- A decreasing actual subspace chain with initial dimension at most
N and a nonzero Nth member must already have an adjacent equality. -/
theorem nonzero_antitone_kernel_chain_stabilizes (P : ℕ → Submodule k M)
    (hanti : Antitone P) (N : ℕ) (hstart : Module.finrank k (P 0) ≤ N)
    (hnonzero : P N ≠ ⊥) : ∃ d : ℕ, d < N ∧ P d = P (d + 1) := by
  by_contra h
  push_neg at h
  have hstrict (d : ℕ) (hd : d < N) : P (d + 1) < P d :=
    lt_of_le_of_ne (hanti (by omega)) (h d hd).symm
  have hbound : ∀ d : ℕ, d ≤ N → Module.finrank k (P d) + d ≤ Module.finrank k (P 0) := by
    intro d
    induction d with
    | zero => simp
    | succ d ih =>
        intro hd
        have hprev := ih (show d ≤ N by omega)
        have hdrop := Submodule.finrank_lt_finrank_of_lt (hstrict d (by omega))
        omega
  have hlast := hbound N le_rfl
  have hpositive : 0 < Module.finrank k (P N) := Nat.pos_of_ne_zero
    (fun hzero => hnonzero (Submodule.finrank_eq_zero.mp hzero))
  omega

end Litt3.CartierAndSpin

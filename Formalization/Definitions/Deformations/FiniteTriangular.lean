import Definitions.Deformations.ObstructionTorsors
import Mathlib.Data.Fin.Tuple.Basic
import Mathlib.Algebra.Group.Pi.Basic

namespace Litt3.Deformations

/-- A finite prefix with possibly different coefficient groups in
each block. -/
abbrev BlockPrefix (K : ℕ → Type*) (n : ℕ) := ∀ i : Fin n, K i.val

/-- Append the last coordinate; the equivalence retains the literal
finite-indexed coordinate presentation. -/
def prefixSnocEquiv (K : ℕ → Type*) (n : ℕ) :
    BlockPrefix K n × K n ≃ BlockPrefix K (n + 1) :=
  (Equiv.prodComm _ _).trans (Fin.snocEquiv (fun i : Fin (n + 1) => K i.val))

variable {K O : ℕ → Type*} [∀ n, AddCommGroup (O n)]

/-- Solve ALL finite triangular blocks. The `n`th tail is an arbitrary
function of the earlier original variables, and may be nonlinear. -/
def finiteTriangularEquiv (diagonal : ∀ n, K n ≃ O n)
    (tail : ∀ n, BlockPrefix K n → O n) :
    ∀ n, BlockPrefix K n ≃ BlockPrefix O n
  | 0 => {
      toFun := fun _ i => i.elim0
      invFun := fun _ i => i.elim0
      left_inv := fun _ => funext (fun i => i.elim0)
      right_inv := fun _ => funext (fun i => i.elim0) }
  | n + 1 => (prefixSnocEquiv K n).symm.trans
      ((triangularStep (finiteTriangularEquiv diagonal tail n)
        (diagonal n) (tail n)).trans (prefixSnocEquiv O n))

end Litt3.Deformations

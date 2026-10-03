import Definitions.Jacobians.ValuationDivisors
import Mathlib.Algebra.Module.Submodule.Defs

namespace Litt3.SharedTensors

open Litt3.Jacobians
open scoped WithZero

variable {k K X : Type*} [Field k] [Field K] [Algebra k K]

/-- The actual rational functions whose orders are bounded by an actual
integral divisor. Zero is included by the valuation convention. Constant
scalars have value at most one, as required for a constant-field vector space. -/
noncomputable def divisorSectionSpace (S : ValuationDivisorSystem K X)
    (constants : ∀ c : k, ∀ x, S.valuation x (algebraMap k K c) ≤ 1)
    (D : Divisor X) : Submodule k K where
  carrier := {f | ∀ x, S.valuation x f ≤ WithZero.exp (D x)}
  zero_mem' := by
    intro x
    change S.valuation x (0 : K) ≤ WithZero.exp (D x)
    rw [map_zero]
    exact bot_le
  add_mem' := by
    intro f g hf hg x
    exact (S.valuation x).map_add_le (hf x) (hg x)
  smul_mem' := by
    intro c f hf x
    rw [Algebra.smul_def, map_mul]
    calc
      S.valuation x (algebraMap k K c) * S.valuation x f ≤ 1 * S.valuation x f :=
        mul_le_mul_right' (constants c x) _
      _ ≤ WithZero.exp (D x) := by simpa using hf x

end Litt3.SharedTensors

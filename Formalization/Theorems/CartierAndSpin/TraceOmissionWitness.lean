import Definitions.CartierAndSpin.NewtonSharpness
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace Litt3.CartierAndSpin.Specifications

variable {R K ι : Type*} [CommRing R] [Field K] [Algebra R K] [Fintype ι]

/-- All the actual short-list inputs except the single trace P_(p+i),
whose failure is part of this precise counterexample proposition. -/
def OmittedHigherTraceWitness (u : ι → K) (p r i : ℕ) : Prop :=
  Fintype.card ι = 2 * p + r ∧
  (∀ j, u j ≠ 0) ∧
  (∃ b : R, IsUnit b ∧ algebraMap R K b = ∏ j, u j) ∧
  (∀ k, 0 < k → k < p → finitePowerSum u k ∈ (algebraMap R K).range) ∧
  (∀ k, 0 < k → k < p → finitePowerSum (fun j => (u j)⁻¹) k ∈
    (algebraMap R K).range) ∧
  finiteElementarySymmetric u p ∈ (algebraMap R K).range ∧
  (∀ j, 0 < j → j ≤ r → j ≠ i → finitePowerSum u (p + j) ∈
    (algebraMap R K).range) ∧
  finitePowerSum u (p + i) ∉ (algebraMap R K).range

end Litt3.CartierAndSpin.Specifications

import Theorems.Deformations.NilpotentPositiveBlocks
import Solutions.Deformations.NilpotentQuotientBlocks
import Solutions.Deformations.PositiveQuotientBlocks

namespace Litt3.Deformations

variable {k V : Type*} [Field k] [AddCommGroup V] [Module k V]

/-- The full quotient decomposition of every actual finite-dimensional
nilpotent operator exists over every field. No Jordan form or finite
computation is supplied as a hypothesis. -/
theorem nilpotent_positive_blocks [FiniteDimensional k V]
    (T : V →ₗ[k] V) (N : ℕ) (nilpotent : T ^ N = 0) :
    Specifications.NilpotentPositiveBlocks T N := by
  classical
  obtain ⟨d, length, bound, e, operator⟩ := nilpotent_quotient_blocks T N nilpotent
  let I := {i : Fin d // 0 < length i}
  let index : I ≃ Fin (Fintype.card I) := Fintype.equivFin I
  let positiveLength : Fin (Fintype.card I) → ℕ := fun i => length (index.symm i).1
  let E := e.trans ((positiveQuotientBlocksEquiv length).trans
    (LinearEquiv.piCongrLeft' k (fun i : I => TruncatedCoefficientRing k (length i.1)) index))
  refine ⟨Fintype.card I, positiveLength, ?_, ?_, E, ?_⟩
  · intro i
    exact (index.symm i).2
  · intro i
    exact bound (index.symm i).1
  · intro v i
    exact operator v (index.symm i).1

end Litt3.Deformations

import Mathlib.LinearAlgebra.Eigenspace.Triangularizable

namespace Litt3.CartierAndSpin

open Module

variable {k M : Type*} [Field k] [AddCommGroup M] [Module k M]
variable [IsAlgClosed k] [FiniteDimensional k M] [Nontrivial M]

/-- Commuting actual endomorphisms have a genuine common eigenvector
over every algebraically closed field, with no characteristic restriction. -/
theorem commuting_endomorphisms_common_eigenvector (U V : Module.End k M)
    (hcomm : Commute U V) :
    ∃ (a b : k) (x : M), x ≠ 0 ∧ U x = a • x ∧ V x = b • x := by
  obtain ⟨a, ha⟩ := U.exists_eigenvalue
  let P := U.eigenspace a
  letI : Nontrivial P := Submodule.nontrivial_iff_ne_bot.mpr ha
  have hstable : ∀ x ∈ P, V x ∈ P := by
    intro x hx
    apply Module.End.mem_eigenspace_iff.mpr
    calc
      U (V x) = V (U x) := DFunLike.congr_fun hcomm.eq x
      _ = V (a • x) := by rw [Module.End.mem_eigenspace_iff.mp hx]
      _ = a • V x := V.map_smul a x
  let W : Module.End k P := V.restrict hstable
  obtain ⟨b, hb⟩ := W.exists_eigenvalue
  obtain ⟨x, hx⟩ := hb.exists_hasEigenvector
  refine ⟨a, b, x.val, ?_, Module.End.mem_eigenspace_iff.mp x.property, ?_⟩
  · intro hzero
    exact hx.2 (Subtype.ext hzero)
  · exact congrArg Subtype.val hx.apply_eq_smul

end Litt3.CartierAndSpin

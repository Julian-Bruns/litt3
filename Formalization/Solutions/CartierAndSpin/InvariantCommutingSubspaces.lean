import Solutions.CartierAndSpin.CommonEigenvectors

namespace Litt3.CartierAndSpin

variable {k M : Type*} [Field k] [AddCommGroup M] [Module k M]
variable [IsAlgClosed k] [FiniteDimensional k M]

/-- An actual nonzero invariant subspace on which two endomorphisms
commute supplies a common eigenvector in the original space. -/
theorem invariant_commuting_subspace_common_eigenvector
    (U V : Module.End k M) (P : Submodule k M) (hP : P ≠ ⊥)
    (hU : ∀ x ∈ P, U x ∈ P) (hV : ∀ x ∈ P, V x ∈ P)
    (hcomm : ∀ x ∈ P, U (V x) = V (U x)) :
    ∃ (a b : k) (x : M), x ≠ 0 ∧ U x = a • x ∧ V x = b • x := by
  letI : Nontrivial P := Submodule.nontrivial_iff_ne_bot.mpr hP
  let U' : Module.End k P := U.restrict hU
  let V' : Module.End k P := V.restrict hV
  have hc : Commute U' V' := by
    ext x
    exact hcomm x.val x.property
  obtain ⟨a, b, x, hx, hUx, hVx⟩ := commuting_endomorphisms_common_eigenvector U' V' hc
  refine ⟨a, b, x.val, ?_, congrArg Subtype.val hUx, congrArg Subtype.val hVx⟩
  intro hz
  exact hx (Subtype.ext hz)

end Litt3.CartierAndSpin

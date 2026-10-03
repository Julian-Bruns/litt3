import Mathlib.LinearAlgebra.Basis.Basic
import Mathlib.LinearAlgebra.LinearIndependent.Lemmas
import Mathlib.LinearAlgebra.Projection

set_option maxHeartbeats 800000

namespace Litt3.Deformations

variable {R M I : Type*} [Ring R] [AddCommGroup M] [Module R M]

/-- Removing any chosen subset of an actual basis constructs the exact
complementary quotient basis, with no finite-rank or field assumption. -/
noncomputable def basisQuotientComplement (b : Module.Basis I R M) (s : Set I) :
    Module.Basis {i : I // i ∉ s} R (M ⧸ Submodule.span R (b '' s)) := by
  let v : {i : I // i ∉ s} → M := fun i => b i.val
  have independent : LinearIndependent R v :=
    b.linearIndependent.comp (fun i : {i : I // i ∉ s} => i.val) Subtype.val_injective
  have rangeEq : Set.range v = b '' sᶜ := by
    ext x
    constructor
    · rintro ⟨i, rfl⟩
      exact ⟨i.val, i.property, rfl⟩
    · rintro ⟨i, member, rfl⟩
      exact ⟨⟨i, member⟩, rfl⟩
  let c : Module.Basis {i : I // i ∉ s} R (Submodule.span R (b '' sᶜ)) :=
    (Module.Basis.span independent).map (LinearEquiv.ofEq _ _ (congrArg (Submodule.span R) rangeEq))
  have complement : IsCompl (Submodule.span R (b '' s)) (Submodule.span R (b '' sᶜ)) :=
    b.linearIndependent.isCompl_span_image b.span_eq isCompl_compl
  exact c.map (Submodule.quotientEquivOfIsCompl _ _ complement).symm

/-- Every new quotient basis vector is precisely the unchanged original
basis vector's actual quotient class. -/
theorem basis_quotient_complement_apply (b : Module.Basis I R M) (s : Set I)
    (i : {i : I // i ∉ s}) :
    basisQuotientComplement b s i = Submodule.Quotient.mk (b i.val) := by
  simp only [basisQuotientComplement, Module.Basis.map_apply,
    Submodule.quotientEquivOfIsCompl_symm_apply]
  congr 1
  simpa only [LinearEquiv.coe_ofEq_apply] using Module.Basis.span_apply
    (b.linearIndependent.comp (fun j : {j : I // j ∉ s} => j.val) Subtype.val_injective) i

end Litt3.Deformations

import Solutions.CartierAndSpin.FunctionRootDepth
import Solutions.CartierAndSpin.OneVariableSquarePencils

namespace Litt3.CartierAndSpin

variable {k L : Type*} [Field k] [Field L] [Algebra k L] [IsAlgClosed k]
variable {p : ℕ} [Fact p.Prime] [CharP k p] [CharP L p]

/-- In a genuine finitely generated one-variable field over algebraically
closed constants, membership in every actual iterated Frobenius image is
exactly membership in the actual constant field. -/
theorem all_frobenius_roots_iff_constant
    (hfg : IntermediateField.FG (F := k) (E := L) ⊤)
    (htrdeg : Algebra.trdeg k L = 1) (q : L) :
    (∀ e : ℕ, ∃ r : L, r ^ (p ^ e) = q) ↔ q ∈ Set.range (algebraMap k L) := by
  constructor
  · intro hroots
    by_contra hnonconstant
    have htrans := transcendental_of_not_constant q hnonconstant
    let bound := Nat.log p (Module.finrank (IntermediateField.adjoin k {q}) L)
    obtain ⟨r, hr⟩ := hroots (bound + 1)
    have hdepth := function_root_exponent_bound hfg htrdeg q htrans p
      (Fact.out : p.Prime).one_lt (bound + 1) r hr
    change bound + 1 ≤ bound at hdepth
    omega
  · rintro ⟨c, rfl⟩ e
    let f := iterateFrobeniusEquiv k p e
    refine ⟨algebraMap k L (f.symm c), ?_⟩
    rw [← map_pow]
    congr 1
    exact (iterateFrobeniusEquiv_def k p e (f.symm c)).symm.trans
      (f.apply_symm_apply c)

end Litt3.CartierAndSpin

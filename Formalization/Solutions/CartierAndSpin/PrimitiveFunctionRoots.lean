import Solutions.CartierAndSpin.FunctionRootDepth
import Solutions.CartierAndSpin.PBasisDerivationKernel
import Solutions.SharedTensors.SeparatingPBasisExistence
import Solutions.SharedTensors.PBasisPerfectConstants

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {k L : Type*} [Field k] [Field L] [Algebra k L]
variable {p : ℕ} [Fact p.Prime] [CharP k p] [CharP L p] [PerfectField k]

/-- The actual maximal Frobenius root of a nonconstant function has a
nonzero literal universal differential. The full p-basis, normalized
derivation and terminal-root existence are all constructed. -/
theorem primitive_function_root_exists
    (hfg : IntermediateField.FG (F := k) (E := L) ⊤)
    (htrdeg : Algebra.trdeg k L = 1) (q : L) (hq : Transcendental k q) :
    ∃ e : ℕ, ∃ r : L, r ^ (p ^ e) = q ∧
      KaehlerDifferential.D k L r ≠ 0 ∧
      (¬ ∃ s : L, s ^ p = r) ∧
      e ≤ Nat.log p (Module.finrank (IntermediateField.adjoin k {q}) L) := by
  obtain ⟨e, r, hr, hprimitive, hbound⟩ := maximal_function_power_root_exists
    hfg htrdeg q hq p (Fact.out : p.Prime).one_lt
  obtain ⟨b⟩ := one_variable_power_p_basis_exists (p := p) hfg htrdeg
  obtain ⟨D, ht⟩ := p_basis_perfect_base_derivation_exists (k := k) b
  refine ⟨e, r, hr, ?_, hprimitive, hbound⟩
  intro hzero
  have hDr : D r = 0 := by
    rw [← Derivation.liftKaehlerDifferential_comp_D D r, hzero, map_zero]
  exact hprimitive ((normalized_p_basis_derivation_zero_iff_pth_power b D ht r).mp hDr)

end Litt3.CartierAndSpin

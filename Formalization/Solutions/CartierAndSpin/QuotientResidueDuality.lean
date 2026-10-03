import Solutions.CartierAndSpin.QuotientResidueFunctional
import Mathlib.LinearAlgebra.Dual.Lemmas
import Mathlib.LinearAlgebra.FiniteDimensional.Lemmas

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K]

/-- The true polynomial-quotient residue pairing identifies the entire
quotient with its linear dual. This includes repeated and inseparable
polynomials, without assuming a field quotient or a trace pairing. -/
noncomputable def quotientResidueDuality {D : K[X]} (hD : D.Monic) :
    AdjoinRoot D ≃ₗ[K] Module.Dual K (AdjoinRoot D) := by
  letI : Module.Finite K (AdjoinRoot D) := hD.finite_adjoinRoot
  exact (quotientResiduePairing hD).linearEquivOfInjective
    (quotient_residue_pairing_injective hD) (Subspace.dual_finrank_eq.symm)

theorem quotient_residue_duality_apply {D : K[X]} (hD : D.Monic)
    (x y : AdjoinRoot D) :
    quotientResidueDuality hD x y = quotientResidueFunctional hD (x * y) := rfl

/-- Every genuine linear functional has a unique residue multiplier,
even when the usual algebra trace pairing is degenerate. -/
theorem quotient_residue_multiplier_exists_unique {D : K[X]} (hD : D.Monic)
    (f : Module.Dual K (AdjoinRoot D)) :
    ∃! x : AdjoinRoot D, ∀ y : AdjoinRoot D,
      f y = quotientResidueFunctional hD (x * y) := by
  refine ⟨(quotientResidueDuality hD).symm f, ?_, ?_⟩
  · intro y
    exact congrArg (fun g : Module.Dual K (AdjoinRoot D) => g y)
      ((quotientResidueDuality hD).apply_symm_apply f).symm
  · intro x hx
    apply (quotientResidueDuality hD).injective
    apply LinearMap.ext
    intro y
    rw [(quotientResidueDuality hD).apply_symm_apply f]
    exact (hx y).symm

end Litt3.CartierAndSpin

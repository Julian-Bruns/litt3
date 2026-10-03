import Mathlib.LinearAlgebra.Span.Basic
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

variable {R M : Type*} [CommRing R] [AddCommGroup M] [Module R M]

/-- Commutation on one actual vector extends bilinearly from literal
generators to both full original-coefficient spans. -/
theorem commutation_on_vector_extends_to_spans
    (S T : Set (Module.End R M)) (x : M)
    (htest : ∀ A ∈ S, ∀ B ∈ T, A (B x) = B (A x))
    {A B : Module.End R M} (hA : A ∈ Submodule.span R S) (hB : B ∈ Submodule.span R T) :
    A (B x) = B (A x) := by
  have hleft : ∀ B ∈ T, ∀ A ∈ Submodule.span R S, A (B x) = B (A x) := by
    intro B hB A hA
    induction hA using Submodule.span_induction with
    | mem A hA => exact htest A hA B hB
    | zero => simp
    | add A C hA hC hAC hCC => simp only [LinearMap.add_apply, map_add, hAC, hCC]
    | smul r A hA hAC => simp only [LinearMap.smul_apply, map_smul, hAC]
  induction hB using Submodule.span_induction with
  | mem B hB => exact hleft B hB A hA
  | zero => simp
  | add B C hB hC hAB hAC => simp only [LinearMap.add_apply, map_add, hAB, hAC]
  | smul r B hB hAB => simp only [LinearMap.smul_apply, map_smul, hAB]

end Litt3.CartierAndSpin

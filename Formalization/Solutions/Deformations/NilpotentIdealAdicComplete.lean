import Mathlib.RingTheory.AdicCompletion.Basic
import Mathlib.Tactic

namespace Litt3.Deformations

variable {R : Type*} [CommRing R]

/-- A genuinely nilpotent original ideal makes every module adically
complete: its compatible sequence stabilizes at the explicit cutoff. -/
theorem nilpotent_ideal_adic_complete (J : Ideal R) (N : ℕ) (terminal : J ^ N = ⊥)
    (M : Type*) [AddCommGroup M] [Module R M] : IsAdicComplete J M := by
  refine { haus' := ?_, prec' := ?_ }
  · intro x congruences
    have final := congruences N
    simpa only [terminal, Submodule.bot_smul, SModEq.bot] using final
  · intro f compatible
    refine ⟨f N, ?_⟩
    intro n
    by_cases bound : n ≤ N
    · exact compatible bound
    · have equality := compatible (show N ≤ n by omega)
      have same : f N = f n := by
        simpa only [terminal, Submodule.bot_smul, SModEq.bot] using equality
      rw [same]

/-- Literal prime-power nilpotence supplies completeness without
torsion-freeness or a supplied completion model. -/
theorem nilpotent_prime_adic_complete (p N : ℕ) (terminal : (p : R) ^ N = 0) :
    IsAdicComplete (Ideal.span {(p : R)}) R := by
  apply nilpotent_ideal_adic_complete _ N
  rw [Ideal.span_singleton_pow, terminal, Ideal.span_singleton_zero]

end Litt3.Deformations

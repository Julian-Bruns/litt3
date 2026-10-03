import Mathlib.RingTheory.AdicCompletion.Basic

namespace Litt3.Deformations

open Submodule

variable (R M : Type*) [CommRing R] [AddCommGroup M] [Module R M]

/-- Every module is Hausdorff for an actually nilpotent ideal, with
no finite-generation or field hypothesis. -/
theorem nilpotent_ideal_is_hausdorff (I : Ideal R) (n : ℕ) (cutoff : I ^ n = ⊥) :
    IsHausdorff I M := by
  constructor
  intro x vanishes
  have zero := vanishes n
  simpa only [cutoff, bot_smul, SModEq.bot] using zero

/-- An actual nilpotent ideal makes every adic Cauchy sequence
eventually constant. This proves precompleteness constructively from
its finite ideal cutoff. -/
theorem nilpotent_ideal_is_precomplete (I : Ideal R) (n : ℕ) (cutoff : I ^ n = ⊥) :
    IsPrecomplete I M := by
  constructor
  intro f compatible
  refine ⟨f n, fun k => ?_⟩
  by_cases lower : k ≤ n
  · exact compatible lower
  · have same : f n = f k := by
      have congruence := compatible (show n ≤ k by omega)
      simpa only [cutoff, bot_smul, SModEq.bot] using congruence
    rw [same]

/-- Adic completeness is derived for every module from the actual
nilpotence relation, rather than supplied as a literature interface. -/
theorem nilpotent_ideal_is_adic_complete (I : Ideal R) (n : ℕ) (cutoff : I ^ n = ⊥) :
    IsAdicComplete I M :=
  { nilpotent_ideal_is_hausdorff R M I n cutoff,
    nilpotent_ideal_is_precomplete R M I n cutoff with }

end Litt3.Deformations

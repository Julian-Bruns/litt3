import Solutions.CartierAndSpin.SourceTensorConsequences
import Solutions.SharedTensors.OneVariableKaehler

namespace Litt3.CartierAndSpin

open Polynomial Litt3.SharedTensors

variable {k K : Type*} [Field k] [Field K] [Algebra k K]

/-- A genuine finitely generated one-variable function field over a
perfect base constructs the universal differential coordinate and the
entire original-source tensor calculus. No separating parameter,
differential-coordinate or accepted-literature existence premise is
supplied. -/
theorem one_variable_source_universal_calculus [PerfectField k]
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdeg : Algebra.trdeg k K = 1)
    (F H : K[X]) (p : ℕ) [CharP K p] (q tau : K) (hs : F.Separable) :
    ∃ e : KaehlerDifferential k K ≃ₗ[K] K,
      Specifications.SourceUniversalTensorCalculus F H p q tau e hs := by
  obtain ⟨e⟩ := one_variable_kaehler_coordinate_exists hfg htrdeg
  exact ⟨e, source_universal_tensor_calculus F H p q tau e hs⟩

end Litt3.CartierAndSpin

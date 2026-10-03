import Solutions.CartierAndSpin.SourceTensorConsequences
import Solutions.SharedTensors.RationalFunctionKaehler

namespace Litt3.CartierAndSpin

open Polynomial Litt3.SharedTensors

variable {k T K : Type*} [Field k] [Field T] [Field K]
  [Algebra k T] [Algebra k[X] T] [IsScalarTower k k[X] T] [IsFractionRing k[X] T]
  [Algebra k K] [Algebra T K] [IsScalarTower k T K] [Algebra.IsSeparable T K]

/-- An actual separating rational-function subfield constructs the
source's genuine rank-one differential coordinate and literal universal
tensor calculus. No coordinate or rank-one differential module is input. -/
theorem separating_function_source_universal_calculus
    (F H : K[X]) (p : ℕ) [CharP K p] (q tau : K) (hs : F.Separable) :
    ∃ e : KaehlerDifferential k K ≃ₗ[K] K,
      e (KaehlerDifferential.D k K (algebraMap T K (algebraMap k[X] T X))) = 1 ∧
      Specifications.SourceUniversalTensorCalculus F H p q tau e hs := by
  refine ⟨separatingFunctionKaehlerCoordinate (k := k) (K := T) (E := K),
    separatingFunctionKaehlerCoordinate_parameter, ?_⟩
  exact source_universal_tensor_calculus F H p q tau _ hs

/-- A source derivation normalized at the literal separating parameter
uses exactly this universal coordinate, so scalar and tensor formulas
refer to the same given derivation. -/
theorem separating_function_source_derivation_is_universal (D : Derivation k K K)
    (hnormalized : D (algebraMap T K (algebraMap k[X] T X)) = 1) :
    D = universalCoordinateDerivation
      (separatingFunctionKaehlerCoordinate (k := k) (K := T) (E := K)) :=
  separating_function_derivation_is_universal D hnormalized

end Litt3.CartierAndSpin

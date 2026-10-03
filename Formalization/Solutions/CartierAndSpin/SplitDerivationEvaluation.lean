import Solutions.CartierAndSpin.SourceDerivation
import Mathlib.FieldTheory.Separable

namespace Litt3.CartierAndSpin

open Polynomial

variable {R K : Type*} [CommRing R] [Field K] [Algebra R K]

/-- Every actual evaluation of the separable polynomial quotient
commutes with its extended derivation. This uses the nonvanishing
ordinary derivative at the actual root, rather than a chosen basis. -/
theorem separable_quotient_derivation_evaluation_root (D : Derivation R K K)
    (F : K[X]) (hsep : F.Separable)
    (E : Derivation R (AdjoinRoot F) (AdjoinRoot F))
    (compatible : ∀ c : K, E (algebraMap K (AdjoinRoot F) c) =
      algebraMap K (AdjoinRoot F) (D c))
    (evaluation : AdjoinRoot F →ₐ[K] K) :
    evaluation (E (AdjoinRoot.root F)) = D (evaluation (AdjoinRoot.root F)) := by
  let x := evaluation (AdjoinRoot.root F)
  have hzero : aeval x F = 0 := by
    change aeval (evaluation (AdjoinRoot.root F)) F = 0
    rw [aeval_algHom_apply, AdjoinRoot.aeval_eq, AdjoinRoot.mk_self, map_zero]
  have hderiv : aeval x F.derivative ≠ 0 := hsep.aeval_derivative_ne_zero hzero
  have hE := source_derivation_polynomial_aeval D E compatible (AdjoinRoot.root F) F
  rw [AdjoinRoot.aeval_eq, AdjoinRoot.mk_self, map_zero] at hE
  have hEeval := congrArg evaluation hE
  simp only [map_zero, map_add, map_mul, ← aeval_algHom_apply] at hEeval
  have hD := source_derivation_polynomial_aeval D D (by intro c; simp) x F
  rw [hzero, map_zero] at hD
  apply mul_left_cancel₀ hderiv
  change aeval x F.derivative * evaluation (E (AdjoinRoot.root F)) =
    aeval x F.derivative * D x
  linear_combination hD - hEeval

theorem separable_quotient_derivation_evaluation (D : Derivation R K K)
    (F : K[X]) (hsep : F.Separable)
    (E : Derivation R (AdjoinRoot F) (AdjoinRoot F))
    (compatible : ∀ c : K, E (algebraMap K (AdjoinRoot F) c) =
      algebraMap K (AdjoinRoot F) (D c))
    (evaluation : AdjoinRoot F →ₐ[K] K) (value : AdjoinRoot F) :
    evaluation (E value) = D (evaluation value) := by
  refine AdjoinRoot.induction_on F value (fun P => ?_)
  rw [← AdjoinRoot.aeval_eq, source_derivation_polynomial_aeval D E compatible,
    map_add, map_mul, ← aeval_algHom_apply, ← aeval_algHom_apply,
    separable_quotient_derivation_evaluation_root D F hsep E compatible evaluation,
    ← aeval_algHom_apply, source_derivation_polynomial_aeval D D (by intro c; simp)]

end Litt3.CartierAndSpin

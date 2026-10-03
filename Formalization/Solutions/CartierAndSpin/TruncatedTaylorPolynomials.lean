import Solutions.CartierAndSpin.TruncatedHasseDerivatives
import Mathlib.Algebra.Polynomial.Taylor

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Polynomial

variable {L : Type*} [Field L] {p : ℕ} [Fact p.Prime] [CharP L p]

noncomputable def truncatedFieldTaylorAlgHom (b : PowerPBasis L p) (e : ℕ) :
    L →ₐ[iteratedFrobeniusSubfield L p e] TruncatedFieldTaylor L p e :=
  ⟨truncatedFieldTaylorMap b e, truncatedFieldTaylorMap_constants b e⟩

/-- The actual field Taylor map agrees with the literal polynomial
Taylor expansion on every polynomial over the actual power subfield. -/
theorem truncated_taylor_polynomial_evaluation (b : PowerPBasis L p) (e : ℕ)
    (P : (iteratedFrobeniusSubfield L p e)[X]) :
    truncatedFieldTaylorMap b e (aeval b.parameter P) =
      AdjoinRoot.mk (X ^ (p ^ e))
        (taylor b.parameter (P.map (algebraMap (iteratedFrobeniusSubfield L p e) L))) := by
  let S := iteratedFrobeniusSubfield L p e
  let Q := TruncatedFieldTaylor L p e
  change truncatedFieldTaylorAlgHom b e (aeval b.parameter P) = _
  rw [← aeval_algHom_apply (truncatedFieldTaylorAlgHom b e)]
  change aeval (truncatedFieldTaylorMap b e b.parameter) P = _
  rw [truncatedFieldTaylorMap_parameter, taylor_apply]
  change P.eval₂ (algebraMap S Q)
    (algebraMap L Q b.parameter + AdjoinRoot.mk (X ^ (p ^ e)) X) = _
  rw [← AdjoinRoot.aeval_eq (f := (X ^ (p ^ e) : L[X]))
    ((P.map (algebraMap S L)).comp (X + C b.parameter))]
  rw [aeval_def, eval₂_comp, eval₂_map]
  simp only [eval₂_X, eval₂_add, eval₂_C, AdjoinRoot.mk_X]
  rw [add_comm]
  rfl

theorem truncated_hasse_polynomial_evaluation (b : PowerPBasis L p) (e j : ℕ)
    (hj : j < p ^ e) (P : (iteratedFrobeniusSubfield L p e)[X]) :
    truncatedHasseDerivative b e j (aeval b.parameter P) =
      (hasseDeriv j (P.map (algebraMap (iteratedFrobeniusSubfield L p e) L))).eval
        b.parameter := by
  change truncatedTaylorCoefficient L p e j
    (truncatedFieldTaylorMap b e (aeval b.parameter P)) = _
  rw [truncated_taylor_polynomial_evaluation,
    truncated_taylor_coefficient_mk p e j hj, taylor_coeff]

end Litt3.CartierAndSpin

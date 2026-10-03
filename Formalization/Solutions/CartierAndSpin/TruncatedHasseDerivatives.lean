import Solutions.CartierAndSpin.TruncatedTaylorMap
import Solutions.CartierAndSpin.TruncatedTaylorCoefficients

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Polynomial

variable {L : Type*} [Field L] {p : ℕ} [Fact p.Prime] [CharP L p]

/-- Evaluation at the actual nilpotent Taylor parameter zero. -/
noncomputable def truncatedTaylorEvaluation (e : ℕ) :
    TruncatedFieldTaylor L p e →ₐ[L] L :=
  AdjoinRoot.liftAlgHom (X ^ (p ^ e)) (AlgHom.id L L) 0 (by
    rw [eval₂_pow, eval₂_X]
    exact zero_pow (pow_ne_zero e (Fact.out : p.Prime).ne_zero))

omit [CharP L p] in
theorem truncated_taylor_coefficient_zero (e : ℕ) (a : TruncatedFieldTaylor L p e) :
    truncatedTaylorCoefficient L p e 0 a = truncatedTaylorEvaluation e a := by
  obtain ⟨P, rfl⟩ := AdjoinRoot.mk_surjective (g := (X ^ (p ^ e) : L[X])) a
  rw [truncated_taylor_coefficient_mk p e 0
    (pow_pos (Fact.out : p.Prime).pos e)]
  change P.coeff 0 = aeval (0 : L) P
  simp [aeval_def, eval₂_at_zero]

theorem truncated_taylor_evaluation_map (b : PowerPBasis L p) (e : ℕ) (a : L) :
    truncatedTaylorEvaluation e (truncatedFieldTaylorMap b e a) = a := by
  let S := iteratedFrobeniusSubfield L p e
  let f : L →ₐ[S] L :=
    ⟨(truncatedTaylorEvaluation e).toRingHom.comp (truncatedFieldTaylorMap b e),
      fun c => by
        change truncatedTaylorEvaluation e (truncatedFieldTaylorMap b e c.val) = c.val
        rw [truncatedFieldTaylorMap_constants]
        exact (truncatedTaylorEvaluation e).commutes c.val⟩
  have heq : f = AlgHom.id S L := (iteratedPBasisPowerBasis b e).algHom_ext (by
    rw [iteratedPBasisPowerBasis_gen]
    change truncatedTaylorEvaluation e (truncatedFieldTaylorMap b e b.parameter) = b.parameter
    rw [truncatedFieldTaylorMap_parameter, map_add]
    change truncatedTaylorEvaluation e
      (algebraMap L (TruncatedFieldTaylor L p e) b.parameter) +
        truncatedTaylorEvaluation e (AdjoinRoot.root (X ^ (p ^ e))) = b.parameter
    simp [truncatedTaylorEvaluation])
  exact DFunLike.congr_fun heq a

/-- Actual Hasse coefficient maps, extracted from the genuine Taylor
ring homomorphism into L[z]/z^(p^e). -/
noncomputable def truncatedHasseDerivative (b : PowerPBasis L p) (e j : ℕ) : L →+ L :=
  (truncatedTaylorCoefficient L p e j).toAddMonoidHom.comp
    (truncatedFieldTaylorMap b e).toAddMonoidHom

theorem truncated_hasse_zero (b : PowerPBasis L p) (e : ℕ) (a : L) :
    truncatedHasseDerivative b e 0 a = a := by
  change truncatedTaylorCoefficient L p e 0 (truncatedFieldTaylorMap b e a) = a
  rw [truncated_taylor_coefficient_zero, truncated_taylor_evaluation_map]

/-- The genuine higher product rule, in every index below the actual
truncation degree. -/
theorem truncated_hasse_product (b : PowerPBasis L p) (e j : ℕ) (hj : j < p ^ e)
    (a c : L) :
    truncatedHasseDerivative b e j (a * c) =
      ∑ ij ∈ Finset.antidiagonal j,
        truncatedHasseDerivative b e ij.1 a * truncatedHasseDerivative b e ij.2 c := by
  change truncatedTaylorCoefficient L p e j (truncatedFieldTaylorMap b e (a * c)) = _
  rw [map_mul, truncated_taylor_coefficient_mul p e j hj]
  rfl

end Litt3.CartierAndSpin

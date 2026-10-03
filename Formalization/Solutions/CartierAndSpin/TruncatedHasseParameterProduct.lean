import Solutions.CartierAndSpin.TruncatedHasseDerivatives

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Polynomial

variable {L : Type*} [Field L] {p : ℕ} [Fact p.Prime] [CharP L p]

theorem truncated_hasse_parameter_product (b : PowerPBasis L p) (e j : ℕ)
    (hj : j + 1 < p ^ e) (a : L) :
    truncatedHasseDerivative b e (j + 1) (b.parameter * a) =
      b.parameter * truncatedHasseDerivative b e (j + 1) a +
        truncatedHasseDerivative b e j a := by
  change truncatedTaylorCoefficient L p e (j + 1)
    (truncatedFieldTaylorMap b e (b.parameter * a)) = _
  rw [map_mul, truncatedFieldTaylorMap_parameter]
  obtain ⟨P, hP⟩ := AdjoinRoot.mk_surjective (g := (X ^ (p ^ e) : L[X]))
    (truncatedFieldTaylorMap b e a)
  rw [← hP]
  change truncatedTaylorCoefficient L p e (j + 1)
    ((AdjoinRoot.mk (X ^ (p ^ e)) (C b.parameter) +
      AdjoinRoot.mk (X ^ (p ^ e)) X) * AdjoinRoot.mk (X ^ (p ^ e)) P) = _
  rw [← map_add, ← map_mul, truncated_taylor_coefficient_mk p e (j + 1) hj,
    add_mul, coeff_add, coeff_C_mul, coeff_X_mul]
  change b.parameter * P.coeff (j + 1) + P.coeff j =
    b.parameter * truncatedTaylorCoefficient L p e (j + 1)
      (truncatedFieldTaylorMap b e a) +
        truncatedTaylorCoefficient L p e j (truncatedFieldTaylorMap b e a)
  rw [← hP, truncated_taylor_coefficient_mk p e (j + 1) hj,
    truncated_taylor_coefficient_mk p e j (by omega)]

end Litt3.CartierAndSpin

import Solutions.CartierAndSpin.TruncatedHasseDerivatives
import Solutions.SharedTensors.RationalCartierExact

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Polynomial

variable {L : Type*} [Field L] {p : ℕ} [Fact p.Prime] [CharP L p]

theorem truncated_hasse_constants (b : PowerPBasis L p) (e j : ℕ)
    (hj : j < p ^ e) (hpos : 0 < j) (c : iteratedFrobeniusSubfield L p e) :
    truncatedHasseDerivative b e j c.val = 0 := by
  change truncatedTaylorCoefficient L p e j (truncatedFieldTaylorMap b e c.val) = 0
  rw [truncatedFieldTaylorMap_constants]
  change truncatedTaylorCoefficient L p e j (AdjoinRoot.mk (X ^ (p ^ e)) (C c.val)) = 0
  rw [truncated_taylor_coefficient_mk p e j hj]
  simp [coeff_C, hpos.ne']

theorem truncated_hasse_parameter (b : PowerPBasis L p) (e j : ℕ)
    (hj : j < p ^ e) :
    truncatedHasseDerivative b e j b.parameter = (X + C b.parameter : L[X]).coeff j := by
  change truncatedTaylorCoefficient L p e j (truncatedFieldTaylorMap b e b.parameter) = _
  rw [truncatedFieldTaylorMap_parameter]
  change truncatedTaylorCoefficient L p e j
    (AdjoinRoot.mk (X ^ (p ^ e)) (C b.parameter) +
      AdjoinRoot.mk (X ^ (p ^ e)) X) = _
  rw [← map_add, truncated_taylor_coefficient_mk p e j hj, add_comm]

theorem truncated_hasse_first_product (b : PowerPBasis L p) (e : ℕ) (he : 0 < e)
    (a c : L) :
    truncatedHasseDerivative b e 1 (a * c) =
      a * truncatedHasseDerivative b e 1 c + c * truncatedHasseDerivative b e 1 a := by
  have hlt : 1 < p ^ e := (Nat.one_lt_pow_iff he.ne').mpr (Fact.out : p.Prime).one_lt
  rw [truncated_hasse_product b e 1 hlt]
  simp [Finset.Nat.antidiagonal_succ, truncated_hasse_zero, mul_comm]

/-- The first literal Taylor coefficient is a genuine derivation over
the actual p^e-th-power subfield. -/
noncomputable def truncatedHasseFirstDerivation (b : PowerPBasis L p) (e : ℕ) (he : 0 < e) :
    Derivation (iteratedFrobeniusSubfield L p e) L L where
  toLinearMap := {
    toFun := truncatedHasseDerivative b e 1
    map_add' := (truncatedHasseDerivative b e 1).map_add
    map_smul' := fun c a => by
      change truncatedHasseDerivative b e 1 (c.val * a) = c.val * _
      rw [truncated_hasse_first_product b e he]
      have hlt : 1 < p ^ e := (Nat.one_lt_pow_iff he.ne').mpr (Fact.out : p.Prime).one_lt
      rw [truncated_hasse_constants b e 1 hlt (by decide) c, mul_zero, add_zero] }
  leibniz' := fun a c => truncated_hasse_first_product b e he a c
  map_one_eq_zero' := by
    change truncatedHasseDerivative b e 1 (1 : L) = 0
    have hlt : 1 < p ^ e := (Nat.one_lt_pow_iff he.ne').mpr (Fact.out : p.Prime).one_lt
    exact truncated_hasse_constants b e 1 hlt (by decide) 1

theorem truncated_hasse_first_parameter (b : PowerPBasis L p) (e : ℕ) (he : 0 < e) :
    truncatedHasseFirstDerivation b e he b.parameter = 1 := by
  change truncatedHasseDerivative b e 1 b.parameter = 1
  have hlt : 1 < p ^ e := (Nat.one_lt_pow_iff he.ne').mpr (Fact.out : p.Prime).one_lt
  rw [truncated_hasse_parameter b e 1 hlt]
  simp

/-- Every actual derivation normalized at the same p-basis parameter
agrees with the first genuine Taylor coefficient. Its constant ring can
be arbitrary. -/
theorem truncated_hasse_first_eq_normalized_derivation
    {k : Type*} [CommRing k] [Algebra k L]
    (b : PowerPBasis L p) (e : ℕ) (he : 0 < e)
    (D : Derivation k L L) (ht : D b.parameter = 1) (a : L) :
    truncatedHasseDerivative b e 1 a = D a := by
  change truncatedHasseFirstDerivation b e he a = D a
  rw [derivation_p_basis_expansion b (truncatedHasseFirstDerivation b e he)
    (truncated_hasse_first_parameter b e he) a, derivation_p_basis_expansion b D ht a]

end Litt3.CartierAndSpin

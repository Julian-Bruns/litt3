import Solutions.SharedTensors.FrobeniusCoordinates
import Mathlib.RingTheory.Derivation.Basic

namespace Litt3.SharedTensors

open Module

variable {k K : Type*} [CommRing k] [Field K] [Algebra k K]
variable {p : ℕ} [Fact p.Prime] [CharP K p]

/-- The actual Cartier coefficient extraction as an additive map. -/
noncomputable def rationalCartierCoefficientAddHom (b : PowerPBasis K p) : K →+ K where
  toFun := rationalCartierCoefficient K p b
  map_zero' := pRootCoefficient_zero b _
  map_add' := rationalCartierCoefficient_add b

@[simp] theorem pRootCoefficient_parameter_power
    (b : PowerPBasis K p) (i j : Fin p) :
    pRootCoefficient K p b (b.parameter ^ j.val) i = if j = i then 1 else 0 := by
  rw [← b.basis_eq_power j]
  simp only [pRootCoefficient, Basis.repr_self, Finsupp.single_apply]
  split_ifs <;> simp

theorem rationalCartierCoefficient_parameter_power
    (b : PowerPBasis K p) (n : ℕ) (hn : n < p) :
    rationalCartierCoefficient K p b (b.parameter ^ n) =
      if n = p - 1 then 1 else 0 := by
  simpa only [rationalCartierCoefficient, Fin.mk.injEq]
    using pRootCoefficient_parameter_power b
      ⟨p - 1, Nat.sub_lt (Fact.out : p.Prime).pos (by decide)⟩ ⟨n, hn⟩

/-- The full derivative is computed from the actual p-basis expansion. -/
theorem derivation_p_basis_expansion
    (b : PowerPBasis K p) (D : Derivation k K K) (ht : D b.parameter = 1) (a : K) :
    D a = ∑ i : Fin p,
      pRootCoefficient K p b a i ^ p * (i.val : K) * b.parameter ^ (i.val - 1) := by
  conv_lhs => rw [← p_basis_actual_expansion b a]
  rw [map_sum]
  apply Finset.sum_congr rfl
  intro i _
  simp only [D.leibniz, D.leibniz_pow, ht,
    nsmul_eq_mul, smul_eq_mul, CharP.cast_eq_zero, zero_mul, mul_one]
  ring

/-- Rational Cartier kills every actual exact differential, in every
prime characteristic, using the full field expansion. -/
theorem rationalCartierCoefficient_exact
    (b : PowerPBasis K p) (D : Derivation k K K) (ht : D b.parameter = 1) (a : K) :
    rationalCartierCoefficient K p b (D a) = 0 := by
  rw [derivation_p_basis_expansion b D ht a]
  change rationalCartierCoefficientAddHom b _ = 0
  rw [map_sum]
  apply Finset.sum_eq_zero
  intro i _
  change rationalCartierCoefficient K p b
    (pRootCoefficient K p b a i ^ p * (i.val : K) * b.parameter ^ (i.val - 1)) = 0
  have hcast : (i.val : K) ^ p = (i.val : K) := by
    change frobenius K p (i.val : K) = (i.val : K)
    simp only [map_natCast]
  rw [mul_assoc, rationalCartierCoefficient_pth_mul b]
  rw [← hcast, rationalCartierCoefficient_pth_mul b]
  have hp : 2 ≤ p := (Fact.out : p.Prime).two_le
  have hi : i.val - 1 < p := by omega
  have hne : i.val - 1 ≠ p - 1 := by omega
  rw [rationalCartierCoefficient_parameter_power b _ hi, if_neg hne, mul_zero, mul_zero]

end Litt3.SharedTensors

import Solutions.Deformations.CyclicPowerNorm
import Solutions.Deformations.LogCarryFive

namespace Litt3.Deformations

theorem coefficient_scalar_quotient_scalar_vanish {R K : Type*}
    [CommRing R] [AddCommGroup K] [Module R K] (r : R)
    (v : K ⧸ coefficientScalarRange (K := K) r) : r • v = 0 := by
  induction v using Submodule.Quotient.induction_on with
  | _ x =>
    change r • (coefficientScalarRange (K := K) r).mkQ x = 0
    rw [← map_smul]
    exact (Submodule.Quotient.mk_eq_zero _).mpr ⟨x, rfl⟩

theorem original_log_carry_five_two (a : ℕ) (K : Type*)
    [AddCommGroup K] [Module (CyclicPowerBase 5 a) K]
    (C : K ⧸ coefficientScalarRange (K := K) (5 : CyclicPowerBase 5 a))
    (D : Fin 2 → K ⧸ coefficientScalarRange (K := K) (5 : CyclicPowerBase 5 a)) :
    -truncatedLogValue (R := CyclicPowerBase 5 a) 2
      (finiteCoefficientShift (R := CyclicPowerBase 5 a) 2)
      ((Fin.cons C 0 : Fin 2 → K ⧸ coefficientScalarRange (K := K) (5 : CyclicPowerBase 5 a)) +
        finiteCoefficientShift (R := CyclicPowerBase 5 a) 2 D) =
      Fin.cons (-C) (fun _ : Fin 1 => -((2 : CyclicPowerBase 5 a) • C + D 0)) := by
  have twoUnit : IsUnit (2 : CyclicPowerBase 5 a) :=
    (ZMod.isUnit_iff_coprime 2 (5 ^ (a + 1))).mpr ((by decide : Nat.Coprime 2 5).pow_right _)
  exact truncated_log_carry_five_two twoUnit (coefficient_scalar_quotient_scalar_vanish _) C D

set_option maxRecDepth 4096 in
/-- The literal p=5,h=2 source carry, on the original polynomial
module and with the actual coefficient quotient. -/
theorem cyclic_power_norm_five_carry (a : ℕ) [Fact (Nat.Prime 5)]
    (K : Type*) [AddCommGroup K] [Module (CyclicPowerBase 5 a) K]
    [Module.Free (CyclicPowerBase 5 a) K] (aPositive : 0 < a)
    (input : CyclicPowerNormInput 5 a 1 K) (eta : K)
    (C : K ⧸ coefficientScalarRange (K := K) (5 : CyclicPowerBase 5 a))
    (D : Fin 2 → K ⧸ coefficientScalarRange (K := K) (5 : CyclicPowerBase 5 a))
    (y r : PolynomialCyclicModule (R := CyclicPowerBase 5 a) (K := K) 5 a)
    (equation : input.comparison y - cyclicPowerNormTarget 5 a eta =
      (5 : CyclicPowerBase 5 a) ^ a • r)
    (etaReduction : (coefficientScalarRange (K := K) (5 : CyclicPowerBase 5 a)).mkQ eta = C)
    (pattern : coefficientSeriesPrefixSection (R := CyclicPowerBase 5 a) (5 ^ a)
      (cyclicPowerReduction 5 a y) =
      coefficientSeriesShift (R := CyclicPowerBase 5 a) (5 ^ a - 2 - 1)
        (coefficientSeriesConstant (R := CyclicPowerBase 5 a) C) +
      coefficientSeriesShift (R := CyclicPowerBase 5 a) (5 ^ a - 2)
        (coefficientSeriesPrefixSection (R := CyclicPowerBase 5 a) 2 D)) :
    coefficientSeriesPrefix (R := CyclicPowerBase 5 a) 2
      (coefficientSeriesPrefixSection (R := CyclicPowerBase 5 a) (5 ^ a) (cyclicPowerReduction 5 a r)) =
      Fin.cons (-C) (fun _ : Fin 1 => -((2 : CyclicPowerBase 5 a) • C + D 0)) := by
  have carry := (cyclic_power_norm 5 a 1 K aPositive (by decide) input).carry
    eta C D y r equation etaReduction pattern
  exact carry.trans (original_log_carry_five_two a K C D)

theorem cyclic_power_comparison_phi_original {p a n : ℕ} [Fact p.Prime]
    {K : Type*} [AddCommGroup K] [Module (CyclicPowerBase p a) K]
    (input : CyclicPowerNormInput p a n K)
    (x : PolynomialCyclicModule (R := CyclicPowerBase p a) (K := K) p a) :
    input.comparison (polynomialCyclicCoefficientEquiv p a input.Phi x) = input.L x := by
  simp [CyclicPowerNormInput.comparison, mixed_additive_comparison_apply]

end Litt3.Deformations

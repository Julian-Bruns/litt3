import Solutions.Deformations.PolynomialMixedPrimitiveFiber
import Solutions.Deformations.PolynomialFiniteCoordinates

namespace Litt3.Deformations

abbrev CyclicPowerBase (p a : ℕ) := ZMod (p ^ (a + 1))

variable (p a n : ℕ) [Fact p.Prime] (K : Type*)
    [AddCommGroup K] [Module (CyclicPowerBase p a) K]

/-- Exactly the original mixed-additive operator input. The full
polynomial quotient and coefficientwise automorphism are literal. -/
structure CyclicPowerNormInput where
  Phi : K ≃ₗ[CyclicPowerBase p a] K
  L : PolynomialCyclicModule (R := CyclicPowerBase p a) (K := K) p a →+
    PolynomialCyclicModule (R := CyclicPowerBase p a) (K := K) p a
  commute : ∀ v, L (polynomialCyclicAugmentation (R := CyclicPowerBase p a) (K := K) p a v) =
    polynomialCyclicAugmentation (R := CyclicPowerBase p a) (K := K) p a (L v)
  divisible : LinearMap.range (additiveZModOperator (p ^ (a + 1)) L -
      (polynomialCyclicAugmentation (R := CyclicPowerBase p a) (K := K) p a ^ (n + 1)).comp
        (polynomialCyclicCoefficientEquiv p a Phi).toLinearMap) ≤
    LinearMap.range ((p : CyclicPowerBase p a) •
      (LinearMap.id : Module.End (CyclicPowerBase p a)
        (PolynomialCyclicModule (R := CyclicPowerBase p a) (K := K) p a)))

variable {p a n K}

noncomputable def CyclicPowerNormInput.comparison (input : CyclicPowerNormInput p a n K) :
    Module.End (CyclicPowerBase p a) (PolynomialCyclicModule (R := CyclicPowerBase p a) (K := K) p a) :=
  mixedAdditiveComparison (p ^ (a + 1)) input.L (polynomialCyclicCoefficientEquiv p a input.Phi)

noncomputable def cyclicPowerNormTarget (p a : ℕ) [Fact p.Prime] {K : Type*}
    [AddCommGroup K] [Module (CyclicPowerBase p a) K] (eta : K) :
    PolynomialCyclicModule (R := CyclicPowerBase p a) (K := K) p a :=
  (LinearMap.range (polynomialCyclicOperator (R := CyclicPowerBase p a) (K := K) p a)).mkQ
    (polynomialCyclicNormOperator (R := CyclicPowerBase p a) (K := K) p a
      (PolynomialModule.lsingle (CyclicPowerBase p a) 0 eta))

theorem cyclic_power_base_top_vanish (p a : ℕ) : (p : CyclicPowerBase p a) ^ (a + 1) = 0 := by
  rw [← Nat.cast_pow]
  exact ZMod.natCast_self _

noncomputable def cyclicPowerReduction (p a : ℕ) [Fact p.Prime] {K : Type*}
    [AddCommGroup K] [Module (CyclicPowerBase p a) K] :
    PolynomialCyclicModule (R := CyclicPowerBase p a) (K := K) p a →ₗ[CyclicPowerBase p a]
      (Fin (p ^ a) → K ⧸ coefficientScalarRange (K := K) (p : CyclicPowerBase p a)) :=
  polynomialCyclicCoefficientReduction (K := K) p a (cyclic_power_base_top_vanish p a)

end Litt3.Deformations

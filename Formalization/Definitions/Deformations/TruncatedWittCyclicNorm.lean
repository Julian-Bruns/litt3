import Definitions.Deformations.CyclicPowerNormInput
import Solutions.Deformations.TruncatedWittMaps

namespace Litt3.Deformations

abbrev WittCyclicCoefficients (p a : ℕ) (k : Type*) :=
  TruncatedWittVector p (a + 1) k

variable (p a n : ℕ) [Fact p.Prime] (k : Type*)
  [Field k] [CharP k p] [PerfectRing k p]

/-- Exactly a merely additive original cyclic quotient operator over
actual truncated Witt coefficients, with actual Witt Frobenius in its
mod-prime leading term. No Witt-semilinearity is imposed. -/
structure TruncatedWittCyclicNormOperator where
  L : PolynomialCyclicModule (R := CyclicPowerBase p a) (K := WittCyclicCoefficients p a k) p a →+
    PolynomialCyclicModule (R := CyclicPowerBase p a) (K := WittCyclicCoefficients p a k) p a
  commute : ∀ v, L (polynomialCyclicAugmentation
      (R := CyclicPowerBase p a) (K := WittCyclicCoefficients p a k) p a v) =
    polynomialCyclicAugmentation
      (R := CyclicPowerBase p a) (K := WittCyclicCoefficients p a k) p a (L v)
  divisible : LinearMap.range (additiveZModOperator (p ^ (a + 1)) L -
      (polynomialCyclicAugmentation
        (R := CyclicPowerBase p a) (K := WittCyclicCoefficients p a k) p a ^ (n + 1)).comp
        (polynomialCyclicCoefficientEquiv p a
          (truncatedWittFrobeniusLinear p (a + 1) k)).toLinearMap) ≤
    LinearMap.range ((p : CyclicPowerBase p a) •
      (LinearMap.id : Module.End (CyclicPowerBase p a)
        (PolynomialCyclicModule (R := CyclicPowerBase p a) (K := WittCyclicCoefficients p a k) p a)))

/-- The source operator maps literally to the abstract theorem's input;
its coefficient automorphism is the constructed actual Witt Frobenius. -/
noncomputable def TruncatedWittCyclicNormOperator.toInput
    (operator : TruncatedWittCyclicNormOperator p a n k) :
    CyclicPowerNormInput p a n (WittCyclicCoefficients p a k) where
  Phi := truncatedWittFrobeniusLinear p (a + 1) k
  L := operator.L
  commute := operator.commute
  divisible := operator.divisible

end Litt3.Deformations

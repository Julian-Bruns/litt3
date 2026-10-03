import Theorems.Deformations.CyclicPowerNorm
import Solutions.Deformations.PolynomialMixedNormSolvability
import Solutions.Deformations.PolynomialFullSmith
import Solutions.Deformations.PolynomialTerminalCarry

namespace Litt3.Deformations

set_option maxRecDepth 4096 in
/-- Whole exact abstract cyclic-power norm theorem. Every algebraic
bridge, arbitrary free rank argument and finite Smith existence is
proved; the input contains only the source operator hypotheses. -/
theorem cyclic_power_norm (p a n : ℕ) [Fact p.Prime]
    (K : Type*) [AddCommGroup K] [Module (CyclicPowerBase p a) K]
    [Module.Free (CyclicPowerBase p a) K]
    (aPositive : 0 < a) (characteristic : 2 * (n + 1) < p)
    (input : CyclicPowerNormInput p a n K) : CyclicPowerNormResult input := by
  have pBound : p ≤ p ^ a := le_self_pow (by omega) (Nat.ne_of_gt aPositive)
  have bound : n + 1 ≤ p ^ a := (by omega : n + 1 ≤ p).trans pBound
  have comparisonCommute : Commute input.comparison
      (polynomialCyclicAugmentation (R := CyclicPowerBase p a) (K := K) p a) :=
    mixed_additive_comparison_commute (p ^ (a + 1)) input.L
      (polynomialCyclicCoefficientEquiv p a input.Phi) _ input.commute
      (polynomial_cyclic_coefficient_equiv_commute p a input.Phi)
  have comparisonDivisible : LinearMap.range (input.comparison -
      polynomialCyclicAugmentation (R := CyclicPowerBase p a) (K := K) p a ^ (n + 1)) ≤
      LinearMap.range ((p : CyclicPowerBase p a) •
        (LinearMap.id : Module.End (CyclicPowerBase p a)
          (PolynomialCyclicModule (R := CyclicPowerBase p a) (K := K) p a))) :=
    mixed_additive_comparison_scalar_range (p ^ (a + 1)) input.L
      (polynomialCyclicCoefficientEquiv p a input.Phi) _ (n + 1) _ input.divisible
  refine ⟨?_, ?_, ?_, ?_, ?_⟩
  · intro eta
    exact polynomial_mixed_norm_solvable p a n K characteristic bound input.Phi input.L
      input.commute input.divisible eta
  · intro eta v
    exact polynomial_mixed_primitive_fiber p a n K characteristic bound
      (cyclic_power_base_top_vanish p a) input.Phi input.L input.commute input.divisible eta v
  · exact polynomial_commuting_cyclic_cokernel p a n (cyclic_power_base_top_vanish p a)
      characteristic bound input.comparison comparisonCommute comparisonDivisible
  · intro f basis
    exact polynomial_full_smith p a n f K aPositive characteristic
      (cyclic_power_base_top_vanish p a) basis input.comparison comparisonCommute comparisonDivisible
  · intro eta C D y r equation reduction pattern
    exact polynomial_terminal_carry p a n K aPositive characteristic
      (cyclic_power_base_top_vanish p a) input.comparison comparisonCommute comparisonDivisible
      eta C D y r equation reduction pattern

end Litt3.Deformations

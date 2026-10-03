import Solutions.Deformations.PolynomialCoefficientEquivalences
import Solutions.Deformations.PolynomialCommutingCokernel

namespace Litt3.Deformations

/-- Literal original mixed-additive cyclic norm solvability, at every
free coefficient rank. The only coefficient automorphism is the actual
given integer-quotient linear automorphism; L is assumed merely additive. -/
theorem polynomial_mixed_norm_solvable (p a n : ℕ) [Fact p.Prime]
    (K : Type*) [AddCommGroup K] [Module (ZMod (p ^ (a + 1))) K]
    [Module.Free (ZMod (p ^ (a + 1))) K]
    (characteristic : 2 * (n + 1) < p) (bound : n + 1 ≤ p ^ a)
    (Phi : K ≃ₗ[ZMod (p ^ (a + 1))] K)
    (L : PolynomialCyclicModule (R := ZMod (p ^ (a + 1))) (K := K) p a →+
      PolynomialCyclicModule (R := ZMod (p ^ (a + 1))) (K := K) p a)
    (commute : ∀ v, L (polynomialCyclicAugmentation (R := ZMod (p ^ (a + 1))) (K := K) p a v) =
      polynomialCyclicAugmentation (R := ZMod (p ^ (a + 1))) (K := K) p a (L v))
    (divisible : LinearMap.range (additiveZModOperator (p ^ (a + 1)) L -
      (polynomialCyclicAugmentation (R := ZMod (p ^ (a + 1))) (K := K) p a ^ (n + 1)).comp
        (polynomialCyclicCoefficientEquiv p a Phi).toLinearMap) ≤
      LinearMap.range ((p : ZMod (p ^ (a + 1))) •
        (LinearMap.id : Module.End (ZMod (p ^ (a + 1)))
          (PolynomialCyclicModule (R := ZMod (p ^ (a + 1))) (K := K) p a)))) (eta : K) :
    (∃ v, L v = (LinearMap.range
      (polynomialCyclicOperator (R := ZMod (p ^ (a + 1))) (K := K) p a)).mkQ
        (polynomialCyclicNormOperator (R := ZMod (p ^ (a + 1))) (K := K) p a
          (PolynomialModule.lsingle (ZMod (p ^ (a + 1))) 0 eta))) ↔
      eta ∈ coefficientScalarRange (K := K) (p : ZMod (p ^ (a + 1))) := by
  rw [mixed_additive_solution_bijection (p ^ (a + 1)) L (polynomialCyclicCoefficientEquiv p a Phi)]
  exact polynomial_commuting_norm_solvable_free_zmod p a n K characteristic bound _
    (mixed_additive_comparison_commute (p ^ (a + 1)) L (polynomialCyclicCoefficientEquiv p a Phi) _
      commute (polynomial_cyclic_coefficient_equiv_commute p a Phi))
    (mixed_additive_comparison_scalar_range (p ^ (a + 1)) L
      (polynomialCyclicCoefficientEquiv p a Phi) _ (n + 1) _ divisible) eta

end Litt3.Deformations

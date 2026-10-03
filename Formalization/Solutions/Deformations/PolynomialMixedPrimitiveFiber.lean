import Solutions.Deformations.PolynomialPrimitiveFiber
import Solutions.Deformations.PolynomialCoefficientReductionEquiv
import Solutions.Deformations.MixedSolutionReduction

namespace Litt3.Deformations

set_option maxRecDepth 2048 in
/-- The exact full original mixed-additive norm solution image mod p,
including arbitrary free rank and every actual socle coefficient.
The literal original coefficient automorphism and additive L are retained. -/
theorem polynomial_mixed_primitive_fiber (p a n : ℕ) [Fact p.Prime]
    (K : Type*) [AddCommGroup K] [Module (ZMod (p ^ (a + 1))) K]
    [Module.Free (ZMod (p ^ (a + 1))) K]
    (characteristic : 2 * (n + 1) < p) (bound : n + 1 ≤ p ^ a)
    (vanish : (p : ZMod (p ^ (a + 1))) ^ (a + 1) = 0)
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
          (PolynomialCyclicModule (R := ZMod (p ^ (a + 1))) (K := K) p a)))) (eta : K)
    (v : Fin (p ^ a) → K ⧸ coefficientScalarRange (K := K) (p : ZMod (p ^ (a + 1)))) :
    (∃ y, L y = (LinearMap.range
      (polynomialCyclicOperator (R := ZMod (p ^ (a + 1))) (K := K) p a)).mkQ
        (polynomialCyclicNormOperator (R := ZMod (p ^ (a + 1))) (K := K) p a
          (PolynomialModule.lsingle (ZMod (p ^ (a + 1))) 0 eta)) ∧
      polynomialCyclicCoefficientReduction (K := K) p a vanish y = v) ↔
      eta ∈ coefficientScalarRange (K := K) (p : ZMod (p ^ (a + 1))) ∧
        ∃ theta, v = finiteSocleCoefficient (R := ZMod (p ^ (a + 1))) (p ^ a) theta := by
  let R := ZMod (p ^ (a + 1))
  let PhiM := polynomialCyclicCoefficientEquiv p a Phi
  let PhiV := finiteCoefficientEquiv (p ^ a) (scalarCoefficientEquiv (p : R) Phi)
  let red := polynomialCyclicCoefficientReduction (K := K) p a vanish
  let target := (LinearMap.range (polynomialCyclicOperator (R := R) (K := K) p a)).mkQ
    (polynomialCyclicNormOperator (R := R) (K := K) p a (PolynomialModule.lsingle R 0 eta))
  rw [mixed_additive_solution_reduction_bijection (p ^ (a + 1)) L PhiM PhiV red
    (polynomial_cyclic_coefficient_reduction_equiv p a vanish Phi) target v]
  rw [polynomial_primitive_fiber p a n K characteristic bound vanish _
    (mixed_additive_comparison_commute (p ^ (a + 1)) L PhiM _ commute
      (polynomial_cyclic_coefficient_equiv_commute p a Phi))
    (mixed_additive_comparison_scalar_range (p ^ (a + 1)) L PhiM _ (n + 1) _ divisible)]
  exact and_congr_right (fun _ => finite_coefficient_equiv_socle_iff (p ^ a)
    (scalarCoefficientEquiv (p : R) Phi) v)

end Litt3.Deformations

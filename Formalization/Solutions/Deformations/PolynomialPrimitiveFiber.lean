import Solutions.Deformations.FormalCommutingPrimitiveFiber
import Solutions.Deformations.PolynomialCommutingNormSolvability

namespace Litt3.Deformations

set_option maxRecDepth 2048 in
/-- Exact primitive reduction image on the literal original polynomial
cyclic module, for every actual commuting comparison. All quotient,
completion and coefficient-lift bridges are proved. -/
theorem polynomial_primitive_fiber (p a n : ℕ) [Fact p.Prime]
    (K : Type*) [AddCommGroup K] [Module (ZMod (p ^ (a + 1))) K]
    [Module.Free (ZMod (p ^ (a + 1))) K]
    (characteristic : 2 * (n + 1) < p) (bound : n + 1 ≤ p ^ a)
    (vanish : (p : ZMod (p ^ (a + 1))) ^ (a + 1) = 0)
    (A : Module.End (ZMod (p ^ (a + 1)))
      (PolynomialCyclicModule (R := ZMod (p ^ (a + 1))) (K := K) p a))
    (commute : Commute A (polynomialCyclicAugmentation (R := ZMod (p ^ (a + 1))) (K := K) p a))
    (divisible : LinearMap.range (A - polynomialCyclicAugmentation (R := ZMod (p ^ (a + 1))) (K := K) p a ^ (n + 1)) ≤
      LinearMap.range ((p : ZMod (p ^ (a + 1))) •
        (LinearMap.id : Module.End (ZMod (p ^ (a + 1)))
          (PolynomialCyclicModule (R := ZMod (p ^ (a + 1))) (K := K) p a)))) (eta : K)
    (v : Fin (p ^ a) → K ⧸ coefficientScalarRange (K := K) (p : ZMod (p ^ (a + 1)))) :
    (∃ y, A y = (LinearMap.range (polynomialCyclicOperator (R := ZMod (p ^ (a + 1))) (K := K) p a)).mkQ
      (polynomialCyclicNormOperator (R := ZMod (p ^ (a + 1))) (K := K) p a
        (PolynomialModule.lsingle (ZMod (p ^ (a + 1))) 0 eta)) ∧
      polynomialCyclicCoefficientReduction (K := K) p a vanish y = v) ↔
      eta ∈ coefficientScalarRange (K := K) (p : ZMod (p ^ (a + 1))) ∧
        ∃ theta, v = finiteSocleCoefficient (R := ZMod (p ^ (a + 1))) (p ^ a) theta := by
  let R := ZMod (p ^ (a + 1))
  let e := polynomialCyclicCompletionEquiv (R := R) (K := K) p a vanish
  let B := e.conj A
  let target := (LinearMap.range (polynomialCyclicOperator (R := R) (K := K) p a)).mkQ
    (polynomialCyclicNormOperator (R := R) (K := K) p a (PolynomialModule.lsingle R 0 eta))
  let formalTarget := (LinearMap.range (formalCyclicRelation (R := R) (K := K) p a)).mkQ
    (formalCyclicNorm (R := R) p a (coefficientSeriesConstant (R := R) eta))
  have targetEquality : e target = formalTarget := polynomial_cyclic_completion_norm_constant p a vanish eta
  have augmentation := polynomial_cyclic_completion_conjugate_augmentation (K := K) p a vanish
  have Bcommute : Commute B (formalCyclicAugmentation (R := R) (K := K) p a) := by
    rw [← augmentation]
    exact linear_equiv_conjugate_commute e A _ commute
  have Bdivisible : LinearMap.range (B - formalCyclicAugmentation (R := R) (K := K) p a ^ (n + 1)) ≤
      LinearMap.range ((p : R) • (LinearMap.id : Module.End R
        (FormalCyclicModule (R := R) (K := K) p a))) := by
    have transported := linear_equiv_conjugate_scalar_range e _ (p : R) divisible
    rw [map_sub, linear_equiv_conjugate_pow, augmentation] at transported
    exact transported
  have transport : (∃ y, A y = target ∧ polynomialCyclicCoefficientReduction (K := K) p a vanish y = v) ↔
      ∃ y, B y = formalTarget ∧ formalCyclicCoefficientReduction (K := K) p a vanish y = v := by
    constructor
    · rintro ⟨y, equation, reduction⟩
      refine ⟨e y, ?_, reduction⟩
      change e (A (e.symm (e y))) = formalTarget
      rw [LinearEquiv.symm_apply_apply, equation, targetEquality]
    · rintro ⟨y, equation, reduction⟩
      refine ⟨e.symm y, e.injective ?_, ?_⟩
      · change B y = e target
        rw [targetEquality]
        exact equation
      · change formalCyclicCoefficientReduction (K := K) p a vanish (e (e.symm y)) = v
        rw [LinearEquiv.apply_symm_apply]
        exact reduction
  rw [transport]
  exact formal_commuting_primitive_fiber p a n K characteristic bound vanish B Bcommute Bdivisible eta v

end Litt3.Deformations

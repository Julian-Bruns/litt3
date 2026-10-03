import Solutions.Deformations.FormalPreparedTerminalCarry
import Solutions.Deformations.PolynomialCommutingNormSolvability

namespace Litt3.Deformations

set_option maxRecDepth 4096 in
/-- The exact source terminal carry on the literal original polynomial
module and actual comparison operator. Every representative, completion,
coefficient lift and full relation witness is derived. -/
theorem polynomial_terminal_carry (p a n : ℕ) [Fact p.Prime]
    (K : Type*) [AddCommGroup K] [Module (ZMod (p ^ (a + 1))) K]
    [Module.Free (ZMod (p ^ (a + 1))) K]
    (aPositive : 0 < a) (characteristic : 2 * (n + 1) < p)
    (vanish : (p : ZMod (p ^ (a + 1))) ^ (a + 1) = 0)
    (A : Module.End (ZMod (p ^ (a + 1)))
      (PolynomialCyclicModule (R := ZMod (p ^ (a + 1))) (K := K) p a))
    (commute : Commute A (polynomialCyclicAugmentation (R := ZMod (p ^ (a + 1))) (K := K) p a))
    (divisible : LinearMap.range (A - polynomialCyclicAugmentation (R := ZMod (p ^ (a + 1))) (K := K) p a ^ (n + 1)) ≤
      LinearMap.range ((p : ZMod (p ^ (a + 1))) •
        (LinearMap.id : Module.End (ZMod (p ^ (a + 1)))
          (PolynomialCyclicModule (R := ZMod (p ^ (a + 1))) (K := K) p a)))) (eta : K)
    (constant : K ⧸ coefficientScalarRange (K := K) (p : ZMod (p ^ (a + 1))))
    (D : Fin (n + 1) → K ⧸ coefficientScalarRange (K := K) (p : ZMod (p ^ (a + 1))))
    (y r : PolynomialCyclicModule (R := ZMod (p ^ (a + 1))) (K := K) p a)
    (equation : A y - (LinearMap.range
      (polynomialCyclicOperator (R := ZMod (p ^ (a + 1))) (K := K) p a)).mkQ
        (polynomialCyclicNormOperator (R := ZMod (p ^ (a + 1))) (K := K) p a
          (PolynomialModule.lsingle (ZMod (p ^ (a + 1))) 0 eta)) =
      (p : ZMod (p ^ (a + 1))) ^ a • r)
    (etaReduction : (coefficientScalarRange (K := K) (p : ZMod (p ^ (a + 1)))).mkQ eta = constant)
    (pattern : coefficientSeriesPrefixSection (R := ZMod (p ^ (a + 1))) (p ^ a)
      (polynomialCyclicCoefficientReduction (K := K) p a vanish y) =
      coefficientSeriesShift (R := ZMod (p ^ (a + 1))) (p ^ a - (n + 1) - 1)
        (coefficientSeriesConstant (R := ZMod (p ^ (a + 1))) constant) +
      coefficientSeriesShift (R := ZMod (p ^ (a + 1))) (p ^ a - (n + 1))
        (coefficientSeriesPrefixSection (R := ZMod (p ^ (a + 1))) (n + 1) D)) :
    coefficientSeriesPrefix (R := ZMod (p ^ (a + 1))) (n + 1)
      (coefficientSeriesPrefixSection (R := ZMod (p ^ (a + 1))) (p ^ a)
        (polynomialCyclicCoefficientReduction (K := K) p a vanish r)) =
      -truncatedLogValue (R := ZMod (p ^ (a + 1))) (n + 1)
        (finiteCoefficientShift (R := ZMod (p ^ (a + 1))) (n + 1))
        ((Fin.cons constant 0 : Fin (n + 1) → K ⧸ coefficientScalarRange (K := K)
          (p : ZMod (p ^ (a + 1)))) +
          finiteCoefficientShift (R := ZMod (p ^ (a + 1))) (n + 1) D) := by
  let R := ZMod (p ^ (a + 1))
  let e := polynomialCyclicCompletionEquiv (R := R) (K := K) p a vanish
  let B := e.conj A
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
  obtain ⟨correction, same⟩ := formal_cyclic_operator_polynomial_lift p a (n + 1) vanish B Bcommute
    (by rintro v ⟨eta, rfl⟩
        exact Bdivisible ⟨formalCyclicConstant (R := R) (K := K) p a eta, rfl⟩)
  have formalEquation : B (e y) -
      (LinearMap.range (formalCyclicRelation (R := R) (K := K) p a)).mkQ
        (formalCyclicNorm (R := R) p a (coefficientSeriesConstant (R := R) eta)) =
      (p : R) ^ a • e r := by
    have original := congrArg e equation
    rw [map_sub, map_smul, polynomial_cyclic_completion_norm_constant] at original
    change e (A (e.symm (e y))) - _ = _
    rw [LinearEquiv.symm_apply_apply]
    exact original
  rw [same] at formalEquation
  exact formal_prepared_terminal_carry p a n K aPositive characteristic vanish _
    (coefficient_polynomial_operator_commute_shift (p ^ a) correction 1) eta constant D
    (e y) (e r) formalEquation etaReduction pattern

end Litt3.Deformations

import Solutions.Deformations.PolynomialCommutingNormSolvability
import Solutions.Deformations.LinearEndomorphismRanges

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- The complete actual original polynomial cokernel, with its exact
original norm class, for every commuting comparison operator.
All completion, generation and coefficient-lift bridges are constructed. -/
theorem polynomial_commuting_cyclic_cokernel (p a n : ℕ) [Fact p.Prime]
    [Module.Projective R K] (vanish : (p : R) ^ (a + 1) = 0)
    (characteristic : 2 * (n + 1) < p) (bound : n + 1 ≤ p ^ a)
    (A : Module.End R (PolynomialCyclicModule (R := R) (K := K) p a))
    (commute : Commute A (polynomialCyclicAugmentation (R := R) (K := K) p a))
    (divisible : LinearMap.range (A - polynomialCyclicAugmentation (R := R) (K := K) p a ^ (n + 1)) ≤
      LinearMap.range ((p : R) • (LinearMap.id : Module.End R
        (PolynomialCyclicModule (R := R) (K := K) p a)))) :
    ∃ f : (PolynomialCyclicModule (R := R) (K := K) p a ⧸ LinearMap.range A) ≃ₗ[R]
      (K × (Fin n → K ⧸ coefficientScalarRange (K := K) ((p : R) ^ a))),
      ∀ eta : K, f ((LinearMap.range A).mkQ
        ((LinearMap.range (polynomialCyclicOperator (R := R) (K := K) p a)).mkQ
          (polynomialCyclicNormOperator (R := R) (K := K) p a (PolynomialModule.lsingle R 0 eta)))) =
        ((p : R) ^ a • eta, 0) := by
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
  obtain ⟨f, normClass⟩ := formal_commuting_cyclic_cokernel p a n vanish characteristic bound B Bcommute
    (by rintro v ⟨eta, rfl⟩
        exact Bdivisible ⟨formalCyclicConstant (R := R) (K := K) p a eta, rfl⟩)
  let q := Submodule.Quotient.equiv _ _ e (linear_equiv_map_range_conjugate e A)
  refine ⟨q.trans f, ?_⟩
  intro eta
  change f ((LinearMap.range B).mkQ
    (e ((LinearMap.range (polynomialCyclicOperator (R := R) (K := K) p a)).mkQ
      (polynomialCyclicNormOperator (R := R) (K := K) p a (PolynomialModule.lsingle R 0 eta))))) = _
  rw [polynomial_cyclic_completion_norm_constant]
  exact normClass eta

end Litt3.Deformations

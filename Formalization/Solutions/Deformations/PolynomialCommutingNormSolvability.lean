import Solutions.Deformations.PolynomialCyclicGeneration
import Solutions.Deformations.FormalCommutingNormSolvability
import Solutions.Deformations.ConjugateScalarRanges

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

theorem polynomial_cyclic_completion_conjugate_augmentation (p a : ℕ) [Fact p.Prime]
    (vanish : (p : R) ^ (a + 1) = 0) :
    (polynomialCyclicCompletionEquiv (K := K) p a vanish).conj
      (polynomialCyclicAugmentation (R := R) (K := K) p a) =
      formalCyclicAugmentation (R := R) (K := K) p a := by
  apply LinearMap.ext
  intro v
  obtain ⟨w, rfl⟩ := (polynomialCyclicCompletionEquiv (K := K) p a vanish).surjective v
  rw [LinearEquiv.conj_apply_apply, LinearEquiv.symm_apply_apply,
    polynomial_cyclic_completion_augmentation]

/-- The source's literal original polynomial cyclic module and norm
equation, for every commuting comparison operator congruent to e^h,
have the exact top-scalar solvability obstruction. The completion and
finite polynomial lift are both constructed, not supplied hypotheses. -/
theorem polynomial_commuting_norm_solvable_iff (p a n : ℕ) [Fact p.Prime]
    [Module.Projective R K] (vanish : (p : R) ^ (a + 1) = 0)
    (characteristic : 2 * (n + 1) < p) (bound : n + 1 ≤ p ^ a)
    (A : Module.End R (PolynomialCyclicModule (R := R) (K := K) p a))
    (commute : Commute A (polynomialCyclicAugmentation (R := R) (K := K) p a))
    (divisible : LinearMap.range (A - polynomialCyclicAugmentation (R := R) (K := K) p a ^ (n + 1)) ≤
      LinearMap.range ((p : R) • (LinearMap.id : Module.End R
        (PolynomialCyclicModule (R := R) (K := K) p a)))) (eta : K) :
    (∃ v, A v = (LinearMap.range (polynomialCyclicOperator (R := R) (K := K) p a)).mkQ
      (polynomialCyclicNormOperator (R := R) (K := K) p a (PolynomialModule.lsingle R 0 eta))) ↔
      (p : R) ^ a • eta = 0 := by
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
  rw [linear_equiv_conjugate_solvable e, polynomial_cyclic_completion_norm_constant]
  apply formal_commuting_norm_solvable_iff p a n vanish characteristic bound B Bcommute
  rintro v ⟨eta, rfl⟩
  exact Bdivisible ⟨formalCyclicConstant (R := R) (K := K) p a eta, rfl⟩

/-- Exact p-multiple solvability on the original polynomial module
over the literal integer quotient, in every actual free rank. -/
theorem polynomial_commuting_norm_solvable_free_zmod (p a n : ℕ) [Fact p.Prime]
    (K : Type*) [AddCommGroup K] [Module (ZMod (p ^ (a + 1))) K]
    [Module.Free (ZMod (p ^ (a + 1))) K]
    (characteristic : 2 * (n + 1) < p) (bound : n + 1 ≤ p ^ a)
    (A : Module.End (ZMod (p ^ (a + 1)))
      (PolynomialCyclicModule (R := ZMod (p ^ (a + 1))) (K := K) p a))
    (commute : Commute A
      (polynomialCyclicAugmentation (R := ZMod (p ^ (a + 1))) (K := K) p a))
    (divisible : LinearMap.range (A -
      polynomialCyclicAugmentation (R := ZMod (p ^ (a + 1))) (K := K) p a ^ (n + 1)) ≤
      LinearMap.range ((p : ZMod (p ^ (a + 1))) • (LinearMap.id : Module.End (ZMod (p ^ (a + 1)))
        (PolynomialCyclicModule (R := ZMod (p ^ (a + 1))) (K := K) p a)))) (eta : K) :
    (∃ v, A v = (LinearMap.range
      (polynomialCyclicOperator (R := ZMod (p ^ (a + 1))) (K := K) p a)).mkQ
      (polynomialCyclicNormOperator (R := ZMod (p ^ (a + 1))) (K := K) p a
        (PolynomialModule.lsingle (ZMod (p ^ (a + 1))) 0 eta))) ↔
      eta ∈ coefficientScalarRange (K := K) (p : ZMod (p ^ (a + 1))) := by
  have vanish : (p : ZMod (p ^ (a + 1))) ^ (a + 1) = 0 := by
    rw [← Nat.cast_pow]
    exact (ZMod.natCast_eq_zero_iff _ _).mpr dvd_rfl
  rw [polynomial_commuting_norm_solvable_iff p a n vanish characteristic bound A commute divisible]
  change eta ∈ LinearMap.ker
    ((p : ZMod (p ^ (a + 1))) ^ a • (LinearMap.id : K →ₗ[ZMod (p ^ (a + 1))] K)) ↔ _
  rw [free_zmod_last_power_kernel p a (Fact.out : p.Prime).pos K]
  rfl

end Litt3.Deformations

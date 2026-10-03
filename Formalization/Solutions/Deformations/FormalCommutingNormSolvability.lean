import Solutions.Deformations.FormalCyclicOperatorLift
import Solutions.Deformations.FormalCyclicSolvability

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- Exact norm solvability for every original commuting operator,
without supplying its polynomial lift or a Smith form. The lift is
constructed from the original coefficient generators and projectivity. -/
theorem formal_commuting_norm_solvable_iff (p a n : ℕ) [Fact p.Prime]
    [Module.Projective R K] (vanish : (p : R) ^ (a + 1) = 0)
    (characteristic : 2 * (n + 1) < p) (bound : n + 1 ≤ p ^ a)
    (A : Module.End R (FormalCyclicModule (R := R) (K := K) p a))
    (commute : Commute A (formalCyclicAugmentation (R := R) (K := K) p a))
    (divisible : LinearMap.range ((A - formalCyclicAugmentation (R := R) (K := K) p a ^ (n + 1)).comp
      (formalCyclicConstant (R := R) (K := K) p a)) ≤
      LinearMap.range ((p : R) • (LinearMap.id : Module.End R
        (FormalCyclicModule (R := R) (K := K) p a)))) (eta : K) :
    (∃ v, A v = (LinearMap.range (formalCyclicRelation (R := R) (K := K) p a)).mkQ
      (formalCyclicNorm (R := R) p a (coefficientSeriesConstant (R := R) eta))) ↔
      (p : R) ^ a • eta = 0 := by
  obtain ⟨C, rfl⟩ := formal_cyclic_operator_polynomial_lift p a (n + 1) vanish A commute divisible
  exact formal_cyclic_norm_solvable_iff_top_scalar p a n characteristic bound vanish _
    (coefficient_polynomial_operator_commute_shift (p ^ a) C 1) eta

/-- The full original cokernel and original norm class for every
commuting comparison operator are constructed with arbitrary projective
coefficient rank. No conclusion-shaped geometric hypothesis occurs. -/
theorem formal_commuting_cyclic_cokernel (p a n : ℕ) [Fact p.Prime]
    [Module.Projective R K] (vanish : (p : R) ^ (a + 1) = 0)
    (characteristic : 2 * (n + 1) < p) (bound : n + 1 ≤ p ^ a)
    (A : Module.End R (FormalCyclicModule (R := R) (K := K) p a))
    (commute : Commute A (formalCyclicAugmentation (R := R) (K := K) p a))
    (divisible : LinearMap.range ((A - formalCyclicAugmentation (R := R) (K := K) p a ^ (n + 1)).comp
      (formalCyclicConstant (R := R) (K := K) p a)) ≤
      LinearMap.range ((p : R) • (LinearMap.id : Module.End R
        (FormalCyclicModule (R := R) (K := K) p a)))) :
    ∃ e : (FormalCyclicModule (R := R) (K := K) p a ⧸ LinearMap.range A) ≃ₗ[R]
      (K × (Fin n → K ⧸ coefficientScalarRange (K := K) ((p : R) ^ a))),
      ∀ eta : K, e ((LinearMap.range A).mkQ
        ((LinearMap.range (formalCyclicRelation (R := R) (K := K) p a)).mkQ
          (formalCyclicNorm (R := R) p a (coefficientSeriesConstant (R := R) eta)))) =
        ((p : R) ^ a • eta, 0) := by
  obtain ⟨C, rfl⟩ := formal_cyclic_operator_polynomial_lift p a (n + 1) vanish A commute divisible
  exact ⟨formalSeriesCyclicCokernelEquiv p a n characteristic bound vanish _
    (coefficient_polynomial_operator_commute_shift (p ^ a) C 1),
    formal_cyclic_norm_constant_class p a n characteristic bound vanish _
      (coefficient_polynomial_operator_commute_shift (p ^ a) C 1)⟩

end Litt3.Deformations

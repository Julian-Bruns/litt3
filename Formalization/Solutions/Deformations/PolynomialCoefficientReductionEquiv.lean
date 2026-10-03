import Solutions.Deformations.PolynomialCoefficientEquivalences
import Solutions.Deformations.FormalCyclicCoefficientReduction
import Solutions.Deformations.ScalarCoefficientEquivalences

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- Reduction retains the actual given coefficient automorphism,
through the actual scalar quotient on every original coordinate. -/
theorem polynomial_cyclic_coefficient_reduction_equiv (p a : ℕ) [Fact p.Prime]
    (vanish : (p : R) ^ (a + 1) = 0) (Phi : K ≃ₗ[R] K)
    (v : PolynomialCyclicModule (R := R) (K := K) p a) :
    polynomialCyclicCoefficientReduction (K := K) p a vanish
      (polynomialCyclicCoefficientEquiv p a Phi v) =
      finiteCoefficientEquiv (p ^ a) (scalarCoefficientEquiv (p : R) Phi)
        (polynomialCyclicCoefficientReduction (K := K) p a vanish v) := by
  obtain ⟨u, rfl⟩ := (LinearMap.range (polynomialCyclicOperator (R := R) (K := K) p a)).mkQ_surjective v
  funext j
  rw [polynomial_cyclic_coefficient_equiv_mk, polynomial_cyclic_coefficient_reduction_mk]
  change (coefficientScalarRange (K := K) (p : R)).mkQ ((polynomialCoefficientEquiv Phi u) j.val) =
    scalarCoefficientEquiv (p : R) Phi
      (polynomialCyclicCoefficientReduction (K := K) p a vanish
        ((LinearMap.range (polynomialCyclicOperator (R := R) (K := K) p a)).mkQ u) j)
  rw [polynomial_cyclic_coefficient_reduction_mk, scalar_coefficient_equiv_mk]
  rfl

end Litt3.Deformations

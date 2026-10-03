import Solutions.Deformations.ArtinSchreierCarry
import Mathlib.Algebra.MvPolynomial.Degrees
import Mathlib.Algebra.MvPolynomial.Eval

namespace Litt3.Deformations

open scoped BigOperators ArtinSchreierAdic

variable {R : Type*} [CommRing R]

/-- Substitution of an actual polynomial of bounded original degree
starts in the asserted integral carry before any chart operation. -/
theorem artin_schreier_polynomial_degree (p r : ℕ) (a b : Fin r → R)
    (f : MvPolynomial (Fin r) R) (d : ℕ) (degree : f.totalDegree ≤ d) :
    f.eval₂ (algebraMap R (artinSchreierChart R p r a b))
      (artinSchreierChartCoordinate R p r a b) ∈ artinSchreierCarry R p r a b (d : ℤ) := by
  classical
  rw [MvPolynomial.eval₂_eq']
  apply Submodule.sum_mem
  intro alpha support
  change algebraMap R (artinSchreierChart R p r a b) (f.coeff alpha) *
    generatorMonomial (artinSchreierChartCoordinate R p r a b) (fun i => alpha i) ∈ _
  rw [← Algebra.smul_def]
  apply Submodule.smul_mem
  apply (signedGeneratorFiltration R (p : artinSchreierChart R p r a b) (p - 1)
    (artinSchreierChartCoordinate R p r a b) (d : ℤ)).le_topologicalClosure
  have bound : generatorMonomialWeight (fun i => alpha i) ≤ d := by
    have total := (MvPolynomial.le_totalDegree support).trans degree
    rw [Finsupp.sum_fintype _ _ (by simp)] at total
    exact total
  simpa only [pow_zero, one_mul] using signed_generator_member (R := R)
    (p : artinSchreierChart R p r a b) (p - 1)
    (artinSchreierChartCoordinate R p r a b) (d : ℤ) 0 (fun i => alpha i) (by
      simp only [Nat.cast_zero, mul_zero, add_zero]
      exact_mod_cast bound)

/-- Arbitrary finite combinations of actual degree-preserving chart
operations preserve every original degree, including differentiation. -/
theorem artin_schreier_operation_word (p r : ℕ) (a b : Fin r → R)
    (operations : List (artinSchreierChart R p r a b → artinSchreierChart R p r a b))
    (preserves : ∀ operation ∈ operations, ∀ (d : ℤ) x,
      x ∈ artinSchreierCarry R p r a b d → operation x ∈ artinSchreierCarry R p r a b d)
    (d : ℤ) (x : artinSchreierChart R p r a b)
    (member : x ∈ artinSchreierCarry R p r a b d) :
    operations.foldl (fun y operation => operation y) x ∈ artinSchreierCarry R p r a b d := by
  induction operations generalizing x with
  | nil => exact member
  | cons operation rest induction =>
    exact induction (fun operation h => preserves operation (List.mem_cons_of_mem _ h))
      (operation x) (preserves operation (List.mem_cons_self) d x member)

end Litt3.Deformations

import Definitions.Deformations.WeightedGeneratorFiltration
import Mathlib.LinearAlgebra.Span.Basic
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Tactic

namespace Litt3.Deformations

variable {R A I : Type*} [CommRing R] [CommRing A] [Algebra R A] [Fintype I]

theorem generator_monomial_product (e : I → A) (alpha beta : I → ℕ) :
    generatorMonomial e alpha * generatorMonomial e beta =
      generatorMonomial e (fun i => alpha i + beta i) := by
  simp only [generatorMonomial, pow_add, Finset.prod_mul_distrib]

theorem generator_monomial_weight_add (alpha beta : I → ℕ) :
    generatorMonomialWeight (fun i => alpha i + beta i) =
      generatorMonomialWeight alpha + generatorMonomialWeight beta := by
  simp only [generatorMonomialWeight, Finset.sum_add_distrib]

theorem weighted_generator_member (p : A) (primeWeight : ℕ) (e : I → A)
    (d j : ℕ) (alpha : I → ℕ)
    (bound : d ≤ primeWeight * j + generatorMonomialWeight alpha) :
    p ^ j * generatorMonomial e alpha ∈ weightedGeneratorFiltration R p primeWeight e d :=
  Submodule.subset_span ⟨j, alpha, bound, rfl⟩

theorem weighted_generator_filtration_antitone (p : A) (primeWeight : ℕ) (e : I → A) :
    Antitone (weightedGeneratorFiltration R p primeWeight e) := by
  intro d b bound
  apply Submodule.span_mono
  rintro x ⟨j, alpha, weight, rfl⟩
  exact ⟨j, alpha, bound.trans weight, rfl⟩

/-- Multiplicativity follows from literal monomial products and scalar
powers, before any normal-basis or coefficient-ring hypothesis. -/
theorem weighted_generator_filtration_multiplicative (p : A) (primeWeight : ℕ) (e : I → A)
    (d b : ℕ) (x y : A)
    (hx : x ∈ weightedGeneratorFiltration R p primeWeight e d)
    (hy : y ∈ weightedGeneratorFiltration R p primeWeight e b) :
    x * y ∈ weightedGeneratorFiltration R p primeWeight e (d + b) := by
  induction hx using Submodule.span_induction with
  | mem x hx =>
    obtain ⟨j, alpha, xbound, rfl⟩ := hx
    induction hy using Submodule.span_induction with
    | mem y hy =>
      obtain ⟨k, beta, ybound, rfl⟩ := hy
      have product : (p ^ j * generatorMonomial e alpha) * (p ^ k * generatorMonomial e beta) =
          p ^ (j + k) * generatorMonomial e (fun i => alpha i + beta i) := by
        rw [pow_add, ← generator_monomial_product]
        ring
      rw [product]
      apply weighted_generator_member
      rw [generator_monomial_weight_add, Nat.mul_add]
      omega
    | zero => simpa using (weightedGeneratorFiltration R p primeWeight e (d + b)).zero_mem
    | add y z _ _ iy iz => rw [mul_add]; exact Submodule.add_mem _ iy iz
    | smul r y _ induction => rw [mul_smul_comm]; exact Submodule.smul_mem _ r induction
  | zero => simpa using (weightedGeneratorFiltration R p primeWeight e (d + b)).zero_mem
  | add x z _ _ ix iz => rw [add_mul]; exact Submodule.add_mem _ ix iz
  | smul r x _ induction => rw [smul_mul_assoc]; exact Submodule.smul_mem _ r induction

theorem weighted_generator_initial_one (p : A) (primeWeight : ℕ) (e : I → A) :
    1 ∈ weightedGeneratorFiltration R p primeWeight e 0 := by
  simpa [generatorMonomial, generatorMonomialWeight] using
    weighted_generator_member (R := R) p primeWeight e 0 0 (fun _ => 0) (by simp)

/-- The literal scalar prime raises the actual weight by its assigned
weight, uniformly on the full generated submodule. -/
theorem weighted_generator_prime_mul (p : A) (primeWeight : ℕ) (e : I → A)
    (d : ℕ) (x : A) (member : x ∈ weightedGeneratorFiltration R p primeWeight e d) :
    p * x ∈ weightedGeneratorFiltration R p primeWeight e (primeWeight + d) := by
  have prime : p ∈ weightedGeneratorFiltration R p primeWeight e primeWeight := by
    simpa [generatorMonomial, generatorMonomialWeight] using
      weighted_generator_member (R := R) p primeWeight e primeWeight 1 (fun _ => 0) (by simp)
  exact weighted_generator_filtration_multiplicative p primeWeight e primeWeight d p x prime member

end Litt3.Deformations

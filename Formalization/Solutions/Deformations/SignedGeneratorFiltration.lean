import Definitions.Deformations.SignedGeneratorFiltration
import Solutions.Deformations.WeightedGeneratorFiltration

namespace Litt3.Deformations

open scoped BigOperators

variable {R A I : Type*} [CommRing R] [CommRing A] [Algebra R A] [Fintype I]

theorem signed_generator_member (p : A) (w : ℕ) (e : I → A)
    (d : ℤ) (j : ℕ) (alpha : I → ℕ)
    (bound : (generatorMonomialWeight alpha : ℤ) ≤ d + (w : ℤ) * j) :
    p ^ j * generatorMonomial e alpha ∈ signedGeneratorFiltration R p w e d :=
  Submodule.subset_span ⟨j, alpha, bound, rfl⟩

theorem signed_generator_filtration_monotone (p : A) (w : ℕ) (e : I → A) :
    Monotone (signedGeneratorFiltration R p w e) := by
  intro d b bound
  apply Submodule.span_mono
  rintro x ⟨j, alpha, weight, rfl⟩
  exact ⟨j, alpha, by omega, rfl⟩

theorem signed_generator_filtration_multiplicative (p : A) (w : ℕ) (e : I → A)
    (d b : ℤ) (x y : A)
    (hx : x ∈ signedGeneratorFiltration R p w e d)
    (hy : y ∈ signedGeneratorFiltration R p w e b) :
    x * y ∈ signedGeneratorFiltration R p w e (d + b) := by
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
      apply signed_generator_member
      rw [generator_monomial_weight_add, Nat.cast_add, Nat.cast_add, mul_add]
      omega
    | zero => simpa using (signedGeneratorFiltration R p w e (d + b)).zero_mem
    | add y z _ _ iy iz => rw [mul_add]; exact Submodule.add_mem _ iy iz
    | smul c y _ induction => rw [mul_smul_comm]; exact Submodule.smul_mem _ c induction
  | zero => simpa using (signedGeneratorFiltration R p w e (d + b)).zero_mem
  | add x z _ _ ix iz => rw [add_mul]; exact Submodule.add_mem _ ix iz
  | smul c x _ induction => rw [smul_mul_assoc]; exact Submodule.smul_mem _ c induction

theorem signed_generator_initial_one (p : A) (w : ℕ) (e : I → A) :
    1 ∈ signedGeneratorFiltration R p w e 0 := by
  simpa [generatorMonomial, generatorMonomialWeight] using
    signed_generator_member (R := R) p w e 0 0 (fun _ => 0) (by simp [generatorMonomialWeight])

theorem signed_generator_power (p : A) (w : ℕ) (e : I → A)
    (d : ℤ) (x : A) (member : x ∈ signedGeneratorFiltration R p w e d) (n : ℕ) :
    x ^ n ∈ signedGeneratorFiltration R p w e ((n : ℤ) * d) := by
  induction n with
  | zero => simpa using signed_generator_initial_one (R := R) p w e
  | succ n induction =>
    have product := signed_generator_filtration_multiplicative p w e
      ((n : ℤ) * d) d (x ^ n) x induction member
    simpa only [pow_succ, Nat.cast_add, Nat.cast_one, add_mul, one_mul] using product

theorem signed_generator_finite_product (p : A) (w : ℕ) (e : I → A)
    (s : Finset I) (x : I → A) (d : I → ℤ)
    (member : ∀ i ∈ s, x i ∈ signedGeneratorFiltration R p w e (d i)) :
    ∏ i ∈ s, x i ∈ signedGeneratorFiltration R p w e (∑ i ∈ s, d i) := by
  classical
  induction s using Finset.induction_on with
  | empty => simpa using signed_generator_initial_one (R := R) p w e
  | @insert i s outside induction =>
    rw [Finset.prod_insert outside, Finset.sum_insert outside]
    exact signed_generator_filtration_multiplicative p w e (d i) (∑ j ∈ s, d j)
      (x i) (∏ j ∈ s, x j) (member i (Finset.mem_insert_self _ _))
      (induction (fun j hj => member j (Finset.mem_insert_of_mem hj)))

/-- Scalar prime powers lower degree exactly by their assigned weight;
no cancellation or torsion-freeness is used. -/
theorem signed_generator_prime_power_mul (p : A) (w : ℕ) (e : I → A)
    (d : ℤ) (n : ℕ) (x : A) (member : x ∈ signedGeneratorFiltration R p w e d) :
    p ^ n * x ∈ signedGeneratorFiltration R p w e (d - (w : ℤ) * n) := by
  induction member using Submodule.span_induction with
  | mem x hx =>
    obtain ⟨j, alpha, bound, rfl⟩ := hx
    rw [← mul_assoc, ← pow_add]
    apply signed_generator_member
    rw [Nat.cast_add, mul_add]
    omega
  | zero => simpa using (signedGeneratorFiltration R p w e _).zero_mem
  | add x y _ _ ix iy => rw [mul_add]; exact Submodule.add_mem _ ix iy
  | smul c x _ induction => rw [mul_smul_comm]; exact Submodule.smul_mem _ c induction

end Litt3.Deformations

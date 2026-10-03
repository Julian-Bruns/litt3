import Solutions.Deformations.ClosedSignedOperations
import Mathlib.RingTheory.Derivation.Basic

namespace Litt3.Deformations

open scoped BigOperators

variable {R A I : Type*} [CommRing R] [CommRing A] [Algebra R A] [Fintype I]
  [TopologicalSpace A] [ContinuousAdd A] [ContinuousMul A] [ContinuousConstSMul R A]

/-- Leibniz preserves the total degree of any finite product whose
factors and their actual derivatives have the same degree bounds. -/
theorem derivation_finite_product_degree {J : Type*} (p : A) (w : ℕ) (e : I → A)
    (E : Derivation ℤ A A) (s : Finset J) (x : J → A) (degree : J → ℤ)
    (member : ∀ i ∈ s, x i ∈ closedSignedFiltration R p w e (degree i))
    (derivatives : ∀ i ∈ s, E (x i) ∈ closedSignedFiltration R p w e (degree i)) :
    E (∏ i ∈ s, x i) ∈ closedSignedFiltration R p w e (∑ i ∈ s, degree i) := by
  classical
  induction s using Finset.induction_on with
  | empty => simp
  | @insert i s outside induction =>
    rw [Finset.prod_insert outside, Finset.sum_insert outside, Derivation.leibniz]
    change x i * E (∏ j ∈ s, x j) + (∏ j ∈ s, x j) * E (x i) ∈ _
    apply Submodule.add_mem
    · exact closed_signed_filtration_multiplicative p w e _ _ _ _
        (member i (Finset.mem_insert_self _ _))
        (induction (fun j hj => member j (Finset.mem_insert_of_mem hj))
          (fun j hj => derivatives j (Finset.mem_insert_of_mem hj)))
    · have result := closed_signed_filtration_multiplicative p w e _ _ _ _
        (closed_signed_finite_product p w e s x degree
          (fun j hj => member j (Finset.mem_insert_of_mem hj)))
        (derivatives i (Finset.mem_insert_self _ _))
      simpa only [add_comm] using result

theorem derivation_coordinate_power_degree (p : A) (w : ℕ) (e : I → A)
    (E : Derivation ℤ A A)
    (derivatives : ∀ i, E (e i) ∈ closedSignedFiltration R p w e 1) (i : I) (n : ℕ) :
    E (e i ^ n) ∈ closedSignedFiltration R p w e (n : ℤ) := by
  cases n with
  | zero => simp
  | succ n =>
    have coordinate : e i ∈ closedSignedFiltration R p w e 1 :=
      (signedGeneratorFiltration R p w e 1).le_topologicalClosure
        (signed_generator_coordinate p w e i)
    have product := closed_signed_filtration_multiplicative p w e (n : ℤ) 1
      (e i ^ n) (E (e i)) (by simpa using closed_signed_power p w e 1 _ coordinate n)
      (derivatives i)
    rw [Derivation.leibniz_pow]
    simp only [Nat.succ_sub_one, smul_eq_mul]
    exact (closedSignedFiltration R p w e (n + 1)).nsmul_mem
      (by simpa using product) (n + 1)

theorem derivation_monomial_degree (p : A) (w : ℕ) (e : I → A)
    (E : Derivation ℤ A A)
    (derivatives : ∀ i, E (e i) ∈ closedSignedFiltration R p w e 1) (alpha : I → ℕ) :
    E (generatorMonomial e alpha) ∈
      closedSignedFiltration R p w e (generatorMonomialWeight alpha : ℤ) := by
  have coordinate (i : I) : e i ∈ closedSignedFiltration R p w e 1 :=
    (signedGeneratorFiltration R p w e 1).le_topologicalClosure
      (signed_generator_coordinate p w e i)
  have result := derivation_finite_product_degree p w e E Finset.univ
    (fun i => e i ^ alpha i) (fun i => (alpha i : ℤ))
    (fun i _ => by simpa using closed_signed_power p w e 1 _ (coordinate i) (alpha i))
    (fun i _ => derivation_coordinate_power_degree p w e E derivatives i (alpha i))
  simpa [generatorMonomial, generatorMonomialWeight] using result

/-- Derivatives of all literal integral weighted-span elements preserve
degree, including negative degrees and torsion, from original coordinate
bounds and the actual base derivation compatibility. -/
theorem derivation_signed_degree (p : ℕ) (w : ℕ) (e : I → A)
    (D : Derivation ℤ R R) (E : Derivation ℤ A A)
    (extension : ∀ c, E (algebraMap R A c) = algebraMap R A (D c))
    (derivatives : ∀ i, E (e i) ∈ closedSignedFiltration R (p : A) w e 1)
    (d : ℤ) (x : A) (member : x ∈ signedGeneratorFiltration R (p : A) w e d) :
    E x ∈ closedSignedFiltration R (p : A) w e d := by
  induction member using Submodule.span_induction with
  | mem x hx =>
    obtain ⟨j, alpha, bound, rfl⟩ := hx
    rw [Derivation.leibniz, Derivation.leibniz_pow, Derivation.map_natCast]
    simp only [smul_eq_mul, mul_zero, nsmul_zero, add_zero]
    exact closed_signed_filtration_monotone (p : A) w e
      (show (generatorMonomialWeight alpha : ℤ) - (w : ℤ) * j ≤ d by omega)
      (closed_signed_prime_power_mul (p : A) w e _ j _
        (derivation_monomial_degree (p : A) w e E derivatives alpha))
  | zero => simp
  | add x y _ _ hx hy => rw [map_add]; exact Submodule.add_mem _ hx hy
  | smul c x hx induction =>
    rw [Algebra.smul_def, Derivation.leibniz, extension]
    simp only [smul_eq_mul]
    simpa only [Algebra.smul_def, mul_comm, add_comm] using
      Submodule.add_mem (closedSignedFiltration R (p : A) w e d)
        ((closedSignedFiltration R (p : A) w e d).smul_mem (D c)
          ((signedGeneratorFiltration R (p : A) w e d).le_topologicalClosure hx))
        ((closedSignedFiltration R (p : A) w e d).smul_mem c induction)

end Litt3.Deformations

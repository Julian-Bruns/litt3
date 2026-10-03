import Solutions.Deformations.ClosedSignedFiltration

namespace Litt3.Deformations

open scoped BigOperators

variable {R A I : Type*} [CommRing R] [CommRing A] [Algebra R A] [Fintype I]
  [TopologicalSpace A] [ContinuousAdd A] [ContinuousMul A] [ContinuousConstSMul R A]

theorem closed_signed_initial_one (p : A) (w : ℕ) (e : I → A) :
    (1 : A) ∈ closedSignedFiltration R p w e 0 :=
  (signedGeneratorFiltration R p w e 0).le_topologicalClosure
    (signed_generator_initial_one (R := R) p w e)

theorem closed_signed_filtration_monotone (p : A) (w : ℕ) (e : I → A) :
    Monotone (closedSignedFiltration R p w e) := fun _ _ bound =>
  Submodule.topologicalClosure_mono (signed_generator_filtration_monotone p w e bound)

theorem closed_signed_power (p : A) (w : ℕ) (e : I → A)
    (d : ℤ) (x : A) (member : x ∈ closedSignedFiltration R p w e d) (n : ℕ) :
    x ^ n ∈ closedSignedFiltration R p w e ((n : ℤ) * d) := by
  induction n with
  | zero => simpa using closed_signed_initial_one (R := R) p w e
  | succ n induction =>
    have product := closed_signed_filtration_multiplicative p w e
      ((n : ℤ) * d) d (x ^ n) x induction member
    simpa only [pow_succ, Nat.cast_add, Nat.cast_one, add_mul, one_mul] using product

theorem closed_signed_finite_product {J : Type*} (p : A) (w : ℕ) (e : I → A)
    (s : Finset J) (x : J → A) (d : J → ℤ)
    (member : ∀ i ∈ s, x i ∈ closedSignedFiltration R p w e (d i)) :
    ∏ i ∈ s, x i ∈ closedSignedFiltration R p w e (∑ i ∈ s, d i) := by
  classical
  induction s using Finset.induction_on with
  | empty => simpa using closed_signed_initial_one (R := R) p w e
  | @insert i s outside induction =>
    rw [Finset.prod_insert outside, Finset.sum_insert outside]
    exact closed_signed_filtration_multiplicative p w e (d i) (∑ j ∈ s, d j)
      (x i) (∏ j ∈ s, x j) (member i (Finset.mem_insert_self _ _))
      (induction (fun j hj => member j (Finset.mem_insert_of_mem hj)))

theorem closed_signed_prime_power_mul (p : A) (w : ℕ) (e : I → A)
    (d : ℤ) (n : ℕ) (x : A) (member : x ∈ closedSignedFiltration R p w e d) :
    p ^ n * x ∈ closedSignedFiltration R p w e (d - (w : ℤ) * n) := by
  have maps : Set.MapsTo (fun y : A => p ^ n * y)
      (signedGeneratorFiltration R p w e d : Set A)
      (signedGeneratorFiltration R p w e (d - (w : ℤ) * n) : Set A) := fun y hy =>
    signed_generator_prime_power_mul p w e d n y hy
  exact maps.closure (continuous_const.mul continuous_id) member

end Litt3.Deformations

import Solutions.Deformations.WeightedGeneratorFiltration

namespace Litt3.Deformations

open scoped BigOperators

variable {R A I J : Type*} [CommRing R] [CommRing A] [Algebra R A] [Fintype I]

theorem weighted_generator_product_member (p : A) (w : ℕ) (e : I → A)
    (s : Finset J) (x : J → A) (degree : J → ℕ)
    (members : ∀ j ∈ s, x j ∈ weightedGeneratorFiltration R p w e (degree j)) :
    ∏ j ∈ s, x j ∈ weightedGeneratorFiltration R p w e (∑ j ∈ s, degree j) := by
  classical
  induction s using Finset.induction_on with
  | empty =>
    simpa only [Finset.prod_empty, Finset.sum_empty] using weighted_generator_initial_one (R := R) p w e
  | @insert j s absent induction =>
    rw [Finset.prod_insert absent, Finset.sum_insert absent]
    exact weighted_generator_filtration_multiplicative p w e _ _ _ _
      (members j (Finset.mem_insert_self j s))
      (induction (fun t ht => members t (Finset.mem_insert_of_mem ht)))

/-- Products of genuine weighted congruences are congruent one weight
higher than the sum, without assuming a graded presentation. -/
theorem weighted_generator_product_congruence (p : A) (w : ℕ) (e : I → A)
    (s : Finset J) (x y : J → A) (degree : J → ℕ)
    (xMembers : ∀ j ∈ s, x j ∈ weightedGeneratorFiltration R p w e (degree j))
    (yMembers : ∀ j ∈ s, y j ∈ weightedGeneratorFiltration R p w e (degree j))
    (congruences : ∀ j ∈ s, x j - y j ∈ weightedGeneratorFiltration R p w e (degree j + 1)) :
    (∏ j ∈ s, x j) - (∏ j ∈ s, y j) ∈
      weightedGeneratorFiltration R p w e ((∑ j ∈ s, degree j) + 1) := by
  classical
  induction s using Finset.induction_on with
  | empty =>
    simp only [Finset.prod_empty, sub_self]
    exact Submodule.zero_mem _
  | @insert j s absent induction =>
    rw [Finset.prod_insert absent, Finset.prod_insert absent, Finset.sum_insert absent]
    have first := weighted_generator_filtration_multiplicative (R := R) p w e
      (degree j + 1) (∑ t ∈ s, degree t) (x j - y j) (∏ t ∈ s, x t)
      (congruences j (Finset.mem_insert_self j s))
      (weighted_generator_product_member p w e s x degree
        (fun t ht => xMembers t (Finset.mem_insert_of_mem ht)))
    have second := weighted_generator_filtration_multiplicative (R := R) p w e
      (degree j) ((∑ t ∈ s, degree t) + 1) (y j)
      ((∏ t ∈ s, x t) - (∏ t ∈ s, y t))
      (yMembers j (Finset.mem_insert_self j s))
      (induction
        (fun t ht => xMembers t (Finset.mem_insert_of_mem ht))
        (fun t ht => yMembers t (Finset.mem_insert_of_mem ht))
        (fun t ht => congruences t (Finset.mem_insert_of_mem ht)))
    have firstIndex : degree j + 1 + (∑ t ∈ s, degree t) =
        degree j + (∑ t ∈ s, degree t) + 1 := by omega
    rw [firstIndex] at first
    have result := Submodule.add_mem _ first second
    have identity : x j * (∏ t ∈ s, x t) - y j * (∏ t ∈ s, y t) =
        (x j - y j) * (∏ t ∈ s, x t) +
          y j * ((∏ t ∈ s, x t) - (∏ t ∈ s, y t)) := by ring
    rw [identity]
    simpa only [Nat.add_assoc] using result

end Litt3.Deformations

import Definitions.Deformations.WeightedNormalReduction
import Solutions.Deformations.WeightedGeneratorFiltration

namespace Litt3.Deformations

variable {R A I : Type*} [CommRing R] [CommRing A] [Algebra R A]
  [Fintype I] [DecidableEq I]

theorem generator_monomial_single (e : I → A) (i : I) (n : ℕ) :
    generatorMonomial e (Pi.single i n : I → ℕ) = e i ^ n := by
  classical
  simp [generatorMonomial, Pi.single_apply]

theorem generator_monomial_weight_single (i : I) (n : ℕ) :
    generatorMonomialWeight (Pi.single i n : I → ℕ) = n := by
  classical
  simp [generatorMonomialWeight, Pi.single_apply]

theorem normal_generator_member (q : ℕ) (p : A) (e : I → A)
    (d j : ℕ) (alpha : I → ℕ) (normal : ∀ i, alpha i < q)
    (bound : d ≤ (q - 1) * j + generatorMonomialWeight alpha) :
    p ^ j * generatorMonomial e alpha ∈ normalGeneratorFiltration R q p e d :=
  Submodule.subset_span ⟨j, alpha, normal, bound, rfl⟩

/-- Every literal high monomial reduces into the actual normal
weighted span when each relation replaces e_i^q by p times positive
lower powers. The proof is uniform in q, rank and coefficient ring. -/
theorem weighted_generator_normal_form (q : ℕ) (positive : 0 < q) (p : A) (e : I → A)
    (coefficients : I → Fin (q - 1) → R)
    (relations : ∀ i, e i ^ q = p * ∑ l : Fin (q - 1), coefficients i l • e i ^ (l.val + 1))
    (d : ℕ) :
    weightedGeneratorFiltration R p (q - 1) e d = normalGeneratorFiltration R q p e d := by
  classical
  have reduction (n : ℕ) : ∀ alpha : I → ℕ, generatorMonomialWeight alpha = n →
      ∀ j d, d ≤ (q - 1) * j + generatorMonomialWeight alpha →
        p ^ j * generatorMonomial e alpha ∈ normalGeneratorFiltration R q p e d := by
    induction n using Nat.strong_induction_on with
    | h n induction =>
      intro alpha degree j d bound
      by_cases normal : ∀ i, alpha i < q
      · exact normal_generator_member q p e d j alpha normal bound
      · obtain ⟨i, high⟩ := not_forall.mp normal
        have high' : q ≤ alpha i := Nat.le_of_not_lt high
        let beta := fun t => if t = i then alpha t - q else alpha t
        have exponent : alpha = fun t => beta t + (Pi.single i q : I → ℕ) t := by
          funext t
          by_cases same : t = i
          · subst t; simp [beta, Nat.sub_add_cancel high']
          · simp [beta, Pi.single_apply, same]
        have weight : generatorMonomialWeight alpha = generatorMonomialWeight beta + q := by
          rw [exponent, generator_monomial_weight_add, generator_monomial_weight_single]
        have factor : generatorMonomial e alpha = generatorMonomial e beta * e i ^ q := by
          rw [exponent, ← generator_monomial_product, generator_monomial_single]
        let lower := fun l : Fin (q - 1) =>
          fun t => beta t + (Pi.single i (l.val + 1) : I → ℕ) t
        have lowerWeight (l : Fin (q - 1)) :
            generatorMonomialWeight (lower l) = generatorMonomialWeight beta + (l.val + 1) := by
          dsimp only [lower]
          rw [generator_monomial_weight_add, generator_monomial_weight_single]
        have lowerMember (l : Fin (q - 1)) : p ^ (j + 1) * generatorMonomial e (lower l) ∈
            normalGeneratorFiltration R q p e d := by
          apply induction (generatorMonomialWeight (lower l))
          · rw [lowerWeight, ← degree, weight]
            have := l.isLt
            omega
          · rfl
          · rw [lowerWeight, Nat.mul_add, Nat.mul_one]
            rw [weight] at bound
            omega
        have expansion : p ^ j * generatorMonomial e alpha =
            ∑ l : Fin (q - 1), coefficients i l • (p ^ (j + 1) * generatorMonomial e (lower l)) := by
          rw [factor, relations, ← mul_assoc, ← mul_assoc, Finset.mul_sum]
          simp only [lower, ← generator_monomial_product, generator_monomial_single,
            mul_smul_comm, Algebra.smul_def, pow_succ]
          apply Finset.sum_congr rfl
          intro l _
          ring
        rw [expansion]
        exact Submodule.sum_mem _ fun l _ => Submodule.smul_mem _ _ (lowerMember l)
  apply le_antisymm
  · apply Submodule.span_le.mpr
    rintro x ⟨j, alpha, bound, rfl⟩
    exact reduction (generatorMonomialWeight alpha) alpha rfl j d bound
  · apply Submodule.span_mono
    rintro x ⟨j, alpha, _, bound, rfl⟩
    exact ⟨j, alpha, bound, rfl⟩

/-- Scalar nilpotence and actual normal exponents give the exact
finite upper weight. No numerical Hilbert certificate is needed. -/
theorem normal_generator_filtration_cutoff (q N : ℕ) (qPositive : 0 < q) (nPositive : 0 < N)
    (p : A) (nilpotent : p ^ N = 0) (e : I → A) (d : ℕ)
    (high : (q - 1) * (N - 1) + (q - 1) * Fintype.card I < d) :
    normalGeneratorFiltration R q p e d = ⊥ := by
  apply le_antisymm
  · apply Submodule.span_le.mpr
    rintro x ⟨j, alpha, normal, bound, rfl⟩
    by_cases terminal : N ≤ j
    · have vanish : p ^ j = 0 := by
        rw [← Nat.add_sub_of_le terminal, pow_add, nilpotent, zero_mul]
      simp [vanish]
    · have scalarBound : (q - 1) * j ≤ (q - 1) * (N - 1) :=
        Nat.mul_le_mul_left _ (by omega)
      have exponentBound : generatorMonomialWeight alpha ≤ (q - 1) * Fintype.card I := by
        calc
          _ ≤ ∑ _i : I, (q - 1) := Finset.sum_le_sum (fun i _ => by have := normal i; omega)
          _ = _ := by simp [mul_comm]
      omega
  · exact bot_le

end Litt3.Deformations

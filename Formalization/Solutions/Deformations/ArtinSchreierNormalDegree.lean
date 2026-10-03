import Definitions.Deformations.NormalSignedFiltration
import Solutions.Deformations.SignedGeneratorFiltration
import Solutions.Deformations.WeightedNormalReduction

namespace Litt3.Deformations

variable {R A I : Type*} [CommRing R] [CommRing A] [Algebra R A] [Fintype I]

theorem normal_signed_generator_member (q : ℕ) (p : A) (w : ℕ) (e : I → A)
    (d : ℤ) (j : ℕ) (alpha : I → ℕ) (normal : ∀ i, alpha i < q)
    (bound : (generatorMonomialWeight alpha : ℤ) ≤ d + (w : ℤ) * j) :
    p ^ j * generatorMonomial e alpha ∈ normalSignedFiltration R q p w e d :=
  Submodule.subset_span ⟨j, alpha, normal, bound, rfl⟩

/-- Literal monic chart relations reduce every high power without
increasing ordinary degree or dividing any coefficient. Thus the full
signed carry span equals the actual original normal monomial span. -/
theorem artin_schreier_signed_normal_form (q : ℕ) (large : 1 < q) (p : A) (w : ℕ)
    (e : I → A) (a b : I → R)
    (relations : ∀ i, e i ^ q = a i • e i + b i • (1 : A)) (d : ℤ) :
    signedGeneratorFiltration R p w e d = normalSignedFiltration R q p w e d := by
  classical
  have reduction (n : ℕ) : ∀ alpha : I → ℕ, generatorMonomialWeight alpha = n →
      ∀ (j : ℕ) (d : ℤ), (generatorMonomialWeight alpha : ℤ) ≤ d + (w : ℤ) * j →
        p ^ j * generatorMonomial e alpha ∈ normalSignedFiltration R q p w e d := by
    induction n using Nat.strong_induction_on with
    | h n induction =>
      intro alpha degree j d bound
      by_cases normal : ∀ i, alpha i < q
      · exact normal_signed_generator_member q p w e d j alpha normal bound
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
        let lower := fun t => beta t + (Pi.single i 1 : I → ℕ) t
        have lowerWeight : generatorMonomialWeight lower = generatorMonomialWeight beta + 1 := by
          dsimp only [lower]
          rw [generator_monomial_weight_add, generator_monomial_weight_single]
        have lowerMember : p ^ j * generatorMonomial e lower ∈ normalSignedFiltration R q p w e d := by
          apply induction (generatorMonomialWeight lower)
          · rw [lowerWeight, ← degree, weight]; omega
          · rfl
          · rw [lowerWeight, Nat.cast_add, Nat.cast_one]
            rw [weight, Nat.cast_add] at bound
            omega
        have betaMember : p ^ j * generatorMonomial e beta ∈ normalSignedFiltration R q p w e d := by
          apply induction (generatorMonomialWeight beta)
          · rw [← degree, weight]; omega
          · rfl
          · rw [weight, Nat.cast_add] at bound
            omega
        have expansion : p ^ j * generatorMonomial e alpha =
            a i • (p ^ j * generatorMonomial e lower) +
              b i • (p ^ j * generatorMonomial e beta) := by
          rw [factor, relations]
          simp only [lower, ← generator_monomial_product, generator_monomial_single,
            pow_one, Algebra.smul_def]
          ring
        rw [expansion]
        exact Submodule.add_mem _ (Submodule.smul_mem _ _ lowerMember)
          (Submodule.smul_mem _ _ betaMember)
  apply le_antisymm
  · apply Submodule.span_le.mpr
    rintro x ⟨j, alpha, bound, rfl⟩
    exact reduction (generatorMonomialWeight alpha) alpha rfl j d bound
  · apply Submodule.span_mono
    rintro x ⟨j, alpha, _, bound, rfl⟩
    exact ⟨j, alpha, bound, rfl⟩

end Litt3.Deformations

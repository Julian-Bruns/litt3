import Solutions.Deformations.WeightedRootFunctionEquiv

namespace Litt3.Deformations

open scoped BigOperators

variable (F K : Type*) [Field F] [Fintype F] [DecidableEq F] [Field K]

/-- Literal untruncated graded norm polynomial, specialized at a
nonzero scaling root of minus tau. -/
noncomputable def weightedRootNormElement (c : K) (r : ℕ) :
    weightedRootProduct K (Fintype.card F) (-c ^ (Fintype.card F - 1)) r :=
  ∏ i : Fin r, (
    weightedRootProductParameter K (Fintype.card F) (-c ^ (Fintype.card F - 1)) r i ^
      (Fintype.card F - 1) +
    algebraMap K (weightedRootProduct K (Fintype.card F) (-c ^ (Fintype.card F - 1)) r)
      (-c ^ (Fintype.card F - 1)))

theorem weighted_root_norm_evaluation (φ : F →+* K) (c : K) (r : ℕ) (a : Fin r → F) :
    weightedRootFunctionEvaluation F K φ c r (weightedRootNormElement F K c r) a =
      if a = 0 then (-c ^ (Fintype.card F - 1)) ^ r else 0 := by
  classical
  rw [weightedRootNormElement, map_prod]
  simp only [map_add, map_pow, AlgHom.commutes, Finset.prod_apply, Pi.add_apply, Pi.pow_apply,
    weighted_root_function_evaluation_parameter, Pi.algebraMap_apply, Algebra.algebraMap_self]
  have positive : 0 < Fintype.card F - 1 := by have := Fintype.one_lt_card (α := F); omega
  split_ifs with origin
  · subst a
    simp [zero_pow (Nat.ne_of_gt positive)]
  · have coordinates : ∃ i, a i ≠ 0 := by
      by_contra none
      apply origin
      ext i
      exact not_not.mp (not_exists.mp none i)
    obtain ⟨i, nonzero⟩ := coordinates
    apply Finset.prod_eq_zero (Finset.mem_univ i)
    have power : φ (a i) ^ (Fintype.card F - 1) = 1 := by
      rw [← map_pow, FiniteField.pow_card_sub_one_eq_one (a i) nonzero, map_one]
    rw [mul_pow, power, mul_one]
    exact add_neg_cancel _

theorem weighted_root_norm_function (φ : F →+* K) (c : K) (r : ℕ) :
    weightedRootFunctionEvaluation F K φ c r (weightedRootNormElement F K c r) =
      Pi.single (0 : Fin r → F) ((-c ^ (Fintype.card F - 1)) ^ r) := by
  classical
  ext a
  rw [weighted_root_norm_evaluation]
  simp [Pi.single_apply, eq_comm]

/-- For an actual element nonvanishing on every original nonzero
finite-field direction, its actual multiplication kernel in the literal
graded quotient is exactly the line of the actual norm polynomial. -/
theorem weighted_root_direction_kernel (φ : F →+* K) (c : K) (nonzero : c ≠ 0) (r : ℕ)
    (q x : weightedRootProduct K (Fintype.card F) (-c ^ (Fintype.card F - 1)) r)
    (origin : weightedRootFunctionEvaluation F K φ c r q 0 = 0)
    (directions : ∀ a : Fin r → F, a ≠ 0 → weightedRootFunctionEvaluation F K φ c r q a ≠ 0) :
    q * x = 0 ↔ ∃ b : K, x = b • weightedRootNormElement F K c r := by
  classical
  let evaluate := weightedRootFunctionEvaluation F K φ c r
  have injective := (weighted_root_function_evaluation_bijective F K φ c nonzero r).injective
  have normValue := weighted_root_norm_function F K φ c r
  have scalarNonzero : (-c ^ (Fintype.card F - 1)) ^ r ≠ 0 :=
    pow_ne_zero r (neg_ne_zero.mpr (pow_ne_zero _ nonzero))
  constructor
  · intro vanish
    have pointwise : ∀ a, evaluate q a * evaluate x a = 0 := by
      intro a
      have image := congrArg (fun y => evaluate y a) vanish
      simpa only [map_mul, Pi.mul_apply, map_zero, Pi.zero_apply] using image
    obtain ⟨b, values⟩ := (finite_function_origin_kernel F (evaluate q) (evaluate x) origin directions).mp pointwise
    refine ⟨b / ((-c ^ (Fintype.card F - 1)) ^ r), ?_⟩
    apply injective
    rw [map_smul, normValue, values]
    ext a
    by_cases zero : a = 0
    · subst a
      simp only [Pi.smul_apply, smul_eq_mul, Pi.single_eq_same]
      rw [div_mul_cancel₀ _ scalarNonzero]
    · simp [Pi.single_apply, zero]
  · rintro ⟨b, rfl⟩
    apply injective
    rw [map_mul, map_smul, normValue, map_zero]
    ext a
    by_cases zero : a = 0
    · subst a
      simp [origin]
    · simp [Pi.single_apply, zero]

end Litt3.Deformations

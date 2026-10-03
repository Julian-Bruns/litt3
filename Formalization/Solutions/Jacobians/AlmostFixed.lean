import Theorems.Jacobians.AlmostFixed
import Mathlib.Tactic

namespace Litt3.Jacobians

/-- The midpoint of two equal-norm vectors lies on the same sphere only
when both vectors coincide. No finite-dimensional assumption is needed. -/
theorem equal_norm_almost_fixed_vectors
    {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    (v a b : E) (ha : ‖a‖ = ‖v‖) (hb : ‖b‖ = ‖v‖)
    (hsum : a + b = (2 : ℝ) • v) : a = v ∧ b = v := by
  have hparallelogram := parallelogram_law_with_norm ℝ a b
  rw [hsum, ha, hb, norm_smul] at hparallelogram
  norm_num at hparallelogram
  have hnorm : ‖a - b‖ = 0 := by nlinarith [norm_nonneg (a - b)]
  have hab : a = b := sub_eq_zero.mp (norm_eq_zero.mp hnorm)
  have hdouble : (2 : ℝ) • a = (2 : ℝ) • v := by
    simpa only [← hab, two_smul] using hsum
  have hav := congrArg (fun w : E => (1 / 2 : ℝ) • w) hdouble
  norm_num [smul_smul] at hav
  exact ⟨hav, hab.symm.trans hav⟩

/-- Isometric linear actions cannot have a nontrivial second-difference
relation. The group itself need not be finite. -/
theorem almost_fixed_under_linear_isometries
    {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    (M N : E →ₗᵢ[ℝ] E) (v : E)
    (hrelation : M v + N v = (2 : ℝ) • v) : M v = v ∧ N v = v :=
  equal_norm_almost_fixed_vectors v (M v) (N v) (M.norm_map v) (N.norm_map v) hrelation

theorem finite_permutation_almost_fixed
    {ι : Type*} [Fintype ι] (σ τ : Equiv.Perm ι) (coefficient : ι → ℝ)
    (hrelation : ∀ i, coefficient (σ i) + coefficient (τ i) = 2 * coefficient i) :
    (∀ i, coefficient (σ i) = coefficient i) ∧
      (∀ i, coefficient (τ i) = coefficient i) := by
  let v : EuclideanSpace ℝ ι := WithLp.toLp 2 coefficient
  let M := LinearIsometryEquiv.piLpCongrLeft 2 ℝ ℝ σ.symm
  let N := LinearIsometryEquiv.piLpCongrLeft 2 ℝ ℝ τ.symm
  have hsum : M v + N v = (2 : ℝ) • v := by
    ext i
    change coefficient (σ i) + coefficient (τ i) = 2 * coefficient i
    exact hrelation i
  have hfixed := equal_norm_almost_fixed_vectors v (M v) (N v)
    (M.norm_map v) (N.norm_map v) hsum
  constructor
  · intro i
    exact congrArg (fun w : EuclideanSpace ℝ ι => w i) hfixed.1
  · intro i
    exact congrArg (fun w : EuclideanSpace ℝ ι => w i) hfixed.2

theorem finite_permutation_almost_fixed_target : Targets.FinitePermutationAlmostFixed := by
  intro ι inst σ τ coefficient hrelation
  exact finite_permutation_almost_fixed σ τ coefficient hrelation

/-- Integer divisor multiplicities satisfy the same conclusion. -/
theorem integer_finite_permutation_almost_fixed
    {ι : Type*} [Fintype ι] (σ τ : Equiv.Perm ι) (coefficient : ι → ℤ)
    (hrelation : ∀ i, coefficient (σ i) + coefficient (τ i) = 2 * coefficient i) :
    (∀ i, coefficient (σ i) = coefficient i) ∧
      (∀ i, coefficient (τ i) = coefficient i) := by
  have hreal : ∀ i,
      (coefficient (σ i) : ℝ) + (coefficient (τ i) : ℝ) = 2 * (coefficient i : ℝ) := by
    intro i
    exact_mod_cast hrelation i
  obtain ⟨hσ, hτ⟩ := finite_permutation_almost_fixed σ τ
    (fun i => (coefficient i : ℝ)) hreal
  constructor
  · intro i; exact_mod_cast hσ i
  · intro i; exact_mod_cast hτ i

end Litt3.Jacobians

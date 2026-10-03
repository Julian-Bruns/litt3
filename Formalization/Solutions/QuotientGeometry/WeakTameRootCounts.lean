import Solutions.QuotientGeometry.WeakTamePolynomial
import Mathlib.FieldTheory.IsAlgClosed.Basic
import Mathlib.FieldTheory.Separable

namespace Litt3.QuotientGeometry

theorem linearized_constant_polynomial_derivative
    {k : Type*} [Field k] (p : ℕ) [CharP k p] (α γ : k) :
    (linearizedConstantPolynomial p α γ).derivative = Polynomial.C γ := by
  simp [linearizedConstantPolynomial, Polynomial.derivative_X_pow, CharP.cast_eq_zero k p]

theorem linearized_constant_polynomial_separable
    {k : Type*} [Field k] (p : ℕ) [CharP k p] (α γ : k) (hγ : γ ≠ 0) :
    (linearizedConstantPolynomial p α γ).Separable := by
  rw [Polynomial.separable_def', linearized_constant_polynomial_derivative]
  refine ⟨0, Polynomial.C γ⁻¹, ?_⟩
  simp [← map_mul, hγ]

theorem linearized_constant_roots_card
    {k : Type*} [Field k] [IsAlgClosed k] [DecidableEq k] (p : ℕ) [CharP k p] (hp : 1 < p)
    (α γ : k) (hα : α ≠ 0) (hγ : γ ≠ 0) :
    (linearizedConstantPolynomial p α γ).roots.toFinset.card = p := by
  classical
  rw [Multiset.toFinset_card_of_nodup
    (Polynomial.nodup_roots (linearized_constant_polynomial_separable p α γ hγ)),
    IsAlgClosed.card_roots_eq_natDegree, linearized_constant_polynomial_degree p hp α γ hα]

theorem mem_linearized_constant_roots
    {k : Type*} [Field k] [DecidableEq k] (p : ℕ) (hp : 1 < p) (α γ : k) (hα : α ≠ 0) (b : k) :
    b ∈ (linearizedConstantPolynomial p α γ).roots.toFinset ↔ α * b ^ p + γ * b = 0 := by
  classical
  have hnonzero : linearizedConstantPolynomial p α γ ≠ 0 := by
    intro hz
    have hdegree := linearized_constant_polynomial_degree p hp α γ hα
    simp [hz] at hdegree
    omega
  rw [Multiset.mem_toFinset, Polynomial.mem_roots hnonzero]
  simp [Polynomial.IsRoot, linearizedConstantPolynomial]

theorem tame_scalar_roots_card
    {k : Type*} [Field k] [IsAlgClosed k] [DecidableEq k] (h : ℕ) (hh : 0 < h) (hchar : (h : k) ≠ 0) :
    (Polynomial.X ^ h - Polynomial.C (1 : k)).roots.toFinset.card = h := by
  classical
  rw [Multiset.toFinset_card_of_nodup
    (Polynomial.nodup_roots (Polynomial.separable_X_pow_sub_C (1 : k) hchar one_ne_zero)),
    IsAlgClosed.card_roots_eq_natDegree]
  exact Polynomial.natDegree_X_pow_sub_C

theorem mem_tame_scalar_roots
    {k : Type*} [Field k] [DecidableEq k] (h : ℕ) (hh : 0 < h) (ζ : k) :
    ζ ∈ (Polynomial.X ^ h - Polynomial.C (1 : k)).roots.toFinset ↔ ζ ^ h = 1 := by
  classical
  rw [Multiset.mem_toFinset, Polynomial.mem_roots (Polynomial.X_pow_sub_C_ne_zero hh (1 : k))]
  simp [Polynomial.IsRoot, sub_eq_zero]

theorem tame_scalar_frobenius_fixed
    {k : Type*} [Field k] (p h : ℕ) (hp : 1 < p) (hdiv : h ∣ p - 1)
    (ζ : k) (hζ : ζ ^ h = 1) : ζ ^ p = ζ := by
  obtain ⟨m, hm⟩ := hdiv
  have hpower : ζ ^ (p - 1) = 1 := by rw [hm, pow_mul, hζ, one_pow]
  calc
    ζ ^ p = ζ ^ ((p - 1) + 1) := by congr 1; omega
    _ = ζ ^ (p - 1) * ζ := pow_succ _ _
    _ = ζ := by rw [hpower, one_mul]

end Litt3.QuotientGeometry

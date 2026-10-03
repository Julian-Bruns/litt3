import Mathlib.RingTheory.AdicCompletion.Basic
import Mathlib.LinearAlgebra.Basis.Defs
import Mathlib.Tactic

namespace Litt3.Deformations

open scoped BigOperators

variable {R M Iota : Type*} [CommRing R] [AddCommGroup M] [Module R M] [Fintype Iota]

/-- Membership in an ideal times a finite free module is exactly
membership of every actual basis coefficient in the original ideal. -/
theorem basis_ideal_span_coefficient_iff (B : Module.Basis Iota R M) (J : Ideal R) (x : M) :
    x ∈ J • (⊤ : Submodule R M) ↔ ∀ i, B.repr x i ∈ J := by
  classical
  constructor
  · intro member
    refine Submodule.smul_induction_on member ?_ ?_
    · intro c hc y _ i
      simp only [map_smul, Finsupp.smul_apply, smul_eq_mul]
      exact J.mul_mem_right _ hc
    · intro x y hx hy i
      simp only [map_add, Finsupp.add_apply]
      exact J.add_mem (hx i) (hy i)
  · intro coefficients
    rw [← B.sum_repr x]
    exact Submodule.sum_mem _ fun i _ =>
      Submodule.smul_mem_smul (coefficients i) (Submodule.mem_top : B i ∈ (⊤ : Submodule R M))

/-- Actual finite free modules over an adically complete coefficient
ring are adically complete, constructed coordinate by coordinate. -/
theorem finite_basis_adic_complete (J : Ideal R) [IsAdicComplete J R]
    (B : Module.Basis Iota R M) : IsAdicComplete J M := by
  classical
  refine { haus' := ?_, prec' := ?_ }
  · intro x congruences
    apply B.repr.injective
    apply Finsupp.ext
    intro i
    simp only [map_zero, Finsupp.zero_apply]
    apply IsHausdorff.haus' (I := J)
    intro n
    have member := (SModEq.sub_mem.mp (congruences n))
    simp only [sub_zero] at member
    have coefficient := (basis_ideal_span_coefficient_iff B (J ^ n) x).mp member i
    simpa only [SModEq.sub_mem, sub_zero, smul_eq_mul, Ideal.mul_top] using coefficient
  · intro f compatible
    have coordinates : ∀ i, ∃ c : R, ∀ n,
        B.repr (f n) i ≡ c [SMOD (J ^ n • (⊤ : Submodule R R))] := by
      intro i
      apply IsPrecomplete.prec'
      intro m n bound
      have member := (SModEq.sub_mem.mp (compatible bound))
      have coefficient := (basis_ideal_span_coefficient_iff B (J ^ m) (f m - f n)).mp member i
      simpa only [SModEq.sub_mem, map_sub, Finsupp.sub_apply, smul_eq_mul, Ideal.mul_top] using coefficient
    choose c limit using coordinates
    refine ⟨∑ i, c i • B i, ?_⟩
    intro n
    apply SModEq.sub_mem.mpr
    apply (basis_ideal_span_coefficient_iff B (J ^ n) _).mpr
    intro i
    simp only [map_sub, Finsupp.sub_apply]
    have coefficient := SModEq.sub_mem.mp (limit i n)
    simpa only [B.repr_sum_self, smul_eq_mul, Ideal.mul_top] using coefficient

end Litt3.Deformations

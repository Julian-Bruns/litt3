import Definitions.Deformations.ArtinSchreierRootStep
import Solutions.Deformations.PrimePowerContraction

namespace Litt3.Deformations

variable {R A : Type*} [CommRing R] [CommRing A] [Algebra R A]

theorem artin_schreier_root_step_fixed (p : ℕ) (a : Rˣ) (b : R) (x : A) :
    artinSchreierRootStep p a b x = x ↔
      x ^ p = a.val • x + b • (1 : A) := by
  constructor
  · intro fixed
    have equality := congrArg (fun z : A => a.val • z) fixed
    simp only [artinSchreierRootStep, smul_smul, Units.mul_inv, one_smul] at equality
    simp only [Algebra.smul_def, mul_one] at equality ⊢
    linear_combination equality
  · intro equation
    rw [artinSchreierRootStep, equation, Algebra.algebraMap_eq_smul_one, add_sub_cancel_right, smul_smul]
    simp

theorem artin_schreier_root_step_improves (p : ℕ) (prime : p.Prime)
    (a : Rˣ) (b : R) (n : ℕ) (positive : 0 < n) (x y : A)
    (difference : ∃ z : A, x - y = (p : A) ^ n * z) :
    ∃ z : A, artinSchreierRootStep p a b x - artinSchreierRootStep p a b y =
      (p : A) ^ (n + 1) * z := by
  obtain ⟨z, powerDifference⟩ := prime_power_difference_improves p prime n positive x y difference
  refine ⟨(a⁻¹ : Rˣ).val • z, ?_⟩
  simp only [artinSchreierRootStep, ← smul_sub, sub_sub_sub_cancel_right,
    powerDifference, mul_smul_comm]

end Litt3.Deformations

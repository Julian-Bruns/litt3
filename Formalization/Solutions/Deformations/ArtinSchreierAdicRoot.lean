import Solutions.Deformations.ArtinSchreierRootStep
import Solutions.Deformations.PrimePowerIdeal
import Solutions.Deformations.AdicContractingFixedPoint

namespace Litt3.Deformations

variable {R A : Type*} [CommRing R] [CommRing A] [Algebra R A]

/-- A genuine root modulo p has a constructed unique actual root in
its original residue class in any p-adically complete ambient algebra.
Only the coefficient of x must be a unit. -/
theorem artin_schreier_adic_root_lift (p : ℕ) (prime : p.Prime)
    [IsAdicComplete (Ideal.span {(p : A)}) A]
    (a : Rˣ) (b : R) (seed : A)
    (initial : seed ^ p ≡ a.val • seed + b • (1 : A)
      [SMOD (Ideal.span {(p : A)})]) :
    ∃ x : A, x ^ p = a.val • x + b • (1 : A) ∧
      x ≡ seed [SMOD (Ideal.span {(p : A)})] ∧
      (∀ n, (artinSchreierRootStep p a b)^[n] seed ≡ x
        [SMOD ((Ideal.span {(p : A)}) ^ n)]) ∧
      ∀ y : A, y ^ p = a.val • y + b • (1 : A) →
        y ≡ seed [SMOD (Ideal.span {(p : A)})] → y = x := by
  have initialStep : artinSchreierRootStep p a b seed ≡ seed
      [SMOD (Ideal.span {(p : A)})] := by
    simp only [Algebra.smul_def, mul_one] at initial
    have multiplied := (SModEq.refl (U := Ideal.span {(p : A)})
      (algebraMap R A (a⁻¹ : Rˣ).val)).mul
        (initial.sub (SModEq.refl (algebraMap R A b)))
    simpa [artinSchreierRootStep, Algebra.smul_def, add_sub_cancel_right,
      ← mul_assoc, ← map_mul] using multiplied
  have improves : ∀ n : ℕ, 0 < n → ∀ x y : A,
      x ≡ y [SMOD ((Ideal.span {(p : A)}) ^ n)] →
      artinSchreierRootStep p a b x ≡ artinSchreierRootStep p a b y
        [SMOD ((Ideal.span {(p : A)}) ^ (n + 1))] := by
    intro n positive x y congruence
    apply (prime_power_smodEq_iff p (n + 1) _ _).mpr
    exact artin_schreier_root_step_improves p prime a b n positive x y
      ((prime_power_smodEq_iff p n x y).mp congruence)
  obtain ⟨x, fixed, residue, approximations, unique⟩ :=
    adic_contracting_fixed_point (Ideal.span {(p : A)}) (artinSchreierRootStep p a b)
      improves seed initialStep
  refine ⟨x, (artin_schreier_root_step_fixed p a b x).mp fixed, residue, approximations, ?_⟩
  intro y root congruence
  exact unique y ((artin_schreier_root_step_fixed p a b y).mpr root) congruence

end Litt3.Deformations

import Mathlib.LinearAlgebra.Finsupp.LinearCombination
import Mathlib.LinearAlgebra.FreeModule.Basic
import Mathlib.Tactic

namespace Litt3.Deformations

variable {R S I : Type*} [CommRing R] [CommRing S]

/-- Coefficientwise divisibility lifts to a finitely supported scalar
multiple, preserving finite support without a finite basis assumption. -/
theorem finsupp_scalar_factorization (r : R) (c : I →₀ R)
    (divisible : ∀ i, ∃ z : R, r * z = c i) :
    ∃ d : I →₀ R, r • d = c := by
  classical
  choose z relation using divisible
  let d : I →₀ R := Finsupp.onFinset c.support
    (fun i => if i ∈ c.support then z i else 0) (by
      intro i
      by_cases member : i ∈ c.support
      · exact fun _ => member
      · simp [member])
  refine ⟨d, ?_⟩
  ext i
  by_cases member : i ∈ c.support
  · simpa [d, member, Finsupp.mem_support_iff.mp member] using relation i
  · simp [d, member, Finsupp.notMem_support_iff.mp member]

/-- Lifting a genuine residue basis through a nilpotent scalar
constructs a full basis whenever every nonterminal scalar annihilator
is divisible by that scalar. This is uniform in arbitrary basis rank. -/
theorem nilpotent_residue_basis_bijective {M V : Type*}
    [AddCommGroup M] [Module R M] [AddCommGroup V]
    (r : R) (N : ℕ) (nilpotent : r ^ N = 0)
    (φ : R →+* S) (coefficientKernel : ∀ x : R, φ x = 0 → ∃ z, r * z = x)
    (q : M →+ V) (kernel : ∀ x : M, q x = 0 ↔ ∃ z, r • z = x)
    (annihilator : ∀ j < N, ∀ x : M, r ^ j • x = 0 → ∃ z, r • z = x)
    (C : (I →₀ R) →ₗ[R] M)
    (independentResidue : ∀ c, q (C c) = 0 → ∀ i, φ (c i) = 0)
    (spanningResidue : ∀ x : M, ∃ c, q (C c) = q x) :
    Function.Bijective C := by
  classical
  have cancellation (m : ℕ) : ∀ j, j + m = N → ∀ c : I →₀ R,
      r ^ j • C c = 0 → r ^ j • c = 0 := by
    induction m with
    | zero =>
      intro j equality c _
      have equal : j = N := by omega
      rw [equal, nilpotent, zero_smul]
    | succ m induction =>
      intro j equality c zero
      have bound : j < N := by omega
      obtain ⟨x, relation⟩ := annihilator j bound (C c) zero
      have qzero : q (C c) = 0 := (kernel (C c)).mpr ⟨x, relation⟩
      obtain ⟨d, factor⟩ := finsupp_scalar_factorization r c
        (fun i => coefficientKernel (c i) (independentResidue c qzero i))
      have nextZero : r ^ (j + 1) • C d = 0 := by
        rw [pow_succ, mul_smul, ← map_smul, factor]
        exact zero
      have next := induction (j + 1) (by omega) d nextZero
      rw [← factor, smul_smul, ← pow_succ]
      exact next
  have injective : Function.Injective C := by
    intro c d same
    have zero : C (c - d) = 0 := by rw [map_sub, same, sub_self]
    have coefficients := cancellation N 0 (by omega) (c - d) (by simpa using zero)
    apply sub_eq_zero.mp
    simpa using coefficients
  have approximation (m : ℕ) : ∀ x : M, ∃ c : I →₀ R, ∃ z : M,
      x = C c + r ^ m • z := by
    induction m with
    | zero => intro x; exact ⟨0, x, by simp⟩
    | succ m induction =>
      intro x
      obtain ⟨c, z, equation⟩ := induction x
      obtain ⟨d, reduction⟩ := spanningResidue z
      have residual : q (z - C d) = 0 := by rw [map_sub, reduction, sub_self]
      obtain ⟨w, relation⟩ := (kernel _).mp residual
      have zEquation : z = C d + r • w := by rw [relation, add_sub_cancel]
      refine ⟨c + r ^ m • d, w, ?_⟩
      rw [equation, zEquation, smul_add, ← map_smul, ← add_assoc, ← map_add, smul_smul, ← pow_succ]
  refine ⟨injective, ?_⟩
  intro x
  obtain ⟨c, z, equation⟩ := approximation N x
  refine ⟨c, ?_⟩
  simpa only [nilpotent, zero_smul, add_zero] using equation.symm

/-- The actual lifted linear-combination map is a basis equivalence. -/
noncomputable def nilpotentResidueBasis {M V : Type*}
    [AddCommGroup M] [Module R M] [AddCommGroup V]
    (r : R) (N : ℕ) (nilpotent : r ^ N = 0)
    (φ : R →+* S) (coefficientKernel : ∀ x : R, φ x = 0 → ∃ z, r * z = x)
    (q : M →+ V) (kernel : ∀ x : M, q x = 0 ↔ ∃ z, r • z = x)
    (annihilator : ∀ j < N, ∀ x : M, r ^ j • x = 0 → ∃ z, r • z = x)
    (C : (I →₀ R) →ₗ[R] M)
    (independentResidue : ∀ c, q (C c) = 0 → ∀ i, φ (c i) = 0)
    (spanningResidue : ∀ x : M, ∃ c, q (C c) = q x) : Module.Basis I R M :=
  Module.Basis.ofRepr (LinearEquiv.ofBijective C
    (nilpotent_residue_basis_bijective r N nilpotent φ coefficientKernel q kernel annihilator C
      independentResidue spanningResidue)).symm

end Litt3.Deformations

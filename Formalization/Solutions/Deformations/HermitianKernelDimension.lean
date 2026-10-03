import Theorems.Deformations.HermitianKernelDimension
import Solutions.Deformations.HermitianCyclicKernel
import Solutions.Deformations.CyclicBlockProfile

namespace Litt3.Deformations

section General

variable {k : Type*} [CommRing k]

/-- The full truncation power annihilates every actual
module over Q_N. -/
theorem truncated_module_full_power_zero (N : ℕ) (M : Type*)
    [AddCommGroup M] [Module (TruncatedCoefficientRing k N) M] :
    truncatedModulePowerMap k N N M = 0 := by
  apply LinearMap.ext
  intro x
  change truncatedParameter k N ^ N • x = 0
  rw [truncated_parameter_pow, zero_smul]

noncomputable def truncatedFullPowerKernelEquiv (N : ℕ) (M : Type*)
    [AddCommGroup M] [Module (TruncatedCoefficientRing k N) M] :
    LinearMap.ker (truncatedModulePowerMap k N N M) ≃ₗ[TruncatedCoefficientRing k N] M :=
  (LinearEquiv.ofEq _ _ (by rw [truncated_module_full_power_zero, LinearMap.ker_zero])).trans
    (Submodule.topEquiv : (⊤ : Submodule (TruncatedCoefficientRing k N) M) ≃ₗ[_] M)

end General

variable {k : Type*} [Field k]

theorem truncated_cyclic_family_dimension (N s : ℕ) (degree multiplicity : Fin s → ℕ)
    (bounded : ∀ i, degree i ≤ N) :
    Module.finrank k (TruncatedCyclicBlocks k N s degree multiplicity) =
      cyclicFamilyDimension degree multiplicity := by
  rw [← ((truncatedFullPowerKernelEquiv (k := k) N
    (TruncatedCyclicBlocks k N s degree multiplicity)).restrictScalars k).finrank_eq,
    truncated_cyclic_block_profile N s degree multiplicity bounded N]
  unfold cyclicDimensionProfile cyclicFamilyDimension
  apply Finset.sum_congr rfl
  intro i _
  rw [min_eq_right (bounded i)]

theorem odd_cyclic_family_has_free {ι : Type*} [Fintype ι] (N : ℕ)
    (degree multiplicity : ι → ℕ) (bounded : ∀ i, degree i ≤ N)
    (parity : ∀ i, Odd (degree i) → degree i < N → Even (multiplicity i))
    (oddDimension : Odd (cyclicFamilyDimension degree multiplicity)) :
    ∃ i, degree i = N ∧ 0 < multiplicity i := by
  by_contra noFree
  have evenDimension : Even (cyclicFamilyDimension degree multiplicity) := by
    unfold cyclicFamilyDimension
    apply Finset.even_sum
    intro i _
    rcases Nat.even_or_odd (degree i) with even | odd
    · exact even.mul_left _
    · by_cases less : degree i < N
      · exact (parity i odd less).mul_right _
      · have equal : degree i = N := Nat.le_antisymm (bounded i) (Nat.le_of_not_gt less)
        have zero : multiplicity i = 0 := by
          by_contra nonzero
          exact noFree ⟨i, equal, Nat.pos_of_ne_zero nonzero⟩
        rw [zero, zero_mul]
        exact ⟨0, rfl⟩
  exact Nat.not_even_iff_odd.mpr oddDimension evenDimension

theorem odd_cyclic_family_dimension_bound {ι : Type*} [Fintype ι] (N : ℕ)
    (degree multiplicity : ι → ℕ) (bounded : ∀ i, degree i ≤ N)
    (parity : ∀ i, Odd (degree i) → degree i < N → Even (multiplicity i))
    (oddDimension : Odd (cyclicFamilyDimension degree multiplicity)) :
    N ≤ cyclicFamilyDimension degree multiplicity := by
  obtain ⟨i, equal, positive⟩ := odd_cyclic_family_has_free N degree multiplicity bounded parity oddDimension
  calc
    N = 1 * degree i := by rw [equal, one_mul]
    _ ≤ multiplicity i * degree i := Nat.mul_le_mul_right _ positive
    _ ≤ ∑ i, multiplicity i * degree i :=
      Finset.single_le_sum (f := fun i => multiplicity i * degree i)
        (fun _ _ => Nat.zero_le _) (Finset.mem_univ i)

/-- An odd-dimensional kernel of any actual Hermitian
Q_N matrix has dimension at least N, without needing a
chosen canonical decomposition or a prior parity assumption. -/
theorem hermitian_odd_kernel_dimension (two_ne_zero : (2 : k) ≠ 0)
    (N : ℕ) (positive : 0 < N) (d : ℕ)
    (A : Matrix (Fin d) (Fin d) (TruncatedCoefficientRing k N))
    (hermitian : truncatedHermitianTranspose k N A = A) :
    Specifications.HermitianOddKernelDimension N d A := by
  obtain ⟨data⟩ := hermitian_cyclic_kernel two_ne_zero N positive d A hermitian
  have dimension : Module.finrank k (LinearMap.ker (Matrix.toLin' A)) =
      cyclicFamilyDimension data.degree data.multiplicity :=
    ((data.kernel_equiv.restrictScalars k).finrank_eq).trans
      (truncated_cyclic_family_dimension N data.s data.degree data.multiplicity data.bounded)
  intro oddDimension
  rw [dimension] at oddDimension ⊢
  exact odd_cyclic_family_dimension_bound N data.degree data.multiplicity data.bounded
    data.odd_nonfree_even oddDimension

end Litt3.Deformations

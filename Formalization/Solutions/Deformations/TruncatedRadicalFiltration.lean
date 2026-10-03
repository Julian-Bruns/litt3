import Theorems.Deformations.TruncatedRadicalFiltration
import Solutions.Deformations.TruncatedRestriction
import Solutions.Deformations.RadicalPowerFiltration
import Solutions.Deformations.FiltrationWindows
import Lean.Elab.Tactic.Omega

namespace Litt3.Deformations

section Principal

variable {k A : Type*} [Field k] [CommRing A] [Algebra k A]

theorem principal_coefficient_subspace_mem (f x : A) :
    x ∈ principalCoefficientSubspace (k := k) f ↔ ∃ a : A, a * f = x := Iff.rfl

/-- Actual positive powers of a principal ideal, viewed as full
coefficient subspaces, are the full spaces of power multiples. -/
theorem principal_coefficient_subspace_positive_power (f : A) (n : ℕ) :
    principalCoefficientSubspace (k := k) f ^ (n + 1) =
      principalCoefficientSubspace (k := k) (f ^ (n + 1)) := by
  induction n with
  | zero => simp only [Nat.zero_add, pow_one]
  | succ n ih =>
      rw [pow_succ, ih]
      apply le_antisymm
      · apply Submodule.mul_le.mpr
        intro x hx y hy
        obtain ⟨a, rfl⟩ := hx
        obtain ⟨b, rfl⟩ := hy
        refine ⟨a * b, ?_⟩
        simp only [LinearMap.mulRight_apply, pow_succ]
        ring
      · intro x hx
        obtain ⟨a, rfl⟩ := hx
        have hleft : a * f ^ (n + 1) ∈ principalCoefficientSubspace (k := k) (f ^ (n + 1)) :=
          ⟨a, rfl⟩
        have hright : f ∈ principalCoefficientSubspace (k := k) f := ⟨1, one_mul f⟩
        simpa only [LinearMap.mulRight_apply, pow_succ, mul_assoc] using
          Submodule.mul_mem_mul hleft hright

end Principal

section Truncated

variable {k : Type*} [Field k]

theorem truncated_residue_surjective (N : ℕ) (positive : 0 < N) :
    Function.Surjective (truncatedResidue k N positive) := by
  intro c
  exact ⟨AdjoinRoot.of ((Polynomial.X : Polynomial k) ^ N) c,
    truncated_residue_constant N positive c⟩

theorem truncated_parameter_mem_jacobson (N : ℕ) (positive : 0 < N) :
    truncatedParameter k N ∈ Ring.jacobson (TruncatedCoefficientRing k N) := by
  rw [Ring.jacobson_eq_sInf_isMaximal]
  apply Submodule.mem_sInf.mpr
  intro I hI
  apply (hI.isPrime.pow_mem_iff_mem N positive).mp
  rw [truncated_parameter_pow]
  exact I.zero_mem

/-- The genuine residue kernel equals the genuine Jacobson
radical, proved from actual maximal ideals and parameter nilpotence. -/
theorem truncated_jacobson_residue_kernel (N : ℕ) (positive : 0 < N) :
    Ring.jacobson (TruncatedCoefficientRing k N) = RingHom.ker (truncatedResidue k N positive) := by
  apply le_antisymm
  · rw [Ring.jacobson_eq_sInf_isMaximal]
    exact sInf_le (RingHom.ker_isMaximal_of_surjective _ (truncated_residue_surjective N positive))
  · intro x hx
    obtain ⟨y, hy⟩ := truncated_scalar_decomposition N positive x
    have hzero : truncatedResidue k N positive x = 0 := hx
    rw [hzero, map_zero, zero_add] at hy
    rw [hy]
    exact Ideal.mul_mem_right y _ (truncated_parameter_mem_jacobson N positive)

theorem actual_truncated_radical (N : ℕ) (positive : 0 < N) :
    Specifications.ActualTruncatedRadical (k := k) N := by
  unfold Specifications.ActualTruncatedRadical jacobsonRadicalSubspace
  rw [truncated_jacobson_residue_kernel N positive]
  ext x
  constructor
  · intro hx
    obtain ⟨y, hy⟩ := truncated_scalar_decomposition N positive x
    have hzero : truncatedResidue k N positive x = 0 := hx
    rw [hzero, map_zero, zero_add] at hy
    exact ⟨y, (mul_comm y (truncatedParameter k N)).trans hy.symm⟩
  · rintro ⟨y, rfl⟩
    change truncatedResidue k N positive (y * truncatedParameter k N) = 0
    rw [map_mul, truncated_residue_parameter, mul_zero]

theorem truncated_radical_filtration_range (N : ℕ) (positive : 0 < N) (n : ℕ) :
    jacobsonRadicalFiltration (k := k) (A := TruncatedCoefficientRing k N) n =
      principalCoefficientSubspace (k := k) (truncatedParameter k N ^ n) := by
  cases n with
  | zero =>
      change ⊤ = LinearMap.range (LinearMap.mulRight k (truncatedParameter k N ^ 0))
      simp
  | succ n =>
      change jacobsonRadicalSubspace (k := k) (A := TruncatedCoefficientRing k N) ^ (n + 1) = _
      rw [actual_truncated_radical N positive]
      exact principal_coefficient_subspace_positive_power _ n

theorem truncated_principal_power_subspace_finrank (N n : ℕ) :
    Module.finrank k (principalCoefficientSubspace (k := k) (truncatedParameter k N ^ n)) =
      N - min N n := by
  by_cases bound : n ≤ N
  · have heq : LinearMap.mulRight k (truncatedParameter k N ^ n) =
        truncatedPowerCoefficientMap k N n := by
      ext x
      exact mul_comm x (truncatedParameter k N ^ n)
    have hk : Module.finrank k (LinearMap.ker
        (LinearMap.mulRight k (truncatedParameter k N ^ n))) = n :=
      (congrArg (fun T : TruncatedCoefficientRing k N →ₗ[k] TruncatedCoefficientRing k N =>
        Module.finrank k (LinearMap.ker T)) heq).trans
          (truncated_power_kernel_finrank N n bound)
    have h := (LinearMap.mulRight k (truncatedParameter k N ^ n)).finrank_range_add_finrank_ker
    rw [hk, truncated_coefficient_finrank N] at h
    change Module.finrank k (LinearMap.range (LinearMap.mulRight k (truncatedParameter k N ^ n))) = _
    rw [min_eq_right bound]
    omega
  · have hn : N ≤ n := by omega
    have hz := pow_eq_zero_of_le hn (truncated_parameter_pow (k := k) N)
    simp [principalCoefficientSubspace, hz, min_eq_left hn]

theorem truncated_radical_filtration_finrank (N : ℕ) (positive : 0 < N) (i : ℕ) :
    Module.finrank k (jacobsonRadicalFiltration (k := k) (A := TruncatedCoefficientRing k N) i) =
      N - min N i := by
  rw [truncated_radical_filtration_range N positive i]
  exact truncated_principal_power_subspace_finrank N i

/-- Actual Jacobson-radical Hilbert layers of the genuine
truncated algebra, with no supplied Hilbert table. -/
theorem actual_truncated_radical_layer_dimensions (N : ℕ) (positive : 0 < N) :
    Specifications.ActualTruncatedRadicalLayerDimensions (k := k) N := by
  intro i
  rw [filtration_layer_finrank _ jacobson_radical_filtration_descending,
    truncated_radical_filtration_finrank N positive i,
    truncated_radical_filtration_finrank N positive (i + 1)]
  split_ifs <;> omega

/-- The genuine all-index radical-window maximum is min(N,lag)
and is attained at degree zero, for every positive truncation length. -/
theorem actual_truncated_radical_width (N : ℕ) (positive : 0 < N) (lag : ℕ) :
    Specifications.ActualTruncatedRadicalWidth (k := k) N lag := by
  have window : ∀ i, (∑ j ∈ Finset.range lag, Module.finrank k
      (FiltrationLayer (jacobsonRadicalFiltration (k := k) (A := TruncatedCoefficientRing k N))
        (i + j))) = (N - min N i) - (N - min N (i + lag)) := by
    intro i
    rw [filtration_window_finrank _ jacobson_radical_filtration_descending,
      truncated_radical_filtration_finrank N positive i,
      truncated_radical_filtration_finrank N positive (i + lag)]
  constructor
  · intro i
    dsimp only
    rw [window i]
    omega
  · dsimp only
    rw [window 0]
    simp only [min_zero, Nat.sub_zero, Nat.zero_add]
    omega

end Truncated

end Litt3.Deformations

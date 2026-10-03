import Theorems.CartierAndSpin.IsotropicDifferences
import Mathlib.LinearAlgebra.Dimension.Finrank
import Mathlib.Tactic.FinCases
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Abel

namespace Litt3.CartierAndSpin

open LinearMap Module
open LinearMap (BilinForm)

variable {K V : Type*} [Field K] [AddCommGroup V] [Module K V]

/-- A totally isotropic subspace has at most half the ambient dimension.
This is the underlying dimension argument, valid in every characteristic. -/
theorem totallyIsotropic_finrank_twice_le [FiniteDimensional K V]
    (B : BilinForm K V) (hB : B.Nondegenerate) (hreflect : B.IsRefl)
    (S : Submodule K V) (hisotropic : ∀ x ∈ S, ∀ y ∈ S, B x y = 0) :
    2 * finrank K S ≤ finrank K V := by
  have hle : S ≤ B.orthogonal S := by
    intro x hx
    rw [BilinForm.mem_orthogonal_iff]
    intro y hy
    exact hisotropic y hy x hx
  have hdim := Submodule.finrank_mono hle
  rw [BilinForm.finrank_orthogonal hB hreflect] at hdim
  omega

theorem symmetric_isotropic_differences_orthogonal (B : BilinForm K V)
    (hsymm : B.IsSymm) (htwo : (2 : K) ≠ 0) (u v : V)
    (hu : B u u = 0) (hv : B v v = 0) (huv : B (u - v) (u - v) = 0) :
    B u v = 0 := by
  have hpolar : (2 : K) * B u v = 0 := by
    simp only [map_sub, LinearMap.sub_apply] at huv
    rw [hsymm.eq v u, hu, hv] at huv
    linear_combination -huv
  exact (mul_eq_zero.mp hpolar).resolve_left htwo

theorem coupledDifferenceBilinear_apply (u v : Fin 3 → K) :
    coupledDifferenceBilinear u v =
      u 0 * v 1 + u 1 * v 0 + u 0 * v 2 + u 2 * v 0 + u 1 * v 2 + u 2 * v 1 := by
  simp only [coupledDifferenceBilinear, LinearMap.add_apply, LinearMap.smulRight_apply,
    LinearMap.proj_apply, LinearMap.smul_apply, smul_eq_mul]

theorem coupledDifferenceBilinear_self (u : Fin 3 → K) :
    coupledDifferenceBilinear u u = 2 * coupledDifferenceQuadratic u := by
  rw [coupledDifferenceBilinear_apply]
  unfold coupledDifferenceQuadratic
  ring

theorem coupledDifferenceBilinear_symmetric :
    (coupledDifferenceBilinear (K := K)).IsSymm := by
  constructor
  intro u v
  rw [coupledDifferenceBilinear_apply, coupledDifferenceBilinear_apply]
  ring

theorem coupledDifferenceBilinear_nondegenerate (htwo : (2 : K) ≠ 0) :
    (coupledDifferenceBilinear (K := K)).Nondegenerate := by
  intro u hu
  have h0 := hu (Pi.single 0 1)
  have h1 := hu (Pi.single 1 1)
  have h2 := hu (Pi.single 2 1)
  rw [coupledDifferenceBilinear_apply] at h0 h1 h2
  simp only [Pi.single_apply, ite_true, ite_false, Fin.isValue, Fin.reduceEq,
    mul_zero, mul_one, zero_add, add_zero] at h0 h1 h2
  have hu0 : u 0 = 0 := by
    apply (mul_eq_zero.mp (show (2 : K) * u 0 = 0 from by
      linear_combination h1 + h2 - h0)).resolve_left htwo
  have hu1 : u 1 = 0 := by linear_combination h2 - hu0
  have hu2 : u 2 = 0 := by linear_combination h1 - hu0
  funext i
  fin_cases i
  · exact hu0
  · exact hu1
  · exact hu2

theorem pairwiseOrthogonal_span_totallyIsotropic (B : BilinForm K V) (A : Set V)
    (hA : ∀ x ∈ A, ∀ y ∈ A, B x y = 0) :
    ∀ x ∈ Submodule.span K A, ∀ y ∈ Submodule.span K A, B x y = 0 := by
  have hle : Submodule.span K A ≤ B.orthogonal (Submodule.span K A) := by
    apply Submodule.span_le.mpr
    intro x hx
    change x ∈ B.orthogonal (Submodule.span K A)
    rw [BilinForm.mem_orthogonal_iff]
    change ∀ y ∈ Submodule.span K A, B y x = 0
    intro y hy
    induction hy using Submodule.span_induction with
    | mem y hy => exact hA y hy x hx
    | zero => simp only [map_zero, LinearMap.zero_apply]
    | add y z hy hz ihy ihz =>
        simp only [map_add, LinearMap.add_apply, ihy, ihz, zero_add]
    | smul c y hy ih =>
        simp only [map_smul, LinearMap.smul_apply, ih, smul_zero]
  intro x hx y hy
  exact hle hy x hx

/-- Every subspace of dimension at most one is contained in the span of
a single vector. The zero-dimensional case is retained. -/
theorem subspace_finrank_le_one_has_spanning_vector [FiniteDimensional K V]
    (S : Submodule K V) (hdim : finrank K S ≤ 1) :
    ∃ direction : V, S = Submodule.span K ({direction} : Set V) := by
  by_cases hzero : S = ⊥
  · exact ⟨0, by rw [hzero, Submodule.span_zero_singleton]⟩
  obtain ⟨direction, hmem, hnonzero⟩ := S.ne_bot_iff.mp hzero
  have hle : Submodule.span K ({direction} : Set V) ≤ S :=
    (Submodule.span_le.mpr (Set.singleton_subset_iff.mpr hmem))
  refine ⟨direction, (Submodule.eq_of_le_of_finrank_le hle ?_).symm⟩
  rw [finrank_span_singleton hnonzero]
  exact hdim

/-- The coupled difference condition forces containment in an affine line
over the actual coefficient field; no finiteness, rationality, or bounded
enumeration of the set is required. -/
theorem coupledDifferencesLieInAffineLine (A : Set (Fin 3 → K)) :
    Specifications.CoupledDifferencesLieInAffineLine A := by
  intro htwo hpair
  by_cases hnonempty : A.Nonempty
  · obtain ⟨base, hbase⟩ := hnonempty
    let differences : Set (Fin 3 → K) := (fun r => r - base) '' A
    let S := Submodule.span K differences
    have horthogonal : ∀ u ∈ differences, ∀ v ∈ differences,
        coupledDifferenceBilinear u v = 0 := by
      rintro u ⟨r, hr, rfl⟩ v ⟨s, hs, rfl⟩
      apply symmetric_isotropic_differences_orthogonal coupledDifferenceBilinear
        coupledDifferenceBilinear_symmetric htwo
      · rw [coupledDifferenceBilinear_self, hpair r hr base hbase, mul_zero]
      · rw [coupledDifferenceBilinear_self, hpair s hs base hbase, mul_zero]
      · have hdiff : (r - base) - (s - base) = r - s := by abel
        rw [hdiff, coupledDifferenceBilinear_self, hpair r hr s hs, mul_zero]
    have hdim := totallyIsotropic_finrank_twice_le coupledDifferenceBilinear
      (coupledDifferenceBilinear_nondegenerate htwo)
      coupledDifferenceBilinear_symmetric.isRefl S
      (pairwiseOrthogonal_span_totallyIsotropic coupledDifferenceBilinear differences horthogonal)
    have hdim' : finrank K S ≤ 1 := by
      have hambient : finrank K (Fin 3 → K) = 3 := by simp
      rw [hambient] at hdim
      omega
    obtain ⟨direction, hspan⟩ := subspace_finrank_le_one_has_spanning_vector S hdim'
    refine ⟨base, direction, ?_⟩
    intro r hr
    rw [← hspan]
    exact Submodule.subset_span ⟨r, hr, rfl⟩
  · refine ⟨0, 0, ?_⟩
    intro r hr
    exact (hnonempty ⟨r, hr⟩).elim

end Litt3.CartierAndSpin

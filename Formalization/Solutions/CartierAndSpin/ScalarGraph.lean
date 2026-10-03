import Theorems.CartierAndSpin.ScalarGraph
import Mathlib.Algebra.Algebra.Basic
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring
import Mathlib.Tactic.LinearCombination

/-!
# Scalar-graph tests without a coordinate pivot

The basis test works in arbitrary dimension and over every field. The second
test multiplies by an actual nonzero element of an extension field, so its
membership condition has no coordinate denominator.
-/

namespace Litt3.CartierAndSpin

open Module

variable {K V W ι : Type*} [Field K]
  [AddCommGroup V] [Module K V] [AddCommGroup W] [Module K W]

theorem linearMap_eq_smulRight_of_range_in_line (D : V →ₗ[K] W) (e : W)
    (he : e ≠ 0) (hline : ∀ v, D v ∈ Submodule.span K ({e} : Set W)) :
    ∃ a : V →ₗ[K] K, D = a.smulRight e := by
  let a : V →ₗ[K] K := (LinearEquiv.coord K W e he).toLinearMap.comp
    (D.codRestrict (Submodule.span K ({e} : Set W)) hline)
  refine ⟨a, ?_⟩
  ext v
  exact (LinearEquiv.coord_apply_smul K W e he
    ⟨D v, hline v⟩).symm

theorem scalarGraphBasisCriterion (M A : V →ₗ[K] W) (e : W)
    (basis : Basis ι K V) : Specifications.ScalarGraphBasisCriterion M A e basis := by
  intro he
  constructor
  · rintro ⟨a, rfl⟩ i
    simp only [LinearMap.add_apply, add_sub_cancel_left, LinearMap.smulRight_apply]
    exact Submodule.smul_mem _ _ (Submodule.mem_span_singleton_self e)
  · intro htests
    let D : V →ₗ[K] W := M - A
    let S := Submodule.span K ({e} : Set W)
    have htop : S.comap D = ⊤ :=
      (Submodule.eq_top_iff_forall_basis_mem basis).mpr htests
    have hline (v : V) : D v ∈ S := by
      have hv : v ∈ S.comap D := by rw [htop]; exact Submodule.mem_top
      exact hv
    obtain ⟨a, ha⟩ := linearMap_eq_smulRight_of_range_in_line D e he hline
    refine ⟨a, ?_⟩
    have : M - A = a.smulRight e := ha
    exact sub_eq_iff_eq_add.mp this |>.trans (add_comm _ _)

section FieldRatio

variable {L : Type*} [Field L] [Algebra K L]

/-- Exact rescaling independence of the skew-kernel ratio. -/
theorem scalarGraphRatio_rescale (k z : L) (r : K) (hr : r ≠ 0) :
    (r • z) / (r • k) = z / k := by
  simp only [Algebra.smul_def]
  have hr' : algebraMap K L r ≠ 0 :=
    fun h => hr ((FaithfulSMul.algebraMap_eq_zero_iff K L).mp h)
  rw [mul_div_mul_left _ _ hr']

/-- The pointwise denominator-free two-dimensional span test is equivalent
to the two shifts in the actual scalar-graph equation. No independence of
`k,z` is needed for existence; independence is only needed for uniqueness. -/
theorem scalarGraph_denominatorFree_iff (k z v w : L) (hk : k ≠ 0) :
    k * w - z * v ∈ Submodule.span K ({k, z} : Set L) ↔
      ∃ a b : K, (z / k) * (v + algebraMap K L a) = w + algebraMap K L b := by
  rw [Submodule.mem_span_pair]
  constructor
  · rintro ⟨α, β, h⟩
    refine ⟨β, -α, ?_⟩
    simp only [Algebra.smul_def] at h
    rw [map_neg]
    apply (div_mul_eq_mul_div _ _ _).trans ?_
    apply (div_eq_iff hk).mpr
    linear_combination h
  · rintro ⟨a, b, h⟩
    refine ⟨-b, a, ?_⟩
    simp only [Algebra.smul_def, map_neg]
    have h' : z * (v + algebraMap K L a) =
        (w + algebraMap K L b) * k := by
      apply (div_eq_iff hk).mp
      simpa only [div_mul_eq_mul_div] using h
    linear_combination h'

end FieldRatio

end Litt3.CartierAndSpin

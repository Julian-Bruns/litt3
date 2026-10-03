import Theorems.CartierAndSpin.SkewKernel
import Mathlib.LinearAlgebra.FiniteDimensional.Lemmas
import Mathlib.Tactic.FinCases
import Mathlib.Tactic.Ring

/-!
# Scalar-graph skew kernels

The kernel criterion is proved over every commutative ring, without a rank or
characteristic assumption. Its three-dimensional matrix realization supplies
the explicit signed cofactor vector used by `quartic_scalar_graph_skew_recovery`.
Trace compression, adjoint construction and actual scalar graph existence
remain separate components of the source record.
-/

namespace Litt3.CartierAndSpin

section Ring

variable {K V : Type*} [CommRing K] [AddCommGroup V] [Module K V]

theorem rankTwoSkewKernelCriterion (e u : V) (a b : V →ₗ[K] K) :
    Specifications.RankTwoSkewKernelCriterion e u a b := by
  intro hli x
  constructor
  · intro hzero
    have hsum : ∑ i : Fin 2, (![a x, -b x] i) • (![e, u] i) = 0 := by
      simpa [rankTwoSkew, Fin.sum_univ_succ, sub_eq_add_neg, neg_smul] using hzero
    have hcoeff := Fintype.linearIndependent_iff.mp hli ![a x, -b x] hsum
    exact ⟨by simpa using hcoeff 0, by simpa using hcoeff 1⟩
  · rintro ⟨ha, hb⟩
    simp [rankTwoSkew, ha, hb]

theorem alternatingThreeKernelVector_mem_kernel (a b c : K) :
    (alternatingThreeMatrix a b c).mulVec (alternatingThreeKernelVector a b c) = 0 := by
  ext i
  rw [Matrix.mulVec, dotProduct, Fin.sum_univ_three]
  fin_cases i
  · change (0 * c + a * (-b)) + b * a = 0
    ring
  · change ((-a) * c + 0 * (-b)) + c * a = 0
    ring
  · change ((-b) * c + (-c) * (-b)) + 0 * a = 0
    ring

end Ring

section Field

variable {K V : Type*} [Field K] [AddCommGroup V] [Module K V]

theorem rankTwoSkew_range_eq_span (e u : V) (a b : V →ₗ[K] K)
    (hsurj : Function.Surjective (fun x : V => (a x, b x))) :
    LinearMap.range (rankTwoSkew e u a b) = Submodule.span K (Set.range (![e, u])) := by
  have he : e ∈ LinearMap.range (rankTwoSkew e u a b) := by
    obtain ⟨x, hx⟩ := hsurj (1, 0)
    have ha : a x = 1 := congrArg Prod.fst hx
    have hb : b x = 0 := congrArg Prod.snd hx
    exact ⟨x, by simp [rankTwoSkew, ha, hb]⟩
  have hu : u ∈ LinearMap.range (rankTwoSkew e u a b) := by
    obtain ⟨x, hx⟩ := hsurj (0, -1)
    have ha : a x = 0 := congrArg Prod.fst hx
    have hb : b x = -1 := congrArg Prod.snd hx
    exact ⟨x, by simp [rankTwoSkew, ha, hb]⟩
  apply le_antisymm
  · intro z hz
    obtain ⟨x, rfl⟩ := hz
    apply Submodule.sub_mem
    · apply Submodule.smul_mem
      exact Submodule.subset_span ⟨0, rfl⟩
    · apply Submodule.smul_mem
      exact Submodule.subset_span ⟨1, rfl⟩
  · apply Submodule.span_le.mpr
    rintro z ⟨i, rfl⟩
    fin_cases i
    · exact he
    · exact hu

/-- A surjective pair of coefficient functionals and two independent vectors
give a skew kernel of codimension exactly two, in every finite dimension. -/
theorem rankTwoSkew_finrank_kernel [FiniteDimensional K V]
    (e u : V) (a b : V →ₗ[K] K) (hli : LinearIndependent K ![e, u])
    (hsurj : Function.Surjective (fun x : V => (a x, b x))) :
    Module.finrank K (LinearMap.ker (rankTwoSkew e u a b)) + 2 = Module.finrank K V := by
  have hrange : Module.finrank K (LinearMap.range (rankTwoSkew e u a b)) = 2 := by
    rw [rankTwoSkew_range_eq_span e u a b hsurj, finrank_span_eq_card hli]
    simp only [Fintype.card_fin]
  have h := (rankTwoSkew e u a b).finrank_range_add_finrank_ker
  rw [hrange] at h
  omega

theorem rankTwoSkew_finrank_kernel_three [FiniteDimensional K V]
    (e u : V) (a b : V →ₗ[K] K) (hli : LinearIndependent K ![e, u])
    (hsurj : Function.Surjective (fun x : V => (a x, b x)))
    (hdim : Module.finrank K V = 3) :
    Module.finrank K (LinearMap.ker (rankTwoSkew e u a b)) = 1 := by
  have h := rankTwoSkew_finrank_kernel e u a b hli hsurj
  omega

end Field

end Litt3.CartierAndSpin

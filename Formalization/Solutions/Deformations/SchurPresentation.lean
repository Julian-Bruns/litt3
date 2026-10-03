import Theorems.Deformations.SchurPresentation
import Mathlib.Tactic.Abel

namespace Litt3.Deformations

variable {R V W : Type*} [Ring R] [AddCommGroup V] [AddCommGroup W]
variable [Module R V] [Module R W]

@[simp] theorem schurResponse_apply (A : V ≃ₗ[R] V) (b : W →ₗ[R] V)
    (c : V →ₗ[R] W) (d : W →ₗ[R] W) (p : V × W) :
    schurResponse A b c d p = (A p.1 + b p.2, c p.1 + d p.2) := rfl

@[simp] theorem schurEntry_apply (A : V ≃ₗ[R] V) (b : W →ₗ[R] V)
    (c : V →ₗ[R] W) (d : W →ₗ[R] W) (w : W) :
    schurEntry A b c d w = d w - c (A.symm (b w)) := rfl

@[simp] theorem schurResidual_apply (A : V ≃ₗ[R] V) (c : V →ₗ[R] W)
    (p : V × W) : schurResidual A c p = p.2 - c (A.symm p.1) := rfl

theorem schur_residual_response (A : V ≃ₗ[R] V) (b : W →ₗ[R] V)
    (c : V →ₗ[R] W) (d : W →ₗ[R] W) (p : V × W) :
    schurResidual A c (schurResponse A b c d p) = schurEntry A b c d p.2 := by
  simp only [schurResponse_apply, schurResidual_apply, schurEntry_apply,
    map_add, LinearEquiv.symm_apply_apply]
  abel

/-- Block elimination gives exact image equality, including every
lower-block value; no dimension or determinant assumption is needed. -/
theorem schur_solvability (A : V ≃ₗ[R] V) (b : W →ₗ[R] V)
    (c : V →ₗ[R] W) (d : W →ₗ[R] W) :
    Specifications.SchurSolvability A b c d := by
  intro p
  constructor
  · rintro ⟨v, rfl⟩
    exact ⟨v.2, (schur_residual_response A b c d v).symm⟩
  · rintro ⟨w, hw⟩
    refine ⟨(A.symm p.1 - A.symm (b w), w), ?_⟩
    rw [schurResponse_apply]
    apply Prod.ext
    · simp only [map_sub, LinearEquiv.apply_symm_apply]
      exact sub_add_cancel _ _
    · simp only [map_sub]
      change c (A.symm p.1) - c (A.symm (b w)) + d w = p.2
      calc
        _ = c (A.symm p.1) + (d w - c (A.symm (b w))) := by abel
        _ = c (A.symm p.1) + (p.2 - c (A.symm p.1)) := by
          exact congrArg (fun z => c (A.symm p.1) + z) hw
        _ = p.2 := by abel

theorem schur_quotient_projection_surjective (A : V ≃ₗ[R] V) (b : W →ₗ[R] V)
    (c : V →ₗ[R] W) (d : W →ₗ[R] W) :
    Function.Surjective (schurQuotientProjection A b c d) := by
  intro q
  obtain ⟨w, rfl⟩ := (LinearMap.range (schurEntry A b c d)).mkQ_surjective q
  refine ⟨(0, w), ?_⟩
  simp [schurQuotientProjection, schurResidual]

theorem schur_quotient_projection_kernel (A : V ≃ₗ[R] V) (b : W →ₗ[R] V)
    (c : V →ₗ[R] W) (d : W →ₗ[R] W) :
    LinearMap.range (schurResponse A b c d) =
      LinearMap.ker (schurQuotientProjection A b c d) := by
  apply SetLike.ext
  intro p
  rw [schur_solvability A b c d p, LinearMap.mem_ker]
  change schurResidual A c p ∈ LinearMap.range (schurEntry A b c d) ↔
    Submodule.Quotient.mk (schurResidual A c p) = 0
  exact (Submodule.Quotient.mk_eq_zero (LinearMap.range (schurEntry A b c d))).symm

/-- The actual cokernel of the original block response is linearly
equivalent to the actual cokernel of its Schur entry. This remains
valid for noncommutative rings and arbitrary module ranks. -/
noncomputable def schurCokernelEquiv (A : V ≃ₗ[R] V) (b : W →ₗ[R] V)
    (c : V →ₗ[R] W) (d : W →ₗ[R] W) :
    ((V × W) ⧸ LinearMap.range (schurResponse A b c d)) ≃ₗ[R]
      W ⧸ LinearMap.range (schurEntry A b c d) :=
  (Submodule.quotEquivOfEq _ _ (schur_quotient_projection_kernel A b c d)).trans
    ((schurQuotientProjection A b c d).quotKerEquivOfSurjective
      (schur_quotient_projection_surjective A b c d))

/-- An endomorphism of the left regular module is right
multiplication by its value at one. This formula imposes no
commutativity on the coefficient ring. -/
theorem left_regular_endomorphism_apply (d : R →ₗ[R] R) (x : R) :
    d x = x * d 1 := by
  simpa only [smul_eq_mul, mul_one] using d.map_smul x 1

theorem left_regular_endomorphism_range (d : R →ₗ[R] R) :
    LinearMap.range d = Submodule.span R {d 1} := by
  apply SetLike.ext
  intro x
  rw [LinearMap.mem_range, Submodule.mem_span_singleton]
  constructor
  · rintro ⟨a, ha⟩
    exact ⟨a, (left_regular_endomorphism_apply d a).symm.trans ha⟩
  · rintro ⟨a, ha⟩
    exact ⟨a, (left_regular_endomorphism_apply d a).trans ha⟩

/-- The exact one-relation presentation for an original block
operator with one remaining free left-module coordinate. The
relation is the derived Schur value at one and its image is R f. -/
noncomputable def scalarSchurCokernelEquiv (A : V ≃ₗ[R] V) (b : R →ₗ[R] V)
    (c : V →ₗ[R] R) (d : R →ₗ[R] R) :
    ((V × R) ⧸ LinearMap.range (schurResponse A b c d)) ≃ₗ[R]
      R ⧸ Submodule.span R {schurEntry A b c d 1} :=
  (schurCokernelEquiv A b c d).trans
    (Submodule.quotEquivOfEq _ _ (left_regular_endomorphism_range (schurEntry A b c d)))

end Litt3.Deformations

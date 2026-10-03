import Theorems.Deformations.FiltrationWidth

namespace Litt3.Deformations

variable {k V : Type*} [DivisionRing k] [AddCommGroup V] [Module k V]
variable [FiniteDimensional k V]

/-- Restricting the domain to S makes its image lie in U. The
resulting kernel injects into the original kernel, so the dimension
loss is uniform without a matrix or finite enumeration. -/
theorem lowered_subspace_kernel_bound (T : V →ₗ[k] V)
    (S U : Submodule k V) (lowers : ∀ x, x ∈ S → T x ∈ U) :
    Module.finrank k S ≤ Module.finrank k U + Module.finrank k (LinearMap.ker T) := by
  let restricted := T.comp S.subtype
  have hrange : LinearMap.range restricted ≤ U := by
    rintro y ⟨x, rfl⟩
    exact lowers x.val x.property
  have hrank := Submodule.finrank_mono hrange
  let kernelEmbedding : LinearMap.ker restricted →ₗ[k] LinearMap.ker T := {
    toFun := fun x => ⟨x.val.val, x.property⟩
    map_add' := by intro x y; apply Subtype.ext; rfl
    map_smul' := by intro r x; apply Subtype.ext; rfl }
  have hinjective : Function.Injective kernelEmbedding := by
    intro x y h
    apply Subtype.ext
    apply Subtype.ext
    exact congrArg (fun z : LinearMap.ker T => z.val) h
  have hkernel := LinearMap.finrank_le_finrank_of_injective hinjective
  have hnullity := restricted.finrank_range_add_finrank_ker
  omega

/-- Kernel and cokernel dimensions agree for any endomorphism of a
finite-dimensional space, independently of characteristic. -/
theorem kernel_cokernel_finrank_eq (T : V →ₗ[k] V) :
    Module.finrank k (LinearMap.ker T) = Module.finrank k (EndomorphismCokernel T) := by
  have hk := T.finrank_range_add_finrank_ker
  have hq := (LinearMap.range T).finrank_quotient_add_finrank
  change Module.finrank k (LinearMap.ker T) =
    Module.finrank k (V ⧸ LinearMap.range T)
  omega

/-- Dimension of an actual successive quotient is the filtration
dimension drop, once the filtration is decreasing. -/
theorem filtration_layer_finrank (F : ℕ → Submodule k V)
    (descending : ∀ i, F (i + 1) ≤ F i) (i : ℕ) :
    Module.finrank k (FiltrationLayer F i) =
      Module.finrank k (F i) - Module.finrank k (F (i + 1)) := by
  let sub := (F (i + 1)).comap (F i).subtype
  have heq : Module.finrank k sub = Module.finrank k (F (i + 1)) :=
    (Submodule.comapSubtypeEquivOfLe (descending i)).finrank_eq
  have hquot := sub.finrank_quotient_add_finrank
  change Module.finrank k (F i ⧸ sub) = _
  omega

/-- A step-two lowering operator has cokernel dimension at least
every adjacent pair of filtration-layer dimensions. This is the
computation-free algebra behind augmentation-width lower bounds and
is valid for noncommutative algebra filtrations. -/
theorem adjacent_filtration_width (T : V →ₗ[k] V)
    (F : ℕ → Submodule k V)
    (descending : ∀ i, F (i + 1) ≤ F i)
    (two_step_lowering : ∀ i x, x ∈ F i → T x ∈ F (i + 2)) :
    Specifications.AdjacentFiltrationWidth T F := by
  intro i
  have hbound := lowered_subspace_kernel_bound T (F i) (F (i + 2))
    (two_step_lowering i)
  have h1 := Submodule.finrank_mono (descending i)
  have h2 : Module.finrank k (F (i + 2)) ≤ Module.finrank k (F (i + 1)) :=
    Submodule.finrank_mono (descending (i + 1))
  rw [filtration_layer_finrank F descending i,
    filtration_layer_finrank F descending (i + 1)]
  rw [kernel_cokernel_finrank_eq T] at hbound
  change Module.finrank k (F i) - Module.finrank k (F (i + 1)) +
    (Module.finrank k (F (i + 1)) - Module.finrank k (F (i + 2))) ≤
      Module.finrank k (EndomorphismCokernel T)
  omega

end Litt3.Deformations

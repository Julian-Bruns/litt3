import Solutions.Jacobians.ActualTildeFiniteProjectiveOpenSections
import Mathlib.LinearAlgebra.Span.Basic

open CategoryTheory Opposite TopologicalSpace AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {R : Type u} [CommRing R] (M : ModuleCat.{u} R)

theorem actual_finite_projective_dual_reconstruction
    [Module.Finite R M] [Module.Projective R M] :
    ∃ (n : ℕ) (m : Fin n → M) (G : Fin n → Module.Dual R M),
      ∀ a : M, ∑ i, G i a • m i = a := by
  classical
  obtain ⟨n, f, g, _hf, _hg, hfg⟩ := Module.Finite.exists_comp_eq_id_of_projective R M
  let m (i : Fin n) := f (Pi.single i (1 : R))
  let G (i : Fin n) : Module.Dual R M := (LinearMap.proj i).comp g
  refine ⟨n, m, G, ?_⟩
  intro a
  have hv : ∑ i : Fin n, g a i • (Pi.single i (1 : R) : Fin n → R) = g a := by
    ext j
    simp [Pi.single_apply]
  change ∑ i : Fin n, g a i • f (Pi.single i (1 : R)) = a
  simp_rw [← f.map_smul]
  rw [← map_sum, hv]
  exact LinearMap.congr_fun hfg a

/-- On EVERY actual open, actual original sections generate the ENTIRE
true associated-sheaf section module over its actual structure ring. -/
theorem actualTildeOriginalOpenSections_span_top
    [Module.Finite R M] [Module.Projective R M] (U : Opens (PrimeSpectrum R)) :
    Submodule.span ((Spec.structureSheaf R).val.obj (op U))
      (Set.range (fun m : M =>
        (show M.tilde.val.obj (op U) from ModuleCat.Tilde.toOpen M U m))) = ⊤ := by
  obtain ⟨n, m, G, h⟩ := actual_finite_projective_dual_reconstruction M
  apply top_unique
  intro s hs
  rw [← actual_tilde_open_section_reconstruction M m G h U s]
  apply Submodule.sum_mem
  intro i hi
  apply Submodule.smul_mem
  exact Submodule.subset_span ⟨m i, rfl⟩

end Litt3.Jacobians

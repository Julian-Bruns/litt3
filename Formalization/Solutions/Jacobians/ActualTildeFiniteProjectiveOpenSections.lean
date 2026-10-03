import Solutions.Jacobians.ActualTildeOpenTensorEquivalence

open CategoryTheory Opposite TopologicalSpace AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {R : Type u} [CommRing R] (M : ModuleCat.{u} R)

/-- On EVERY actual open U of Spec R, an actual finite projective module has
its true associated-sheaf sections equal to the ACTUAL coefficient extension
O(U)⊗_R M. No affineness, quasi-compactness or supplied Γ reconstruction of U. -/
theorem actualTildeOpenBaseChangeMap_bijective
    [Module.Finite R M] [Module.Projective R M] (U : Opens (PrimeSpectrum R)) :
    Function.Bijective (actualTildeOpenBaseChangeMap M U) := by
  classical
  obtain ⟨n, f, g, _hf, _hg, hfg⟩ := Module.Finite.exists_comp_eq_id_of_projective R M
  let m (i : Fin n) := f (Pi.single i (1 : R))
  let G (i : Fin n) : Module.Dual R M := (LinearMap.proj i).comp g
  apply actualTildeOpenBaseChangeMap_bijective_of_reconstruction M m G
  intro a
  have hv : ∑ i : Fin n, g a i • (Pi.single i (1 : R) : Fin n → R) = g a := by
    ext j
    simp [Pi.single_apply]
  change ∑ i : Fin n, g a i • f (Pi.single i (1 : R)) = a
  simp_rw [← f.map_smul]
  rw [← map_sum, hv]
  exact LinearMap.congr_fun hfg a

/-- A genuine O(U)-module equivalence from actual coefficient extension to
actual sheaf sections, natural source map and hypotheses fully explicit. -/
noncomputable def actualTildeFiniteProjectiveOpenSectionsIso
    [Module.Finite R M] [Module.Projective R M] (U : Opens (PrimeSpectrum R)) :
    (ModuleCat.extendScalars (StructureSheaf.toOpen R U).hom).obj M ≅
      M.tilde.val.obj (op U) :=
  (LinearEquiv.ofBijective (actualTildeOpenBaseChangeMap M U).hom
    (actualTildeOpenBaseChangeMap_bijective M U)).toModuleIso

end Litt3.Jacobians

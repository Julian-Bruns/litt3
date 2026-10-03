import Solutions.Jacobians.ActualTildeUnit

open CategoryTheory Opposite TopologicalSpace AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {R : Type u} [CommRing R] (M : ModuleCat.{u} R)

theorem actualLocalizedScalarMap (x : PrimeSpectrum R) (r : R)
    (a : LocalizedModule x.asIdeal.primeCompl M) :
    LocalizedModule.map x.asIdeal.primeCompl (r • LinearMap.id) a =
      algebraMap R (Localization.AtPrime x.asIdeal) r • a := by
  have h : (LocalizedModule.map x.asIdeal.primeCompl
      (r • (LinearMap.id : M →ₗ[R] M))).restrictScalars R =
        r • (LinearMap.id : LocalizedModule x.asIdeal.primeCompl M →ₗ[R]
          LocalizedModule x.asIdeal.primeCompl M) := by
    apply IsLocalizedModule.linearMap_ext x.asIdeal.primeCompl
      (LocalizedModule.mkLinearMap x.asIdeal.primeCompl M)
      (LocalizedModule.mkLinearMap x.asIdeal.primeCompl M)
    apply LinearMap.ext
    intro m
    change LocalizedModule.map x.asIdeal.primeCompl (r • LinearMap.id)
      (LocalizedModule.mk m 1) = r • LocalizedModule.mk m 1
    rw [LocalizedModule.map_mk]
    exact (LocalizedModule.mkLinearMap x.asIdeal.primeCompl M).map_smul r m
  simpa only [LinearMap.restrictScalars_apply, LinearMap.smul_apply,
    LinearMap.id_apply, algebraMap_smul] using LinearMap.congr_fun h a

/-- Original scalar multiplication induces ACTUAL O-section scalar multiplication
on every section of the actual associated sheaf, not only original elements. -/
theorem actualTildeScalarMap_apply (r : R) (U : (Opens (PrimeSpectrum R))ᵒᵖ)
    (s : M.tilde.val.obj U) :
    (actualTildeMap (ModuleCat.ofHom (r • (LinearMap.id : M →ₗ[R] M)))).val.app U s =
      StructureSheaf.toOpen R U.unop r • s := by
  apply Subtype.ext
  funext x
  exact actualLocalizedScalarMap M x.1 r (s.val x)

theorem actualTilde_composite_apply {N : ModuleCat.{u} R}
    (f : M ⟶ N) (g : N ⟶ M) (r : R)
    (h : f ≫ g = ModuleCat.ofHom (r • (LinearMap.id : M →ₗ[R] M)))
    (U : (Opens (PrimeSpectrum R))ᵒᵖ) (s : M.tilde.val.obj U) :
    (actualTildeMap g).val.app U ((actualTildeMap f).val.app U s) =
      StructureSheaf.toOpen R U.unop r • s := by
  have he := congrArg (fun e => e.val.app U s) (actualTildeMap_comp f g).symm
  change (actualTildeMap g).val.app U ((actualTildeMap f).val.app U s) =
    (actualTildeMap (f ≫ g)).val.app U s at he
  rw [he, h]
  exact actualTildeScalarMap_apply M r U s

end Litt3.Jacobians

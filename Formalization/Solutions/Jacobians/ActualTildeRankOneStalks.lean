import Solutions.Jacobians.ActualTildeMaps
import Mathlib.RingTheory.PicardGroup
import Mathlib.RingTheory.Localization.Free

open CategoryTheory Opposite TopologicalSpace AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {R : Type u} [CommRing R] (M : ModuleCat.{u} R) [Module.Invertible R M]

/-- Genuine rank-one frame over the ACTUAL original prime-local ring. -/
noncomputable def actualLocalizedInvertibleFrame (x : PrimeSpectrum R) :
    LocalizedModule x.asIdeal.primeCompl M ≃ₗ[Localization.AtPrime x.asIdeal]
      Localization.AtPrime x.asIdeal :=
  (Module.Invertible.free_iff_linearEquiv.mp
    (inferInstance : Module.Free (Localization.AtPrime x.asIdeal)
      (LocalizedModule x.asIdeal.primeCompl M))).some

/-- An actual original stalk of the actual associated O_Spec-module sheaf
has a derived rank-one frame; no stalk-freeness assumption is supplied. -/
noncomputable def actualTildeStalkFrame (x : PrimeSpectrum R) :
    (M.tildeInModuleCat.stalk x) ≃ₗ[R] Localization.AtPrime x.asIdeal :=
  (ModuleCat.Tilde.stalkIso M x).toLinearEquiv ≪≫ₗ
    (actualLocalizedInvertibleFrame M x).restrictScalars R

theorem actualTildeStalkFrame_germ
    (U : Opens (PrimeSpectrum R)) (x : PrimeSpectrum R) (hx : x ∈ U)
    (s : M.tildeInModuleCat.obj (op U)) :
    actualTildeStalkFrame M x (M.tildeInModuleCat.germ U x hx s) =
      actualLocalizedInvertibleFrame M x (s.val ⟨x, hx⟩) := by
  exact congrArg (actualLocalizedInvertibleFrame M x)
    (ModuleCat.Tilde.stalkToFiberLinearMap_germ M U x hx s)

theorem actualTildeStalkFrame_original_element (x : PrimeSpectrum R) (m : M) :
    actualTildeStalkFrame M x (ModuleCat.Tilde.toStalk M x m) =
      actualLocalizedInvertibleFrame M x (LocalizedModule.mkLinearMap x.asIdeal.primeCompl M m) := by
  exact congrArg (actualLocalizedInvertibleFrame M x)
    (ModuleCat.Tilde.stalkToFiberLinearMap_toStalk M x m)

/-- For EVERY original prime, an actual principal basic-open neighborhood
has a genuine rank-one localization frame. Finite presentation, local freeness
and rank one are all consequences of the actual Module.Invertible hypothesis. -/
theorem actual_invertible_module_basic_open_frame (x : PrimeSpectrum R) :
    ∃ r : R, r ∉ x.asIdeal ∧ Nonempty
      (LocalizedModule (Submonoid.powers r) M ≃ₗ[Localization.Away r] Localization.Away r) := by
  letI := Module.finitePresentation_of_projective R M
  obtain ⟨r, hr, hfree, _⟩ :=
    Module.FinitePresentation.exists_free_localizedModule_powers x.asIdeal.primeCompl
      (LocalizedModule.mkLinearMap x.asIdeal.primeCompl M) (Localization.AtPrime x.asIdeal)
  letI := hfree
  exact ⟨r, hr, Module.Invertible.free_iff_linearEquiv.mp hfree⟩

end Litt3.Jacobians

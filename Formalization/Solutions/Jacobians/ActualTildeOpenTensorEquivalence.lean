import Solutions.Jacobians.ActualTildeOpenTensorReconstruction
import Mathlib.RingTheory.Finiteness.Projective

open CategoryTheory Opposite TopologicalSpace AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {R : Type u} [CommRing R] (M : ModuleCat.{u} R)

theorem actualTildeOpenBaseChangeMap_bijective_of_reconstruction
    {ι : Type*} [Fintype ι] (m : ι → M) (g : ι → Module.Dual R M)
    (h : ∀ a : M, ∑ i, g i a • m i = a) (U : Opens (PrimeSpectrum R)) :
    Function.Bijective (actualTildeOpenBaseChangeMap M U) := by
  constructor
  · intro a b hab
    have hcoeff : ∀ i, actualTildeOpenTensorFunctional M (g i) U a =
        actualTildeOpenTensorFunctional M (g i) U b := by
      intro i
      have he := CategoryTheory.congr_fun
        (actualTildeOpenTensorFunctional_compatibility M (g i) U) a
      have he' := CategoryTheory.congr_fun
        (actualTildeOpenTensorFunctional_compatibility M (g i) U) b
      change actualTildeOpenFunctional M (g i) U (actualTildeOpenBaseChangeMap M U a) = _ at he
      change actualTildeOpenFunctional M (g i) U (actualTildeOpenBaseChangeMap M U b) = _ at he'
      rw [← he, ← he', hab]
    rw [← actual_tilde_open_extended_module_reconstruction M m g h U a,
      ← actual_tilde_open_extended_module_reconstruction M m g h U b]
    simp_rw [hcoeff]
  · intro s
    refine ⟨∑ i, actualTildeOpenFunctional M (g i) U s •
      actualTildeOpenExtendedOriginal M U (m i), ?_⟩
    rw [map_sum]
    calc
      _ = ∑ i, actualTildeOpenFunctional M (g i) U s •
          (show M.tilde.val.obj (op U) from ModuleCat.Tilde.toOpen M U (m i)) := by
        apply Finset.sum_congr rfl
        intro i hi
        exact ((actualTildeOpenBaseChangeMap M U).hom.map_smul _ _).trans
          (congrArg (fun t => actualTildeOpenFunctional M (g i) U s • t)
            (actualTildeOpenBaseChangeMap_original M U (m i)))
      _ = s := actual_tilde_open_section_reconstruction M m g h U s

end Litt3.Jacobians

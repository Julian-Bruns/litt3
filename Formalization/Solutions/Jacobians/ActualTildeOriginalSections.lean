import Solutions.Jacobians.ActualTildeMaps
import Mathlib.RingTheory.LocalProperties.Submodule

open CategoryTheory Opposite TopologicalSpace AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {R : Type u} [CommRing R]

/-- The genuine global associated-sheaf section of an ORIGINAL module element. -/
noncomputable def actualTildeOriginalGlobalSection (M : ModuleCat.{u} R) (m : M) :
    M.tildeInModuleCat.obj (op ⊤) :=
  ⟨fun x => LocalizedModule.mkLinearMap x.1.asIdeal.primeCompl M m, by
    intro y
    refine ⟨⊤, trivial, 𝟙 _, m, 1, ?_⟩
    intro x
    exact ⟨(Ideal.ne_top_iff_one _).mp x.1.isPrime.ne_top, by simp⟩⟩

theorem actualTildeOriginalGlobalSection_apply (M : ModuleCat.{u} R) (m : M)
    (x : PrimeSpectrum R) :
    (actualTildeOriginalGlobalSection M m).val ⟨x, trivial⟩ =
      LocalizedModule.mkLinearMap x.asIdeal.primeCompl M m := rfl

theorem actualTildeMap_original_global {M N : ModuleCat.{u} R}
    (f : M ⟶ N) (m : M) :
    (actualTildeMap f).val.app (op ⊤) (actualTildeOriginalGlobalSection M m) =
      actualTildeOriginalGlobalSection N (f m) := by
  apply Subtype.ext
  funext x
  exact LocalizedModule.map_mk x.1.asIdeal.primeCompl f.hom m 1

theorem actualTildeOriginalGlobalSection_injective (M : ModuleCat.{u} R) :
    Function.Injective (actualTildeOriginalGlobalSection M) := by
  intro a b h
  apply Module.eq_of_localization_maximal (R := R)
    (fun (P : Ideal R) (_ : P.IsMaximal) => LocalizedModule P.primeCompl M)
    (fun (P : Ideal R) (_ : P.IsMaximal) => LocalizedModule.mkLinearMap P.primeCompl M) a b
  intro P hP
  exact congrArg (fun s => s.val ⟨⟨P, hP.isPrime⟩, trivial⟩) h

/-- Genuine associated-sheaf maps distinguish EVERY original module map. -/
theorem actualTildeMap_injective {M N : ModuleCat.{u} R} :
    Function.Injective (actualTildeMap (M := M) (N := N)) := by
  intro f g h
  apply ModuleCat.hom_ext
  apply LinearMap.ext
  intro m
  apply actualTildeOriginalGlobalSection_injective N
  rw [← actualTildeMap_original_global f m, ← actualTildeMap_original_global g m, h]

instance actualTildeFunctorFaithful : (actualTildeFunctor R).Faithful where
  map_injective := fun h => actualTildeMap_injective h

end Litt3.Jacobians

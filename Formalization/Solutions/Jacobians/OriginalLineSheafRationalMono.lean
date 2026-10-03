import Solutions.Jacobians.OriginalLineSheafRationalEmbedding

open CategoryTheory Opposite AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u}) [IsIntegral X] (M : X.Modules)
  (hM : ActualOriginalLineSheaf X M)

/-- The derived ORIGINAL rational embedding is a genuine MONO
in the ENTIRE actual module-SHEAF category, with no generic-embedding
assumption supplied. -/
instance actualOriginalLineSheafToRational_mono :
    Mono (actualOriginalLineSheafToRational X M hM) where
  right_cancellation := by
    intro N f g h
    apply SheafOfModules.hom_ext
    apply PresheafOfModules.hom_ext
    intro U
    apply ModuleCat.hom_ext
    apply LinearMap.ext
    intro a
    apply actualOriginalLineSheafToRational_app_injective X M hM U.unop
    have hv := congrArg (fun j => (j.val.app U) a) h
    exact hv

end Litt3.Jacobians

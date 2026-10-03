import Solutions.Jacobians.ActualTildeTensorNaturality
import Mathlib.Algebra.Category.ModuleCat.Sheaf

open CategoryTheory Opposite TopologicalSpace AlgebraicGeometry TensorProduct
open scoped TensorProduct

namespace Litt3.Jacobians

universe u
variable {R : Type u} [CommRing R] (M N : ModuleCat.{u} R)
  [Module.Finite R M] [Module.Projective R M]
  [Module.Finite R N] [Module.Projective R N]

/-- The pointwise tensor of these actual associated finite projective
sheaves satisfies the genuine SHEAF condition on the full original open site. -/
theorem actualTildeTensorPresheaf_isSheaf :
    Presheaf.IsSheaf (Opens.grothendieckTopology (PrimeSpectrum R))
      (PresheafOfModules.Monoidal.tensorObj (R := (Spec.structureSheaf R).val)
        M.tilde.val N.tilde.val).presheaf := by
  exact (Presheaf.isSheaf_of_iso_iff
    ((PresheafOfModules.toPresheaf _).mapIso (actualTildeTensorPresheafIso M N))).mpr
      (ModuleCat.of R (M ⊗[R] N)).tilde.isSheaf

/-- The true tensor SHEAF of the actual associated finite projective
modules, using their original pointwise tensor and restriction maps. -/
noncomputable def actualTildeTensorSheaf : (Spec (.of R)).Modules where
  val := PresheafOfModules.Monoidal.tensorObj (R := (Spec.structureSheaf R).val)
    M.tilde.val N.tilde.val
  isSheaf := actualTildeTensorPresheaf_isSheaf M N

/-- The canonical genuine SHEAF isomorphism between the tensor of the
associated finite projective sheaves and the sheaf of the original tensor. -/
noncomputable def actualTildeTensorSheafIso :
    actualTildeTensorSheaf M N ≅ (ModuleCat.of R (M ⊗[R] N)).tilde where
  hom := ⟨(actualTildeTensorPresheafIso M N).hom⟩
  inv := ⟨(actualTildeTensorPresheafIso M N).inv⟩
  hom_inv_id := SheafOfModules.hom_ext (actualTildeTensorPresheafIso M N).hom_inv_id
  inv_hom_id := SheafOfModules.hom_ext (actualTildeTensorPresheafIso M N).inv_hom_id

end Litt3.Jacobians

import Definitions.QuotientGeometry.SchemeBaseFields
import Mathlib.AlgebraicGeometry.Modules.Sheaf
import Mathlib.Algebra.Category.ModuleCat.Differentials.Presheaf
import Mathlib.Algebra.Category.ModuleCat.Presheaf.Sheafification

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.SharedTensors

open Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] {X : Scheme.{u}}

/-- The ORIGINAL structure morphism supplies a natural map from the
constant coefficient ring to the actual structure presheaf, on EVERY
open including the empty open. -/
noncomputable def schemeConstantFieldPresheafMap (sX : X ⟶ Spec (.of k)) :
    (Functor.const X.Opensᵒᵖ).obj (CommRingCat.of k) ⟶ X.presheaf where
  app U := CommRingCat.ofHom (chartBaseFieldHom sX U.unop)
  naturality U V f := by
    change CommRingCat.ofHom (chartBaseFieldHom sX V.unop) =
      CommRingCat.ofHom (chartBaseFieldHom sX U.unop) ≫ X.presheaf.map f
    dsimp only [chartBaseFieldHom, CommRingCat.ofHom_hom]
    simp only [Category.assoc, ← X.presheaf.map_comp]
    rfl

/-- The genuine universal relative differential PRESHEAF of the
original structure sheaf over the actual coefficient field. It is not
defined by an intersection of rational images. -/
noncomputable def schemeDifferentialPresheaf (sX : X ⟶ Spec (.of k)) :
    X.PresheafOfModules :=
  PresheafOfModules.DifferentialsConstruction.relativeDifferentials'
    (schemeConstantFieldPresheafMap sX)

/-- The actual differential sheaf is the associated sheaf of modules
of the literal universal differential presheaf. -/
noncomputable def schemeDifferentialSheaf (sX : X ⟶ Spec (.of k)) : X.Modules :=
  (PresheafOfModules.sheafification (𝟙 X.ringCatSheaf.val)).obj
    (schemeDifferentialPresheaf sX)

/-- Actual global sections of the constructed differential SHEAF.
Identification with rational forms is a theorem to be proved separately. -/
noncomputable abbrev schemeDifferentialGlobalSections (sX : X ⟶ Spec (.of k)) :=
  (schemeDifferentialSheaf sX).val.obj (Opposite.op (⊤ : X.Opens))

end Litt3.SharedTensors

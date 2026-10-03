import Solutions.QuotientGeometry.SchemeStalkPointTransport

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

/-- A genuine Scheme stalk map from the stalk at a fixed original
downstairs point, using only actual equality of that point with the
image of the original upstairs point. -/
noncomputable def actualSchemeFixedBaseStalkMap
    {k : Type u} [Field k] {X Y : Scheme.{u}}
    (f : Y ⟶ X) (sY : Y ⟶ Spec (.of k)) (sX : X ⟶ Spec (.of k))
    (hover : f ≫ sX = sY) (b : X) (y : Y) (hb : b = f y) :
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sX b).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sY y).toAlgebra
    X.presheaf.stalk b →ₐ[k] Y.presheaf.stalk y := by
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sX b).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sX (f y)).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sY y).toAlgebra
  exact (actualSchemeStalkAlgHom f sY sX hover y).comp
    (actualSchemeStalkPointAlgEquiv sX b (f y) hb).toAlgHom

instance actualSchemeFixedBaseStalkMap_isLocal
    {k : Type u} [Field k] {X Y : Scheme.{u}}
    (f : Y ⟶ X) (sY : Y ⟶ Spec (.of k)) (sX : X ⟶ Spec (.of k))
    (hover : f ≫ sX = sY) (b : X) (y : Y) (hb : b = f y) :
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sX b).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sY y).toAlgebra
    IsLocalHom (actualSchemeFixedBaseStalkMap f sY sX hover b y hb).toRingHom := by
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sX b).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sX (f y)).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sY y).toAlgebra
  let e := actualSchemeStalkPointAlgEquiv sX b (f y) hb
  letI : IsLocalHom e.toRingHom := ⟨fun r hr => (MulEquiv.isUnit_map e).mp hr⟩
  change IsLocalHom ((actualSchemeStalkAlgHom f sY sX hover y).toRingHom.comp e.toRingHom)
  infer_instance

end Litt3.QuotientGeometry

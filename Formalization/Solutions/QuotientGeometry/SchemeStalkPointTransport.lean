import Solutions.QuotientGeometry.SchemeSameSourceStalkSquare

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

/-- Transport between equal actual scheme points preserves the
coefficient map coming from their true structure map. -/
noncomputable def actualSchemeStalkPointAlgEquiv
    {k : Type u} [Field k] {B : Scheme.{u}}
    (sB : B ⟶ Spec (.of k)) (b₁ b₂ : B) (hb : b₁ = b₂) :
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sB b₁).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sB b₂).toAlgebra
    B.presheaf.stalk b₁ ≃ₐ[k] B.presheaf.stalk b₂ := by
  subst b₂
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sB b₁).toAlgebra
  exact AlgEquiv.refl

theorem actualSchemeStalkPointAlgEquiv_ring
    {k : Type u} [Field k] {B : Scheme.{u}}
    (sB : B ⟶ Spec (.of k)) (b₁ b₂ : B) (hb : b₁ = b₂) :
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sB b₁).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sB b₂).toAlgebra
    (actualSchemeStalkPointAlgEquiv sB b₁ b₂ hb).toRingHom =
      (B.presheaf.stalkCongr (.of_eq hb)).hom.hom := by
  subst b₂
  simp [actualSchemeStalkPointAlgEquiv, TopCat.Presheaf.stalkCongr]

/-- The second true endpoint-to-base stalk map, transported to the
first actual downstairs point. -/
noncomputable def actualSchemeSecondBaseStalkMap
    {k : Type u} [Field k] {T X Y B : Scheme.{u}}
    (f₁ : T ⟶ X) (f₂ : T ⟶ Y) (χ₁ : X ⟶ B) (χ₂ : Y ⟶ B)
    (sY : Y ⟶ Spec (.of k)) (sB : B ⟶ Spec (.of k))
    (hχ₂ : χ₂ ≫ sB = sY) (hcomm : f₁ ≫ χ₁ = f₂ ≫ χ₂) (t : T) :
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sB (χ₁ (f₁ t))).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sY (f₂ t)).toAlgebra
    B.presheaf.stalk (χ₁ (f₁ t)) →ₐ[k] Y.presheaf.stalk (f₂ t) := by
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sB (χ₁ (f₁ t))).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sB (χ₂ (f₂ t))).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sY (f₂ t)).toAlgebra
  exact (actualSchemeStalkAlgHom χ₂ sY sB hχ₂ (f₂ t)).comp
    (actualSchemeStalkPointAlgEquiv sB (χ₁ (f₁ t)) (χ₂ (f₂ t))
      (congrArg (fun f : T ⟶ B => f t) hcomm)).toAlgHom

instance actualSchemeSecondBaseStalkMap_isLocal
    {k : Type u} [Field k] {T X Y B : Scheme.{u}}
    (f₁ : T ⟶ X) (f₂ : T ⟶ Y) (χ₁ : X ⟶ B) (χ₂ : Y ⟶ B)
    (sY : Y ⟶ Spec (.of k)) (sB : B ⟶ Spec (.of k))
    (hχ₂ : χ₂ ≫ sB = sY) (hcomm : f₁ ≫ χ₁ = f₂ ≫ χ₂) (t : T) :
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sB (χ₁ (f₁ t))).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sY (f₂ t)).toAlgebra
    IsLocalHom (actualSchemeSecondBaseStalkMap f₁ f₂ χ₁ χ₂ sY sB hχ₂ hcomm t).toRingHom := by
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sB (χ₁ (f₁ t))).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sB (χ₂ (f₂ t))).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sY (f₂ t)).toAlgebra
  let e := actualSchemeStalkPointAlgEquiv sB (χ₁ (f₁ t)) (χ₂ (f₂ t))
    (congrArg (fun f : T ⟶ B => f t) hcomm)
  letI : IsLocalHom e.toRingHom := ⟨fun r hr => (MulEquiv.isUnit_map e).mp hr⟩
  change IsLocalHom
    ((actualSchemeStalkAlgHom χ₂ sY sB hχ₂ (f₂ t)).toRingHom.comp e.toRingHom)
  infer_instance

end Litt3.QuotientGeometry

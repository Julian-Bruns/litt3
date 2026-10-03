import Solutions.SharedTensors.ConstantPrincipalDivisors

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

/-- Coefficients on true scheme stalks come from the actual structure
map and global sections. Every actual scheme morphism preserves these
coefficients for its composite structure map. -/
theorem actual_scheme_stalk_base_field_comp
    {k : Type u} [Field k] {X Y : Scheme.{u}}
    (f : X ⟶ Y) (sY : Y ⟶ Spec (.of k)) (x : X) :
    (f.stalkMap x).hom.comp (Litt3.SharedTensors.stalkBaseFieldHom sY (f x)) =
      Litt3.SharedTensors.stalkBaseFieldHom (f ≫ sY) x := by
  change ((Scheme.ΓSpecIso (.of k)).inv ≫ sY.appTop ≫
    Y.presheaf.germ ⊤ (f x) trivial ≫ f.stalkMap x).hom = _
  rw [Scheme.Hom.germ_stalkMap]
  rw [Litt3.SharedTensors.stalkBaseFieldHom, Scheme.Hom.comp_appTop]
  rfl

/-- Coefficient compatibility follows from the actual over-base scheme
square; no independent stalk coefficient square is assumed. -/
theorem actual_scheme_stalk_base_field_over
    {k : Type u} [Field k] {X Y : Scheme.{u}}
    (f : X ⟶ Y) (sX : X ⟶ Spec (.of k)) (sY : Y ⟶ Spec (.of k))
    (hover : f ≫ sY = sX) (x : X) :
    (f.stalkMap x).hom.comp (Litt3.SharedTensors.stalkBaseFieldHom sY (f x)) =
      Litt3.SharedTensors.stalkBaseFieldHom sX x := by
  rw [actual_scheme_stalk_base_field_comp, hover]

/-- The true local scheme stalk morphism, with the coefficient algebras
induced by the actual structure maps. -/
noncomputable def actualSchemeStalkAlgHom
    {k : Type u} [Field k] {X Y : Scheme.{u}}
    (f : X ⟶ Y) (sX : X ⟶ Spec (.of k)) (sY : Y ⟶ Spec (.of k))
    (hover : f ≫ sY = sX) (x : X) :
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sY (f x)).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sX x).toAlgebra
    Y.presheaf.stalk (f x) →ₐ[k] X.presheaf.stalk x := by
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sY (f x)).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sX x).toAlgebra
  exact { (f.stalkMap x).hom with
    commutes' := fun a => DFunLike.congr_fun
      (actual_scheme_stalk_base_field_over f sX sY hover x) a }

theorem actualSchemeStalkAlgHom_ring
    {k : Type u} [Field k] {X Y : Scheme.{u}}
    (f : X ⟶ Y) (sX : X ⟶ Spec (.of k)) (sY : Y ⟶ Spec (.of k))
    (hover : f ≫ sY = sX) (x : X) :
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sY (f x)).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sX x).toAlgebra
    (actualSchemeStalkAlgHom f sX sY hover x).toRingHom = (f.stalkMap x).hom := rfl

instance actualSchemeStalkAlgHom_isLocal
    {k : Type u} [Field k] {X Y : Scheme.{u}}
    (f : X ⟶ Y) (sX : X ⟶ Spec (.of k)) (sY : Y ⟶ Spec (.of k))
    (hover : f ≫ sY = sX) (x : X) :
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sY (f x)).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sX x).toAlgebra
    IsLocalHom (actualSchemeStalkAlgHom f sX sY hover x).toRingHom :=
  inferInstanceAs (IsLocalHom (f.stalkMap x).hom)

end Litt3.QuotientGeometry

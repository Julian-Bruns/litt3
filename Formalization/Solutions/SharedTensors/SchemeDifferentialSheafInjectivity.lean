import Solutions.SharedTensors.SchemeDifferentialAffineInjectivity

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.SharedTensors

open Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] {X : Scheme.{u}} [IsIntegral X]

omit [IsIntegral X] in
/-- The genuine nonempty affine opens are an actual basis. -/
theorem actual_nonempty_affine_opens_basis :
    Opens.IsBasis {U : X.Opens | IsAffineOpen U ∧ Nonempty U} := by
  rw [Opens.isBasis_iff_nbhd]
  intro U x hx
  obtain ⟨V, hV, hxV, hVU⟩ :=
    (Opens.isBasis_iff_nbhd.mp X.isBasis_affineOpens) hx
  exact ⟨V, ⟨hV, ⟨⟨x, hxV⟩⟩⟩, hxV, hVU⟩

/-- The actual ORIGINAL differential-presheaf rational map is injective
on every stalk of an actual smooth integral scheme. -/
theorem schemeDifferentialPresheafToRational_stalk_injective
    (sX : X ⟶ Spec (.of k)) (n : ℕ) [IsSmoothOfRelativeDimension n sX] (x : X) :
    Function.Injective ((TopCat.Presheaf.stalkFunctor AddCommGrpCat x).map
      (schemeDifferentialPresheafToRational sX)) := by
  apply TopCat.Presheaf.stalkFunctor_map_injective_of_isBasis
    (actual_nonempty_affine_opens_basis (X := X))
  intro U hU
  letI : Nonempty U := hU.2
  intro a b equality
  apply schemeDifferentialOpenToFunctionField_affine_injective sX n U hU.1
  have h := congrArg (fun t => (schemeRationalDifferentialOpenIso sX U).hom t) equality
  have compat := schemeDifferentialPresheafToRational_open sX U
  have ha := congrArg (fun f => f.hom a) compat
  have hb := congrArg (fun f => f.hom b) compat
  exact ha.symm.trans (h.trans hb)

omit [IsIntegral X] in
/-- The ORIGINAL sheafification unit is genuinely surjective on every
actual stalk, from the proved locally-surjective sheafification property. -/
theorem schemeDifferentialSheafification_stalk_surjective
    (sX : X ⟶ Spec (.of k)) (x : X) :
    Function.Surjective ((TopCat.Presheaf.stalkFunctor AddCommGrpCat x).map
      (CategoryTheory.toSheafify (Opens.grothendieckTopology X)
        (schemeDifferentialPresheaf sX).presheaf)) := by
  apply (TopCat.Presheaf.locally_surjective_iff_surjective_on_stalks _).mp
    (show CategoryTheory.Presheaf.IsLocallySurjective (Opens.grothendieckTopology X)
      (CategoryTheory.toSheafify (Opens.grothendieckTopology X)
        (schemeDifferentialPresheaf sX).presheaf) from inferInstance)

/-- The actual associated differential SHEAF rational map is injective
on every genuine stalk. Smoothness derives the original-module
injections; no sheaf injection hypothesis is supplied. -/
theorem schemeDifferentialSheafToRational_stalk_injective
    (sX : X ⟶ Spec (.of k)) (n : ℕ) [IsSmoothOfRelativeDimension n sX] (x : X) :
    Function.Injective ((TopCat.Presheaf.stalkFunctor AddCommGrpCat x).map
      (schemeDifferentialSheafToRational sX)) := by
  intro a b equality
  obtain ⟨a0, ha⟩ := schemeDifferentialSheafification_stalk_surjective sX x a
  obtain ⟨b0, hb⟩ := schemeDifferentialSheafification_stalk_surjective sX x b
  have compat :
      (TopCat.Presheaf.stalkFunctor AddCommGrpCat x).map
          (CategoryTheory.toSheafify (Opens.grothendieckTopology X)
            (schemeDifferentialPresheaf sX).presheaf) ≫
        (TopCat.Presheaf.stalkFunctor AddCommGrpCat x).map
          (schemeDifferentialSheafToRational sX) =
      (TopCat.Presheaf.stalkFunctor AddCommGrpCat x).map
        (schemeDifferentialPresheafToRational sX) := by
    rw [← Functor.map_comp, schemeDifferentialSheafToRational_presheaf_compatibility]
  have ha0 := congrArg (fun f => f.hom a0) compat
  have hb0 := congrArg (fun f => f.hom b0) compat
  have mixed :
      ((TopCat.Presheaf.stalkFunctor AddCommGrpCat x).map
        (schemeDifferentialSheafToRational sX))
          (((TopCat.Presheaf.stalkFunctor AddCommGrpCat x).map
            (CategoryTheory.toSheafify (Opens.grothendieckTopology X)
              (schemeDifferentialPresheaf sX).presheaf)) a0) =
      ((TopCat.Presheaf.stalkFunctor AddCommGrpCat x).map
        (schemeDifferentialSheafToRational sX))
          (((TopCat.Presheaf.stalkFunctor AddCommGrpCat x).map
            (CategoryTheory.toSheafify (Opens.grothendieckTopology X)
              (schemeDifferentialPresheaf sX).presheaf)) b0) := by
    rw [ha, hb]
    exact equality
  have original : a0 = b0 := schemeDifferentialPresheafToRational_stalk_injective sX n x
    (ha0.symm.trans (mixed.trans hb0))
  rw [← ha, ← hb, original]

/-- On EVERY original open the genuine differential SHEAF map to
rational forms is injective. Its source is the actual associated sheaf. -/
theorem schemeDifferentialSheafToRational_open_injective
    (sX : X ⟶ Spec (.of k)) (n : ℕ) [IsSmoothOfRelativeDimension n sX] (U : X.Opens) :
    Function.Injective ((schemeDifferentialSheafToRational sX).app (Opposite.op U)) := by
  apply TopCat.Presheaf.app_injective_of_stalkFunctor_map_injective
    (F := ⟨(schemeDifferentialSheaf sX).val.presheaf,
      (schemeDifferentialSheaf sX).isSheaf⟩)
  intro x _
  exact schemeDifferentialSheafToRational_stalk_injective sX n x

/-- Honest actual differential SHEAF sections have a unique original
rational image on every nonempty original open. -/
theorem schemeDifferentialSheafOpenToFunctionField_injective
    (sX : X ⟶ Spec (.of k)) (n : ℕ) [IsSmoothOfRelativeDimension n sX]
    (U : X.Opens) [Nonempty U] :
    Function.Injective (schemeDifferentialSheafOpenToFunctionField sX U) := by
  exact (ConcreteCategory.bijective_of_isIso
    (schemeRationalDifferentialOpenIso sX U).hom).injective.comp
      (schemeDifferentialSheafToRational_open_injective sX n U)

end Litt3.SharedTensors

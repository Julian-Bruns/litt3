import Solutions.Jacobians.SchemeDivisorSectionPullbackMaps

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace

namespace Litt3.Jacobians

universe u
variable {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  [ClosedPointDVRStalks X] [ClosedPointDVRStalks Y]
  (f : X ⟶ Y) [IsFinite f] [Surjective f]
  [AlgebraicGeometry.FormallyUnramified f] [LocallyOfFiniteType f]
  (D : Divisor (Litt3.SharedTensors.ClosedPoint Y))

/-- The ACTUAL global original O(D) SHEAF map into the true
pushforward of O(f*D), through the literal original rational-function map.
Every section, valuation bound and original restriction square is genuine. -/
noncomputable def actualSchemeDivisorSheafToPushforward :
    actualSchemeDivisorSheaf Y D ⟶
      (SheafOfModules.pushforward (actualSchemeRingSheafMap f)).obj
        (actualSchemeDivisorSheaf X (Litt3.SharedTensors.schemeDivisorPullback f D)) where
  val :=
    { app := fun U => ModuleCat.ofHom
        (X := (actualSchemeDivisorSheaf Y D).val.obj U)
        (Y := ((SheafOfModules.pushforward (actualSchemeRingSheafMap f)).obj
          (actualSchemeDivisorSheaf X (Litt3.SharedTensors.schemeDivisorPullback f D))).val.obj U)
        (actualSchemeDivisorSectionPullbackMap f D U.unop)
      naturality := fun {U V} i => by
        classical
        apply ModuleCat.hom_ext
        apply LinearMap.ext
        intro a
        by_cases hV : Nonempty V.unop
        · letI := hV
          let x : V.unop := Classical.arbitrary V.unop
          letI : Nonempty U.unop := ⟨⟨x.val, i.unop.le x.property⟩⟩
          apply Subtype.ext
          change (actualSchemeDivisorSectionPullbackMap f D V.unop
              ((actualSchemeDivisorSheaf Y D).val.map i a)).val =
            (actualSchemeRationalFunctionRingSheaf X).val.map
              ((Opens.map f.base).map i.unop).op
              (actualSchemeDivisorSectionPullbackMap f D U.unop a).val
          rw [actualSchemeDivisorSectionPullbackMap_rational_value,
            actualSchemeDivisorSectionPullbackMap_rational_value]
          exact actualSchemeRationalSectionPullback_restriction f i.unop a.val
        · have hpre : ¬Nonempty (f ⁻¹ᵁ V.unop) := by
            rintro ⟨x⟩
            exact hV ⟨⟨f x.val, x.property⟩⟩
          let N := actualSchemeDivisorSheaf X (Litt3.SharedTensors.schemeDivisorPullback f D)
          letI : Subsingleton (N.val.obj (op (f ⁻¹ᵁ V.unop))) :=
            actualOriginalModuleSheaf_empty_sections_subsingleton X N (f ⁻¹ᵁ V.unop) hpre
          exact @Subsingleton.elim (N.val.obj (op (f ⁻¹ᵁ V.unop))) inferInstance _ _ }

/-- The TRUE categorical ORIGINAL module-SHEAF pullback has a
canonical genuine map to O(f*D), obtained by its ACTUAL pullback/pushforward
adjunction from the original rational-section map. Isomorphism is a further
obligation, not a hypothesis in this construction. -/
noncomputable def actualSchemeDivisorSheafPullbackMap :
    (actualSchemeModulePullback f).obj (actualSchemeDivisorSheaf Y D) ⟶
      actualSchemeDivisorSheaf X (Litt3.SharedTensors.schemeDivisorPullback f D) :=
  ((SheafOfModules.pullbackPushforwardAdjunction (actualSchemeRingSheafMap f)).homEquiv _ _).symm
    (actualSchemeDivisorSheafToPushforward f D)

end Litt3.Jacobians

import Solutions.Jacobians.SchemeDivisorSectionPullbackBounds
import Solutions.Jacobians.OriginalModuleSheafEmptySections

open CategoryTheory Opposite AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  [ClosedPointDVRStalks X] [ClosedPointDVRStalks Y]
  (f : X ⟶ Y) [IsFinite f] [Surjective f]
  [AlgebraicGeometry.FormallyUnramified f] [LocallyOfFiniteType f]
  (D : Divisor (Litt3.SharedTensors.ClosedPoint Y))

/-- The actual ORIGINAL section map O(D)(U) into O(f*D)(f^-1 U),
linear over the ORIGINAL target-open ring through the genuine structure
map. This includes the actual empty-open zero section map. -/
noncomputable def actualSchemeDivisorSectionPullbackMap (U : Y.Opens) :
    (actualSchemeDivisorSheaf Y D).val.obj (op U) →ₗ[Γ(Y, U)]
      ((SheafOfModules.pushforward (actualSchemeRingSheafMap f)).obj
        (actualSchemeDivisorSheaf X (Litt3.SharedTensors.schemeDivisorPullback f D))).val.obj
          (op U) := by
  classical
  by_cases hU : Nonempty U
  · letI := hU
    exact
      { toFun := fun a => ⟨actualSchemeRationalSectionPullback f U a.val,
          actualSchemeRationalSectionPullback_mem_divisor f D U a.val a.property⟩
        map_add' := fun a b => Subtype.ext (map_add (actualSchemeRationalSectionPullback f U) _ _)
        map_smul' := fun r a => by
          apply Subtype.ext
          exact actualSchemeRationalSectionPullback_smul f U r a.val }
  · exact 0

/-- On EVERY nonempty original open the whole section map is
LITERALLY the actual original rational-section pullback. -/
theorem actualSchemeDivisorSectionPullbackMap_rational_value
    (U : Y.Opens) [Nonempty U] (a : (actualSchemeDivisorSheaf Y D).val.obj (op U)) :
    (actualSchemeDivisorSectionPullbackMap f D U a).val =
      actualSchemeRationalSectionPullback f U a.val := by
  classical
  simp only [actualSchemeDivisorSectionPullbackMap,
    dif_pos (inferInstance : Nonempty U), LinearMap.coe_mk, AddHom.coe_mk]

end Litt3.Jacobians

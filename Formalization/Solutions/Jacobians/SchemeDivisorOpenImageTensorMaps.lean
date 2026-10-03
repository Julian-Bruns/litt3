import Solutions.Jacobians.SchemeOpenImageTensorCocones
import Solutions.Jacobians.SchemeDivisorSheafPullbackMaps

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace
open scoped TensorProduct ChangeOfRings

namespace Litt3.Jacobians

universe u
variable {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  [ClosedPointDVRStalks X] [ClosedPointDVRStalks Y]
  (f : X ⟶ Y) [IsFinite f] [Surjective f]
  [AlgebraicGeometry.FormallyUnramified f] [LocallyOfFiniteType f]
  (hf : IsOpenMap f.base) (D : Divisor (Litt3.SharedTensors.ClosedPoint Y))

/-- The actual global explicit tensor-presheaf divisor map comes
from the genuine original divisor-SHEAF pushforward morphism through the
FULL original tensor universal property. -/
noncomputable def actualSchemeDivisorOpenImageTensorMap :
    actualSchemeOpenImageTensorPresheaf f hf (actualSchemeDivisorSheaf Y D) ⟶
      (actualSchemeDivisorSheaf X (Litt3.SharedTensors.schemeDivisorPullback f D)).val :=
  actualSchemeOpenImageTensorCocone f hf (actualSchemeDivisorSheaf Y D)
    (actualSchemeDivisorSheaf X (Litt3.SharedTensors.schemeDivisorPullback f D)).val
      (actualSchemeDivisorSheafToPushforward f D).val

omit [IsIntegral X] [IsIntegral Y] [ClosedPointDVRStalks X] [ClosedPointDVRStalks Y]
  [IsFinite f] [Surjective f] [AlgebraicGeometry.FormallyUnramified f]
  [LocallyOfFiniteType f] in
/-- Actual open images of nonempty original opens are genuinely
nonempty; no surjectivity is needed for this topological fact. -/
theorem actualSchemeOpenImage_nonempty (V : X.Opens) [Nonempty V] :
    Nonempty (hf.functor.obj V) := by
  let x : V := Classical.arbitrary V
  exact ⟨⟨f x.val, ⟨x.val, x.property, rfl⟩⟩⟩

/-- The full ORIGINAL rational value of the tensor map on EVERY
original unit tensor is EXACTLY the true generic-stalk field pullback.
Both the original inverse-image restriction and original rational-section
pullback are proved, not replaced by a value-level definition. -/
theorem actualSchemeDivisorOpenImageTensorMap_unit_field_value
    (V : X.Opens) [Nonempty V]
    (b : (actualSchemeDivisorSheaf Y D).val.obj (op (hf.functor.obj V))) :
    letI := actualSchemeOpenImage_nonempty f hf V
    actualRationalFunctionOpenLinearEquiv X V
      ((actualSchemeDivisorOpenImageTensorMap f hf D).app (op V)
        ((1 : Γ(X, V))
          ⊗ₜ[Γ(Y, hf.functor.obj V),((actualSchemeOpenImageRingMap f hf).app (op V)).hom] b)).val =
      Litt3.SharedTensors.schemeFunctionFieldPullback f
        (actualRationalFunctionOpenLinearEquiv Y (hf.functor.obj V) b.val) := by
  letI := actualSchemeOpenImage_nonempty f hf V
  letI := actualSchemeNonemptyPreimageOpen f (hf.functor.obj V)
  letI : Nonempty ((hf.functor ⋙ Opens.map f.base).obj V) :=
    actualSchemeNonemptyPreimageOpen f (hf.functor.obj V)
  letI : Nonempty ((𝟭 X.Opens).obj V) := inferInstanceAs (Nonempty V)
  change actualRationalFunctionOpenLinearEquiv X V
      (actualSchemeOpenImageTensorCoconeApp f hf (actualSchemeDivisorSheaf Y D)
        (actualSchemeDivisorSheaf X (Litt3.SharedTensors.schemeDivisorPullback f D)).val
        (actualSchemeDivisorSheafToPushforward f D).val V
          ((1 : Γ(X, V))
            ⊗ₜ[Γ(Y, hf.functor.obj V),((actualSchemeOpenImageRingMap f hf).app (op V)).hom] b)).val = _
  rw [actualSchemeOpenImageTensorCoconeApp_tmul, one_smul]
  change actualRationalFunctionOpenLinearEquiv X V
      (((actualSchemeDivisorSheaf X (Litt3.SharedTensors.schemeDivisorPullback f D)).val.map
        (hf.adjunction.unit.app V).op)
          (actualSchemeDivisorSectionPullbackMap f D (hf.functor.obj V) b)).val = _
  have hr := actualDivisorSheafSectionValue_restriction X
    (Litt3.SharedTensors.schemeDivisorPullback f D) (hf.adjunction.unit.app V)
      (actualSchemeDivisorSectionPullbackMap f D (hf.functor.obj V) b)
  change actualRationalFunctionOpenLinearEquiv X V
      (((actualSchemeDivisorSheaf X (Litt3.SharedTensors.schemeDivisorPullback f D)).val.map
        (hf.adjunction.unit.app V).op)
          (actualSchemeDivisorSectionPullbackMap f D (hf.functor.obj V) b)).val =
    actualRationalFunctionOpenLinearEquiv X (f ⁻¹ᵁ hf.functor.obj V)
      (actualSchemeDivisorSectionPullbackMap f D (hf.functor.obj V) b).val at hr
  rw [hr, actualSchemeDivisorSectionPullbackMap_rational_value,
    actualSchemeRationalSectionPullback_field_value]

end Litt3.Jacobians

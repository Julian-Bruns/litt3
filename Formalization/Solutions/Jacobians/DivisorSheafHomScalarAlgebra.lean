import Solutions.Jacobians.DivisorSheafHomScalars

open CategoryTheory Opposite AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  (X : Scheme.{u}) [IsIntegral X] [ClosedPointDVRStalks X]
  (D E F : Divisor (Litt3.SharedTensors.ClosedPoint X))
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]

include sX in
/-- Composition of TRUE global divisor-sheaf morphisms is literal
multiplication of their derived ORIGINAL rational scalars. -/
theorem actualDivisorSheafHomScalar_compose
    (h : actualSchemeDivisorSheaf X D ⟶ actualSchemeDivisorSheaf X E)
    (g : actualSchemeDivisorSheaf X E ⟶ actualSchemeDivisorSheaf X F) :
    actualDivisorSheafHomScalar X D F (h ≫ g) =
      actualDivisorSheafHomScalar X E F g * actualDivisorSheafHomScalar X D E h := by
  let W := actualDivisorSupportComplement X D
  letI : Nonempty W := ⟨⟨genericPoint X, actualDivisorSupportComplement_generic X D⟩⟩
  exact actualDivisorSheafHomScalar_on_open X E F sX g W
    ((h.val.app (op W)) (actualDivisorSheafZeroOpenUnitSection X D W
      (actualDivisorSupportComplement_coefficient X D)))

/-- The identity on an ACTUAL divisor SHEAF has the ORIGINAL unit
rational scalar. -/
theorem actualDivisorSheafHomScalar_identity :
    actualDivisorSheafHomScalar X D D (𝟙 (actualSchemeDivisorSheaf X D)) = 1 := by
  let W := actualDivisorSupportComplement X D
  have hg : genericPoint X ∈ W := actualDivisorSupportComplement_generic X D
  letI : Nonempty W := ⟨⟨genericPoint X, hg⟩⟩
  change (actualSchemeRationalFunctionOpenIso X W).hom.hom
    (actualDivisorSheafZeroOpenUnitSection X D W
      (actualDivisorSupportComplement_coefficient X D)).val = 1
  rw [← actualRationalFunctionEvaluation_eq_open X W (genericPoint X) hg]
  exact actualDivisorSheafZeroOpenUnitSection_value X D W
    (actualDivisorSupportComplement_coefficient X D) (genericPoint X) hg

include sX in
/-- An ACTUAL global divisor-sheaf isomorphism has a NONZERO
original rational multiplier, derived from its actual inverse. -/
theorem actualDivisorSheafIsoScalar_ne_zero
    (e : actualSchemeDivisorSheaf X D ≅ actualSchemeDivisorSheaf X E) :
    actualDivisorSheafHomScalar X D E e.hom ≠ 0 := by
  have h := actualDivisorSheafHomScalar_compose X D E D sX e.hom e.inv
  rw [e.hom_inv_id, actualDivisorSheafHomScalar_identity] at h
  intro hz
  rw [hz, mul_zero] at h
  exact one_ne_zero h

/-- The ACTUAL nonzero rational multiplier of a genuine global
divisor-sheaf isomorphism, as a unit of the ORIGINAL function field. -/
noncomputable def actualDivisorSheafIsoRationalUnit
    (e : actualSchemeDivisorSheaf X D ≅ actualSchemeDivisorSheaf X E) : X.functionFieldˣ :=
  Units.mk0 (actualDivisorSheafHomScalar X D E e.hom)
    (actualDivisorSheafIsoScalar_ne_zero X D E sX e)

end Litt3.Jacobians

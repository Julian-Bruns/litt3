import Solutions.Jacobians.DivisorSheafHomScalarAlgebra

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u}) [IsIntegral X] [ClosedPointDVRStalks X]
  (D E : Divisor (Litt3.SharedTensors.ClosedPoint X))

/-- The TRUE zero SHEAF morphism has the original zero scalar. -/
theorem actualDivisorSheafHomScalar_zero :
    actualDivisorSheafHomScalar X D E
      (0 : actualSchemeDivisorSheaf X D ⟶ actualSchemeDivisorSheaf X E) = 0 := by
  let W := actualDivisorSupportComplement X D
  letI : Nonempty W := ⟨⟨genericPoint X, actualDivisorSupportComplement_generic X D⟩⟩
  change (actualSchemeRationalFunctionOpenIso X W).hom.hom 0 = 0
  exact map_zero _

/-- Addition of TRUE global SHEAF morphisms adds their derived
ORIGINAL rational scalars. -/
theorem actualDivisorSheafHomScalar_add
    (h g : actualSchemeDivisorSheaf X D ⟶ actualSchemeDivisorSheaf X E) :
    actualDivisorSheafHomScalar X D E (h + g) =
      actualDivisorSheafHomScalar X D E h + actualDivisorSheafHomScalar X D E g := by
  let W := actualDivisorSupportComplement X D
  letI : Nonempty W := ⟨⟨genericPoint X, actualDivisorSupportComplement_generic X D⟩⟩
  let a := actualDivisorSheafZeroOpenUnitSection X D W
    (actualDivisorSupportComplement_coefficient X D)
  change (actualSchemeRationalFunctionOpenIso X W).hom.hom
      (((h.val.app (op W)) a).val + ((g.val.app (op W)) a).val) = _
  exact map_add _ _ _

variable {k : Type u} [Field k] [IsAlgClosed k]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]

include sX in
/-- The original rational scalar determines the ENTIRE TRUE
divisor-sheaf morphism, including every original open and the empty open.
Thus the actual morphism space embeds faithfully in the original field. -/
theorem actualDivisorSheafHomScalar_injective :
    Function.Injective (actualDivisorSheafHomScalar X D E) := by
  intro h g hfg
  apply SheafOfModules.hom_ext
  apply PresheafOfModules.hom_ext
  intro U
  apply ModuleCat.hom_ext
  apply DFunLike.ext
  intro a
  rcases isEmpty_or_nonempty U.unop with hEmpty | hNonempty
  · letI := hEmpty
    have hbot : U.unop = (⊥ : X.Opens) := by
      apply SetLike.ext'
      exact Set.eq_empty_iff_forall_notMem.mpr
        (fun x hx => hEmpty.false (⟨x, hx⟩ : U.unop))
    letI : Subsingleton ((actualSchemeRationalFunctionRingSheaf X).val.obj U) :=
      CommRingCat.subsingleton_of_isTerminal
        ((actualSchemeRationalFunctionRingSheaf X).isTerminalOfEqEmpty hbot)
    letI : Subsingleton ((actualSchemeRationalFunctionModuleSheaf X).val.obj U) :=
      inferInstanceAs (Subsingleton ((actualSchemeRationalFunctionRingSheaf X).val.obj U))
    apply Subtype.ext
    exact Subsingleton.elim _ _
  · letI := hNonempty
    apply Subtype.ext
    apply (actualSchemeRationalFunctionOpenIso X U.unop).commRingCatIsoToRingEquiv.injective
    change (actualSchemeRationalFunctionOpenIso X U.unop).hom.hom ((h.val.app U) a).val =
      (actualSchemeRationalFunctionOpenIso X U.unop).hom.hom ((g.val.app U) a).val
    rw [actualDivisorSheafHomScalar_on_open X D E sX h,
      actualDivisorSheafHomScalar_on_open X D E sX g, hfg]

end Litt3.Jacobians

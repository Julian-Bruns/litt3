import Solutions.Jacobians.DivisorSheafTrivialSectionGenerators

open CategoryTheory Opposite AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u}) [IsIntegral X] [ClosedPointDVRStalks X]
  (D : Divisor (Litt3.SharedTensors.ClosedPoint X))
  (e : actualSchemeDivisorSheaf X D ≅ SheafOfModules.unit X.ringCatSheaf)

/-- The ORIGINAL rational function obtained from the true inverse
image of the original GLOBAL unit section under a genuine divisor-sheaf
trivialization. No generic multiplier is assumed or chosen separately. -/
noncomputable def actualDivisorSheafGlobalGenerator : X.functionField :=
  actualRationalFunctionEvaluation X ⊤ (genericPoint X) trivial
    (actualDivisorSheafUnitGenerator X D e (op ⊤)).val

/-- The derived actual global rational function is the actual rational
value of EVERY restricted unit generator on EVERY nonempty original open. -/
theorem actualDivisorSheafGlobalGenerator_on_open
    (U : X.Opens) [Nonempty U] (x : X) (hx : x ∈ U) :
    actualRationalFunctionEvaluation X U x hx
      (actualDivisorSheafUnitGenerator X D e (op U)).val =
        actualDivisorSheafGlobalGenerator X D e := by
  letI : Nonempty (⊤ : X.Opens) := ⟨⟨genericPoint X, trivial⟩⟩
  let i : U ⟶ ⊤ := homOfLE le_top
  have hg := congrArg Subtype.val (actualDivisorSheafUnitGenerator_restriction X D e i.op)
  change (actualSchemeRationalFunctionRingSheaf X).val.map i.op
      (actualDivisorSheafUnitGenerator X D e (op ⊤)).val =
    (actualDivisorSheafUnitGenerator X D e (op U)).val at hg
  have h := RingHom.congr_fun (actualRationalFunctionEvaluation_restriction X i x hx)
    (actualDivisorSheafUnitGenerator X D e (op ⊤)).val
  change actualRationalFunctionEvaluation X U x hx
      ((actualSchemeRationalFunctionRingSheaf X).val.map i.op
        (actualDivisorSheafUnitGenerator X D e (op ⊤)).val) =
      actualRationalFunctionEvaluation X ⊤ x (i.le hx)
        (actualDivisorSheafUnitGenerator X D e (op ⊤)).val at h
  rw [hg, actualRationalFunctionEvaluation_eq_open] at h
  rw [actualRationalFunctionEvaluation_eq_open X ⊤ x (i.le hx)] at h
  rw [actualRationalFunctionEvaluation_eq_open X U x hx]
  change (actualSchemeRationalFunctionOpenIso X U).hom.hom
      (actualDivisorSheafUnitGenerator X D e (op U)).val =
    actualRationalFunctionEvaluation X ⊤ (genericPoint X) trivial
      (actualDivisorSheafUnitGenerator X D e (op ⊤)).val
  exact h.trans (congrArg
    (fun r => r (actualDivisorSheafUnitGenerator X D e (op ⊤)).val)
    (actualRationalFunctionEvaluation_eq_open X ⊤ (genericPoint X) trivial).symm)

/-- A true global sheaf trivialization produces a NONZERO original
rational function, using actual section-map and generic-map injectivity. -/
theorem actualDivisorSheafGlobalGenerator_ne_zero :
    actualDivisorSheafGlobalGenerator X D e ≠ 0 := by
  letI : Nonempty (⊤ : X.Opens) := ⟨⟨genericPoint X, trivial⟩⟩
  intro hf
  have hvalue : actualRationalFunctionOpenLinearEquiv X ⊤
      (actualDivisorSheafUnitGenerator X D e (op ⊤)).val = 0 := by
    simpa only [actualDivisorSheafGlobalGenerator, actualRationalFunctionEvaluation_eq_open]
      using hf
  have hz : (actualDivisorSheafUnitGenerator X D e (op ⊤)).val = 0 :=
    (actualRationalFunctionOpenLinearEquiv X ⊤).injective
      (hvalue.trans (map_zero _).symm)
  have hsection : actualDivisorSheafUnitGenerator X D e (op ⊤) = 0 := Subtype.ext hz
  have hone := congrArg (actualDivisorSheafTrivialSectionEquiv X D e (op ⊤)) hsection
  exact (one_ne_zero : (1 : Γ(X, ⊤)) ≠ 0)
    (by simpa [actualDivisorSheafUnitGenerator] using hone)

end Litt3.Jacobians

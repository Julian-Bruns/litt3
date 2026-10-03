import Solutions.SharedTensors.DifferentialTensorDivisorSheaves
import Solutions.SharedTensors.SchemeDivisorSections

open CategoryTheory Opposite AlgebraicGeometry

namespace Litt3.SharedTensors

open Litt3.Jacobians Litt3.QuotientGeometry

universe u

/-- The original structure morphism supplies the coefficient-field
action on genuine global sections of ANY original module sheaf. -/
noncomputable def actualOriginalModuleGlobalSectionsModule
    {k : Type u} [Field k] {X : Scheme.{u}}
    (sX : X ⟶ Spec (.of k)) (M : X.Modules) :
    Module k (M.val.obj (op (⊤ : X.Opens))) :=
  Module.compHom (M.val.obj (op (⊤ : X.Opens))) (chartBaseFieldHom sX ⊤)

variable {k : Type u} [Field k] {X : Scheme.{u}} [IsIntegral X]
  [ClosedPointDVRStalks X] [FinitePrincipalSupport X]
  (sX : X ⟶ Spec (.of k))

noncomputable local instance canonicalTensorTopNonempty : Nonempty (⊤ : X.Opens) :=
  ⟨⟨genericPoint X, trivial⟩⟩

/-- Genuine H0 of the whole ORIGINAL divisor sheaf is the actual
valuation-bounded rational-function space, with the ORIGINAL k action.
This needs neither smoothness, properness nor a dimension hypothesis. -/
noncomputable def actualOriginalDivisorGlobalSectionsEquiv
    (D : Divisor (ClosedPoint X)) :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := actualOriginalModuleGlobalSectionsModule sX (actualSchemeDivisorSheaf X D)
    (actualSchemeDivisorSheaf X D).val.obj (op (⊤ : X.Opens)) ≃ₗ[k]
      schemeDivisorSectionSpace sX D := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := actualOriginalModuleGlobalSectionsModule sX (actualSchemeDivisorSheaf X D)
  let e := actualRationalFunctionOpenLinearEquiv X (⊤ : X.Opens)
  let f : (actualSchemeDivisorSheaf X D).val.obj (op (⊤ : X.Opens)) →ₗ[k]
      schemeDivisorSectionSpace sX D :=
    { toFun := fun a => ⟨e a.val, by
        intro x
        have h := a.property x (by trivial)
        rw [actualRationalFunctionEvaluation_eq_open] at h
        exact h⟩
      map_add' := fun a b => Subtype.ext (e.map_add a.val b.val)
      map_smul' := by
        intro c a
        apply Subtype.ext
        change e (chartBaseFieldHom sX ⊤ c • a.val) = c • e a.val
        rw [e.map_smul]
        have hcoef := RingHom.congr_fun (chart_base_field_hom_generic_compatibility sX ⊤) c
        change algebraMap Γ(X, ⊤) X.functionField (chartBaseFieldHom sX ⊤ c) =
          algebraMap k X.functionField c at hcoef
        rw [Algebra.smul_def, hcoef, Algebra.smul_def] }
  apply LinearEquiv.ofBijective f
  constructor
  · intro a b h
    apply Subtype.ext
    exact e.injective (congrArg Subtype.val h)
  · intro b
    refine ⟨⟨e.symm b.val, ?_⟩, ?_⟩
    · intro x hx
      rw [actualRationalFunctionEvaluation_eq_open]
      change closedPointValuation X x (e (e.symm b.val)) ≤ WithZero.exp (D x)
      rw [e.apply_symm_apply]
      exact b.property x
    · exact Subtype.ext (e.apply_symm_apply b.val)

variable [IsAlgClosed k] [CompactSpace X] [IsSmoothOfRelativeDimension 1 sX]

/-- Every genuine canonical tensor H0 is the corresponding ORIGINAL
bounded rational-function space through the whole-sheaf isomorphism.
Every weight, including zero, retains actual sections and scalar action;
no cohomological genus, degree or common-tensor existence is inferred. -/
noncomputable def actualOriginalCanonicalTensorGlobalSectionsEquiv :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ (omega : KaehlerDifferential k X.functionField) (h : omega ≠ 0) (n : ℕ),
      letI := actual_smooth_curve_closed_point_dvr_stalks sX
      letI := actual_quasiCompact_smooth_curve_finite_principal_support sX
      let M := actualSchemeModuleTensorPower X (schemeDifferentialSheaf sX) n
      letI := actualOriginalModuleGlobalSectionsModule sX M
      M.val.obj (op (⊤ : X.Opens)) ≃ₗ[k]
        schemeDivisorSectionSpace sX (n • actualRationalDifferentialDivisor sX omega h) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega h n
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  letI := actual_quasiCompact_smooth_curve_finite_principal_support sX
  let M := actualSchemeModuleTensorPower X (schemeDifferentialSheaf sX) n
  let N := actualSmoothCurveDivisorSheaf sX (n • actualRationalDifferentialDivisor sX omega h)
  letI := actualOriginalModuleGlobalSectionsModule sX M
  letI := actualOriginalModuleGlobalSectionsModule sX N
  let e := ((SheafOfModules.evaluation X.ringCatSheaf (op (⊤ : X.Opens))).mapIso
    (actualDifferentialTensorDivisorSheafIso sX omega h n)).toLinearEquiv
  let eK : M.val.obj (op (⊤ : X.Opens)) ≃ₗ[k] N.val.obj (op (⊤ : X.Opens)) :=
    { toAddEquiv := e.toAddEquiv
      map_smul' := fun c a => e.map_smul (chartBaseFieldHom sX ⊤ c) a }
  exact eK.trans (actualOriginalDivisorGlobalSectionsEquiv sX
    (n • actualRationalDifferentialDivisor sX omega h))

end Litt3.SharedTensors

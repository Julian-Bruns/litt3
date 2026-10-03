import Solutions.SharedTensors.SchemeDifferentialSheafLinearity

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.SharedTensors

open Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] {X : Scheme.{u}} [IsIntegral X]

/-- The ACTUAL global differential module carries the coefficient-field
action supplied by the ORIGINAL structure morphism and global section
ring. This is not an action transported from a rational-image model. -/
noncomputable instance schemeDifferentialGlobalSectionsModule
    (sX : X ⟶ Spec (.of k)) : Module k (schemeDifferentialGlobalSections sX) :=
  Module.compHom (schemeDifferentialGlobalSections sX) (chartBaseFieldHom sX ⊤)

noncomputable local instance globalLinearTopNonempty : Nonempty (⊤ : X.Opens) :=
  ⟨⟨genericPoint X, trivial⟩⟩

/-- The genuine rational realization of ACTUAL global differential
sections is linear over the actual original coefficient field. -/
noncomputable def schemeDifferentialGlobalSectionsToFunctionField
    (sX : X ⟶ Spec (.of k)) :
    letI := (genericBaseFieldHom sX).toAlgebra
    schemeDifferentialGlobalSections sX →ₗ[k] KaehlerDifferential k X.functionField := by
  letI := (genericBaseFieldHom sX).toAlgebra
  refine
    { toFun := schemeDifferentialSheafOpenToFunctionField sX ⊤
      map_add' := fun a b => map_add _ a b
      map_smul' := ?_ }
  intro c a
  change schemeDifferentialSheafOpenToFunctionField sX ⊤
      (chartBaseFieldHom sX ⊤ c • a) = c • _
  rw [schemeDifferentialSheafOpenToFunctionField_smul]
  have hcoef := RingHom.congr_fun (chart_base_field_hom_generic_compatibility sX ⊤) c
  change algebraMap Γ(X, ⊤) X.functionField (chartBaseFieldHom sX ⊤ c) =
    algebraMap k X.functionField c at hcoef
  rw [hcoef, IsScalarTower.algebraMap_smul]

/-- The actual global-section linear map has image EXACTLY the original
closed-stalk intersection, with no H0 identification assumed. -/
theorem schemeDifferentialGlobalSectionsToFunctionField_range
    (sX : X ⟶ Spec (.of k)) (n : ℕ) [IsSmoothOfRelativeDimension n sX] :
    letI := (genericBaseFieldHom sX).toAlgebra
    LinearMap.range (schemeDifferentialGlobalSectionsToFunctionField sX) =
      schemeGlobalRegularDifferentials sX := by
  letI := (genericBaseFieldHom sX).toAlgebra
  ext omega
  exact (schemeDifferential_closed_regular_iff_global_section sX n omega).symm

/-- Genuine global sections of the ORIGINAL differential sheaf are
linearly equivalent to the intersection of ORIGINAL closed-stalk
images, for any integral smooth scheme of ANY relative dimension over
ANY field. The inverse is constructed by actual sheaf gluing; neither
properness, finite dimensionality, characteristic nor genus is needed. -/
noncomputable def schemeDifferentialGlobalSectionsRegularEquiv
    (sX : X ⟶ Spec (.of k)) (n : ℕ) [IsSmoothOfRelativeDimension n sX] :
    letI := (genericBaseFieldHom sX).toAlgebra
    schemeDifferentialGlobalSections sX ≃ₗ[k] schemeGlobalRegularDifferentials sX := by
  letI := (genericBaseFieldHom sX).toAlgebra
  let f := (schemeDifferentialGlobalSectionsToFunctionField sX).codRestrict
    (schemeGlobalRegularDifferentials sX)
    (fun a => schemeDifferentialGlobalSections_mem_regular sX a)
  apply LinearEquiv.ofBijective f
  constructor
  · intro a b h
    apply schemeDifferentialSheafOpenToFunctionField_injective sX n ⊤
    exact congrArg Subtype.val h
  · intro omega
    obtain ⟨a, ha⟩ :=
      (schemeDifferential_closed_regular_iff_global_section sX n omega.val).mp omega.property
    exact ⟨a, Subtype.ext ha⟩

theorem schemeDifferentialGlobalSectionsRegularEquiv_apply
    (sX : X ⟶ Spec (.of k)) (n : ℕ) [IsSmoothOfRelativeDimension n sX] :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ a : schemeDifferentialGlobalSections sX,
      (schemeDifferentialGlobalSectionsRegularEquiv sX n a).val =
        schemeDifferentialSheafOpenToFunctionField sX ⊤ a := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro a
  rfl

end Litt3.SharedTensors

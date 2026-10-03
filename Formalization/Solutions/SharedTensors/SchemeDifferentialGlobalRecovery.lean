import Solutions.SharedTensors.SchemeDifferentialLocalLifts
import Mathlib.Topology.Sheaves.SheafCondition.UniqueGluing

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.SharedTensors

open Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] {X : Scheme.{u}} [IsIntegral X]

noncomputable local instance topNonempty : Nonempty (⊤ : X.Opens) :=
  ⟨⟨genericPoint X, trivial⟩⟩

/-- A form in every ORIGINAL stalk image is exactly a genuine global
section of the ORIGINAL associated differential SHEAF. Local lifts and
the actual sheaf gluing construct the global section; rational-image
injectivity proves compatibility. No H0 identification is an input. -/
theorem schemeDifferential_regular_everywhere_iff_global_section
    (sX : X ⟶ Spec (.of k)) (n : ℕ) [IsSmoothOfRelativeDimension n sX] :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ omega : KaehlerDifferential k X.functionField,
      (∀ x : X, omega ∈ schemeLocalRegularDifferentials sX x) ↔
      ∃ a : schemeDifferentialGlobalSections sX,
        schemeDifferentialSheafOpenToFunctionField sX ⊤ a = omega := by
  classical
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega
  constructor
  · intro regular
    choose U hx a ha using fun x : X =>
      schemeLocalRegularDifferential_open_lift sX x omega (regular x)
    letI : ∀ x : X, Nonempty (U x) := fun x => ⟨⟨x, hx x⟩⟩
    let F : TopCat.Sheaf AddCommGrpCat X :=
      ⟨(schemeDifferentialSheaf sX).val.presheaf, (schemeDifferentialSheaf sX).isSheaf⟩
    let b (x : X) : F.val.obj (Opposite.op (U x)) :=
      (CategoryTheory.toSheafify (Opens.grothendieckTopology X)
        (schemeDifferentialPresheaf sX).presheaf).app (Opposite.op (U x)) (a x)
    have hfield : ∀ x, schemeDifferentialSheafOpenToFunctionField sX (U x) (b x) = omega := by
      intro x
      exact (congrArg (fun f => f.hom (a x))
        (schemeDifferentialSheafOpenToFunctionField_presheaf sX (U x))).trans (ha x)
    have compatible : TopCat.Presheaf.IsCompatible F.val U b := by
      intro i j
      have hi : genericPoint X ∈ U i :=
        ((genericPoint_spec X).mem_open_set_iff (U i).isOpen).mpr
          (by simpa using (inferInstance : Nonempty (U i)))
      have hj : genericPoint X ∈ U j :=
        ((genericPoint_spec X).mem_open_set_iff (U j).isOpen).mpr
          (by simpa using (inferInstance : Nonempty (U j)))
      letI : Nonempty (U i ⊓ U j : X.Opens) := ⟨⟨genericPoint X, ⟨hi, hj⟩⟩⟩
      apply schemeDifferentialSheafOpenToFunctionField_injective sX n (U i ⊓ U j)
      have hleft := congrArg (fun f => f.hom (b i))
        (schemeDifferentialSheafOpenToFunctionField_restriction sX
          (homOfLE (inf_le_left : U i ⊓ U j ≤ U i)))
      have hright := congrArg (fun f => f.hom (b j))
        (schemeDifferentialSheafOpenToFunctionField_restriction sX
          (homOfLE (inf_le_right : U i ⊓ U j ≤ U j)))
      exact hleft.trans ((hfield i).trans ((hfield j).symm.trans hright.symm))
    have cover : (⊤ : X.Opens) ≤ iSup U := by
      intro x _
      exact Opens.mem_iSup.mpr ⟨x, hx x⟩
    obtain ⟨aGlobal, hGlobal, _⟩ := F.existsUnique_gluing' U ⊤
      (fun _ => homOfLE le_top) cover b compatible
    let x : X := genericPoint X
    have h := congrArg (fun f => f.hom aGlobal)
      (schemeDifferentialSheafOpenToFunctionField_restriction sX
        (homOfLE (le_top : U x ≤ ⊤)))
    change schemeDifferentialSheafOpenToFunctionField sX (U x)
      (F.val.map (homOfLE le_top).op aGlobal) =
        schemeDifferentialSheafOpenToFunctionField sX ⊤ aGlobal at h
    rw [hGlobal x, hfield x] at h
    exact ⟨aGlobal, h.symm⟩
  · rintro ⟨a, ha⟩ x
    rw [← ha]
    exact schemeDifferentialSheafOpenToFunctionField_mem_local sX ⊤ ⟨x, trivial⟩ a

/-- The genuine rational realization of ORIGINAL global differential
sections has exact image the intersection of ALL original stalk images. -/
theorem schemeDifferentialGlobalSections_range_all_stalks
    (sX : X ⟶ Spec (.of k)) (n : ℕ) [IsSmoothOfRelativeDimension n sX] :
    letI := (genericBaseFieldHom sX).toAlgebra
    Set.range (schemeDifferentialSheafOpenToFunctionField sX ⊤) =
      {omega | ∀ x : X, omega ∈ schemeLocalRegularDifferentials sX x} := by
  letI := (genericBaseFieldHom sX).toAlgebra
  ext omega
  exact (schemeDifferential_regular_everywhere_iff_global_section sX n omega).symm

end Litt3.SharedTensors

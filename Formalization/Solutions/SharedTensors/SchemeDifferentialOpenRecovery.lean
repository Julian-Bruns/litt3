import Solutions.SharedTensors.SchemeDifferentialClosedRecovery

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.SharedTensors

open Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] {X : Scheme.{u}} [IsIntegral X]

/-- Original closed-point regularity detects ALL original point-stalk
images on EVERY open, not just the global sections. -/
theorem schemeDifferential_closed_regular_on_open_iff_all_stalks
    (sX : X ⟶ Spec (.of k)) [JacobsonSpace X] (U : X.Opens) :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ omega : KaehlerDifferential k X.functionField,
      (∀ x : ClosedPoint X, x.val ∈ U → omega ∈ schemeLocalRegularDifferentials sX x.val) ↔
        ∀ x : X, x ∈ U → omega ∈ schemeLocalRegularDifferentials sX x := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega
  constructor
  · intro hclosed x hx
    by_contra hn
    have hopen := schemeDifferential_regular_locus_isOpen sX omega
    obtain ⟨y, hy, hyclosed⟩ := nonempty_inter_closedPoints
      (show ((U : Set X) ∩ {z : X | omega ∈ schemeLocalRegularDifferentials sX z}ᶜ).Nonempty
        from ⟨x, hx, hn⟩)
      (U.isOpen.isLocallyClosed.inter hopen.isClosed_compl.isLocallyClosed)
    exact hy.2 (hclosed ⟨y, hyclosed⟩ hy.1)
  · intro h x hx
    exact h x.val hx

/-- Every form regular in the ORIGINAL point-stalks of an open is the
rational realization of an ORIGINAL differential SHEAF section there.
Actual local representatives and genuine sheaf gluing prove surjectivity. -/
theorem schemeDifferential_regular_on_open_iff_section
    (sX : X ⟶ Spec (.of k)) (n : ℕ) [IsSmoothOfRelativeDimension n sX]
    (U : X.Opens) [Nonempty U] :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ omega : KaehlerDifferential k X.functionField,
      (∀ x : X, x ∈ U → omega ∈ schemeLocalRegularDifferentials sX x) ↔
      ∃ a : (schemeDifferentialSheaf sX).val.obj (Opposite.op U),
        schemeDifferentialSheafOpenToFunctionField sX U a = omega := by
  classical
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega
  constructor
  · intro regular
    choose V hx a ha using fun x : U =>
      schemeLocalRegularDifferential_open_lift sX x.val omega (regular x.val x.property)
    let W (x : U) : X.Opens := U ⊓ V x
    letI : ∀ x : U, Nonempty (V x) := fun x => ⟨⟨x.val, hx x⟩⟩
    letI : ∀ x : U, Nonempty (W x) := fun x => ⟨⟨x.val, x.property, hx x⟩⟩
    let F : TopCat.Sheaf AddCommGrpCat X :=
      ⟨(schemeDifferentialSheaf sX).val.presheaf, (schemeDifferentialSheaf sX).isSheaf⟩
    let c (x : U) : F.val.obj (Opposite.op (V x)) :=
      (CategoryTheory.toSheafify (Opens.grothendieckTopology X)
        (schemeDifferentialPresheaf sX).presheaf).app (Opposite.op (V x)) (a x)
    let b (x : U) : F.val.obj (Opposite.op (W x)) :=
      F.val.map (homOfLE (show W x ≤ V x from inf_le_right)).op (c x)
    have hc : ∀ x, schemeDifferentialSheafOpenToFunctionField sX (V x) (c x) = omega := by
      intro x
      exact (congrArg (fun f => f.hom (a x))
        (schemeDifferentialSheafOpenToFunctionField_presheaf sX (V x))).trans (ha x)
    have hb : ∀ x, schemeDifferentialSheafOpenToFunctionField sX (W x) (b x) = omega := by
      intro x
      exact (congrArg (fun f => f.hom (c x))
        (schemeDifferentialSheafOpenToFunctionField_restriction sX
          (homOfLE (show W x ≤ V x from inf_le_right)))).trans (hc x)
    have compatible : TopCat.Presheaf.IsCompatible F.val W b := by
      intro i j
      have hi : genericPoint X ∈ W i :=
        ((genericPoint_spec X).mem_open_set_iff (W i).isOpen).mpr
          (by simpa using (inferInstance : Nonempty (W i)))
      have hj : genericPoint X ∈ W j :=
        ((genericPoint_spec X).mem_open_set_iff (W j).isOpen).mpr
          (by simpa using (inferInstance : Nonempty (W j)))
      letI : Nonempty (W i ⊓ W j : X.Opens) := ⟨⟨genericPoint X, hi, hj⟩⟩
      apply schemeDifferentialSheafOpenToFunctionField_injective sX n (W i ⊓ W j)
      have hleft := congrArg (fun f => f.hom (b i))
        (schemeDifferentialSheafOpenToFunctionField_restriction sX
          (homOfLE (inf_le_left : W i ⊓ W j ≤ W i)))
      have hright := congrArg (fun f => f.hom (b j))
        (schemeDifferentialSheafOpenToFunctionField_restriction sX
          (homOfLE (inf_le_right : W i ⊓ W j ≤ W j)))
      exact hleft.trans ((hb i).trans ((hb j).symm.trans hright.symm))
    have cover : U ≤ iSup W := by
      intro x hU
      exact Opens.mem_iSup.mpr ⟨⟨x, hU⟩, hU, hx ⟨x, hU⟩⟩
    obtain ⟨aU, hU, _⟩ := F.existsUnique_gluing' W U
      (fun _ => homOfLE inf_le_left) cover b compatible
    let x : U := Classical.arbitrary U
    have h := congrArg (fun f => f.hom aU)
      (schemeDifferentialSheafOpenToFunctionField_restriction sX
        (homOfLE (show W x ≤ U from inf_le_left)))
    change schemeDifferentialSheafOpenToFunctionField sX (W x)
      (F.val.map (homOfLE inf_le_left).op aU) =
        schemeDifferentialSheafOpenToFunctionField sX U aU at h
    rw [hU x, hb x] at h
    exact ⟨aU, h.symm⟩
  · rintro ⟨a, ha⟩ x hx
    rw [← ha]
    exact schemeDifferentialSheafOpenToFunctionField_mem_local sX U ⟨x, hx⟩ a

/-- The genuine original differential SHEAF is recovered on every
nonempty open by its actual ORIGINAL closed-stalk regularity bounds. -/
theorem schemeDifferential_closed_regular_on_open_iff_section
    (sX : X ⟶ Spec (.of k)) (n : ℕ) [IsSmoothOfRelativeDimension n sX]
    (U : X.Opens) [Nonempty U] :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ omega : KaehlerDifferential k X.functionField,
      (∀ x : ClosedPoint X, x.val ∈ U → omega ∈ schemeLocalRegularDifferentials sX x.val) ↔
      ∃ a : (schemeDifferentialSheaf sX).val.obj (Opposite.op U),
        schemeDifferentialSheafOpenToFunctionField sX U a = omega := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI : IsSmooth sX := IsSmoothOfRelativeDimension.isSmooth n sX
  letI : JacobsonSpace X := LocallyOfFiniteType.jacobsonSpace sX
  intro omega
  exact (schemeDifferential_closed_regular_on_open_iff_all_stalks sX U omega).trans
    (schemeDifferential_regular_on_open_iff_section sX n U omega)

end Litt3.SharedTensors

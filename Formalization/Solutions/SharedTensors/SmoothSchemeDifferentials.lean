import Solutions.SharedTensors.SmoothFractionDifferentials
import Solutions.QuotientGeometry.SchemeBaseFields
import Mathlib.AlgebraicGeometry.Morphisms.Smooth

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.SharedTensors

open Litt3.QuotientGeometry
universe u

variable {k : Type u} [Field k] {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k))

/-- At the actual generic point, a smooth morphism of fixed relative
dimension supplies a genuine standard smooth affine chart over k. -/
theorem actual_smooth_generic_chart (n : ℕ) [IsSmoothOfRelativeDimension n sX] :
    ∃ U : X.Opens, IsAffineOpen U ∧ genericPoint X ∈ U ∧
      RingHom.IsStandardSmoothOfRelativeDimension n (chartBaseFieldHom sX U) := by
  obtain ⟨⟨V, hV⟩, ⟨U, hU⟩, hx, e, hs⟩ :=
    IsSmoothOfRelativeDimension.exists_isStandardSmoothOfRelativeDimension
      (n := n) (f := sX) (genericPoint X)
  have hVtop : V = ⊤ := by
    ext y
    constructor
    · intro _
      trivial
    · intro _
      have hy : y = sX (genericPoint X) := Subsingleton.elim _ _
      simpa only [hy] using e hx
  subst V
  refine ⟨U, hU, hx, ?_⟩
  change RingHom.IsStandardSmoothOfRelativeDimension n
    (((Scheme.ΓSpecIso (.of k)).inv ≫ sX.appLE ⊤ U le_top).hom)
  rw [CommRingCat.hom_comp,
    RingHom.isStandardSmoothOfRelativeDimension_respectsIso.cancel_left_isIso]
  exact hs

/-- The relative dimension is proved for the actual rational universal
differential module of the actual smooth scheme, through its actual chart. -/
theorem actual_smooth_function_field_kaehler_rank (n : ℕ)
    [IsSmoothOfRelativeDimension n sX] :
    letI := (genericBaseFieldHom sX).toAlgebra
    Module.rank X.functionField (KaehlerDifferential k X.functionField) = n := by
  letI := (genericBaseFieldHom sX).toAlgebra
  obtain ⟨U, hU, hx, hs⟩ := actual_smooth_generic_chart sX n
  letI : Nonempty U := ⟨⟨genericPoint X, hx⟩⟩
  letI : Algebra k Γ(X, U) := (chartBaseFieldHom sX U).toAlgebra
  letI : IsScalarTower k Γ(X, U) X.functionField :=
    IsScalarTower.of_algebraMap_eq fun c =>
      (DFunLike.congr_fun (chart_base_field_hom_generic_compatibility sX U) c).symm
  letI : IsFractionRing Γ(X, U) X.functionField :=
    functionField_isFractionRing_of_isAffineOpen X U hU
  letI : Algebra.IsStandardSmoothOfRelativeDimension n k Γ(X, U) := hs
  exact smooth_fraction_field_kaehler_rank (R := Γ(X, U)) n

theorem actual_smooth_function_field_kaehler_finrank (n : ℕ)
    [IsSmoothOfRelativeDimension n sX] :
    letI := (genericBaseFieldHom sX).toAlgebra
    Module.finrank X.functionField (KaehlerDifferential k X.functionField) = n := by
  letI := (genericBaseFieldHom sX).toAlgebra
  exact Module.finrank_eq_of_rank_eq (actual_smooth_function_field_kaehler_rank sX n)

noncomputable def actualSmoothCurveKaehlerCoordinate
    [IsSmoothOfRelativeDimension 1 sX] :
    letI := (genericBaseFieldHom sX).toAlgebra
    KaehlerDifferential k X.functionField ≃ₗ[X.functionField] X.functionField := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI : Module.Finite X.functionField (KaehlerDifferential k X.functionField) :=
    Module.finite_of_rank_eq_nat (actual_smooth_function_field_kaehler_rank sX 1)
  exact LinearEquiv.ofFinrankEq (KaehlerDifferential k X.functionField) X.functionField
    (by rw [actual_smooth_function_field_kaehler_finrank sX 1, Module.finrank_self])

end Litt3.SharedTensors

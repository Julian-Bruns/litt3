import Solutions.QuotientGeometry.SchemeBaseRingSections

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.QuotientGeometry

universe u

/-- The original affine-chart coordinate algebra has the ACTUAL open
generic stalk as its true fraction field through the chart's ORIGINAL
structure map, rather than a supplied or merely isomorphic algebra map. -/
theorem actual_affine_chart_generic_field_isFractionRing
    {X : Scheme.{u}} [IsIntegral X] (U : X.Opens)
    (hU : IsAffineOpen U) [Nonempty U] :
    letI := (genericBaseRingHom hU.isoSpec.hom).toAlgebra
    IsFractionRing Γ(X, U) U.toScheme.functionField := by
  letI : IsAffine U.toScheme := hU
  letI : Nonempty (⊤ : U.toScheme.Opens) := ⟨⟨genericPoint U.toScheme, trivial⟩⟩
  let B := Γ(U.toScheme, ⊤)
  letI : Algebra B U.toScheme.functionField :=
    (U.toScheme.germToFunctionField ⊤).hom.toAlgebra
  have hfrac : IsFractionRing B U.toScheme.functionField :=
    functionField_isFractionRing_of_isAffineOpen U.toScheme ⊤ (isAffineOpen_top _)
  let e : B ≃+* Γ(X, U) := U.topIso.commRingCatIsoToRingEquiv
  have htransport := (IsFractionRing.isFractionRing_iff_of_base_ringEquiv
    (S := U.toScheme.functionField) e).mp hfrac
  letI := (genericBaseRingHom hU.isoSpec.hom).toAlgebra
  change @IsFractionRing Γ(X, U) _ U.toScheme.functionField _
    (genericBaseRingHom hU.isoSpec.hom).toAlgebra
  rw [generic_base_ring_hom_original_affine_chart]
  exact htransport

end Litt3.QuotientGeometry

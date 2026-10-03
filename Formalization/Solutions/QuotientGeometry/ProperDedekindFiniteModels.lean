import Solutions.QuotientGeometry.FiniteSeparableNormalizationModels

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.QuotientGeometry

universe u

theorem scheme_separated_of_structure_over_ring
    {R : Type u} [CommRing R] {X : Scheme.{u}}
    (sX : X ⟶ Spec (.of R)) [IsSeparated sX] : X.IsSeparated := by
  haveI : IsSeparated (sX ≫ Limits.terminal.from (Spec (.of R))) := inferInstance
  constructor
  simpa using (inferInstance : IsSeparated (sX ≫ Limits.terminal.from (Spec (.of R))))

/-- The constructed equivalence of the normalization's actual generic
stalk with its actual field fixes EVERY element of the original base. -/
theorem actual_separable_normalization_generic_field_base
    {R K L : Type u} [CommRing R] [IsDomain R] [IsDedekindDomain R]
    [Field K] [Field L] [Algebra R K] [Algebra K L] [Algebra R L]
    [IsScalarTower R K L] [IsFractionRing R K]
    [FiniteDimensional K L] [Algebra.IsSeparable K L] :
    (actualSeparableNormalizationGenericFieldEquiv (R := R) (K := K) (L := L)).toRingHom.comp
        (genericBaseRingHom (Spec.map (CommRingCat.ofHom
          (algebraMap R (integralClosure R L))))) = algebraMap R L := by
  let C := integralClosure R L
  letI : Algebra C (Spec (.of C)).functionField :=
    (StructureSheaf.toStalk C (genericPoint (Spec (.of C)))).hom.toAlgebra
  letI : IsFractionRing C (Spec (.of C)).functionField :=
    functionField_isFractionRing_of_affine (.of C)
  letI : IsFractionRing C L :=
    IsIntegralClosure.isFractionRing_of_finite_extension R K L C
  ext r
  rw [RingHom.comp_apply, generic_base_ring_hom_affine_structure]
  change IsFractionRing.ringEquivOfRingEquiv (RingEquiv.refl C)
    (algebraMap C (Spec (.of C)).functionField (algebraMap R C r)) = algebraMap R L r
  rw [IsFractionRing.ringEquivOfRingEquiv_algebraMap]
  exact (IsScalarTower.algebraMap_apply R C L r).symm

/-- A genuine proper integral model with valuation stalks is the actual
finite normalization once its ORIGINAL generic field is a finite
separable extension of the Dedekind base fraction field. Affineness and
normalization model identification are CONSTRUCTED, not assumed. -/
theorem actual_proper_valuation_scheme_over_dedekind_isFinite
    {R K : Type u} [CommRing R] [IsDomain R] [IsDedekindDomain R]
    [Field K] [Algebra R K] [IsFractionRing R K]
    {X : Scheme.{u}} [IsIntegral X]
    (sX : X ⟶ Spec (.of R)) [IsProper sX]
    [Algebra R X.functionField] [Algebra K X.functionField]
    [IsScalarTower R K X.functionField]
    [FiniteDimensional K X.functionField] [Algebra.IsSeparable K X.functionField]
    (hbase : algebraMap R X.functionField = genericBaseRingHom sX)
    (hvaluation : ∀ x : X, ValuationRing (X.presheaf.stalk x)) : IsFinite sX := by
  let C := integralClosure R X.functionField
  let N := Spec (.of C)
  let sN : N ⟶ Spec (.of R) := Spec.map (CommRingCat.ofHom (algebraMap R C))
  letI : IsFinite sN := actual_finite_separable_normalization_morphism (K := K)
  letI : IsProper sN := inferInstance
  letI : X.IsSeparated := scheme_separated_of_structure_over_ring sX
  let e : N.functionField ≃+* X.functionField :=
    actualSeparableNormalizationGenericFieldEquiv (R := R) (K := K)
  have he : GenericFieldMapOver sX sN e.toRingHom := by
    apply (generic_field_map_over_iff_base_ring sX sN e.toRingHom).mpr
    exact (actual_separable_normalization_generic_field_base (R := R) (K := K)).trans hbase
  obtain ⟨i, hi, -, -, -⟩ := proper_curve_function_field_equiv_realized
    sX sN e he hvaluation (actual_finite_separable_normalization_valuation_stalks (K := K))
  haveI : IsFinite (i.hom ≫ sN) := inferInstance
  rwa [hi] at this

end Litt3.QuotientGeometry

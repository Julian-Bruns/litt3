import Solutions.QuotientGeometry.ProperCurveIsomorphisms
import Solutions.QuotientGeometry.SchemeBaseRings
import Solutions.Jacobians.DedekindSpec
import Mathlib.RingTheory.DedekindDomain.IntegralClosure

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.QuotientGeometry

universe u

variable {R K L : Type u} [CommRing R] [IsDomain R] [IsDedekindDomain R]
  [Field K] [Field L] [Algebra R K] [Algebra K L] [Algebra R L]
  [IsScalarTower R K L] [IsFractionRing R K]
  [FiniteDimensional K L] [Algebra.IsSeparable K L]

include K in
/-- A genuine finite SEPARABLE field extension gives an actual finite
normalization Scheme over ANY original Dedekind base. No Galoisness,
constant-field perfection, explicit basis or normalization finiteness is
supplied. -/
theorem actual_finite_separable_normalization_morphism :
    IsFinite (Spec.map (CommRingCat.ofHom (algebraMap R (integralClosure R L)))) := by
  letI : Module.Finite R (integralClosure R L) :=
    IsIntegralClosure.finite R K L (integralClosure R L)
  apply (IsFinite.SpecMap_iff _).mpr
  exact RingHom.finite_algebraMap.mpr inferInstance

include K in
theorem actual_finite_separable_normalization_dedekind :
    IsDedekindDomain (integralClosure R L) := integralClosure.isDedekindDomain R K L

include K in
/-- ALL true normalization stalks, including the generic point, are
actual valuation rings, derived from the finite separable field data. -/
theorem actual_finite_separable_normalization_valuation_stalks
    (x : Spec (.of (integralClosure R L))) :
    ValuationRing ((Spec (.of (integralClosure R L))).presheaf.stalk x) := by
  letI : IsDedekindDomain (integralClosure R L) :=
    actual_finite_separable_normalization_dedekind (K := K)
  letI : IsDedekindDomain Γ(Spec (.of (integralClosure R L)), ⊤) :=
    Litt3.Jacobians.dedekind_spec_global_sections (integralClosure R L)
  exact Litt3.Jacobians.dedekind_chart_stalk_valuation_ring
    (isAffineOpen_top _) ⟨x, trivial⟩

include K in
/-- The ACTUAL generic stalk of the original normalization Spec is
identified with the TRUE finite extension field. -/
noncomputable def actualSeparableNormalizationGenericFieldEquiv :
    let C := integralClosure R L;
    letI : Algebra C (Spec (.of C)).functionField :=
      (StructureSheaf.toStalk C (genericPoint (Spec (.of C)))).hom.toAlgebra;
    (Spec (.of C)).functionField ≃+* L := by
  let C := integralClosure R L
  letI : Algebra C (Spec (.of C)).functionField :=
    (StructureSheaf.toStalk C (genericPoint (Spec (.of C)))).hom.toAlgebra
  letI : IsFractionRing C (Spec (.of C)).functionField :=
    functionField_isFractionRing_of_affine (.of C)
  letI : IsFractionRing C L :=
    IsIntegralClosure.isFractionRing_of_finite_extension R K L C
  exact IsFractionRing.ringEquivOfRingEquiv (RingEquiv.refl C)

end Litt3.QuotientGeometry

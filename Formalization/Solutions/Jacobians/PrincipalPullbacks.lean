import Definitions.Jacobians.PrincipalPullbacks
import Definitions.SharedTensors.DivisorRelations
import Solutions.Jacobians.UnramifiedDVRPullbacks
import Solutions.Jacobians.ValuationDivisorClasses
import Mathlib.GroupTheory.QuotientGroup.Basic

namespace Litt3.Jacobians

open scoped WithZero

theorem valuation_order_pullback_of_valuation_compatibility
    {K L : Type*} [Field K] [Field L]
    (v : Valuation K ℤᵐ⁰) (w : Valuation L ℤᵐ⁰) (φ : K →+* L)
    (hvaluation : ∀ x : K, w (φ x) = v x) (f : Additive Kˣ) :
    valuationOrder w (rationalUnitPullback φ f) = valuationOrder v f := by
  have hunit : Units.map w.toMonoidWithZeroHom.toMonoidHom
      (Units.map φ.toMonoidHom f.toMul) =
      Units.map v.toMonoidWithZeroHom.toMonoidHom f.toMul :=
    Units.ext (hvaluation f.toMul.val)
  change -Multiplicative.toAdd
      ((WithZero.unitsWithZeroEquiv : (ℤᵐ⁰)ˣ ≃* Multiplicative ℤ)
        (Units.map w.toMonoidWithZeroHom.toMonoidHom (Units.map φ.toMonoidHom f.toMul))) =
    -Multiplicative.toAdd
      ((WithZero.unitsWithZeroEquiv : (ℤᵐ⁰)ˣ ≃* Multiplicative ℤ)
        (Units.map v.toMonoidWithZeroHom.toMonoidHom f.toMul))
  rw [hunit]

theorem unramified_dvr_integer_order_preserved
    {R S K L : Type*} [CommRing R] [IsDomain R] [IsDiscreteValuationRing R]
    [CommRing S] [IsDomain S] [IsDiscreteValuationRing S] [Algebra R S]
    [IsLocalHom (algebraMap R S)] [Algebra.EssFiniteType R S]
    [Algebra.FormallyUnramified R S]
    [Field K] [Field L] [Algebra R K] [IsFractionRing R K]
    [Algebra S L] [IsFractionRing S L] [Algebra R L] [IsScalarTower R S L]
    (φ : K →+* L) (hφ : ∀ a : R, φ (algebraMap R K a) = algebraMap R L a)
    (f : Additive Kˣ) :
    valuationOrder ((discreteValuationPlace S).valuation L) (rationalUnitPullback φ f) =
      valuationOrder ((discreteValuationPlace R).valuation K) f := by
  apply valuation_order_pullback_of_valuation_compatibility
  exact unramified_dvr_fraction_field_valuation_preserved φ hφ

/-- Coefficientwise valuation compatibility gives the actual
principal-divisor pullback, with finite fibers ensuring finite support.
The preceding DVR theorem proves compatibility from unramified local maps. -/
theorem principal_divisor_pullback
    {K L I J : Type*} [Field K] [Field L]
    (v : ValuationDivisorSystem K I) (w : ValuationDivisorSystem L J)
    (π : J → I) (hπ : ∀ s : Set I, s.Finite → (π ⁻¹' s).Finite)
    (φ : K →+* L) (hvaluation : ∀ j : J, ∀ x : K, w.valuation j (φ x) = v.valuation (π j) x)
    (f : Additive Kˣ) :
    principalDivisorMap w (rationalUnitPullback φ f) =
      Litt3.SharedTensors.divisorPullback π hπ (principalDivisorMap v f) := by
  ext j
  simp only [Litt3.SharedTensors.divisorPullback_apply, principal_divisor_coefficient]
  exact valuation_order_pullback_of_valuation_compatibility _ _ φ (hvaluation j) f

noncomputable def divisorClassPullback
    {K L I J : Type*} [Field K] [Field L]
    (v : ValuationDivisorSystem K I) (w : ValuationDivisorSystem L J)
    (π : J → I) (hπ : ∀ s : Set I, s.Finite → (π ⁻¹' s).Finite)
    (φ : K →+* L) (hvaluation : ∀ j : J, ∀ x : K, w.valuation j (φ x) = v.valuation (π j) x) :
    DivisorClassGroup v →+ DivisorClassGroup w :=
  QuotientAddGroup.map (principalDivisors v) (principalDivisors w)
    (Litt3.SharedTensors.divisorPullback π hπ) (by
      rintro D ⟨f, rfl⟩
      exact ⟨rationalUnitPullback φ f, principal_divisor_pullback v w π hπ φ hvaluation f⟩)

theorem divisor_class_pullback_representative
    {K L I J : Type*} [Field K] [Field L]
    (v : ValuationDivisorSystem K I) (w : ValuationDivisorSystem L J)
    (π : J → I) (hπ : ∀ s : Set I, s.Finite → (π ⁻¹' s).Finite)
    (φ : K →+* L) (hvaluation : ∀ j : J, ∀ x : K, w.valuation j (φ x) = v.valuation (π j) x)
    (D : Divisor I) :
    divisorClassPullback v w π hπ φ hvaluation (divisorClassMap v D) =
      divisorClassMap w (Litt3.SharedTensors.divisorPullback π hπ D) := rfl

end Litt3.Jacobians

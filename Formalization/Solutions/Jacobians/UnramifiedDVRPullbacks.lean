import Definitions.Jacobians.DedekindDivisors
import Definitions.Jacobians.DVRDivisors
import Mathlib.RingTheory.DiscreteValuationRing.Basic
import Mathlib.RingTheory.Unramified.LocalRing
import Mathlib.Tactic

namespace Litt3.Jacobians

open IsLocalRing

/-- A local unramified map of actual DVRs carries a uniformizer to a
uniformizer. The map of maximal ideals is proved by formal unramifiedness. -/
theorem unramified_dvr_map_irreducible
    {R S : Type*} [CommRing R] [IsDomain R] [IsDiscreteValuationRing R]
    [CommRing S] [IsDomain S] [IsDiscreteValuationRing S] [Algebra R S]
    [IsLocalHom (algebraMap R S)] [Algebra.EssFiniteType R S]
    [Algebra.FormallyUnramified R S]
    (π : R) (hπ : Irreducible π) : Irreducible (algebraMap R S π) := by
  apply (IsDiscreteValuationRing.irreducible_iff_uniformizer _).mpr
  rw [← Algebra.FormallyUnramified.map_maximalIdeal (R := R) (S := S),
    (IsDiscreteValuationRing.irreducible_iff_uniformizer π).mp hπ,
    Ideal.map_span, Set.image_singleton]

theorem unramified_dvr_additive_order_preserved
    {R S : Type*} [CommRing R] [IsDomain R] [IsDiscreteValuationRing R]
    [CommRing S] [IsDomain S] [IsDiscreteValuationRing S] [Algebra R S]
    [IsLocalHom (algebraMap R S)] [Algebra.EssFiniteType R S]
    [Algebra.FormallyUnramified R S] (a : R) :
    IsDiscreteValuationRing.addVal S (algebraMap R S a) =
      IsDiscreteValuationRing.addVal R a := by
  by_cases ha : a = 0
  · simp [ha, IsDiscreteValuationRing.addVal_zero]
  obtain ⟨π, hπ⟩ := IsDiscreteValuationRing.exists_irreducible R
  obtain ⟨n, u, hau⟩ := IsDiscreteValuationRing.eq_unit_mul_pow_irreducible ha hπ
  have hπmap := unramified_dvr_map_irreducible (S := S) π hπ
  rw [IsDiscreteValuationRing.addVal_def a u hπ n hau]
  apply IsDiscreteValuationRing.addVal_def _ (u.map (algebraMap R S).toMonoidHom) hπmap n
  rw [hau, map_mul, map_pow]
  rfl

theorem dvr_unit_adic_value_one
    {R : Type*} [CommRing R] [IsDomain R] [IsDiscreteValuationRing R] (u : Rˣ) :
    (discreteValuationPlace R).intValuation u.val = 1 := by
  apply IsDedekindDomain.HeightOneSpectrum.intValuation_eq_one_iff.mpr
  exact notMem_maximalIdeal.mpr u.isUnit

theorem dvr_uniformizer_adic_value
    {R : Type*} [CommRing R] [IsDomain R] [IsDiscreteValuationRing R]
    (π : R) (hπ : Irreducible π) :
    (discreteValuationPlace R).intValuation π = WithZero.exp (-1 : ℤ) := by
  apply (discreteValuationPlace R).intValuation_singleton hπ.ne_zero
  exact (IsDiscreteValuationRing.irreducible_iff_uniformizer π).mp hπ

theorem unramified_dvr_adic_value_preserved
    {R S : Type*} [CommRing R] [IsDomain R] [IsDiscreteValuationRing R]
    [CommRing S] [IsDomain S] [IsDiscreteValuationRing S] [Algebra R S]
    [IsLocalHom (algebraMap R S)] [Algebra.EssFiniteType R S]
    [Algebra.FormallyUnramified R S] (a : R) :
    (discreteValuationPlace S).intValuation (algebraMap R S a) =
      (discreteValuationPlace R).intValuation a := by
  by_cases ha : a = 0
  · simp [ha]
  obtain ⟨π, hπ⟩ := IsDiscreteValuationRing.exists_irreducible R
  obtain ⟨n, u, hau⟩ := IsDiscreteValuationRing.eq_unit_mul_pow_irreducible ha hπ
  have hπmap := unramified_dvr_map_irreducible (S := S) π hπ
  have hunitS : (discreteValuationPlace S).intValuation (algebraMap R S u.val) = 1 :=
    dvr_unit_adic_value_one (u.map (algebraMap R S).toMonoidHom)
  rw [hau, map_mul, map_pow, map_mul, map_pow, hunitS,
    dvr_uniformizer_adic_value _ hπmap, map_mul, map_pow,
    dvr_unit_adic_value_one u, dvr_uniformizer_adic_value _ hπ]

theorem unramified_dvr_fraction_field_valuation_preserved
    {R S K L : Type*} [CommRing R] [IsDomain R] [IsDiscreteValuationRing R]
    [CommRing S] [IsDomain S] [IsDiscreteValuationRing S] [Algebra R S]
    [IsLocalHom (algebraMap R S)] [Algebra.EssFiniteType R S]
    [Algebra.FormallyUnramified R S]
    [Field K] [Field L] [Algebra R K] [IsFractionRing R K]
    [Algebra S L] [IsFractionRing S L] [Algebra R L] [IsScalarTower R S L]
    (φ : K →+* L) (hφ : ∀ a : R, φ (algebraMap R K a) = algebraMap R L a)
    (x : K) :
    (discreteValuationPlace S).valuation L (φ x) =
      (discreteValuationPlace R).valuation K x := by
  obtain ⟨a, b, _, rfl⟩ := IsFractionRing.div_surjective (A := R) x
  rw [map_div₀, hφ a, hφ b, IsScalarTower.algebraMap_apply R S L a,
    IsScalarTower.algebraMap_apply R S L b, map_div₀, map_div₀,
    IsDedekindDomain.HeightOneSpectrum.valuation_of_algebraMap,
    IsDedekindDomain.HeightOneSpectrum.valuation_of_algebraMap,
    IsDedekindDomain.HeightOneSpectrum.valuation_of_algebraMap,
    IsDedekindDomain.HeightOneSpectrum.valuation_of_algebraMap,
    unramified_dvr_adic_value_preserved, unramified_dvr_adic_value_preserved]

end Litt3.Jacobians

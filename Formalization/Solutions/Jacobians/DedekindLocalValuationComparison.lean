import Solutions.Jacobians.DedekindLocalValuationIntegers
import Solutions.Jacobians.NormalizedValuationUniqueness
import Definitions.Jacobians.DVRDivisors
import Mathlib.RingTheory.Valuation.Discrete.Basic

open IsDedekindDomain

namespace Litt3.Jacobians

variable {R S K : Type*} [CommRing R] [IsDedekindDomain R]
  [CommRing S] [IsDomain S] [IsDiscreteValuationRing S]
  [Field K] [Algebra R S] [Algebra R K] [Algebra S K]
  [IsScalarTower R S K] [IsFractionRing R K] [IsFractionRing S K]

/-- The ACTUAL normalized valuation of the original localized DVR
equals the ACTUAL normalized prime valuation of the original Dedekind
coordinate ring on the ENTIRE original fraction field. No ramification
factor or compatibility identity is assumed. -/
theorem actual_dedekind_prime_localization_normalized_valuation
    (v : HeightOneSpectrum R) [IsLocalization.AtPrime S v.asIdeal] :
    (discreteValuationPlace S).valuation K = v.valuation K := by
  have hglobal : (v.valuation K).Integers S :=
    actual_dedekind_prime_localization_valuation_integers v
  have hlocal : ((discreteValuationPlace S).valuation K).Integers S :=
    { hom_inj := IsFractionRing.injective S K
      map_le_one := fun s => (discreteValuationPlace S).valuation_le_one s
      exists_of_le_one := fun {x} hx => IsDiscreteValuationRing.exists_lift_of_le_one hx }
  apply normalized_integer_valuations_equal
    ((discreteValuationPlace S).valuation K) (v.valuation K)
  · apply Valuation.isEquiv_of_val_le_one
    intro x
    exact ⟨fun hx => by
      obtain ⟨s, rfl⟩ := hlocal.exists_of_le_one hx
      exact hglobal.map_le_one s,
      fun hx => by
      obtain ⟨s, rfl⟩ := hglobal.exists_of_le_one hx
      exact hlocal.map_le_one s⟩
  · exact (discreteValuationPlace S).valuation_exists_uniformizer K
  · exact v.valuation_exists_uniformizer K

end Litt3.Jacobians

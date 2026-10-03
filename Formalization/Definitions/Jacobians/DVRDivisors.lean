import Definitions.Jacobians.DedekindDivisors
import Mathlib.RingTheory.DiscreteValuationRing.Basic

namespace Litt3.Jacobians

noncomputable def discreteValuationPlace
    (R : Type*) [CommRing R] [IsDomain R] [IsDiscreteValuationRing R] :
    IsDedekindDomain.HeightOneSpectrum R where
  asIdeal := IsLocalRing.maximalIdeal R
  isPrime := inferInstance
  ne_bot := IsDiscreteValuationRing.not_a_field R

end Litt3.Jacobians

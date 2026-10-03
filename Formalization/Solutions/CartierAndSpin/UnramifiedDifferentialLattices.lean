import Solutions.CartierAndSpin.FormallyEtaleDifferentialCoordinates
import Solutions.CartierAndSpin.NormalizedDVRBoundary
import Solutions.Jacobians.UnramifiedDVRPullbacks

namespace Litt3.CartierAndSpin

open Litt3.Jacobians

theorem actual_dvr_fraction_image_iff_valuation_le_one
    {R F : Type*} [CommRing R] [IsDomain R] [IsDiscreteValuationRing R]
    [Field F] [Algebra R F] [IsFractionRing R F] (a : F) :
    a ∈ (algebraMap R F).range ↔
      (discreteValuationPlace R).valuation F a ≤ 1 := by
  have hv := dvr_height_one_valuation_integers (R := R) (K := F)
  constructor
  · rintro ⟨r, rfl⟩
    exact hv.map_le_one r
  · intro h
    exact hv.exists_of_le_one h

section Unramified

variable {k R S F E : Type*} [CommRing k]
  [CommRing R] [IsDomain R] [IsDiscreteValuationRing R]
  [CommRing S] [IsDomain S] [IsDiscreteValuationRing S]
  [Field F] [Field E]
  [Algebra k R] [Algebra k S] [Algebra k F] [Algebra k E]
  [Algebra R S] [Algebra R F] [Algebra R E] [Algebra S E] [Algebra F E]
  [IsFractionRing R F] [IsFractionRing S E]
  [IsScalarTower k R S] [IsScalarTower k R F] [IsScalarTower k R E]
  [IsScalarTower k S E] [IsScalarTower k F E]
  [IsScalarTower R S E] [IsScalarTower R F E]
  [IsLocalHom (algebraMap R S)] [Algebra.EssFiniteType R S]
  [Algebra.FormallyEtale R S]

/-- Actual local unramified DVR maps reflect membership in the
ORIGINAL coefficient ring. Valuation compatibility is derived from
the real map, not assumed. -/
theorem actual_unramified_fraction_image_iff (a : F) :
    algebraMap F E a ∈ (algebraMap S E).range ↔ a ∈ (algebraMap R F).range := by
  rw [actual_dvr_fraction_image_iff_valuation_le_one,
    actual_dvr_fraction_image_iff_valuation_le_one]
  rw [unramified_dvr_fraction_field_valuation_preserved
    (algebraMap F E) (fun r => (IsScalarTower.algebraMap_apply R F E r).symm)]

/-- The actual universal differential pullback reflects and preserves
membership in BOTH original regular differential images. Everything
is over the real DVRs and fraction fields; no completed-lattice or
polar-support equality is an input. -/
theorem actual_unramified_differential_image_iff
    (e : KaehlerDifferential k R ≃ₗ[R] R) (omega : KaehlerDifferential k F) :
    (∃ omegaS : KaehlerDifferential k S,
      KaehlerDifferential.map k k S E omegaS = KaehlerDifferential.map k k F E omega) ↔
    (∃ omegaR : KaehlerDifferential k R,
      KaehlerDifferential.map k k R F omegaR = omega) := by
  letI : Algebra.FormallyEtale R F :=
    Algebra.FormallyEtale.of_isLocalization (nonZeroDivisors R)
  letI : Algebra.FormallyEtale S E :=
    Algebra.FormallyEtale.of_isLocalization (nonZeroDivisors S)
  rw [formally_etale_differential_image_iff_coordinate
      (formallyEtaleDifferentialCoordinate (S := S) e),
    formally_etale_differential_image_iff_coordinate e,
    formally_etale_differential_coordinate_square]
  exact actual_unramified_fraction_image_iff _

end Unramified

end Litt3.CartierAndSpin

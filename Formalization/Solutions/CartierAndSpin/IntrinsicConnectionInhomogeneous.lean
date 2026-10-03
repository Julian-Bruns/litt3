import Solutions.CartierAndSpin.ConnectionInhomogeneousSolvability
import Solutions.CartierAndSpin.IntrinsicCartierRestrictedConnections

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {k K : Type*} [CommRing k] [Field K] [Algebra k K]
  {p : ℕ} [Fact p.Prime] [CharP K p]

/-- For a Cartier-fixed ORIGINAL rational form, the ENTIRE universal
differential equation dv-v*omega=eta has an actual field solution exactly
when the genuine original unit-twisted eta is Cartier-killed. The unit,
criterion and original differential identity are all constructed. -/
theorem p_basis_intrinsic_inhomogeneous_connection_criterion
    (C : RationalCartierOperator k K p) (b : PowerPBasis K p)
    (e : KaehlerDifferential k K ≃ₗ[K] K)
    (he : e (KaehlerDifferential.D k K b.parameter) = 1)
    (omega : KaehlerDifferential k K) (hfixed : C.toAddHom omega = omega) :
    ∃ u : Kˣ,
      KaehlerDifferential.D k K (u : K) = (u : K) • omega ∧
      ∀ eta : KaehlerDifferential k K,
        (∃ v : K, KaehlerDifferential.D k K v - v • omega = eta) ↔
          C.toAddHom ((u : K)⁻¹ • eta) = 0 := by
  let D := universalCoordinateDerivation e
  have hzero := (p_basis_intrinsic_cartier_fixed_iff_restricted_curvature_zero
    C b e he omega).mp hfixed
  obtain ⟨u, hDu, hsolv⟩ :=
    actual_zero_curvature_inhomogeneous_criterion_exists b D he (e omega) hzero
  refine ⟨u, ?_, ?_⟩
  · apply e.injective
    change D (u : K) = e ((u : K) • omega)
    rw [e.map_smul, smul_eq_mul, hDu, mul_comm]
  · intro eta
    have hcoordinate (v : K) :
        scalarDerivationConnection D (e omega) v =
          e (KaehlerDifferential.D k K v - v • omega) := by
      change e (KaehlerDifferential.D k K v) - e omega * v = _
      simpa only [map_smul, smul_eq_mul, mul_comm v (e omega)] using
        (map_sub e (KaehlerDifferential.D k K v) (v • omega)).symm
    have hsolutions :
        (∃ v : K, KaehlerDifferential.D k K v - v • omega = eta) ↔
          ∃ v : K, scalarDerivationConnection D (e omega) v = e eta := by
      constructor
      · rintro ⟨v, hv⟩
        exact ⟨v, (hcoordinate v).trans (congrArg e hv)⟩
      · rintro ⟨v, hv⟩
        exact ⟨v, e.injective ((hcoordinate v).symm.trans hv)⟩
    have hCartierCoordinate : e (C.toAddHom ((u : K)⁻¹ • eta)) =
        rationalCartierCoefficient K p b (e eta / (u : K)) := by
      rw [C.coordinate_formula b e he, e.map_smul, smul_eq_mul]
      rw [div_eq_mul_inv, mul_comm ((u : K)⁻¹) (e eta)]
    have hCartier : rationalCartierCoefficient K p b (e eta / (u : K)) = 0 ↔
        C.toAddHom ((u : K)⁻¹ • eta) = 0 := by
      constructor
      · intro h
        apply e.injective
        rw [hCartierCoordinate, h, map_zero]
      · intro h
        rw [← hCartierCoordinate, h, map_zero]
    exact (hsolutions.trans (hsolv (e eta))).trans hCartier

end Litt3.CartierAndSpin

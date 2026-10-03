import Solutions.SharedTensors.FrobeniusCoordinateTransport
import Solutions.SharedTensors.PBasisKaehler
import Solutions.SharedTensors.EtaleSymmetricTrace

namespace Litt3.SharedTensors

variable {k K L : Type*} [CommRing k] [Field K] [Field L]
  [Algebra k K] [Algebra k L]
variable {p : ℕ} [Fact p.Prime] [CharP K p] [CharP L p]

/-- Actual normalized field differentiation commutes with any inclusion
having compatible full p-bases. No algebraicity of the inclusion or
scalar action of K on L is needed in the statement. -/
theorem p_basis_derivative_transport
    (phi : K →+* L) (bK : PowerPBasis K p) (bL : PowerPBasis L p)
    (hb : bL.parameter = phi bK.parameter)
    (eK : KaehlerDifferential k K ≃ₗ[K] K)
    (heK : eK (KaehlerDifferential.D k K bK.parameter) = 1)
    (DL : Derivation k L L) (hDL : DL bL.parameter = 1) (f : K) :
    phi (eK (KaehlerDifferential.D k K f)) = DL (phi f) := by
  have hK := derivation_p_basis_module_expansion bK (universalCoordinateDerivation eK) f
  change eK (KaehlerDifferential.D k K f) =
    (∑ i : Fin p, pRootCoefficient K p bK f i ^ p *
      (i.val : K) * bK.parameter ^ (i.val - 1)) •
      eK (KaehlerDifferential.D k K bK.parameter) at hK
  rw [heK, smul_eq_mul, mul_one] at hK
  have hL := derivation_p_basis_module_expansion bL DL (phi f)
  rw [hDL, smul_eq_mul, mul_one] at hL
  rw [hK, hL, map_sum]
  apply Finset.sum_congr rfl
  intro i _
  rw [map_mul, map_mul, map_pow, map_pow,
    pRootCoefficient_map phi bK bL hb, hb, map_natCast]

end Litt3.SharedTensors

import Solutions.SharedTensors.CartierFrobeniusDifferential
import Definitions.SharedTensors.RationalCartier

namespace Litt3.SharedTensors

variable {k K : Type*} [CommRing k] [Field K] [Algebra k K]
variable {p : ℕ} [Fact p.Prime] [CharP K p]

/-- Logarithmic fixedness follows from the full binomial primitive and
the actual p-basis; no Cartier property is assumed. -/
theorem rationalCartierCoefficient_logarithmic
    (b : PowerPBasis K p) (D : Derivation k K K) (ht : D b.parameter = 1) (a : K) :
    rationalCartierCoefficient K p b (a⁻¹ * D a) = a⁻¹ * D a := by
  by_cases ha : a = 0
  · simp [ha, rationalCartierCoefficient]
  have hp : 1 ≤ p := (Fact.out : p.Prime).pos
  have hpow : a ^ p = a ^ (p - 1) * a := by
    conv_lhs => rw [← Nat.sub_add_cancel hp]
    rw [pow_succ]
  have hidentity : a⁻¹ * D a = (a⁻¹) ^ p * (a ^ (p - 1) * D a) := by
    rw [inv_pow, hpow]
    field_simp
  calc
    _ = rationalCartierCoefficient K p b
        ((a⁻¹) ^ p * (a ^ (p - 1) * D a)) := congrArg _ hidentity
    _ = a⁻¹ * rationalCartierCoefficient K p b (a ^ (p - 1) * D a) :=
      rationalCartierCoefficient_pth_mul b _ _
    _ = _ := by rw [rationalCartierCoefficient_frobenius_differential b D ht a]

theorem constructedRationalCartier_fixes_logarithmic
    (b : PowerPBasis K p) (e : KaehlerDifferential k K ≃ₗ[K] K)
    (hnormalized : e (KaehlerDifferential.D k K b.parameter) = 1) (a : K) :
    constructedRationalCartier b e (a⁻¹ • KaehlerDifferential.D k K a) =
      a⁻¹ • KaehlerDifferential.D k K a := by
  apply e.injective
  rw [constructedRationalCartier_coordinate, map_smul, smul_eq_mul]
  exact rationalCartierCoefficient_logarithmic b (universalCoordinateDerivation e)
    hnormalized a

/-- Construct the actual intrinsic rational Cartier operator on the
actual universal differential module, proving all standard properties. -/
noncomputable def intrinsicRationalCartier
    (b : PowerPBasis K p) (e : KaehlerDifferential k K ≃ₗ[K] K)
    (hnormalized : e (KaehlerDifferential.D k K b.parameter) = 1) :
    RationalCartierOperator k K p where
  toAddHom := constructedRationalCartier b e
  pth_semilinear := constructedRationalCartier_pth_semilinear b e
  kills_exact := constructedRationalCartier_kills_exact b e hnormalized
  fixes_logarithmic := constructedRationalCartier_fixes_logarithmic b e hnormalized

end Litt3.SharedTensors

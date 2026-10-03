import Solutions.SharedTensors.RationalCartierExact
import Solutions.SharedTensors.EtaleSymmetricTrace

namespace Litt3.SharedTensors

variable {k K : Type*} [CommRing k] [Field K] [Algebra k K]
variable {p : ℕ} [Fact p.Prime] [CharP K p]

/-- The actual additive Cartier map constructed by p-basis extraction on
the actual universal differential module. Intrinsic logarithmic fixedness
is proved separately, rather than included in this definition. -/
noncomputable def constructedRationalCartier
    (b : PowerPBasis K p) (e : KaehlerDifferential k K ≃ₗ[K] K) :
    KaehlerDifferential k K →+ KaehlerDifferential k K :=
  e.symm.toLinearMap.toAddMonoidHom.comp
    ((rationalCartierCoefficientAddHom b).comp e.toLinearMap.toAddMonoidHom)

theorem constructedRationalCartier_coordinate
    (b : PowerPBasis K p) (e : KaehlerDifferential k K ≃ₗ[K] K)
    (omega : KaehlerDifferential k K) :
    e (constructedRationalCartier b e omega) =
      rationalCartierCoefficient K p b (e omega) :=
  e.apply_symm_apply _

theorem constructedRationalCartier_pth_semilinear
    (b : PowerPBasis K p) (e : KaehlerDifferential k K ≃ₗ[K] K)
    (a : K) (omega : KaehlerDifferential k K) :
    constructedRationalCartier b e (a ^ p • omega) =
      a • constructedRationalCartier b e omega := by
  apply e.injective
  rw [constructedRationalCartier_coordinate, map_smul,
    smul_eq_mul, rationalCartierCoefficient_pth_mul, map_smul,
    constructedRationalCartier_coordinate, smul_eq_mul]

theorem constructedRationalCartier_kills_exact
    (b : PowerPBasis K p) (e : KaehlerDifferential k K ≃ₗ[K] K)
    (hnormalized : e (KaehlerDifferential.D k K b.parameter) = 1) (a : K) :
    constructedRationalCartier b e (KaehlerDifferential.D k K a) = 0 := by
  apply e.injective
  rw [constructedRationalCartier_coordinate, map_zero]
  exact rationalCartierCoefficient_exact b (universalCoordinateDerivation e) hnormalized a

theorem constructedRationalCartier_parameter_top
    (b : PowerPBasis K p) (e : KaehlerDifferential k K ≃ₗ[K] K)
    (hnormalized : e (KaehlerDifferential.D k K b.parameter) = 1) :
    constructedRationalCartier b e
      (b.parameter ^ (p - 1) • KaehlerDifferential.D k K b.parameter) =
      KaehlerDifferential.D k K b.parameter := by
  apply e.injective
  rw [constructedRationalCartier_coordinate, map_smul, hnormalized,
    smul_eq_mul, mul_one,
    rationalCartierCoefficient_parameter_power b _
      (Nat.sub_lt (Fact.out : p.Prime).pos (by decide)), if_pos rfl]

/-- The constructed map is genuinely onto the whole universal
differential module, in every prime characteristic. -/
theorem constructedRationalCartier_surjective
    (b : PowerPBasis K p) (e : KaehlerDifferential k K ≃ₗ[K] K)
    (hnormalized : e (KaehlerDifferential.D k K b.parameter) = 1) :
    Function.Surjective (constructedRationalCartier b e) := by
  intro omega
  refine ⟨(e omega) ^ p •
    (b.parameter ^ (p - 1) • KaehlerDifferential.D k K b.parameter), ?_⟩
  rw [constructedRationalCartier_pth_semilinear,
    constructedRationalCartier_parameter_top b e hnormalized]
  apply e.injective
  rw [map_smul, hnormalized, smul_eq_mul, mul_one]

end Litt3.SharedTensors

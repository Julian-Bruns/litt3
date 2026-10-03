import Solutions.SharedTensors.KaehlerMapComposition
import Mathlib.RingTheory.Etale.Kaehler

open scoped TensorProduct

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

section Coordinates

variable {k R S : Type*} [CommRing k] [CommRing R] [CommRing S]
  [Algebra k R] [Algebra k S] [Algebra R S] [IsScalarTower k R S]
  [Algebra.FormallyEtale R S]

/-- Base change of the ENTIRE true universal rank-one module through
any genuine formally etale algebra, over arbitrary commutative rings. -/
noncomputable def formallyEtaleDifferentialCoordinate
    (e : KaehlerDifferential k R ≃ₗ[R] R) : KaehlerDifferential k S ≃ₗ[S] S :=
  (KaehlerDifferential.tensorKaehlerEquivOfFormallyEtale k R S).symm.trans
    ((e.baseChange R S (KaehlerDifferential k R) R).trans
      (TensorProduct.AlgebraTensorModule.rid R S S))

theorem formally_etale_differential_coordinate_map
    (e : KaehlerDifferential k R ≃ₗ[R] R) (omega : KaehlerDifferential k R) :
    formallyEtaleDifferentialCoordinate (S := S) e (KaehlerDifferential.map k k R S omega) =
      algebraMap R S (e omega) := by
  have h := KaehlerDifferential.mapBaseChange_tmul k R S 1 omega
  rw [one_smul] at h
  rw [← h]
  change (TensorProduct.AlgebraTensorModule.rid R S S)
    ((e.baseChange R S (KaehlerDifferential k R) R)
      ((KaehlerDifferential.tensorKaehlerEquivOfFormallyEtale k R S).symm
        ((KaehlerDifferential.tensorKaehlerEquivOfFormallyEtale k R S) (1 ⊗ₜ omega)))) = _
  rw [LinearEquiv.symm_apply_apply, LinearEquiv.baseChange_tmul,
    TensorProduct.AlgebraTensorModule.rid_tmul, Algebra.smul_def, mul_one]

/-- Regularity in the ORIGINAL universal-module image is exactly
membership of its TRUE coordinate in the original coefficient image. -/
theorem formally_etale_differential_image_iff_coordinate
    (e : KaehlerDifferential k R ≃ₗ[R] R) (omega : KaehlerDifferential k S) :
    (∃ omegaR : KaehlerDifferential k R,
      KaehlerDifferential.map k k R S omegaR = omega) ↔
    formallyEtaleDifferentialCoordinate (S := S) e omega ∈ (algebraMap R S).range := by
  constructor
  · rintro ⟨omegaR, rfl⟩
    exact ⟨e omegaR, (formally_etale_differential_coordinate_map e omegaR).symm⟩
  · rintro ⟨a, ha⟩
    refine ⟨e.symm a, ?_⟩
    apply (formallyEtaleDifferentialCoordinate (S := S) e).injective
    rw [formally_etale_differential_coordinate_map, e.apply_symm_apply]
    exact ha

end Coordinates

section Square

variable {k R S F E : Type*} [CommRing k] [CommRing R] [CommRing S] [Field F] [Field E]
  [Algebra k R] [Algebra k S] [Algebra k F] [Algebra k E]
  [Algebra R S] [Algebra R F] [Algebra R E] [Algebra S E] [Algebra F E]
  [IsScalarTower k R S] [IsScalarTower k R F] [IsScalarTower k R E]
  [IsScalarTower k S E] [IsScalarTower k F E]
  [IsScalarTower R S E] [IsScalarTower R F E]
  [Algebra.FormallyEtale R S] [Algebra.FormallyEtale R F] [Algebra.FormallyEtale S E]

/-- Both routes through an ACTUAL coefficient square have the same
universal differential coordinate. Neither differential compatibility
nor a chosen compatible frame is an input. -/
theorem formally_etale_differential_coordinate_square
    (e : KaehlerDifferential k R ≃ₗ[R] R) (omega : KaehlerDifferential k F) :
    formallyEtaleDifferentialCoordinate (S := E)
        (formallyEtaleDifferentialCoordinate (S := S) e)
        (KaehlerDifferential.map k k F E omega) =
      algebraMap F E (formallyEtaleDifferentialCoordinate (S := F) e omega) := by
  let nu := e.symm 1
  let c := formallyEtaleDifferentialCoordinate (S := F) e omega
  have hnuF : formallyEtaleDifferentialCoordinate (S := F) e
      (KaehlerDifferential.map k k R F nu) = 1 := by
    rw [formally_etale_differential_coordinate_map]
    simp only [nu, e.apply_symm_apply, map_one]
  have hform : omega = c • KaehlerDifferential.map k k R F nu := by
    apply (formallyEtaleDifferentialCoordinate (S := F) e).injective
    rw [map_smul, hnuF, smul_eq_mul, mul_one]
  have hnuE : formallyEtaleDifferentialCoordinate (S := E)
        (formallyEtaleDifferentialCoordinate (S := S) e)
        (KaehlerDifferential.map k k F E (KaehlerDifferential.map k k R F nu)) = 1 := by
    rw [kaehler_map_composition (k := k) (R := R) (S := F) (T := E),
      ← kaehler_map_composition (k := k) (R := R) (S := S) (T := E),
      formally_etale_differential_coordinate_map, formally_etale_differential_coordinate_map]
    simp only [nu, e.apply_symm_apply, map_one]
  rw [hform, map_smul, ← IsScalarTower.algebraMap_smul (R := F) E, map_smul, hnuE,
    smul_eq_mul, mul_one]
  rw [map_smul, hnuF, smul_eq_mul, mul_one]

end Square

end Litt3.CartierAndSpin

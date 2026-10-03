import Solutions.SharedTensors.KaehlerCharacters
import Solutions.SharedTensors.AffineMinimalPolynomials
import Mathlib.RingTheory.Etale.Kaehler
import Mathlib.RingTheory.Etale.Field

namespace Litt3.SharedTensors

open Polynomial TensorProduct
open scoped TensorProduct

variable {k K L : Type*} [Field k] [Field K] [Field L]
  [Algebra k K] [Algebra k L] [Algebra K L] [IsScalarTower k K L]
  [Algebra.IsSeparable K L]

/-- Base change of the actual differential coordinate through the actual
separable field extension, using the genuine universal differential map. -/
noncomputable def separableKaehlerCoordinate
    (e : KaehlerDifferential k K ≃ₗ[K] K) : KaehlerDifferential k L ≃ₗ[L] L := by
  letI : Algebra.FormallyEtale K L := Algebra.FormallyEtale.of_isSeparable K L
  exact (KaehlerDifferential.tensorKaehlerEquivOfFormallyEtale k K L).symm.trans
    ((e.baseChange K L (KaehlerDifferential k K) K).trans
      (TensorProduct.AlgebraTensorModule.rid K L L))

theorem separableKaehlerCoordinate_map
    (e : KaehlerDifferential k K ≃ₗ[K] K) (omega : KaehlerDifferential k K) :
    separableKaehlerCoordinate (L := L) e (KaehlerDifferential.map k k K L omega) =
      algebraMap K L (e omega) := by
  letI : Algebra.FormallyEtale K L := Algebra.FormallyEtale.of_isSeparable K L
  have h := KaehlerDifferential.mapBaseChange_tmul k K L 1 omega
  rw [one_smul] at h
  rw [← h]
  change (TensorProduct.AlgebraTensorModule.rid K L L)
    ((e.baseChange K L (KaehlerDifferential k K) K)
      ((KaehlerDifferential.tensorKaehlerEquivOfFormallyEtale k K L).symm
      ((KaehlerDifferential.tensorKaehlerEquivOfFormallyEtale k K L) (1 ⊗ₜ omega)))) = _
  rw [LinearEquiv.symm_apply_apply, LinearEquiv.baseChange_tmul,
    TensorProduct.AlgebraTensorModule.rid_tmul, Algebra.smul_def, mul_one]

theorem actual_separable_kaehler_derivation_compatibility
    (e : KaehlerDifferential k K ≃ₗ[K] K) (a : K) :
    algebraMap K L (kaehlerCoordinateDerivation e a) =
      kaehlerCoordinateDerivation (separableKaehlerCoordinate (L := L) e)
        (algebraMap K L a) := by
  rw [kaehlerCoordinateDerivation_apply, kaehlerCoordinateDerivation_apply,
    ← KaehlerDifferential.map_D k k K L]
  exact (separableKaehlerCoordinate_map e _).symm

/-- The actual universal-differential equation of an actual algebraic
element forces its actual minimal-polynomial coefficient equations. -/
theorem actual_kaehler_affine_minimal_polynomial_equation
    (e : KaehlerDifferential k K ≃ₗ[K] K)
    (eta beta : KaehlerDifferential k K) (chi : L)
    (integral : IsIntegral K chi)
    (affine : KaehlerDifferential.D k L chi =
      KaehlerDifferential.map k k K L eta +
        chi • KaehlerDifferential.map k k K L beta) :
    KaehlerAffinePolynomialEquation eta beta (minpoly K chi) := by
  let E := kaehlerCoordinateDerivation (separableKaehlerCoordinate (L := L) e)
  have hAffine : E chi = algebraMap K L (e eta) + chi * algebraMap K L (e beta) := by
    change separableKaehlerCoordinate e (KaehlerDifferential.D k L chi) = _
    rw [affine, map_add, map_smul, separableKaehlerCoordinate_map,
      separableKaehlerCoordinate_map, smul_eq_mul]
  have hpoly := affine_minimal_polynomial_equation
    (kaehlerCoordinateDerivation e) E
    (actual_separable_kaehler_derivation_compatibility e)
    (e eta) (e beta) chi integral hAffine
  have hcoeff := (affine_differential_polynomial_zero_iff ..).mp hpoly
  intro i
  apply e.injective
  change kaehlerCoordinateDerivation e ((minpoly K chi).coeff i) = _
  simpa only [map_add, map_smul, smul_eq_mul, mul_comm, mul_left_comm, mul_assoc] using hcoeff i

theorem actual_kaehler_affine_source_field_degree_bound
    (p : ℕ) [CharP K p] (hp : 0 < p)
    (e : KaehlerDifferential k K ≃ₗ[K] K)
    (eta beta : KaehlerDifferential k K) (V : Submodule k K)
    (characters : NoKaehlerHomogeneousCharacters beta V p)
    (constants : NoNonconstantKaehlerConstants V)
    (chi : L) (integral : IsIntegral K chi)
    (coefficients : CoefficientsIn V (minpoly K chi))
    (affine : KaehlerDifferential.D k L chi =
      KaehlerDifferential.map k k K L eta +
        chi • KaehlerDifferential.map k k K L beta)
    (generates : IntermediateField.adjoin K {chi} = ⊤) :
    Module.finrank K L < p := by
  have h := kaehler_characteristic_separable_degree_bound p hp e eta beta V
    characters constants (minpoly K chi) (minpoly.monic integral) coefficients
    (actual_kaehler_affine_minimal_polynomial_equation e eta beta chi integral affine)
    (minpoly.irreducible integral) (Algebra.IsSeparable.isSeparable K chi)
  rw [← IntermediateField.adjoin.finrank integral, generates] at h
  simpa only [IntermediateField.finrank_top'] using h

end Litt3.SharedTensors

import Solutions.SharedTensors.SymmetricDifferentials
import Mathlib.RingTheory.Etale.Kaehler
import Mathlib.RingTheory.Trace.Basic

open scoped TensorProduct

namespace Litt3.SharedTensors

variable {k K B : Type*} [CommRing k] [CommRing K] [CommRing B]
  [Algebra k K] [Algebra k B] [Algebra K B] [IsScalarTower k K B]
  [Algebra.FormallyEtale K B]

/-- A genuine universal differential coordinate, valid also for
disconnected commutative source algebras. -/
noncomputable def universalCoordinateDerivation
    (e : KaehlerDifferential k K ≃ₗ[K] K) : Derivation k K K :=
  KaehlerDifferential.linearMapEquivDerivation k K e.toLinearMap

theorem universalCoordinateDerivation_apply
    (e : KaehlerDifferential k K ≃ₗ[K] K) (a : K) :
    universalCoordinateDerivation e a = e (KaehlerDifferential.D k K a) := rfl

/-- Actual formally étale base change of the universal differential
coordinate, without making the source algebra a field. -/
noncomputable def etaleDifferentialCoordinate
    (e : KaehlerDifferential k K ≃ₗ[K] K) : KaehlerDifferential k B ≃ₗ[B] B :=
  (KaehlerDifferential.tensorKaehlerEquivOfFormallyEtale k K B).symm.trans
    ((e.baseChange K B (KaehlerDifferential k K) K).trans
      (TensorProduct.AlgebraTensorModule.rid K B B))

theorem etaleDifferentialCoordinate_map
    (e : KaehlerDifferential k K ≃ₗ[K] K) (omega : KaehlerDifferential k K) :
    etaleDifferentialCoordinate (B := B) e (KaehlerDifferential.map k k K B omega) =
      algebraMap K B (e omega) := by
  have h := KaehlerDifferential.mapBaseChange_tmul k K B 1 omega
  rw [one_smul] at h
  rw [← h]
  change (TensorProduct.AlgebraTensorModule.rid K B B)
    ((e.baseChange K B (KaehlerDifferential k K) K)
      ((KaehlerDifferential.tensorKaehlerEquivOfFormallyEtale k K B).symm
        ((KaehlerDifferential.tensorKaehlerEquivOfFormallyEtale k K B) (1 ⊗ₜ omega)))) = _
  rw [LinearEquiv.symm_apply_apply, LinearEquiv.baseChange_tmul,
    TensorProduct.AlgebraTensorModule.rid_tmul, Algebra.smul_def, mul_one]

theorem etale_universal_derivation_compatibility
    (e : KaehlerDifferential k K ≃ₗ[K] K) (a : K) :
    universalCoordinateDerivation (etaleDifferentialCoordinate (B := B) e)
      (algebraMap K B a) = algebraMap K B (universalCoordinateDerivation e a) := by
  change etaleDifferentialCoordinate e (KaehlerDifferential.D k B (algebraMap K B a)) = _
  rw [← KaehlerDifferential.map_D k k K B]
  exact etaleDifferentialCoordinate_map e _

theorem etale_differential_coordinate_inverse_one
    (e : KaehlerDifferential k K ≃ₗ[K] K) :
    (etaleDifferentialCoordinate (B := B) e).symm 1 =
      KaehlerDifferential.map k k K B (e.symm 1) := by
  apply (etaleDifferentialCoordinate e).injective
  rw [LinearEquiv.apply_symm_apply, etaleDifferentialCoordinate_map,
    LinearEquiv.apply_symm_apply, map_one]

theorem etale_differential_coordinate_change_scalar
    (e e' : KaehlerDifferential k K ≃ₗ[K] K) :
    etaleDifferentialCoordinate (B := B) e'
      ((etaleDifferentialCoordinate e).symm 1) =
      algebraMap K B (e' (e.symm 1)) := by
  rw [etale_differential_coordinate_inverse_one, etaleDifferentialCoordinate_map]

theorem etale_symmetric_coordinate_change
    (e e' : KaehlerDifferential k K ≃ₗ[K] K)
    (q : RationalSymmetricSquare B (KaehlerDifferential k B)) :
    rationalSymmetricSquareCoordinate (etaleDifferentialCoordinate e') q =
      algebraMap K B (e' (e.symm 1) ^ 2) *
        rationalSymmetricSquareCoordinate (etaleDifferentialCoordinate e) q := by
  rw [symmetric_differential_coordinate_change,
    etale_differential_coordinate_change_scalar, map_pow]

/-- The actual trace on rational symmetric tensors induced by formally
étale universal differential base change. Coordinate independence is
proved below, rather than assumed. -/
noncomputable def etaleSymmetricTrace
    (e : KaehlerDifferential k K ≃ₗ[K] K)
    (q : RationalSymmetricSquare B (KaehlerDifferential k B)) :
    RationalSymmetricSquare K (KaehlerDifferential k K) :=
  (rationalSymmetricSquareCoordinate e).symm
    (Algebra.trace K B (rationalSymmetricSquareCoordinate (etaleDifferentialCoordinate e) q))

theorem etaleSymmetricTrace_coordinate
    (e : KaehlerDifferential k K ≃ₗ[K] K)
    (q : RationalSymmetricSquare B (KaehlerDifferential k B)) :
    rationalSymmetricSquareCoordinate e (etaleSymmetricTrace e q) =
      Algebra.trace K B (rationalSymmetricSquareCoordinate (etaleDifferentialCoordinate e) q) :=
  LinearEquiv.apply_symm_apply _ _

/-- The trace tensor is independent of the meromorphic differential frame. -/
theorem etaleSymmetricTrace_independent
    (e e' : KaehlerDifferential k K ≃ₗ[K] K)
    (q : RationalSymmetricSquare B (KaehlerDifferential k B)) :
    etaleSymmetricTrace e q = etaleSymmetricTrace e' q := by
  apply (rationalSymmetricSquareCoordinate e').injective
  rw [symmetric_differential_coordinate_change e e' (etaleSymmetricTrace e q),
    etaleSymmetricTrace_coordinate e q,
    etaleSymmetricTrace_coordinate e' q, etale_symmetric_coordinate_change e e' q,
    ← Algebra.smul_def, map_smul, smul_eq_mul]

/-- The scalar energy is the coordinate of the literal traced product
of universal differentials on the actual source algebra. -/
theorem etale_universal_weighted_product_trace
    (e : KaehlerDifferential k K ≃ₗ[K] K) (a b weight : B) :
    rationalSymmetricSquareCoordinate e (etaleSymmetricTrace e
      (weight • rationalSymmetricProduct B (KaehlerDifferential k B)
        (KaehlerDifferential.D k B a) (KaehlerDifferential.D k B b))) =
      Algebra.trace K B (weight *
        universalCoordinateDerivation (etaleDifferentialCoordinate e) a *
        universalCoordinateDerivation (etaleDifferentialCoordinate e) b) := by
  rw [etaleSymmetricTrace_coordinate, map_smul,
    rationalSymmetricSquareCoordinate_product, smul_eq_mul,
    universalCoordinateDerivation_apply, universalCoordinateDerivation_apply]
  change Algebra.trace K B (weight * (_ * _)) = Algebra.trace K B ((weight * _) * _)
  rw [mul_assoc]

end Litt3.SharedTensors

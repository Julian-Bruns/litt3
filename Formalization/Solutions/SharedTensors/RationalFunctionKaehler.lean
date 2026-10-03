import Solutions.SharedTensors.EtaleSymmetricTrace
import Solutions.SharedTensors.SeparableKaehlerCoordinates
import Mathlib.RingTheory.Kaehler.Polynomial
import Mathlib.FieldTheory.RatFunc.Basic

namespace Litt3.SharedTensors

open Polynomial

variable {k K : Type*} [Field k] [Field K]
  [Algebra k K] [Algebra k[X] K] [IsScalarTower k k[X] K]
  [IsFractionRing k[X] K]

/-- The actual universal differential coordinate of any actual fraction
field of k[x], in every characteristic. -/
noncomputable def polynomialFractionKaehlerCoordinate :
    KaehlerDifferential k K ≃ₗ[K] K := by
  letI : Algebra.FormallyEtale k[X] K :=
    Algebra.FormallyEtale.of_isLocalization (nonZeroDivisors k[X])
  exact etaleDifferentialCoordinate (KaehlerDifferential.polynomialEquiv k)

theorem polynomialFractionKaehlerCoordinate_polynomial (P : k[X]) :
    polynomialFractionKaehlerCoordinate
      (KaehlerDifferential.D k K (algebraMap k[X] K P)) =
      algebraMap k[X] K P.derivative := by
  letI : Algebra.FormallyEtale k[X] K :=
    Algebra.FormallyEtale.of_isLocalization (nonZeroDivisors k[X])
  rw [← KaehlerDifferential.map_D k k k[X] K]
  change etaleDifferentialCoordinate (KaehlerDifferential.polynomialEquiv k)
    (KaehlerDifferential.map k k k[X] K (KaehlerDifferential.D k k[X] P)) = _
  rw [etaleDifferentialCoordinate_map, KaehlerDifferential.polynomialEquiv_D]

@[simp] theorem polynomialFractionKaehlerCoordinate_X :
    polynomialFractionKaehlerCoordinate
      (KaehlerDifferential.D k K (algebraMap k[X] K X)) = 1 := by
  rw [polynomialFractionKaehlerCoordinate_polynomial, derivative_X, map_one]

variable {E : Type*} [Field E] [Algebra k E] [Algebra K E]
  [IsScalarTower k K E] [Algebra.IsSeparable K E]

/-- A literal separating rational-function subfield constructs a genuine
coordinate of Ω_k(E); neither rank nor a scalar proxy for Ω is assumed. -/
noncomputable def separatingFunctionKaehlerCoordinate :
    KaehlerDifferential k E ≃ₗ[E] E :=
  separableKaehlerCoordinate (polynomialFractionKaehlerCoordinate (k := k) (K := K))

@[simp] theorem separatingFunctionKaehlerCoordinate_parameter :
    separatingFunctionKaehlerCoordinate (k := k) (K := K) (E := E)
      (KaehlerDifferential.D k E (algebraMap K E (algebraMap k[X] K X))) = 1 := by
  rw [← KaehlerDifferential.map_D k k K E]
  change separableKaehlerCoordinate (polynomialFractionKaehlerCoordinate (k := k) (K := K))
    (KaehlerDifferential.map k k K E
      (KaehlerDifferential.D k K (algebraMap k[X] K X))) = 1
  rw [separableKaehlerCoordinate_map, polynomialFractionKaehlerCoordinate_X, map_one]

/-- Any actual derivation normalized at the separating function equals
the actual universal coordinate derivation. This includes the derivation
originally used to present a disconnected source quotient. -/
theorem separating_function_derivation_is_universal
    (D : Derivation k E E)
    (hnormalized : D (algebraMap K E (algebraMap k[X] K X)) = 1) :
    D = universalCoordinateDerivation
      (separatingFunctionKaehlerCoordinate (k := k) (K := K) (E := E)) := by
  let e := separatingFunctionKaehlerCoordinate (k := k) (K := K) (E := E)
  let x := algebraMap K E (algebraMap k[X] K X)
  have hx : e (KaehlerDifferential.D k E x) = 1 :=
    separatingFunctionKaehlerCoordinate_parameter
  have hframe : e.symm 1 = KaehlerDifferential.D k E x := by
    apply e.injective
    rw [LinearEquiv.apply_symm_apply, hx]
  ext a
  change D a = e (KaehlerDifferential.D k E a)
  have h : KaehlerDifferential.D k E a =
      e (KaehlerDifferential.D k E a) • KaehlerDifferential.D k E x := by
    rw [← hframe]
    apply e.injective
    rw [map_smul, LinearEquiv.apply_symm_apply, smul_eq_mul, mul_one]
  rw [← Derivation.liftKaehlerDifferential_comp_D D a, h, map_smul,
    Derivation.liftKaehlerDifferential_comp_D, hnormalized, smul_eq_mul, mul_one]
  rw [map_smul, hx, smul_eq_mul, mul_one]

end Litt3.SharedTensors

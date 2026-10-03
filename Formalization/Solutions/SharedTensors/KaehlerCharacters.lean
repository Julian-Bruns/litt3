import Definitions.SharedTensors.KaehlerCharacters
import Solutions.SharedTensors.DifferentialPolynomials
import Mathlib.LinearAlgebra.FiniteDimensional.Basic

namespace Litt3.SharedTensors

open Polynomial

variable {k K : Type*} [Field k] [Field K] [Algebra k K]

/-- Scalar coordinates of the actual universal derivation form an actual
derivation. The coordinate map is not an assumed project differential. -/
noncomputable def kaehlerCoordinateDerivation
    (e : KaehlerDifferential k K ≃ₗ[K] K) : Derivation k K K :=
  KaehlerDifferential.linearMapEquivDerivation k K e.toLinearMap

theorem kaehlerCoordinateDerivation_apply
    (e : KaehlerDifferential k K ≃ₗ[K] K) (a : K) :
    kaehlerCoordinateDerivation e a = e (KaehlerDifferential.D k K a) := rfl

/-- The full factorization follows from literal rational differentials,
with every coefficient-space vanishing retained. Only a coordinate of
their actual one-dimensional K-module is chosen. -/
theorem kaehler_characteristic_power_factorization
    (p : ℕ) [CharP K p] (hp : 0 < p)
    (e : KaehlerDifferential k K ≃ₗ[K] K)
    (eta beta : KaehlerDifferential k K) (V : Submodule k K)
    (characters : NoKaehlerHomogeneousCharacters beta V p)
    (constants : NoNonconstantKaehlerConstants V)
    (F : K[X]) (hmonic : F.Monic) (hcoeff : CoefficientsIn V F)
    (hF : KaehlerAffinePolynomialEquation eta beta F) :
    CharacteristicPowerFactorization (k := k) p F := by
  let D := kaehlerCoordinateDerivation e
  have hcharacters : NoHomogeneousCharacters D.toLinearMap (e beta) V p := by
    intro j hj hjp a ha h
    apply characters j hj hjp a ha
    apply e.injective
    change D a = e (((j : K) * a) • beta)
    simpa only [map_smul, smul_eq_mul, mul_comm, mul_left_comm, mul_assoc] using h
  have hconstants : NoNonconstantDifferentialConstants D.toLinearMap V := by
    intro a ha h
    apply constants a ha
    apply e.injective
    change D a = e 0
    simpa only [map_zero] using h
  apply characteristic_power_factorization p hp D.toLinearMap (e eta) (e beta) V
    hcharacters hconstants F hmonic hcoeff
  intro i
  have h := congrArg e (hF i)
  change D (F.coeff i) = _
  simpa only [map_add, map_smul, smul_eq_mul, mul_comm, mul_left_comm, mul_assoc] using h

/-- A finite-dimensional rank-one actual rational differential module
supplies the coordinate map. The smooth-curve rank-one theorem is a
separate geometric input; it is not substituted by a scalar derivation. -/
theorem rank_one_kaehler_characteristic_power_factorization
    [FiniteDimensional K (KaehlerDifferential k K)]
    (hdim : Module.finrank K (KaehlerDifferential k K) = 1)
    (p : ℕ) [CharP K p] (hp : 0 < p)
    (eta beta : KaehlerDifferential k K) (V : Submodule k K)
    (characters : NoKaehlerHomogeneousCharacters beta V p)
    (constants : NoNonconstantKaehlerConstants V)
    (F : K[X]) (hmonic : F.Monic) (hcoeff : CoefficientsIn V F)
    (hF : KaehlerAffinePolynomialEquation eta beta F) :
    CharacteristicPowerFactorization (k := k) p F := by
  let e : KaehlerDifferential k K ≃ₗ[K] K :=
    LinearEquiv.ofFinrankEq (KaehlerDifferential k K) K
      (by simpa only [Module.finrank_self] using hdim)
  exact kaehler_characteristic_power_factorization p hp e eta beta V
    characters constants F hmonic hcoeff hF

theorem kaehler_characteristic_separable_degree_bound
    (p : ℕ) [CharP K p] (hp : 0 < p)
    (e : KaehlerDifferential k K ≃ₗ[K] K)
    (eta beta : KaehlerDifferential k K) (V : Submodule k K)
    (characters : NoKaehlerHomogeneousCharacters beta V p)
    (constants : NoNonconstantKaehlerConstants V)
    (F : K[X]) (hmonic : F.Monic) (hcoeff : CoefficientsIn V F)
    (hF : KaehlerAffinePolynomialEquation eta beta F)
    (hirr : Irreducible F) (hsep : F.Separable) : F.natDegree < p :=
  characteristic_power_factorization_separable_degree_bound p hp F
    (kaehler_characteristic_power_factorization p hp e eta beta V
      characters constants F hmonic hcoeff hF) hirr hsep

end Litt3.SharedTensors

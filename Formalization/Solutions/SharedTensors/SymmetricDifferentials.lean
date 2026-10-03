import Definitions.SharedTensors.SymmetricDifferentials
import Solutions.SharedTensors.KaehlerCharacters

open scoped TensorProduct

namespace Litt3.SharedTensors

variable {K M : Type*} [CommRing K] [AddCommGroup M] [Module K M]

theorem rationalTensorSquareCoordinate_tmul (e : M ≃ₗ[K] K) (a b : M) :
    rationalTensorSquareCoordinate K M e (a ⊗ₜ[K] b) = e a * e b := by
  simp [rationalTensorSquareCoordinate, TensorProduct.congr_tmul, smul_eq_mul]

/-- Exchange acts identically on the actual tensor square of a rank-one
module. No inverse of two is used. -/
theorem rank_one_tensor_exchange_eq (e : M ≃ₗ[K] K) (z : M ⊗[K] M) :
    TensorProduct.comm K M M z = z := by
  induction z using TensorProduct.induction_on with
  | zero => simp
  | tmul a b =>
    apply (rationalTensorSquareCoordinate K M e).injective
    simp only [TensorProduct.comm_tmul, rationalTensorSquareCoordinate_tmul, mul_comm]
  | add x y hx hy => simp only [map_add, hx, hy]

theorem rank_one_symmetric_relations_eq_bot (e : M ≃ₗ[K] K) :
    symmetricSquareRelations K M = ⊥ := by
  apply le_antisymm
  · rw [symmetricSquareRelations, Submodule.span_le]
    rintro _ ⟨z, rfl⟩
    simp [rank_one_tensor_exchange_eq e]
  · exact bot_le

/-- A genuine coordinate for the actual symmetric square. Its quotient
relations vanish because the actual differential module has rank one. -/
noncomputable def rationalSymmetricSquareCoordinate (e : M ≃ₗ[K] K) :
    RationalSymmetricSquare K M ≃ₗ[K] K :=
  ((symmetricSquareRelations K M).quotEquivOfEqBot
    (rank_one_symmetric_relations_eq_bot e)).trans (rationalTensorSquareCoordinate K M e)

theorem rationalSymmetricSquareCoordinate_product (e : M ≃ₗ[K] K) (a b : M) :
    rationalSymmetricSquareCoordinate e (rationalSymmetricProduct K M a b) = e a * e b := by
  change rationalTensorSquareCoordinate K M e (a ⊗ₜ[K] b) = _
  exact rationalTensorSquareCoordinate_tmul e a b

theorem rationalSymmetricProduct_comm (a b : M) :
    rationalSymmetricProduct K M a b = rationalSymmetricProduct K M b a := by
  apply (Submodule.Quotient.eq _).mpr
  apply Submodule.subset_span
  refine ⟨b ⊗ₜ[K] a, ?_⟩
  simp only [TensorProduct.comm_tmul]

variable {k K' : Type*} [Field k] [Field K'] [Algebra k K']

/-- Literal universal differential products have the scalar product
claimed by derivation-coordinate calculations. -/
theorem universal_differential_product_coordinate
    (e : KaehlerDifferential k K' ≃ₗ[K'] K') (a b : K') :
    rationalSymmetricSquareCoordinate e
      (rationalSymmetricProduct K' (KaehlerDifferential k K')
        (KaehlerDifferential.D k K' a) (KaehlerDifferential.D k K' b)) =
      kaehlerCoordinateDerivation e a * kaehlerCoordinateDerivation e b :=
  rationalSymmetricSquareCoordinate_product e _ _

/-- Every change of rank-one coordinate is multiplication by a genuine
nonzero scalar, without a chosen basis beyond the two coordinates. -/
theorem rank_one_coordinate_change (e e' : M ≃ₗ[K] K) (x : M) :
    e' x = e' (e.symm 1) * e x := by
  have hx : x = e x • e.symm 1 := by
    apply e.injective
    simp only [map_smul, LinearEquiv.apply_symm_apply, smul_eq_mul, mul_one]
  conv_lhs => rw [hx]
  rw [map_smul, smul_eq_mul, mul_comm]

theorem rank_one_coordinate_change_nonzero [Nontrivial K] (e e' : M ≃ₗ[K] K) :
    e' (e.symm 1) ≠ 0 := by
  intro h
  have hzero : e.symm 1 = 0 := e'.injective (by simpa only [map_zero] using h)
  have := congrArg e hzero
  simpa only [LinearEquiv.apply_symm_apply, map_zero, one_ne_zero] using this

/-- The exact square weight under arbitrary meromorphic changes of
the actual differential coordinate. -/
theorem symmetric_differential_coordinate_change (e e' : M ≃ₗ[K] K)
    (q : RationalSymmetricSquare K M) :
    rationalSymmetricSquareCoordinate e' q =
      e' (e.symm 1) ^ 2 * rationalSymmetricSquareCoordinate e q := by
  have hq : q = rationalSymmetricSquareCoordinate e q •
      rationalSymmetricProduct K M (e.symm 1) (e.symm 1) := by
    apply (rationalSymmetricSquareCoordinate e).injective
    simp only [map_smul, rationalSymmetricSquareCoordinate_product,
      LinearEquiv.apply_symm_apply, mul_one, smul_eq_mul]
  conv_lhs => rw [hq]
  rw [map_smul, rationalSymmetricSquareCoordinate_product, smul_eq_mul, pow_two]
  exact mul_comm _ _

/-- Scalar equality in a genuine differential coordinate detects literal
equality of rational symmetric tensors. -/
theorem rational_symmetric_tensors_eq_iff (e : M ≃ₗ[K] K)
    (q r : RationalSymmetricSquare K M) :
    q = r ↔ rationalSymmetricSquareCoordinate e q =
      rationalSymmetricSquareCoordinate e r :=
  (rationalSymmetricSquareCoordinate e).injective.eq_iff.symm

end Litt3.SharedTensors

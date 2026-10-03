import Theorems.Deformations.TruncatedSkewCoordinate
import Solutions.Deformations.TruncatedCoordinateChange
import Solutions.Deformations.CyclicGroupAlgebra
import Solutions.Deformations.CyclicCoordinates

namespace Litt3.Deformations

variable {k : Type*} [CommRing k]

@[simp] theorem truncated_substitution_parameter (N : ℕ)
    (x : TruncatedCoefficientRing k N) (relation : x ^ N = 0) :
    truncatedSubstitution k N x relation (truncatedParameter k N) = x :=
  AdjoinRoot.liftAlgHom_root _ _ _ _

theorem truncated_cyclic_augmentation (N : ℕ)
    (u : (TruncatedCoefficientRing k N)ˣ)
    (value : (u : TruncatedCoefficientRing k N) = 1 + truncatedParameter k N) :
    cyclicAugmentationCoordinate u = truncatedParameter k N := by
  unfold cyclicAugmentationCoordinate
  rw [value]
  ring

variable [Invertible (2 : k)]

/-- The actual skew coordinate satisfies the actual truncation
relation, at every length, over arbitrary commutative coefficients. -/
theorem truncated_skew_coordinate_pow (N : ℕ)
    (u : (TruncatedCoefficientRing k N)ˣ)
    (value : (u : TruncatedCoefficientRing k N) = 1 + truncatedParameter k N) :
    cyclicSkewCoordinate u ^ N = 0 := by
  rw [cyclic_coordinate_factorization, truncated_cyclic_augmentation N u value,
    mul_pow, truncated_parameter_pow, zero_mul]

/-- The actual skew coordinate is a genuine automorphic change
of the truncated parameter; its ideal equality alone is insufficient. -/
theorem truncated_skew_coordinate_bijective {K : Type*} [Field K] [Invertible (2 : K)]
    (N : ℕ) : Specifications.TruncatedSkewCoordinateBijective (k := K) N := by
  intro u value relation
  apply truncated_coordinate_change_bijective N
  have hnil : IsNilpotent (cyclicAugmentationCoordinate u) := by
    rw [truncated_cyclic_augmentation N u value]
    exact truncated_parameter_nilpotent N
  have hunit := cyclic_coordinate_factor_isUnit u hnil
  refine ⟨hunit.unit, ?_⟩
  rw [truncated_substitution_parameter, hunit.unit_spec,
    cyclic_coordinate_factorization, truncated_cyclic_augmentation N u value]

noncomputable def truncatedSkewCoordinateEquiv {K : Type*} [Field K]
    [Invertible (2 : K)] (N : ℕ) :
    TruncatedCoefficientRing K N ≃ₐ[K] TruncatedCoefficientRing K N :=
  AlgEquiv.ofBijective
    (truncatedSubstitution K N (cyclicSkewCoordinate (truncatedCyclicUnit (k := K) N))
      (truncated_skew_coordinate_pow N _ (truncated_cyclic_unit_value N)))
    (truncated_skew_coordinate_bijective N _ (truncated_cyclic_unit_value N) _)

@[simp] theorem truncated_skew_equiv_parameter {K : Type*} [Field K]
    [Invertible (2 : K)] (N : ℕ) :
    truncatedSkewCoordinateEquiv (K := K) N (truncatedParameter K N) =
      cyclicSkewCoordinate (truncatedCyclicUnit (k := K) N) := by
  exact truncated_substitution_parameter N _
    (truncated_skew_coordinate_pow N _ (truncated_cyclic_unit_value N))

end Litt3.Deformations

import Definitions.CartierAndSpin.DifferentialZeroLattices
import Solutions.CartierAndSpin.FormallyEtaleDifferentialCoordinates

namespace Litt3.CartierAndSpin

variable {R M : Type*} [CommRing R] [AddCommGroup M] [Module R M]

/-- A genuine rank-one module coordinate carries m·M to the actual
maximal ideal. This concerns the entire module, not only its generators. -/
theorem linear_coordinate_ideal_smul_top
    (e : M ≃ₗ[R] R) (I : Ideal R) :
    (I • (⊤ : Submodule R M)).map e.toLinearMap = I := by
  have hr : LinearMap.range e.toLinearMap = ⊤ := LinearMap.range_eq_top.mpr e.surjective
  rw [Submodule.map_smul'', Submodule.map_top, hr, Ideal.smul_eq_mul, Ideal.mul_top]

section Differential

variable {k R F : Type*} [CommRing k] [CommRing R] [Field F] [IsLocalRing R]
  [Algebra k R] [Algebra k F] [Algebra R F] [IsScalarTower k R F]
  [Algebra.FormallyEtale R F]

/-- The original zero lattice is precisely the image of the actual
maximal ideal in a genuine universal-module coordinate. Coordinate
existence and compatibility are not assertions about the zero form. -/
theorem differential_zero_lattice_iff_coordinate
    (e : KaehlerDifferential k R ≃ₗ[R] R) (omega : KaehlerDifferential k F) :
    differentialZeroLattice (R := R) omega ↔
      ∃ r ∈ IsLocalRing.maximalIdeal R,
        algebraMap R F r = formallyEtaleDifferentialCoordinate (S := F) e omega := by
  constructor
  · rintro ⟨omegaR, hmem, rfl⟩
    refine ⟨e omegaR, ?_, (formally_etale_differential_coordinate_map e omegaR).symm⟩
    rw [← linear_coordinate_ideal_smul_top e (IsLocalRing.maximalIdeal R)]
    exact Submodule.mem_map_of_mem hmem
  · rintro ⟨r, hr, hcoord⟩
    refine ⟨e.symm r, ?_, ?_⟩
    · have hm : r ∈ ((IsLocalRing.maximalIdeal R) •
          (⊤ : Submodule R (KaehlerDifferential k R))).map e.toLinearMap := by
        rwa [linear_coordinate_ideal_smul_top e]
      obtain ⟨w, hw, hew⟩ := hm
      have hwr : w = e.symm r := by
        apply e.injective
        simpa using hew
      rwa [← hwr]
    · apply (formallyEtaleDifferentialCoordinate (S := F) e).injective
      rw [formally_etale_differential_coordinate_map, e.apply_symm_apply]
      exact hcoord

end Differential

end Litt3.CartierAndSpin

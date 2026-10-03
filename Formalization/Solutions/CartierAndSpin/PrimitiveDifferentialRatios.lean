import Solutions.CartierAndSpin.DifferentialZeroCoordinates

namespace Litt3.CartierAndSpin

variable {k R F : Type*} [CommRing k] [CommRing R] [Field F] [IsLocalRing R]
  [Algebra k R] [Algebra k F] [Algebra R F] [IsScalarTower k R F]

/-- Dividing any original regular one-form by an original primitive
regular one-form gives an ORIGINAL regular coefficient. This uses the
entire rank-one local module and the true maximal-ideal zero lattice. -/
theorem actual_primitive_regular_differential_ratio
    (e : KaehlerDifferential k R ≃ₗ[R] R)
    (omega nu : KaehlerDifferential k F)
    (homega : ∃ w : KaehlerDifferential k R, KaehlerDifferential.map k k R F w = omega)
    (hnu : ∃ w : KaehlerDifferential k R, KaehlerDifferential.map k k R F w = nu)
    (hprimitive : ¬ differentialZeroLattice (R := R) omega) :
    ∃ r : R, algebraMap R F r • omega = nu := by
  obtain ⟨w, hw⟩ := homega
  obtain ⟨v, hv⟩ := hnu
  have hnot : e w ∉ IsLocalRing.maximalIdeal R := by
    intro h
    apply hprimitive
    refine ⟨w, ?_, hw⟩
    have hm : e w ∈ ((IsLocalRing.maximalIdeal R) •
        (⊤ : Submodule R (KaehlerDifferential k R))).map e.toLinearMap := by
      rwa [linear_coordinate_ideal_smul_top e]
    obtain ⟨a, ha, hea⟩ := hm
    have haw : a = w := e.injective hea
    rwa [← haw]
  have hu : IsUnit (e w) := (IsLocalRing.notMem_maximalIdeal).mp hnot
  let u : Rˣ := hu.unit
  have huval : u.val = e w := hu.unit_spec
  let r : R := e v * u⁻¹.val
  have hr : r • w = v := by
    apply e.injective
    rw [map_smul, smul_eq_mul]
    change (e v * u⁻¹.val) * e w = e v
    rw [← huval, mul_assoc, Units.inv_mul, mul_one]
  refine ⟨r, ?_⟩
  have h := congrArg (KaehlerDifferential.map k k R F) hr
  rw [map_smul, hw, hv, ← IsScalarTower.algebraMap_smul (R := R) F] at h
  exact h

end Litt3.CartierAndSpin

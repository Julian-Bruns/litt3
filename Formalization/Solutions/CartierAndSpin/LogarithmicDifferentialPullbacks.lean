import Solutions.CartierAndSpin.LogarithmicDifferentialKernel
import Solutions.SharedTensors.SeparableKaehlerCoordinates
import Definitions.Jacobians.PrincipalPullbacks

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.Jacobians

variable {k F E : Type*} [Field k] [Field F] [Field E]
  [Algebra k F] [Algebra k E] [Algebra F E] [IsScalarTower k F E]

/-- Logarithmic differentiation commutes with the literal field
inclusion and its actual universal-differential pullback. -/
theorem rational_logarithmic_differential_pullback (u : Additive Fˣ) :
    rationalLogarithmicDifferential k E
      (rationalUnitPullback (algebraMap F E) u) =
    KaehlerDifferential.map k k F E (rationalLogarithmicDifferential k F u) := by
  change (algebraMap F E ((u.toMul : Fˣ) : F))⁻¹ •
    KaehlerDifferential.D k E (algebraMap F E ((u.toMul : Fˣ) : F)) =
    KaehlerDifferential.map k k F E
      (((u.toMul : Fˣ) : F)⁻¹ • KaehlerDifferential.D k F ((u.toMul : Fˣ) : F))
  rw [map_smul, KaehlerDifferential.map_D,
    ← IsScalarTower.algebraMap_smul (R := F) E,
    map_inv₀]

variable [Algebra.IsSeparable F E]

/-- The actual separable universal-differential inclusion is injective
whenever the original field's genuine differential coordinate exists. -/
theorem separable_universal_differential_map_injective
    (e : KaehlerDifferential k F ≃ₗ[F] F) :
    Function.Injective (KaehlerDifferential.map k k F E) := by
  intro omega eta h
  have heq := congrArg (separableKaehlerCoordinate (L := E) e) h
  rw [separableKaehlerCoordinate_map, separableKaehlerCoordinate_map] at heq
  exact e.injective ((algebraMap F E).injective heq)

variable {p : ℕ} [Fact p.Prime] [CharP k p] [CharP F p] [PerfectField k]

/-- Endpoint p-kernel exactness after the ACTUAL separable pullback.
No endpoint root is inferred merely from an ambient scalar equality. -/
theorem one_variable_pulled_logarithmic_kernel
    (hfg : IntermediateField.FG (F := k) (E := F) ⊤)
    (htrdeg : Algebra.trdeg k F = 1) (u : Additive Fˣ) :
    rationalLogarithmicDifferential k E
      (rationalUnitPullback (algebraMap F E) u) = 0 ↔
        ∃ r : Additive Fˣ, p • r = u := by
  obtain ⟨b⟩ := one_variable_power_p_basis_exists (p := p) hfg htrdeg
  obtain ⟨e, he⟩ := p_basis_perfect_base_kaehler_coordinate_exists (k := k) b
  rw [rational_logarithmic_differential_pullback,
    ← (KaehlerDifferential.map k k F E).map_zero,
    (separable_universal_differential_map_injective (E := E) e).eq_iff]
  exact p_basis_rational_logarithmic_kernel b e he u

end Litt3.CartierAndSpin

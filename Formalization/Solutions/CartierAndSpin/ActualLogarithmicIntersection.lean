import Definitions.CartierAndSpin.LogarithmicDifferentials
import Solutions.SharedTensors.ConstantIntersection
import Mathlib.Algebra.CharP.Lemmas
import Mathlib.Algebra.CharP.Frobenius

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.Jacobians

section Powers

variable {E : Type*} [Field E] {p : ℕ} [Fact p.Prime] [CharP E p]

/-- The pth-power operation is injective on actual field units. -/
theorem actual_field_unit_pth_power_injective :
    Function.Injective (fun u : Additive Eˣ => p • u) := by
  intro u v h
  apply Additive.toMul.injective
  apply Units.ext
  apply (frobenius E p).injective
  have hv := congrArg (fun z : Additive Eˣ => ((z.toMul : Eˣ) : E)) h
  simpa only [frobenius_def, toMul_nsmul, Units.val_pow_eq_pow_val] using hv

end Powers

variable {k F G E : Type*} [Field k] [Field F] [Field G] [Field E]
  [Algebra k F] [Algebra k G] [Algebra k E] [Algebra F E] [Algebra G E]
  [IsScalarTower k F E]

/-- Literal constant intersection of the two actual endpoint field
images forces the common endpoint units to have zero original dlog.
No perfectness, Cartier assertion, or quotient-torsion conclusion is
used in this implication. -/
theorem actual_common_endpoint_units_logarithmic_zero
    (hintersection : EndpointFieldIntersectionConstants
      (algebraMap k F) (algebraMap k G) (algebraMap F E) (algebraMap G E))
    (u : Additive Fˣ) (v : Additive Gˣ)
    (huv : rationalUnitPullback (algebraMap F E) u =
      rationalUnitPullback (algebraMap G E) v) :
    rationalLogarithmicDifferential k E
      (rationalUnitPullback (algebraMap F E) u) = 0 := by
  obtain ⟨c, hcF, _⟩ := endpoint_units_intersection_constants
    (algebraMap k F) (algebraMap k G) (algebraMap F E) (algebraMap G E)
    hintersection u v huv
  have hc : algebraMap k F ((c.toMul : kˣ) : k) = ((u.toMul : Fˣ) : F) :=
    congrArg (fun z : Additive Fˣ => ((z.toMul : Fˣ) : F)) hcF
  have hv : algebraMap F E ((u.toMul : Fˣ) : F) =
      algebraMap k E ((c.toMul : kˣ) : k) := by
    rw [← hc, ← IsScalarTower.algebraMap_apply k F E]
  change (algebraMap F E ((u.toMul : Fˣ) : F))⁻¹ •
    KaehlerDifferential.D k E (algebraMap F E ((u.toMul : Fˣ) : F)) = 0
  rw [hv, (KaehlerDifferential.D k E).map_algebraMap, smul_zero]

end Litt3.CartierAndSpin

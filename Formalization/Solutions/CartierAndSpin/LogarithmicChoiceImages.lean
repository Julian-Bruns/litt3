import Definitions.CartierAndSpin.LogarithmicChoiceFibers
import Solutions.CartierAndSpin.SharedCartierFixedLogarithms

set_option maxHeartbeats 1000000
set_option synthInstance.maxHeartbeats 100000

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.Jacobians

variable {k F E : Type*} [Field k] [Field F] [Field E]
  [Algebra k F] [Algebra k E] [Algebra F E] [IsScalarTower k F E]

/-- The image of actual endpoint logarithmic FORMS is exactly the
image of logarithms of actual pulled endpoint units. -/
theorem endpoint_logarithmic_form_pullback_range :
    (endpointLogarithmicFormPullback k F E).range =
      ((rationalLogarithmicDifferential k E).comp
        (rationalUnitPullback (algebraMap F E))).range := by
  ext omega
  constructor
  · rintro ⟨alpha, ha⟩
    obtain ⟨u, hu⟩ := alpha.property
    refine ⟨u, ?_⟩
    change rationalLogarithmicDifferential k E
      (rationalUnitPullback (algebraMap F E) u) = omega
    rw [rational_logarithmic_differential_pullback, hu]
    exact ha
  · rintro ⟨u, hu⟩
    refine ⟨⟨rationalLogarithmicDifferential k F u, ⟨u, rfl⟩⟩, ?_⟩
    change KaehlerDifferential.map k k F E (rationalLogarithmicDifferential k F u) = omega
    rw [← rational_logarithmic_differential_pullback]
    exact hu

variable {G : Type*} [Field G] [Algebra k G] [Algebra G E] [IsScalarTower k G E]
  [Algebra.IsSeparable F E] [Algebra.IsSeparable G E] [PerfectField k]
variable {p : ℕ} [Fact p.Prime] [CharP k p]

/-- Literal shared image of endpoint logarithmic FORMS equals the
Cartier-fixed part of BOTH actual rational differential images. -/
theorem endpoint_logarithmic_form_shared_image_eq
    (hfgF : IntermediateField.FG (F := k) (E := F) ⊤)
    (htrdegF : Algebra.trdeg k F = 1)
    (hfgG : IntermediateField.FG (F := k) (E := G) ⊤)
    (htrdegG : Algebra.trdeg k G = 1)
    (CE : RationalCartierOperator k E p) :
    (endpointLogarithmicFormPullback k F E).range ⊓
      (endpointLogarithmicFormPullback k G E).range =
        sharedIntrinsicCartierFixedForms k F G E CE := by
  rw [endpoint_logarithmic_form_pullback_range,
    endpoint_logarithmic_form_pullback_range]
  exact actual_shared_logarithmic_image_eq_cartier_fixed hfgF htrdegF hfgG htrdegG CE

end Litt3.CartierAndSpin

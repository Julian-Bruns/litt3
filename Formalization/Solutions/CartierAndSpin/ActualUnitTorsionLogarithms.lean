import Solutions.CartierAndSpin.LogarithmicBoundaryEquivalence
import Solutions.CartierAndSpin.LogarithmicDifferentialPullbacks
import Solutions.CartierAndSpin.ActualLogarithmicIntersection
import Definitions.SharedTensors.MultiplicativeQuotients

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.Jacobians

variable {k F G E : Type*} [Field k] [Field F] [Field G] [Field E]
  [Algebra k F] [Algebra k G] [Algebra k E] [Algebra F E] [Algebra G E]
  [IsScalarTower k F E] [IsScalarTower k G E]
  [Algebra.IsSeparable F E] [Algebra.IsSeparable G E]
variable {p : ℕ} [Fact p.Prime] [CharP k p] [PerfectField k]

/-- Actual p-torsion of the original multiplicative two-endpoint
quotient is canonically the intersection of BOTH actual logarithmic
endpoint images. Every kernel, root and well-definedness assertion is
derived from the original function fields and inclusions. -/
noncomputable def actual_unit_quotient_p_torsion_logarithmic_equiv
    (hfgF : IntermediateField.FG (F := k) (E := F) ⊤)
    (htrdegF : Algebra.trdeg k F = 1)
    (hfgG : IntermediateField.FG (F := k) (E := G) ⊤)
    (htrdegG : Algebra.trdeg k G = 1)
    (hfgE : IntermediateField.FG (F := k) (E := E) ⊤)
    (htrdegE : Algebra.trdeg k E = 1)
    (hintersection : EndpointFieldIntersectionConstants
      (algebraMap k F) (algebraMap k G) (algebraMap F E) (algebraMap G E)) :
    powerTorsionSubgroup
      (UnitRelationQuotient (algebraMap F E) (algebraMap G E)) p ≃+
    sharedLogarithmicImage (rationalLogarithmicDifferential k E)
      (rationalUnitPullback (algebraMap F E))
      (rationalUnitPullback (algebraMap G E)) := by
  letI : CharP F p := charP_of_injective_algebraMap (algebraMap k F).injective p
  letI : CharP G p := charP_of_injective_algebraMap (algebraMap k G).injective p
  letI : CharP E p := charP_of_injective_algebraMap (algebraMap k E).injective p
  exact logarithmicBoundaryEquiv
    (rationalUnitPullback (algebraMap F E)) (rationalUnitPullback (algebraMap G E))
    p (rationalLogarithmicDifferential k E)
    (fun u => one_variable_rational_logarithmic_kernel hfgE htrdegE u)
    (actual_common_endpoint_units_logarithmic_zero hintersection)
    (fun u => one_variable_pulled_logarithmic_kernel hfgF htrdegF u)
    (fun u => one_variable_pulled_logarithmic_kernel hfgG htrdegG u)
    actual_field_unit_pth_power_injective

end Litt3.CartierAndSpin

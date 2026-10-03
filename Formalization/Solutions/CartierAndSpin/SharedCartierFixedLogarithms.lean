import Solutions.CartierAndSpin.PulledCartierFixedLogarithms
import Definitions.CartierAndSpin.LogarithmicQuotientBoundary

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.Jacobians

variable {k F G E : Type*} [Field k] [Field F] [Field G] [Field E]
  [Algebra k F] [Algebra k G] [Algebra k E] [Algebra F E] [Algebra G E]
  [IsScalarTower k F E] [IsScalarTower k G E]
  [Algebra.IsSeparable F E] [Algebra.IsSeparable G E] [PerfectField k]
variable {p : ℕ} [Fact p.Prime] [CharP k p]

/-- Both actual endpoint logarithmic images intersect in precisely the
Cartier-fixed part of the ORIGINAL rational differential intersection.
The converse derives endpoint fixedness by genuine separable pullback
injectivity, then constructs original endpoint logarithmic primitives. -/
theorem actual_shared_logarithmic_image_eq_cartier_fixed
    (hfgF : IntermediateField.FG (F := k) (E := F) ⊤)
    (htrdegF : Algebra.trdeg k F = 1)
    (hfgG : IntermediateField.FG (F := k) (E := G) ⊤)
    (htrdegG : Algebra.trdeg k G = 1)
    (CE : RationalCartierOperator k E p) :
    sharedLogarithmicImage (rationalLogarithmicDifferential k E)
      (rationalUnitPullback (algebraMap F E))
      (rationalUnitPullback (algebraMap G E)) =
    sharedIntrinsicCartierFixedForms k F G E CE := by
  ext omega
  constructor
  · intro h
    obtain ⟨u, hu⟩ := h.1
    obtain ⟨v, hv⟩ := h.2
    change rationalLogarithmicDifferential k E
      (rationalUnitPullback (algebraMap F E) u) = omega at hu
    change rationalLogarithmicDifferential k E
      (rationalUnitPullback (algebraMap G E) v) = omega at hv
    refine ⟨⟨⟨rationalLogarithmicDifferential k F u, ?_⟩,
      ⟨rationalLogarithmicDifferential k G v, ?_⟩⟩, ?_⟩
    · change KaehlerDifferential.map k k F E
        (rationalLogarithmicDifferential k F u) = omega
      rw [← rational_logarithmic_differential_pullback]
      exact hu
    · change KaehlerDifferential.map k k G E
        (rationalLogarithmicDifferential k G v) = omega
      rw [← rational_logarithmic_differential_pullback]
      exact hv
    · change omega ∈ intrinsicCartierFixedSubgroup CE
      rw [mem_intrinsicCartierFixedSubgroup, ← hu]
      exact rational_logarithmic_differential_cartier_fixed CE _
  · intro h
    have hfixed : CE.toAddHom omega = omega :=
      (mem_intrinsicCartierFixedSubgroup CE omega).mp h.2
    exact ⟨pulled_cartier_fixed_form_is_endpoint_logarithmic
      hfgF htrdegF CE omega h.1.1 hfixed,
      pulled_cartier_fixed_form_is_endpoint_logarithmic
        hfgG htrdegG CE omega h.1.2 hfixed⟩

end Litt3.CartierAndSpin

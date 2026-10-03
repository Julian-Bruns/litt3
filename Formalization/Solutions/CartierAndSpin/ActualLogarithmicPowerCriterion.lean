import Solutions.CartierAndSpin.ActualLogarithmicPowerForward
import Solutions.CartierAndSpin.ActualLogarithmicCorrection

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.Jacobians

variable {k F G E : Type*} [Field k] [IsAlgClosed k] [Field F] [Field G] [Field E]
  [Algebra k F] [Algebra k G] [Algebra k E] [Algebra F E] [Algebra G E]
  [IsScalarTower k F E] [IsScalarTower k G E]
  [Algebra.IsSeparable F E] [Algebra.IsSeparable G E]
variable {p : ℕ} [Fact p.Prime] [CharP k p]

/-- Exact quotient p-power membership criterion in the ORIGINAL
two-endpoint unit quotient. The sole remaining geometric bridge is the
explicit finite/shared-rank-at-most-one premise on the literal images;
endpoint logarithmic primitives are constructed rather than assumed.
No constant-intersection or clump premise is needed for this criterion. -/
theorem actual_unit_quotient_power_iff_additive_endpoint_decomposition
    (hfgF : IntermediateField.FG (F := k) (E := F) ⊤)
    (htrdegF : Algebra.trdeg k F = 1)
    (hfgG : IntermediateField.FG (F := k) (E := G) ⊤)
    (htrdegG : Algebra.trdeg k G = 1)
    (hfgE : IntermediateField.FG (F := k) (E := E) ⊤)
    (htrdegE : Algebra.trdeg k E = 1)
    [Module.Finite k ↥(sharedRationalDifferentialSubspace k F G E)]
    (hdim : Module.finrank k ↥(sharedRationalDifferentialSubspace k F G E) ≤ 1)
    (u : Additive Eˣ) :
    (∃ q : UnitRelationQuotient (algebraMap F E) (algebraMap G E),
      p • q = QuotientAddGroup.mk' (unitRelationMap (algebraMap F E) (algebraMap G E)).range u) ↔
    ∃ alpha : KaehlerDifferential k F, ∃ beta : KaehlerDifferential k G,
      rationalLogarithmicDifferential k E u =
        actualRationalDifferentialPullback k G E beta -
          actualRationalDifferentialPullback k F E alpha := by
  constructor
  · exact actual_quotient_power_implies_logarithmic_decomposition u
  · rintro ⟨alpha, beta, hdecomp⟩
    obtain ⟨f, g, hlog⟩ := actual_logarithmic_decomposition_has_logarithmic_choice
      (p := p) hfgF htrdegF hfgG htrdegG hfgE htrdegE hdim u alpha beta hdecomp
    change rationalLogarithmicDifferential k E u =
      KaehlerDifferential.map k k G E (rationalLogarithmicDifferential k G g) -
        KaehlerDifferential.map k k F E (rationalLogarithmicDifferential k F f) at hlog
    letI : CharP E p := charP_of_injective_algebraMap (algebraMap k E).injective p
    have hzero : rationalLogarithmicDifferential k E
        (u - rationalUnitPullback (algebraMap G E) g +
          rationalUnitPullback (algebraMap F E) f) = 0 := by
      rw [map_add, map_sub, rational_logarithmic_differential_pullback,
        rational_logarithmic_differential_pullback, hlog]
      abel
    obtain ⟨a, ha⟩ := (one_variable_rational_logarithmic_kernel hfgE htrdegE _).mp hzero
    let qmap : Additive Eˣ →+ UnitRelationQuotient (algebraMap F E) (algebraMap G E) :=
      QuotientAddGroup.mk'
      (unitRelationMap (algebraMap F E) (algebraMap G E)).range
    have hrep : p • a = u + (rationalUnitPullback (algebraMap F E) f -
        rationalUnitPullback (algebraMap G E) g) := by
      rw [ha]
      abel
    refine ⟨qmap a, ?_⟩
    rw [← map_nsmul]
    apply QuotientAddGroup.eq_iff_sub_mem.mpr
    refine ⟨(f, g), ?_⟩
    change rationalUnitPullback (algebraMap F E) f -
      rationalUnitPullback (algebraMap G E) g = p • a - u
    rw [hrep]
    abel

end Litt3.CartierAndSpin

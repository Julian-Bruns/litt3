import Solutions.CartierAndSpin.ActualSharedDifferentialRank
import Solutions.CartierAndSpin.ActualLogarithmicPowerCriterion

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.Jacobians

variable {k F G E : Type*} [Field k] [IsAlgClosed k] [Field F] [Field G] [Field E]
  [Algebra k F] [Algebra k G] [Algebra k E] [Algebra F E] [Algebra G E]
  [IsScalarTower k F E] [IsScalarTower k G E]
  [Algebra.IsSeparable F E] [Algebra.IsSeparable G E]
variable {p : ℕ} [Fact p.Prime] [CharP k p]

include p

/-- Constant intersection of the actual endpoint fields derives the
shared rank bound. Consequently an arbitrary original additive
decomposition of a source logarithmic form can be changed to genuine
logarithmic forms in BOTH original endpoints. -/
theorem actual_constant_intersection_logarithmic_choice
    (hfgF : IntermediateField.FG (F := k) (E := F) ⊤)
    (htrdegF : Algebra.trdeg k F = 1)
    (hfgG : IntermediateField.FG (F := k) (E := G) ⊤)
    (htrdegG : Algebra.trdeg k G = 1)
    (hfgE : IntermediateField.FG (F := k) (E := E) ⊤)
    (htrdegE : Algebra.trdeg k E = 1)
    (hinter : EndpointFieldIntersectionConstants (algebraMap k F) (algebraMap k G)
      (algebraMap F E) (algebraMap G E))
    (u : Additive Eˣ) (alpha : KaehlerDifferential k F) (beta : KaehlerDifferential k G)
    (hdecomp : rationalLogarithmicDifferential k E u =
      actualRationalDifferentialPullback k G E beta -
        actualRationalDifferentialPullback k F E alpha) :
    ∃ f : Additive Fˣ, ∃ g : Additive Gˣ,
      rationalLogarithmicDifferential k E u =
        actualRationalDifferentialPullback k G E (rationalLogarithmicDifferential k G g) -
          actualRationalDifferentialPullback k F E (rationalLogarithmicDifferential k F f) := by
  obtain ⟨hfinite, hdim⟩ := actual_one_variable_shared_space_finite_and_small
    hfgF htrdegF hfgG htrdegG hinter
  letI := hfinite
  exact actual_logarithmic_decomposition_has_logarithmic_choice (p := p)
    hfgF htrdegF hfgG htrdegG hfgE htrdegE hdim u alpha beta hdecomp

/-- Original quotient p-power membership is equivalent to arbitrary
additive decomposition in the two actual universal endpoint images.
The shared-rank and logarithmic-primitive conclusions are derived,
not supplied. Both literal field embeddings remain present. -/
theorem actual_constant_intersection_power_iff_additive_decomposition
    (hfgF : IntermediateField.FG (F := k) (E := F) ⊤)
    (htrdegF : Algebra.trdeg k F = 1)
    (hfgG : IntermediateField.FG (F := k) (E := G) ⊤)
    (htrdegG : Algebra.trdeg k G = 1)
    (hfgE : IntermediateField.FG (F := k) (E := E) ⊤)
    (htrdegE : Algebra.trdeg k E = 1)
    (hinter : EndpointFieldIntersectionConstants (algebraMap k F) (algebraMap k G)
      (algebraMap F E) (algebraMap G E))
    (u : Additive Eˣ) :
    (∃ q : UnitRelationQuotient (algebraMap F E) (algebraMap G E),
      p • q = QuotientAddGroup.mk' (unitRelationMap (algebraMap F E) (algebraMap G E)).range u) ↔
    ∃ alpha : KaehlerDifferential k F, ∃ beta : KaehlerDifferential k G,
      rationalLogarithmicDifferential k E u =
        actualRationalDifferentialPullback k G E beta -
          actualRationalDifferentialPullback k F E alpha := by
  obtain ⟨hfinite, hdim⟩ := actual_one_variable_shared_space_finite_and_small
    hfgF htrdegF hfgG htrdegG hinter
  letI := hfinite
  exact actual_unit_quotient_power_iff_additive_endpoint_decomposition
    hfgF htrdegF hfgG htrdegG hfgE htrdegE hdim u

end Litt3.CartierAndSpin

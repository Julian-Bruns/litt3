import Definitions.CartierAndSpin.SharedDifferentialSubspaces
import Solutions.CartierAndSpin.LogarithmicDifferentialPullbacks
import Definitions.SharedTensors.MultiplicativeQuotients

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.Jacobians

variable {k F G E : Type*} [Field k] [Field F] [Field G] [Field E]
  [Algebra k F] [Algebra k G] [Algebra k E] [Algebra F E] [Algebra G E]
  [IsScalarTower k F E] [IsScalarTower k G E]
variable {p : ℕ} [CharP k p]

/-- Original quotient p-power membership supplies an actual additive
endpoint differential decomposition. This forward implication needs no
perfectness, finite generation, separability, prime or shared-rank input. -/
theorem actual_quotient_power_implies_logarithmic_decomposition
    (u : Additive Eˣ)
    (hpower : ∃ q : UnitRelationQuotient (algebraMap F E) (algebraMap G E),
      p • q = QuotientAddGroup.mk' (unitRelationMap (algebraMap F E) (algebraMap G E)).range u) :
    ∃ alpha : KaehlerDifferential k F, ∃ beta : KaehlerDifferential k G,
      rationalLogarithmicDifferential k E u =
        actualRationalDifferentialPullback k G E beta -
          actualRationalDifferentialPullback k F E alpha := by
  obtain ⟨q, hq⟩ := hpower
  obtain ⟨a, ha⟩ := QuotientAddGroup.mk'_surjective
    (unitRelationMap (algebraMap F E) (algebraMap G E)).range q
  rw [← ha, ← map_nsmul] at hq
  have hmem : u - p • a ∈
      (unitRelationMap (algebraMap F E) (algebraMap G E)).range :=
    QuotientAddGroup.eq_iff_sub_mem.mp hq.symm
  obtain ⟨⟨b, c⟩, hbc⟩ := hmem
  change rationalUnitPullback (algebraMap F E) b -
    rationalUnitPullback (algebraMap G E) c = u - p • a at hbc
  have h := congrArg (rationalLogarithmicDifferential k E) hbc
  rw [map_sub, map_sub, map_nsmul] at h
  have hchar : p • rationalLogarithmicDifferential k E a = 0 := by
    rw [← Nat.cast_smul_eq_nsmul k, CharP.cast_eq_zero k p, zero_smul]
  rw [hchar, sub_zero, rational_logarithmic_differential_pullback,
    rational_logarithmic_differential_pullback] at h
  refine ⟨-rationalLogarithmicDifferential k F b,
    -rationalLogarithmicDifferential k G c, ?_⟩
  change rationalLogarithmicDifferential k E u =
    KaehlerDifferential.map k k G E (-rationalLogarithmicDifferential k G c) -
      KaehlerDifferential.map k k F E (-rationalLogarithmicDifferential k F b)
  rw [map_neg, map_neg]
  calc
    _ = KaehlerDifferential.map k k F E (rationalLogarithmicDifferential k F b) -
        KaehlerDifferential.map k k G E (rationalLogarithmicDifferential k G c) := h.symm
    _ = _ := by abel

end Litt3.CartierAndSpin

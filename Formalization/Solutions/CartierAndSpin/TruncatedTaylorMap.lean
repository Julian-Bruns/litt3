import Solutions.CartierAndSpin.TruncatedFieldTaylor

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {L : Type*} [Field L] {p : ℕ} [Fact p.Prime] [CharP L p]

noncomputable def truncatedFieldTaylorMap (b : PowerPBasis L p) (e : ℕ) :
    L →+* TruncatedFieldTaylor L p e :=
  Classical.choose (truncated_field_taylor_map_exists b e)

theorem truncatedFieldTaylorMap_parameter (b : PowerPBasis L p) (e : ℕ) :
    truncatedFieldTaylorMap b e b.parameter =
      algebraMap L (TruncatedFieldTaylor L p e) b.parameter +
        truncatedTaylorParameter (L := L) p e :=
  (Classical.choose_spec (truncated_field_taylor_map_exists b e)).1

theorem truncatedFieldTaylorMap_constants (b : PowerPBasis L p) (e : ℕ)
    (c : iteratedFrobeniusSubfield L p e) :
    truncatedFieldTaylorMap b e c.val =
      algebraMap L (TruncatedFieldTaylor L p e) c.val :=
  (Classical.choose_spec (truncated_field_taylor_map_exists b e)).2 c

/-- The genuine Taylor map is uniquely determined by fixing the actual
power subfield and shifting the actual p-basis parameter. The target may
have nilpotents. -/
theorem truncated_field_taylor_map_unique (b : PowerPBasis L p) (e : ℕ)
    (f g : L →+* TruncatedFieldTaylor L p e)
    (hf : ∀ c : iteratedFrobeniusSubfield L p e,
      f c.val = algebraMap L (TruncatedFieldTaylor L p e) c.val)
    (hg : ∀ c : iteratedFrobeniusSubfield L p e,
      g c.val = algebraMap L (TruncatedFieldTaylor L p e) c.val)
    (ht : f b.parameter = g b.parameter) : f = g := by
  let S := iteratedFrobeniusSubfield L p e
  let Q := TruncatedFieldTaylor L p e
  let fa : L →ₐ[S] Q := ⟨f, hf⟩
  let ga : L →ₐ[S] Q := ⟨g, hg⟩
  have heq : fa = ga := (iteratedPBasisPowerBasis b e).algHom_ext (by
    simpa only [iteratedPBasisPowerBasis_gen] using ht)
  exact congrArg AlgHom.toRingHom heq

end Litt3.CartierAndSpin

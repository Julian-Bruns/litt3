import Definitions.QuotientGeometry.FiniteParameterFields
import Solutions.QuotientGeometry.FiniteParameterEmbedding
import Mathlib.LinearAlgebra.Dimension.Constructions
import Mathlib.LinearAlgebra.FiniteDimensional.Defs

namespace Litt3.QuotientGeometry

theorem parameter_laurent_map_power_series
    {k : Type*} [Field k] (b : PowerSeries k)
    (hb : PowerSeries.constantCoeff b = 0)
    (hinj : Function.Injective (PowerSeries.subst b : PowerSeries k → PowerSeries k))
    (f : PowerSeries k) :
    parameterLaurentMap b hb hinj (f : LaurentSeries k) =
      (PowerSeries.subst b f : PowerSeries k) := by
  change IsFractionRing.map _ (algebraMap (PowerSeries k) (LaurentSeries k) f) = _
  rw [IsFractionRing.map, IsLocalization.map_eq]
  exact congrArg (fun g : PowerSeries k => (g : LaurentSeries k))
    (congr_fun (PowerSeries.coe_substAlgHom
      (PowerSeries.HasSubst.of_constantCoeff_zero' hb)) f)

theorem laurent_parameter_denominator_clearing
    {k : Type*} [Field k] (n : ℕ) (hn : 0 < n) (b c : PowerSeries k)
    (hb : b = PowerSeries.X ^ n * c) (f : LaurentSeries k) :
    ∃ m : ℕ, ∃ g : PowerSeries k, ((b ^ m : PowerSeries k) : LaurentSeries k) * f = g := by
  obtain ⟨⟨a, s⟩, hs⟩ := IsLocalization.surj (Submonoid.powers (PowerSeries.X : PowerSeries k)) f
  obtain ⟨m, hm⟩ := s.property
  have hnm : m ≤ n * m := by
    calc
      m = 1 * m := by rw [one_mul]
      _ ≤ n * m := Nat.mul_le_mul_right _ (Nat.succ_le_iff.mpr hn)
  refine ⟨m, (PowerSeries.X : PowerSeries k) ^ (n * m - m) * c ^ m * a, ?_⟩
  have hs' : f * ((PowerSeries.X ^ m : PowerSeries k) : LaurentSeries k) = a := by
    simpa only [hm] using hs
  rw [hb, mul_pow, ← pow_mul]
  have hpower : (PowerSeries.X : PowerSeries k) ^ (n * m) =
      PowerSeries.X ^ (n * m - m) * PowerSeries.X ^ m := by
    rw [← pow_add, Nat.sub_add_cancel hnm]
  rw [hpower, map_mul, map_mul, map_mul, map_mul]
  calc
    (((PowerSeries.X ^ (n * m - m) : PowerSeries k) : LaurentSeries k) *
      ((PowerSeries.X ^ m : PowerSeries k) : LaurentSeries k) *
      ((c ^ m : PowerSeries k) : LaurentSeries k)) * f =
      ((PowerSeries.X ^ (n * m - m) : PowerSeries k) : LaurentSeries k) *
      ((c ^ m : PowerSeries k) : LaurentSeries k) *
      (f * ((PowerSeries.X ^ m : PowerSeries k) : LaurentSeries k)) := by ring
    _ = _ := by rw [hs']

end Litt3.QuotientGeometry

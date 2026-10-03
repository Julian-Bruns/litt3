import Solutions.CartierAndSpin.OneVariableRestrictedConnection
import Solutions.CartierAndSpin.RestrictedConnectionBijections
import Solutions.CartierAndSpin.RestrictedCurvatureScalars

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {k R K : Type*} [Field k] [PerfectField k] [CommRing R] [Field K]
  [Algebra k K] [Algebra R K] {p : ℕ} [Fact p.Prime] [CharP k p] [CharP K p]

/-- Construct a full literal p-basis at the ORIGINAL normalized
parameter of any derivation in a genuine one-variable field. -/
theorem actual_one_variable_normalized_power_basis_exists
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdeg : Algebra.trdeg k K = 1) (D : Derivation R K K)
    (t : K) (hDt : D t = 1) : ∃ b : PowerPBasis K p, b.parameter = t := by
  obtain ⟨b⟩ := one_variable_power_p_basis_exists (p := p) hfg htrdeg
  apply power_p_basis_change_parameter_exists b t
  rintro ⟨r, hr⟩
  have hzero : D (r ^ p) = 0 := by
    rw [D.leibniz_pow, nsmul_eq_mul, CharP.cast_eq_zero K p, zero_mul]
  change r ^ p = t at hr
  rw [hr, hDt] at hzero
  exact one_ne_zero hzero

/-- Exact original connection alternatives, with all p-bases,
nilpotence, solutions and bijectivity derived from genuine FG/trdeg one.
No basis, separating field, curvature identity or literature premise
is supplied. The scalar coefficients stay in the ORIGINAL field. -/
theorem actual_one_variable_connection_alternatives
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdeg : Algebra.trdeg k K = 1) (D : Derivation R K K)
    (t : K) (hDt : D t = 1) (f : K) :
    (∀ a : K, D^[p] a = 0) ∧
    (∃ c : K, c ^ p = D^[p - 1] f + f ^ p) ∧
    ((∃ u : K, u ≠ 0 ∧ D u = f * u) ↔ D^[p - 1] f + f ^ p = 0) ∧
    (Function.Bijective (scalarDerivationConnection D f) ↔
      D^[p - 1] f + f ^ p ≠ 0) := by
  obtain ⟨b, hb⟩ := actual_one_variable_normalized_power_basis_exists hfg htrdeg D t hDt
  have hDb : D b.parameter = 1 := by simpa only [hb] using hDt
  exact ⟨actual_normalized_derivation_prime_iterate_zero b D hDb,
    actual_normalized_curvature_is_pth_power b D hDb f,
    actual_normalized_connection_kernel_iff b D hDb f,
    actual_normalized_connection_bijective_iff b D hDb f⟩

theorem actual_one_variable_curvature_unit_gauge_invariant
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdeg : Algebra.trdeg k K = 1) (D : Derivation R K K)
    (t : K) (hDt : D t = 1) (f g : K) (u : Kˣ)
    (hu : D (u : K) = (f - g) * (u : K)) :
    D^[p - 1] f + f ^ p = D^[p - 1] g + g ^ p := by
  obtain ⟨b, hb⟩ := actual_one_variable_normalized_power_basis_exists hfg htrdeg D t hDt
  exact actual_normalized_curvature_unit_gauge_invariant b D
    (by simpa only [hb] using hDt) f g u hu

end Litt3.CartierAndSpin

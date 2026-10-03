import Solutions.CartierAndSpin.RestrictedNormalizedDerivations
import Solutions.SharedTensors.SeparatingPBasisExistence
import Solutions.SharedTensors.PBasisChangeParameter

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {k R K : Type*} [Field k] [PerfectField k] [CommRing R] [Field K]
  [Algebra k K] [Algebra R K] {p : ℕ} [Fact p.Prime] [CharP k p] [CharP K p]

/-- The literal restricted connection formula in EVERY genuine one-
variable function field over perfect constants, for ANY normalized
actual derivation over ANY constant ring. The full p-basis at t is
constructed from genuine finite generation and trdeg one, rather than
supplied as a premise. No separating subfield or literature input remains. -/
theorem actual_one_variable_restricted_connection_identity
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdeg : Algebra.trdeg k K = 1) (D : Derivation R K K)
    (t : K) (hDt : D t = 1) (f a : K) :
    (scalarDerivationConnection D f)^[p] a = -(D^[p - 1] f + f ^ p) * a := by
  obtain ⟨b⟩ := one_variable_power_p_basis_exists (p := p) hfg htrdeg
  have hnot : t ∉ frobeniusSubfield K p := by
    rintro ⟨r, hr⟩
    have hzero : D (r ^ p) = 0 := by
      rw [D.leibniz_pow, nsmul_eq_mul, CharP.cast_eq_zero K p, zero_mul]
    change r ^ p = t at hr
    rw [hr, hDt] at hzero
    exact one_ne_zero hzero
  obtain ⟨b', hb'⟩ := power_p_basis_change_parameter_exists b t hnot
  exact actual_normalized_derivation_restricted_connection_identity b' D
    (by simpa only [hb'] using hDt) f a

end Litt3.CartierAndSpin

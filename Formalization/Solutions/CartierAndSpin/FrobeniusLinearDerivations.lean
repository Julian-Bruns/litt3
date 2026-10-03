import Definitions.SharedTensors.FrobeniusCoordinates
import Solutions.CartierAndSpin.ConnectionLeibniz

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {R K : Type*} [CommRing R] [Field K] [Algebra R K]
  {p : ℕ} [Fact p.Prime] [CharP K p]

/-- EVERY actual derivation kills the entire literal pth-power field.
No normalized parameter, p-basis, perfectness or finite degree is used. -/
theorem actual_derivation_kills_frobenius_subfield
    (D : Derivation R K K) (c : frobeniusSubfield K p) : D (c : K) = 0 := by
  have hc : ∃ r : K, r ^ p = (c : K) := c.property
  obtain ⟨r, hr⟩ := hc
  rw [← hr, D.leibniz_pow, nsmul_eq_mul, smul_eq_mul,
    CharP.cast_eq_zero K p, zero_mul]

/-- Canonically rebase ANY original derivation to the actual
pth-power subfield, retaining its SAME literal map on the field. -/
noncomputable def frobeniusLinearDerivation (D : Derivation R K K) :
    Derivation (frobeniusSubfield K p) K K where
  toFun := D
  map_add' := D.map_add
  map_smul' c x := by
    change D ((c : K) * x) = (c : K) * D x
    rw [D.leibniz, actual_derivation_kills_frobenius_subfield D c,
      smul_zero, add_zero]
    rfl
  map_one_eq_zero' := D.map_one_eq_zero
  leibniz' := D.leibniz

@[simp] theorem frobenius_linear_derivation_apply
    (D : Derivation R K K) (a : K) :
    frobeniusLinearDerivation (p := p) D a = D a := rfl

/-- Canonical rebasing retains the SAME original field function. -/
theorem frobenius_linear_derivation_function
    (D : Derivation R K K) :
    (frobeniusLinearDerivation (p := p) D : K → K) = D := rfl

/-- The actual connection retains its SAME original pointwise operator
under canonical rebasing; this is no scalar proxy. -/
theorem frobenius_linear_connection_function
    (D : Derivation R K K) (f : K) :
    (scalarDerivationConnection (frobeniusLinearDerivation (p := p) D) f : K → K) =
      scalarDerivationConnection D f := rfl

end Litt3.CartierAndSpin

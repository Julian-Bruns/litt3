import Mathlib.RingTheory.Kaehler.Basic
import Mathlib.Algebra.Group.TypeTags.Basic

namespace Litt3.CartierAndSpin

variable (k K : Type*) [CommRing k] [Field K] [Algebra k K]

/-- The actual logarithmic differential homomorphism from the original
field's multiplicative units to its universal differential module.
Additive notation on units records multiplication, rather than replacing
the original multiplicative group by a scalar proxy. -/
noncomputable def rationalLogarithmicDifferential :
    Additive Kˣ →+ KaehlerDifferential k K where
  toFun u := ((u.toMul : Kˣ) : K)⁻¹ •
    KaehlerDifferential.D k K ((u.toMul : Kˣ) : K)
  map_zero' := by
    change (1 : K)⁻¹ • KaehlerDifferential.D k K 1 = 0
    rw [(KaehlerDifferential.D k K).map_one_eq_zero, smul_zero]
  map_add' u v := by
    change (((u.toMul : Kˣ) : K) * ((v.toMul : Kˣ) : K))⁻¹ •
      KaehlerDifferential.D k K (((u.toMul : Kˣ) : K) * ((v.toMul : Kˣ) : K)) = _
    rw [(KaehlerDifferential.D k K).leibniz, smul_add, smul_smul, smul_smul]
    have hleft : (((u.toMul : Kˣ) : K) * ((v.toMul : Kˣ) : K))⁻¹ *
        ((u.toMul : Kˣ) : K) = ((v.toMul : Kˣ) : K)⁻¹ := by
      field_simp
    have hright : (((u.toMul : Kˣ) : K) * ((v.toMul : Kˣ) : K))⁻¹ *
        ((v.toMul : Kˣ) : K) = ((u.toMul : Kˣ) : K)⁻¹ := by
      field_simp
    rw [hleft, hright, add_comm]

@[simp] theorem rationalLogarithmicDifferential_apply (u : Additive Kˣ) :
    rationalLogarithmicDifferential k K u =
      ((u.toMul : Kˣ) : K)⁻¹ • KaehlerDifferential.D k K ((u.toMul : Kˣ) : K) := rfl

end Litt3.CartierAndSpin

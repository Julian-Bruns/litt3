import Definitions.CartierAndSpin.LogarithmicDifferentials
import Solutions.CartierAndSpin.LogarithmicFibers
import Solutions.SharedTensors.OneVariableCartier

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

section General

variable {k K : Type*} [CommRing k] [Field K] [Algebra k K]
variable {p : ℕ} [Fact p.Prime] [CharP K p]

/-- The literal logarithmic homomorphism's kernel consists precisely of
pth powers in the ORIGINAL multiplicative unit group. -/
theorem p_basis_rational_logarithmic_kernel
    (b : PowerPBasis K p) (e : KaehlerDifferential k K ≃ₗ[K] K)
    (he : e (KaehlerDifferential.D k K b.parameter) = 1) (u : Additive Kˣ) :
    rationalLogarithmicDifferential k K u = 0 ↔
      ∃ r : Additive Kˣ, p • r = u := by
  have hkernel := universal_logarithmic_eq_iff_pth_ratio b e he
    u.toMul.ne_zero (one_ne_zero : (1 : K) ≠ 0)
  simp only [inv_one, (KaehlerDifferential.D k K).map_one_eq_zero,
    smul_zero, div_one] at hkernel
  change ((u.toMul : Kˣ) : K)⁻¹ •
    KaehlerDifferential.D k K ((u.toMul : Kˣ) : K) = 0 ↔ _
  rw [hkernel]
  constructor
  · rintro ⟨r, hr⟩
    have hr0 : r ≠ 0 := by
      intro hz
      rw [hz, zero_pow (Fact.out : p.Prime).ne_zero] at hr
      exact u.toMul.ne_zero hr.symm
    refine ⟨Additive.ofMul (Units.mk0 r hr0), ?_⟩
    apply Additive.toMul.injective
    rw [toMul_nsmul]
    apply Units.ext
    simpa only [Units.val_pow_eq_pow_val, Units.val_mk0] using hr
  · rintro ⟨r, hr⟩
    refine ⟨((r.toMul : Kˣ) : K), ?_⟩
    have h := congrArg (fun z : Additive Kˣ => ((z.toMul : Kˣ) : K)) hr
    simpa only [toMul_nsmul, Units.val_pow_eq_pow_val] using h

omit [Fact p.Prime] [CharP K p] in
/-- The actual logarithmic homomorphism lands in the literal fixed
subgroup of every intrinsic rational Cartier operator. -/
theorem rational_logarithmic_differential_cartier_fixed
    (C : RationalCartierOperator k K p) (u : Additive Kˣ) :
    C.toAddHom (rationalLogarithmicDifferential k K u) =
      rationalLogarithmicDifferential k K u :=
  C.fixes_logarithmic ((u.toMul : Kˣ) : K)

end General

variable {k K : Type*} [Field k] [Field K] [Algebra k K]
variable {p : ℕ} [Fact p.Prime] [CharP k p] [CharP K p] [PerfectField k]

/-- Full logarithmic-kernel exactness on any actual one-variable field
over perfect constants. Its p-basis and original universal coordinate
are derived, with no presentation or literature-existence premise. -/
theorem one_variable_rational_logarithmic_kernel
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdeg : Algebra.trdeg k K = 1) (u : Additive Kˣ) :
    rationalLogarithmicDifferential k K u = 0 ↔
      ∃ r : Additive Kˣ, p • r = u := by
  obtain ⟨b⟩ := one_variable_power_p_basis_exists (p := p) hfg htrdeg
  obtain ⟨e, he⟩ := p_basis_perfect_base_kaehler_coordinate_exists (k := k) b
  exact p_basis_rational_logarithmic_kernel b e he u

end Litt3.CartierAndSpin

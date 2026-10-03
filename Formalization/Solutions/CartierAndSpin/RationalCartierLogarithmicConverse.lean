import Definitions.CartierAndSpin.CartierFixedDifferentials
import Definitions.CartierAndSpin.LogarithmicDifferentials
import Solutions.CartierAndSpin.NormalizedPBasisDerivationComparison
import Solutions.SharedTensors.TaylorPBasisConnection
import Solutions.SharedTensors.OneVariableCartier

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

section PBasis

variable {k K : Type*} [CommRing k] [Field K] [Algebra k K]
variable {p : ℕ} [Fact p.Prime] [CharP K p]

/-- The full rational logarithmic Cartier criterion on the ORIGINAL
universal module. The converse constructs a nonzero original field
solution by actual Taylor scalar extension and descent; no logarithmic
solution, matrix singularity or curvature conclusion is assumed. -/
theorem p_basis_cartier_fixed_iff_logarithmic
    (C : RationalCartierOperator k K p) (b : PowerPBasis K p)
    (e : KaehlerDifferential k K ≃ₗ[K] K)
    (he : e (KaehlerDifferential.D k K b.parameter) = 1)
    (omega : KaehlerDifferential k K) :
    C.toAddHom omega = omega ↔
      ∃ u : K, u ≠ 0 ∧ omega = u⁻¹ • KaehlerDifferential.D k K u := by
  constructor
  · intro hfixed
    have hcoeff := congrArg e hfixed
    rw [C.coordinate_formula b e he] at hcoeff
    obtain ⟨D, hDt⟩ := p_basis_normalized_derivation_exists b
    obtain ⟨u, hu, hDu⟩ := descended_connection_kernel b D hDt (e omega) hcoeff
    refine ⟨u, hu, ?_⟩
    apply e.injective
    rw [map_smul, smul_eq_mul,
      ← normalized_p_basis_derivation_is_universal_coordinate b D hDt e he u, hDu]
    field_simp
  · rintro ⟨u, _, rfl⟩
    exact C.fixes_logarithmic u

/-- The literal range of the actual logarithmic unit homomorphism is
the complete Cartier-fixed subgroup under the actual full p-basis. -/
theorem p_basis_rational_logarithmic_range
    (C : RationalCartierOperator k K p) (b : PowerPBasis K p)
    (e : KaehlerDifferential k K ≃ₗ[K] K)
    (he : e (KaehlerDifferential.D k K b.parameter) = 1) :
    (rationalLogarithmicDifferential k K).range = intrinsicCartierFixedSubgroup C := by
  ext omega
  rw [mem_intrinsicCartierFixedSubgroup, p_basis_cartier_fixed_iff_logarithmic C b e he]
  constructor
  · rintro ⟨u, hu⟩
    exact ⟨((u.toMul : Kˣ) : K), u.toMul.ne_zero, hu.symm⟩
  · rintro ⟨u, hu, homega⟩
    exact ⟨Additive.ofMul (Units.mk0 u hu), homega.symm⟩

end PBasis

variable {k K : Type*} [Field k] [Field K] [Algebra k K]
variable {p : ℕ} [Fact p.Prime] [CharP k p] [CharP K p] [PerfectField k]

/-- The complete logarithmic Cartier converse for every actual
one-variable function field over perfect constants. Finite generation
and transcendence degree one construct the p-basis and true coordinate. -/
theorem one_variable_cartier_fixed_iff_logarithmic
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdeg : Algebra.trdeg k K = 1)
    (C : RationalCartierOperator k K p) (omega : KaehlerDifferential k K) :
    C.toAddHom omega = omega ↔
      ∃ u : K, u ≠ 0 ∧ omega = u⁻¹ • KaehlerDifferential.D k K u := by
  obtain ⟨b⟩ := one_variable_power_p_basis_exists (p := p) hfg htrdeg
  obtain ⟨e, he⟩ := p_basis_perfect_base_kaehler_coordinate_exists (k := k) b
  exact p_basis_cartier_fixed_iff_logarithmic C b e he omega

theorem one_variable_rational_logarithmic_range
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdeg : Algebra.trdeg k K = 1) (C : RationalCartierOperator k K p) :
    (rationalLogarithmicDifferential k K).range = intrinsicCartierFixedSubgroup C := by
  obtain ⟨b⟩ := one_variable_power_p_basis_exists (p := p) hfg htrdeg
  obtain ⟨e, he⟩ := p_basis_perfect_base_kaehler_coordinate_exists (k := k) b
  exact p_basis_rational_logarithmic_range C b e he

end Litt3.CartierAndSpin

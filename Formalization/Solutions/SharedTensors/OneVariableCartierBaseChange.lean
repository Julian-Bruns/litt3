import Solutions.SharedTensors.OneVariableCartier
import Solutions.SharedTensors.SeparablePBasisTransport
import Solutions.SharedTensors.RationalCartierBaseChange

namespace Litt3.SharedTensors

variable {k K L : Type*} [Field k] [Field K] [Field L] [PerfectField k]
  [Algebra k K] [Algebra k L] [Algebra K L] [IsScalarTower k K L]
  [Algebra.IsSeparable K L]
variable {p : ℕ} [Fact p.Prime] [CharP k p] [CharP K p] [CharP L p]

/-- Full separable base change from a genuine one-variable field.
The upstairs extension may be infinite. Compatible p-bases and normalized
coordinates are constructed, without any upstairs finite-generation input. -/
theorem one_variable_rational_cartier_separable_base_change
    (hfgK : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdegK : Algebra.trdeg k K = 1)
    (CK : RationalCartierOperator k K p) (CL : RationalCartierOperator k L p)
    (omega : KaehlerDifferential k K) :
    CL.toAddHom (KaehlerDifferential.map k k K L omega) =
      KaehlerDifferential.map k k K L (CK.toAddHom omega) := by
  obtain ⟨bK⟩ := one_variable_power_p_basis_exists (p := p) hfgK htrdegK
  obtain ⟨e, he⟩ := p_basis_perfect_base_kaehler_coordinate_exists (k := k) bK
  obtain ⟨bL, hbL⟩ := separable_power_p_basis_exists (L := L) bK
  exact rational_cartier_separable_base_change CK CL bK bL hbL e he omega

/-- Existence also propagates to every actual separable algebraic
extension, without assuming that extension finitely generated. -/
theorem one_variable_separable_extension_cartier_exists
    (hfgK : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdegK : Algebra.trdeg k K = 1) :
    Nonempty (RationalCartierOperator k L p) := by
  obtain ⟨bK⟩ := one_variable_power_p_basis_exists (p := p) hfgK htrdegK
  obtain ⟨bL, _⟩ := separable_power_p_basis_exists (L := L) bK
  obtain ⟨eL, heL⟩ := p_basis_perfect_base_kaehler_coordinate_exists (k := k) bL
  exact ⟨intrinsicRationalCartier bL eL heL⟩

theorem one_variable_separable_extension_cartier_unique
    (hfgK : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdegK : Algebra.trdeg k K = 1)
    (C C' : RationalCartierOperator k L p) :
    C.toAddHom = C'.toAddHom := by
  obtain ⟨bK⟩ := one_variable_power_p_basis_exists (p := p) hfgK htrdegK
  obtain ⟨bL, _⟩ := separable_power_p_basis_exists (L := L) bK
  obtain ⟨eL, heL⟩ := p_basis_perfect_base_kaehler_coordinate_exists (k := k) bL
  exact rational_cartier_intrinsic_unique C C' bL eL heL

end Litt3.SharedTensors

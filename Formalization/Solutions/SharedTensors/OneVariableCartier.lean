import Solutions.SharedTensors.RationalCartierLogarithmic
import Solutions.SharedTensors.RationalCartierFormula
import Solutions.SharedTensors.SeparatingPBasisExistence

namespace Litt3.SharedTensors

variable {k K : Type*} [Field k] [Field K] [Algebra k K]
variable {p : ℕ} [Fact p.Prime] [CharP k p] [CharP K p] [PerfectField k]

/-- Intrinsic Cartier exists on the entire actual rational differential
module of every genuine one-variable function field over perfect
constants. All field presentations and p-bases are constructed. -/
theorem one_variable_rational_cartier_exists
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdeg : Algebra.trdeg k K = 1) :
    Nonempty (RationalCartierOperator k K p) := by
  obtain ⟨b⟩ := one_variable_power_p_basis_exists (p := p) hfg htrdeg
  obtain ⟨e, he⟩ := p_basis_perfect_base_kaehler_coordinate_exists (k := k) b
  exact ⟨intrinsicRationalCartier b e he⟩

/-- The full standard intrinsic characterization is unique, with no
supplied p-basis or separating-parameter premise. -/
theorem one_variable_rational_cartier_unique
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdeg : Algebra.trdeg k K = 1)
    (C C' : RationalCartierOperator k K p) :
    C.toAddHom = C'.toAddHom := by
  obtain ⟨b⟩ := one_variable_power_p_basis_exists (p := p) hfg htrdeg
  obtain ⟨e, he⟩ := p_basis_perfect_base_kaehler_coordinate_exists (k := k) b
  exact rational_cartier_intrinsic_unique C C' b e he

/-- A selected actual operator; uniqueness proves that every parameter
and coordinate construction gives exactly this additive map. -/
noncomputable def oneVariableRationalCartier
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdeg : Algebra.trdeg k K = 1) : RationalCartierOperator k K p :=
  Classical.choice (one_variable_rational_cartier_exists hfg htrdeg)

theorem one_variable_rational_cartier_zero_iff_exact
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdeg : Algebra.trdeg k K = 1)
    (C : RationalCartierOperator k K p) (omega : KaehlerDifferential k K) :
    C.toAddHom omega = 0 ↔ ∃ f : K, KaehlerDifferential.D k K f = omega := by
  obtain ⟨b⟩ := one_variable_power_p_basis_exists (p := p) hfg htrdeg
  obtain ⟨e, he⟩ := p_basis_perfect_base_kaehler_coordinate_exists (k := k) b
  have hC := rational_cartier_intrinsic_unique C (intrinsicRationalCartier b e he) b e he
  rw [hC]
  exact constructedRationalCartier_zero_iff_exact b e he omega

theorem one_variable_rational_cartier_surjective
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdeg : Algebra.trdeg k K = 1) (C : RationalCartierOperator k K p) :
    Function.Surjective C.toAddHom := by
  obtain ⟨b⟩ := one_variable_power_p_basis_exists (p := p) hfg htrdeg
  obtain ⟨e, he⟩ := p_basis_perfect_base_kaehler_coordinate_exists (k := k) b
  rw [rational_cartier_intrinsic_unique C (intrinsicRationalCartier b e he) b e he]
  exact constructedRationalCartier_surjective b e he

end Litt3.SharedTensors

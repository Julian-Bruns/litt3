import Solutions.CartierAndSpin.GeneratingCoordinateDerivatives

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors IntermediateField

variable {k L : Type*} [Field k] [Field L] [Algebra k L] [PerfectField k]
variable {p : ℕ} [Fact p.Prime] [CharP k p] [CharP L p]

/-- A genuine generating pair in a one-variable function field supplies
its own separating coordinate, chosen from the pair itself. Neither a
derivation, a p-basis, nor separability is an input. -/
theorem one_variable_generating_pair_coordinate_exists
    (htrdeg : Algebra.trdeg k L = 1) (u v : L)
    (hgen : IntermediateField.adjoin k {u, v} = ⊤) :
    ∃ (b : PowerPBasis L p) (D : Derivation k L L),
      (b.parameter = u ∨ b.parameter = v) ∧ D b.parameter = 1 ∧
      FiniteDimensional (IntermediateField.adjoin k {b.parameter}) L ∧
      Algebra.IsSeparable (IntermediateField.adjoin k {b.parameter}) L := by
  have hfg : IntermediateField.FG (F := k) (E := L) ⊤ := by
    rw [← hgen]
    exact fg_adjoin_of_finite ((Set.finite_singleton v).insert u)
  obtain ⟨b0⟩ := one_variable_power_p_basis_exists (p := p) hfg htrdeg
  obtain ⟨D0, ht0⟩ := p_basis_perfect_base_derivation_exists (k := k) b0
  have hpair := generating_pair_nonzero_derivation D0 u v hgen
    ⟨b0.parameter, by rw [ht0]; exact one_ne_zero⟩
  have hnonpth (r : L) (hr : D0 r ≠ 0) : r ∉ frobeniusSubfield L p := by
    rintro ⟨z, hz⟩
    change z ^ p = r at hz
    apply hr
    rw [← hz, D0.leibniz_pow, nsmul_eq_mul, CharP.cast_eq_zero, zero_mul]
  rcases hpair with hu | hv
  · obtain ⟨b, hb⟩ := power_p_basis_change_parameter_exists b0 u (hnonpth u hu)
    obtain ⟨D, ht⟩ := p_basis_perfect_base_derivation_exists (k := k) b
    obtain ⟨hfinite, hsep⟩ := one_variable_separable_of_derivation_ne_zero p hfg htrdeg
      D b.parameter (by rw [ht]; exact one_ne_zero)
    exact ⟨b, D, Or.inl hb, ht, hfinite, hsep⟩
  · obtain ⟨b, hb⟩ := power_p_basis_change_parameter_exists b0 v (hnonpth v hv)
    obtain ⟨D, ht⟩ := p_basis_perfect_base_derivation_exists (k := k) b
    obtain ⟨hfinite, hsep⟩ := one_variable_separable_of_derivation_ne_zero p hfg htrdeg
      D b.parameter (by rw [ht]; exact one_ne_zero)
    exact ⟨b, D, Or.inr hb, ht, hfinite, hsep⟩

end Litt3.CartierAndSpin

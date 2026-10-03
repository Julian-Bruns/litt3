import Solutions.SharedTensors.PBasisDerivativeTransport
import Solutions.SharedTensors.LaurentPBasisGeneration
import Solutions.SharedTensors.PBasisChangeParameter

namespace Litt3.QuotientGeometry

open Litt3.SharedTensors

variable {k : Type*} [Field k] [PerfectField k]
  {p : ℕ} [Fact p.Prime] [CharP k p]

noncomputable local instance : Module k (LaurentSeries k) := Algebra.toModule

include p

/-- ANY automorphism of the ENTIRE Laurent field satisfies the actual
derivative chain rule over perfect characteristic-p coefficients. No
continuity, coefficient truncation, power-series preservation, or
separability assumption is used. -/
theorem laurent_field_equiv_derivative_chain_rule
    (E : LaurentSeries k ≃+* LaurentSeries k) (f : LaurentSeries k) :
    Litt3.CartierAndSpin.laurentDerivation k (E f) =
      E (Litt3.CartierAndSpin.laurentDerivation k f) *
        Litt3.CartierAndSpin.laurentDerivation k (E (laurentParameter k)) := by
  obtain ⟨b0, hb0⟩ := laurent_power_p_basis_exists (k := k) (p := p)
  have hnotpth : E (laurentParameter k) ∉ frobeniusSubfield (LaurentSeries k) p := by
    rintro ⟨a, ha⟩
    change a ^ p = E (laurentParameter k) at ha
    apply laurent_parameter_not_in_pth_field (k := k) (p := p)
    refine ⟨E.symm a, ?_⟩
    change (E.symm a) ^ p = laurentParameter k
    apply E.injective
    rw [map_pow, E.apply_symm_apply]
    exact ha
  obtain ⟨b1, hb1⟩ := power_p_basis_change_parameter_exists b0
    (E (laurentParameter k)) hnotpth
  have hb : b1.parameter = E b0.parameter := by rw [hb0, hb1]
  let D := Litt3.CartierAndSpin.laurentDerivation k
  have hsource := derivation_p_basis_module_expansion b0 D f
  rw [hb0, laurent_derivation_parameter, smul_eq_mul, mul_one] at hsource
  have htarget := derivation_p_basis_module_expansion b1 D (E f)
  rw [hb1, smul_eq_mul] at htarget
  rw [htarget, hsource, map_sum]
  congr 1
  apply Finset.sum_congr rfl
  intro i _
  have hci := pRootCoefficient_map E.toRingHom b0 b1 hb f i
  change pRootCoefficient (LaurentSeries k) p b1 (E f) i =
    E (pRootCoefficient (LaurentSeries k) p b0 f i) at hci
  rw [map_mul, map_mul, map_pow, map_pow, map_natCast, hci]

end Litt3.QuotientGeometry

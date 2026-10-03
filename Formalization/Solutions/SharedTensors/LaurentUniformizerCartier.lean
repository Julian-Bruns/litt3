import Solutions.SharedTensors.PBasisCartierTransport
import Solutions.SharedTensors.LaurentCartierRegularity
import Solutions.SharedTensors.OneVariableCartier
import Solutions.SharedTensors.PBasisPerfectConstants

namespace Litt3.SharedTensors

open scoped LaurentSeries

variable {k K : Type*} [Field k] [Field K] [PerfectField k]
  [Algebra k K] [Algebra K (LaurentSeries k)]
variable {p : ℕ} [Fact p.Prime] [CharP k p] [CharP K p]

/-- An original parameter whose actual Laurent image is t cannot be
an original p-th power. No algebraic/separable completion assumption. -/
theorem laurent_uniformizer_original_not_pth (t : K)
    (ht : algebraMap K (LaurentSeries k) t = laurentParameter k) :
    t ∉ frobeniusSubfield K p := by
  rintro ⟨a, ha⟩
  change a ^ p = t at ha
  apply laurent_parameter_not_in_pth_field (k := k) (p := p)
  refine ⟨algebraMap K (LaurentSeries k) a, ?_⟩
  change (algebraMap K (LaurentSeries k) a) ^ p = laurentParameter k
  rw [← map_pow, ha, ht]

/-- A genuine one-variable field's Cartier coefficients in an actual
Laurent uniformizer are derived from full compatible p-bases. The
completion embedding need not be an algebraic extension. -/
theorem one_variable_cartier_laurent_uniformizer
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdeg : Algebra.trdeg k K = 1)
    (t : K) (ht : algebraMap K (LaurentSeries k) t = laurentParameter k)
    (CK : RationalCartierOperator k K p) :
    ∃ eK : KaehlerDifferential k K ≃ₗ[K] K,
      eK (KaehlerDifferential.D k K t) = 1 ∧
      ∀ omega n,
        (algebraMap K (LaurentSeries k) (eK (CK.toAddHom omega))).coeff n =
          (frobeniusEquiv k p).symm
            ((algebraMap K (LaurentSeries k) (eK omega)).coeff
              ((p : ℤ) * n + (p - 1 : ℕ))) := by
  obtain ⟨b0⟩ := one_variable_power_p_basis_exists (p := p) hfg htrdeg
  obtain ⟨bK, hbK⟩ := power_p_basis_change_parameter_exists b0 t
    (laurent_uniformizer_original_not_pth t ht)
  obtain ⟨eK, heK⟩ := p_basis_perfect_base_kaehler_coordinate_exists (k := k) bK
  obtain ⟨bL, hbL⟩ := laurent_power_p_basis_exists (k := k) (p := p)
  have heKb : eK (KaehlerDifferential.D k K t) = 1 := by rwa [hbK] at heK
  have hb : bL.parameter = algebraMap K (LaurentSeries k) bK.parameter := by
    rw [hbL, hbK, ht]
  refine ⟨eK, heKb, ?_⟩
  intro omega n
  rw [CK.coordinate_formula bK eK heK]
  calc
    _ = (rationalCartierCoefficient (LaurentSeries k) p bL
        (algebraMap K (LaurentSeries k) (eK omega))).coeff n :=
      congrArg (fun f : LaurentSeries k => f.coeff n)
        (rationalCartierCoefficient_map (algebraMap K (LaurentSeries k)) bK bL hb
          (eK omega)).symm
    _ = _ := laurent_rational_cartier_coefficient bL hbL _ n

end Litt3.SharedTensors

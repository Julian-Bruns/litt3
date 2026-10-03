import Solutions.QuotientGeometry.ConstantPolynomialFieldModel
import Solutions.QuotientGeometry.PoleShiftCoordinates
import Solutions.QuotientGeometry.LaurentParameterRecovery

namespace Litt3.QuotientGeometry

/-- Identifies a literal supplied completed-field map when its pole
is a constant polynomial in an actual pole-shift coordinate. -/
theorem constant_polynomial_completed_map_model
    {k : Type*} [Field k] (g : Polynomial k) (hg : 0 < g.natDegree) (hzero : g.coeff 0 = 0)
    (w : PowerSeries k) (φ : PowerSeries k →ₐ[k] PowerSeries k)
    (Ψ : LaurentSeries k →+* LaurentSeries k)
    (hΨ : ∀ r : PowerSeries k, Ψ (r : LaurentSeries k) = (φ r : PowerSeries k))
    (hφzero : PowerSeries.constantCoeff (φ PowerSeries.X) = 0)
    (hpole : Ψ (HahnSeries.single (-1) 1) =
      g.eval₂ HahnSeries.C (HahnSeries.single (-1) 1 + (w : LaurentSeries k))) :
    ∃ e : AdjoinRoot (constantPolePolynomial g) ≃+* LaurentSeries k,
      ∀ r : LaurentSeries k, e (AdjoinRoot.of (constantPolePolynomial g) r) = Ψ r := by
  obtain ⟨e, E, hE, hEpole⟩ := pole_shift_power_series_coordinates w
  obtain ⟨eG, heG⟩ := constant_polynomial_laurent_field_model g hg hzero
  let b := constantPolynomialParameter g
  have hb : PowerSeries.constantCoeff b = 0 := constant_polynomial_parameter_zero g hg
  let Φ := parameterLaurentMap b hb (constant_polynomial_parameter_injective g hg)
  let χ : PowerSeries k →ₐ[k] PowerSeries k :=
    e.toAlgHom.comp (PowerSeries.substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero' hb))
  let Ω : LaurentSeries k →+* LaurentSeries k := E.toRingHom.comp Φ
  have hΩ : ∀ r : PowerSeries k, Ω (r : LaurentSeries k) = (χ r : PowerSeries k) := by
    intro r
    change E (Φ (r : LaurentSeries k)) =
      (e ((PowerSeries.substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero' hb)) r) : PowerSeries k)
    rw [parameter_laurent_map_power_series, hE]
    exact congrArg (fun f : PowerSeries k => ((e f : PowerSeries k) : LaurentSeries k))
      (congr_fun (PowerSeries.coe_substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero' hb)) r).symm
  have hC : E.toRingHom.comp (HahnSeries.C : k →+* LaurentSeries k) = HahnSeries.C := by
    apply RingHom.ext
    intro a
    change E (HahnSeries.C a) = HahnSeries.C a
    simpa only [LaurentSeries.algebraMap_apply] using E.commutes a
  have heq : Ψ = Ω := by
    apply laurent_field_maps_eq_of_pole_image φ χ Ψ Ω hΨ hΩ hφzero
    change Ψ (HahnSeries.single (-1) 1) = E (Φ (HahnSeries.single (-1) 1))
    rw [constant_polynomial_parameter_pole_image g hg]
    change Ψ (HahnSeries.single (-1) 1) =
      E.toRingHom (g.eval₂ HahnSeries.C (HahnSeries.single (-1) 1))
    rw [Polynomial.hom_eval₂, hC]
    change Ψ (HahnSeries.single (-1) 1) = g.eval₂ HahnSeries.C (E (HahnSeries.single (-1) 1))
    rw [hEpole]
    exact hpole
  refine ⟨eG.trans E.toRingEquiv, ?_⟩
  intro r
  change E (eG (AdjoinRoot.of _ r)) = Ψ r
  rw [heG]
  exact (congr_fun (congrArg DFunLike.coe heq) r).symm

end Litt3.QuotientGeometry

import Solutions.QuotientGeometry.AffinePoleCoordinates
import Solutions.QuotientGeometry.ConstantPolynomialParameter
import Solutions.QuotientGeometry.LaurentParameterRecovery

namespace Litt3.QuotientGeometry

/-- A genuine affine polynomial symmetry gives an actual compatible
Laurent automorphism fixing the entire parameter field. -/
theorem constant_polynomial_affine_parameter_automorphism_with_power_series
    {k : Type*} [Field k] (g : Polynomial k) (hg : 0 < g.natDegree)
    (ζ b : k) (hζ : ζ ≠ 0)
    (hpoly : g.comp (Polynomial.C ζ * Polynomial.X + Polynomial.C b) = g) :
    let Φ := parameterLaurentMap (constantPolynomialParameter g) (constant_polynomial_parameter_zero g hg)
      (constant_polynomial_parameter_injective g hg)
    ∃ (e : PowerSeries k ≃ₐ[k] PowerSeries k) (E : LaurentSeries k ≃ₐ[k] LaurentSeries k),
      (∀ f : PowerSeries k, E (f : LaurentSeries k) = (e f : PowerSeries k)) ∧
      (∀ r : LaurentSeries k, E (Φ r) = Φ r) ∧
      E (HahnSeries.single (-1) 1) = HahnSeries.C ζ * HahnSeries.single (-1) 1 + HahnSeries.C b := by
  obtain ⟨e, E, hE, hEpole⟩ := affine_pole_power_series_coordinates ζ b hζ
  let B := constantPolynomialParameter g
  have hB : PowerSeries.constantCoeff B = 0 := constant_polynomial_parameter_zero g hg
  let φ : PowerSeries k →ₐ[k] PowerSeries k :=
    PowerSeries.substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero' hB)
  let Φ := parameterLaurentMap B hB (constant_polynomial_parameter_injective g hg)
  let Ω : LaurentSeries k →+* LaurentSeries k := E.toRingHom.comp Φ
  have hΦ : ∀ r : PowerSeries k, Φ (r : LaurentSeries k) = (φ r : PowerSeries k) := by
    intro r
    rw [parameter_laurent_map_power_series]
    exact congrArg (fun f : PowerSeries k => (f : LaurentSeries k))
      (congr_fun (PowerSeries.coe_substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero' hB)) r).symm
  have hΩ : ∀ r : PowerSeries k, Ω (r : LaurentSeries k) = ((e.toAlgHom.comp φ) r : PowerSeries k) := by
    intro r
    change E (Φ (r : LaurentSeries k)) = (e (φ r) : PowerSeries k)
    rw [hΦ, hE]
  have hφzero : PowerSeries.constantCoeff (φ PowerSeries.X) = 0 := by
    rw [show φ = PowerSeries.substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero' hB) from rfl,
      PowerSeries.coe_substAlgHom, PowerSeries.subst_X (PowerSeries.HasSubst.of_constantCoeff_zero' hB)]
    exact hB
  have hC : E.toRingHom.comp (HahnSeries.C : k →+* LaurentSeries k) = HahnSeries.C := by
    apply RingHom.ext
    intro a
    change E (HahnSeries.C a) = HahnSeries.C a
    simpa only [LaurentSeries.algebraMap_apply] using E.commutes a
  have hpole : Φ (HahnSeries.single (-1) 1) = Ω (HahnSeries.single (-1) 1) := by
    change Φ (HahnSeries.single (-1) 1) = E.toRingHom (Φ (HahnSeries.single (-1) 1))
    rw [constant_polynomial_parameter_pole_image g hg, Polynomial.hom_eval₂, hC]
    change g.eval₂ HahnSeries.C (HahnSeries.single (-1) 1) =
      g.eval₂ HahnSeries.C (E (HahnSeries.single (-1) 1))
    rw [hEpole]
    have h := congrArg (fun f : Polynomial k => f.eval₂ HahnSeries.C (HahnSeries.single (-1) 1)) hpoly
    dsimp only at h
    rw [Polynomial.eval₂_comp] at h
    simpa only [Polynomial.eval₂_add, Polynomial.eval₂_mul, Polynomial.eval₂_C, Polynomial.eval₂_X] using h.symm
  have heq := laurent_field_maps_eq_of_pole_image φ (e.toAlgHom.comp φ) Φ Ω hΦ hΩ hφzero hpole
  refine ⟨e, E, hE, ?_, hEpole⟩
  intro r
  exact (congr_fun (congrArg DFunLike.coe heq) r).symm

theorem constant_polynomial_affine_parameter_automorphism
    {k : Type*} [Field k] (g : Polynomial k) (hg : 0 < g.natDegree)
    (ζ b : k) (hζ : ζ ≠ 0)
    (hpoly : g.comp (Polynomial.C ζ * Polynomial.X + Polynomial.C b) = g) :
    let Φ := parameterLaurentMap (constantPolynomialParameter g) (constant_polynomial_parameter_zero g hg)
      (constant_polynomial_parameter_injective g hg)
    ∃ E : LaurentSeries k ≃ₐ[k] LaurentSeries k,
      (∀ r : LaurentSeries k, E (Φ r) = Φ r) ∧
      E (HahnSeries.single (-1) 1) = HahnSeries.C ζ * HahnSeries.single (-1) 1 + HahnSeries.C b := by
  obtain ⟨_, E, _, hbase, hpole⟩ :=
    constant_polynomial_affine_parameter_automorphism_with_power_series g hg ζ b hζ hpoly
  exact ⟨E, hbase, hpole⟩

end Litt3.QuotientGeometry

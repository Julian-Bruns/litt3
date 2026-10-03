import Solutions.QuotientGeometry.WeakLaurentClassification
import Solutions.QuotientGeometry.WeakTameRootIndependence
import Solutions.QuotientGeometry.ActualRootMapFactorization
import Solutions.QuotientGeometry.LaurentPoleParameters
import Solutions.CartierAndSpin.LaurentDerivation

namespace Litt3.QuotientGeometry

/-- Classifies BOTH supplied original completed embeddings over the
SAME full beta field. The intermediate Laurent maps are constructed,
and their compatibility with an arbitrary beta-field identification
is proved by genuine algebraic power-field generation. -/
theorem weak_tame_completed_fields_equiv_iff
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hh : 0 < h) (hdiv : h ∣ p - 1)
    (φβ χβ : PowerSeries k →ₐ[k] PowerSeries k)
    (Ψβ Ωβ : LaurentSeries k →+* LaurentSeries k)
    (hΨβ : ∀ r : PowerSeries k, Ψβ (r : LaurentSeries k) = (φβ r : PowerSeries k))
    (hΩβ : ∀ r : PowerSeries k, Ωβ (r : LaurentSeries k) = (χβ r : PowerSeries k))
    (ψ χ : LaurentSeries k)
    (hψroot : ψ ^ h = Ψβ (HahnSeries.single (-1) 1))
    (hχroot : χ ^ h = Ωβ (HahnSeries.single (-1) 1))
    (hψorder : ψ.order = -(p : ℤ)) (hχorder : χ.order = -(p : ℤ))
    (hψderiv : (LaurentSeries.derivative k ψ).order = -2)
    (hχderiv : (LaurentSeries.derivative k χ).order = -2) :
    ParameterFieldsEquivalent Ψβ Ωβ ↔ weakPoleScalar p ψ = weakPoleScalar p χ := by
  have hp : 1 < p := (Fact.out : p.Prime).one_lt
  obtain ⟨φψ, Ψψ, hΨψ, hzeroψ, hpoleψ⟩ := laurent_pole_parameter_maps p (by omega) ψ hψorder
  obtain ⟨φχ, Ψχ, hΨχ, hzeroχ, hpoleχ⟩ := laurent_pole_parameter_maps p (by omega) χ hχorder
  have hfactorψ := completed_map_factor_of_actual_root_maps p h (by omega) hh φβ φψ Ψβ Ψψ
    hΨβ hΨψ ψ hpoleψ hψroot hψorder
  have hfactorχ := completed_map_factor_of_actual_root_maps p h (by omega) hh χβ φχ Ωβ Ψχ
    hΩβ hΨχ χ hpoleχ hχroot hχorder
  have hscalarψ : weakLaurentInvariant p Ψψ = weakPoleScalar p ψ := by
    simp only [weakLaurentInvariant, weakPoleScalar, hpoleψ]
  have hscalarχ : weakLaurentInvariant p Ψχ = weakPoleScalar p χ := by
    simp only [weakLaurentInvariant, weakPoleScalar, hpoleχ]
  constructor
  · rintro ⟨e, he⟩
    have hχne : χ ≠ 0 := by intro hz; simp [hz] at hχorder; omega
    have hpowers : χ ^ h = (e ψ) ^ h := by rw [← map_pow, hψroot, he, hχroot]
    obtain ⟨ζ, hζ, _, hζp, heψ⟩ :=
      laurent_tame_roots_differ_by_constant p h hh hdiv χ (e ψ) hχne hpowers
    have hCne : (HahnSeries.C ζ : LaurentSeries k) ≠ 0 := by
      rw [HahnSeries.C_apply]
      exact HahnSeries.single_ne_zero hζ
    have heψorder : (e ψ).order = -(p : ℤ) := by
      rw [heψ, HahnSeries.order_mul hCne hχne, HahnSeries.C_apply,
        HahnSeries.order_single hζ, hχorder, zero_add]
    have hχDne : LaurentSeries.derivative k χ ≠ 0 := by intro hz; simp [hz] at hχderiv
    have hD : LaurentSeries.derivative k (HahnSeries.C ζ * χ) =
        HahnSeries.C ζ * LaurentSeries.derivative k χ := by
      simpa [HahnSeries.C_apply] using
        Litt3.CartierAndSpin.laurent_derivative_single_mul (0 : ℤ) ζ χ
    have heψderiv : (LaurentSeries.derivative k (e ψ)).order = -2 := by
      rw [heψ, hD, HahnSeries.order_mul hCne hχDne, HahnSeries.C_apply,
        HahnSeries.order_single hζ, hχderiv, zero_add]
    obtain ⟨φe, Ψe, hΨe, hzeroe, hpolee⟩ := laurent_pole_parameter_maps p (by omega) (e ψ) heψorder
    have heψroot : (e ψ) ^ h = Ωβ (HahnSeries.single (-1) 1) := by rw [← map_pow, hψroot, he]
    have hfactore := completed_map_factor_of_actual_root_maps p h (by omega) hh χβ φe Ωβ Ψe
      hΩβ hΨe (e ψ) hpolee heψroot heψorder
    have hmaps : e.toRingHom.comp Ψψ = Ψe := by
      apply power_parameter_maps_ext h hh
      · apply RingHom.ext
        intro r
        change e (Ψψ (powerLaurentMap h hh r)) = Ψe (powerLaurentMap h hh r)
        have hleft := congr_fun (congrArg DFunLike.coe hfactorψ) r
        have hright := congr_fun (congrArg DFunLike.coe hfactore) r
        change Ψβ r = Ψψ (powerLaurentMap h hh r) at hleft
        change Ωβ r = Ψe (powerLaurentMap h hh r) at hright
        rw [← hleft, he, hright]
      · change e (Ψψ (HahnSeries.single (-1) 1)) = Ψe (HahnSeries.single (-1) 1)
        rw [hpoleψ, hpolee]
    have hscalar := (weak_laurent_completed_fields_equiv_iff p φψ φe Ψψ Ψe hΨψ hΨe hzeroψ hzeroe
      (by rw [hpoleψ]; exact hψorder) (by rw [hpolee]; exact heψorder)
      (by rw [hpoleψ]; exact hψderiv) (by rw [hpolee]; exact heψderiv)).mp
        ⟨e, fun r => congr_fun (congrArg DFunLike.coe hmaps) r⟩
    have hscalare : weakLaurentInvariant p Ψe = weakPoleScalar p (e ψ) := by
      simp only [weakLaurentInvariant, weakPoleScalar, hpolee]
    rw [hscalarψ, hscalare, heψ, weak_pole_scalar_frobenius_scaling p ζ hζ hζp χ] at hscalar
    exact hscalar
  · intro hscalar
    have hclass := weak_laurent_completed_fields_equiv_iff p φψ φχ Ψψ Ψχ hΨψ hΨχ hzeroψ hzeroχ
      (by rw [hpoleψ]; exact hψorder) (by rw [hpoleχ]; exact hχorder)
      (by rw [hpoleψ]; exact hψderiv) (by rw [hpoleχ]; exact hχderiv)
    obtain ⟨e, he⟩ := hclass.mpr (by rw [hscalarψ, hscalarχ]; exact hscalar)
    refine ⟨e, ?_⟩
    intro r
    have hleft := congr_fun (congrArg DFunLike.coe hfactorψ) r
    have hright := congr_fun (congrArg DFunLike.coe hfactorχ) r
    change Ψβ r = Ψψ (powerLaurentMap h hh r) at hleft
    change Ωβ r = Ψχ (powerLaurentMap h hh r) at hright
    rw [hleft, he, ← hright]

end Litt3.QuotientGeometry

import Solutions.QuotientGeometry.DVRFunctionFieldCompletion
import Solutions.QuotientGeometry.DVRCompletedFractionMaps

namespace Litt3.QuotientGeometry

variable {k R S K L : Type*} [Field k]
  [CommRing R] [IsDomain R] [IsDiscreteValuationRing R] [Algebra k R]
  [CommRing S] [IsDomain S] [IsDiscreteValuationRing S] [Algebra k S]
  [Field K] [Algebra R K] [IsFractionRing R K]
  [Field L] [Algebra S L] [IsFractionRing S L]

theorem completed_dvr_stalk_map_functorial
    (dR : DVRCompletionParameters k R) (dS : DVRCompletionParameters k S)
    (φ : R →ₐ[k] S) [IsLocalHom φ.toRingHom] (r : R) :
    completedDVRPowerSeriesMap dR dS φ (completedDVRStalkEmbedding dR r) =
      completedDVRStalkEmbedding dS (φ r) :=
  completedDVRPowerSeriesMap_stalk dR dS φ r

/-- The completed field maps commute on EVERY original rational function
with the original fraction-field map, once that original map commutes
on actual local-ring functions. This applies directly to the true
generic-stalk pullback of an actual scheme morphism. -/
theorem dvr_function_field_completion_functorial
    (dR : DVRCompletionParameters k R) (dS : DVRCompletionParameters k S)
    (φ : R →ₐ[k] S) [IsLocalHom φ.toRingHom] (hinj : Function.Injective φ)
    (q : K →+* L)
    (hq : ∀ r : R, q (algebraMap R K r) = algebraMap S L (φ r)) (f : K) :
    completedDVRLaurentMap dR dS φ hinj (dvrFunctionFieldCompletion dR f) =
      dvrFunctionFieldCompletion dS (q f) := by
  obtain ⟨a, b, _, rfl⟩ := IsFractionRing.div_surjective (A := R) f
  simp only [map_div₀, hq, dvrFunctionFieldCompletion_ring,
    completedDVRLaurentMap_power_series, completed_dvr_stalk_map_functorial]

/-- The actual field expression beta=G^m/F^n is equivalent to its
literal polar relation in the original local ring. -/
theorem original_dvr_polar_identity_iff
    (b g F : R) (m n : ℕ) (hb : b ≠ 0) (hF : F ≠ 0) :
    (algebraMap R K b)⁻¹ = (algebraMap R K g) ^ m / (algebraMap R K F) ^ n ↔
      b * g ^ m = F ^ n := by
  have hbK : algebraMap R K b ≠ 0 := by
    simpa only [map_zero] using (IsFractionRing.injective R K).ne hb
  have hFK : algebraMap R K F ≠ 0 := by
    simpa only [map_zero] using (IsFractionRing.injective R K).ne hF
  constructor
  · intro he
    apply IsFractionRing.injective R K
    simp only [map_mul, map_pow]
    field_simp [hbK, hFK] at he
    simpa only [mul_comm] using he.symm
  · intro he
    have heK := congrArg (algebraMap R K) he
    simp only [map_mul, map_pow] at heK
    apply (eq_div_iff (pow_ne_zero n hFK)).mpr
    rw [← heK, ← mul_assoc, inv_mul_cancel₀ hbK, one_mul]

end Litt3.QuotientGeometry

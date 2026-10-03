import Solutions.QuotientGeometry.GaloisSmoothSameSourceFiber
import Solutions.QuotientGeometry.DVRCompletedParameterSubstitution
import Solutions.QuotientGeometry.WeakValuativeClassification
import Solutions.QuotientGeometry.FiniteClosedPointLifts
import Solutions.QuotientGeometry.FiniteSchemeFunctionFields

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

/-- BOTH genuine original maps of the SAME smooth source force scalar
equality for EVERY original weak h-root throughout the true endpoint
fiber. The original positive parameter expansions are constructed from
true stalk maps; their actual separating trace-different profiles are the
only local ramification inputs. Full same-base maps and weak orders are
derived. No local field equivalence or scalar equality is assumed. -/
theorem actual_galois_smooth_same_source_original_profile_scalars_equal
    {k : Type u} [Field k] [IsAlgClosed k]
    (p h : ℕ) [Fact p.Prime] [CharP k p]
    (hp : 1 < p) (hh : 0 < h) (hdiv : h ∣ p - 1)
    {T Y G B : Scheme.{u}} [IsIntegral T] [IsIntegral Y] [IsIntegral G] [IsIntegral B]
    (sT : T ⟶ Spec (.of k)) (sY : Y ⟶ Spec (.of k))
    (sG : G ⟶ Spec (.of k)) (sB : B ⟶ Spec (.of k))
    [IsSmoothOfRelativeDimension 1 sT] [IsSmoothOfRelativeDimension 1 sY]
    [IsSmoothOfRelativeDimension 1 sG] [IsSmoothOfRelativeDimension 1 sB]
    (f : T ⟶ Y) (g : T ⟶ G) (χ : Y ⟶ B) (ν : G ⟶ B)
    [IsFinite f] [IsEtale f] [Surjective f] [IsFinite g]
    [Surjective χ] [IsFinite ν] [Surjective ν]
    (hf : f ≫ sY = sT) (hg : g ≫ sG = sT)
    (hχ : χ ≫ sB = sY) (hν : ν ≫ sB = sG)
    (hcomm : f ≫ χ = g ≫ ν)
    (b : Litt3.SharedTensors.ClosedPoint B)
    (hug : ∀ t : Litt3.SharedTensors.ClosedPoint T,
      b.val = ν (g t.val) → (g.stalkMap t.val).hom.FormallyUnramified)
    (y₁ y₂ : Litt3.SharedTensors.ClosedPoint Y)
    (hb₁ : b.val = χ y₁.val) (hb₂ : b.val = χ y₂.val) :
    letI := (Litt3.SharedTensors.schemeFunctionFieldPullback ν).toAlgebra
    IsGalois B.functionField G.functionField →
    letI := Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr sB b
    letI := Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr sY y₁
    letI := Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr sY y₂
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sB b.val).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sY y₁.val).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sY y₂.val).toAlgebra
    ∀ (dB : DVRCompletionParameters k (B.presheaf.stalk b.val))
      (d₁ : DVRCompletionParameters k (Y.presheaf.stalk y₁.val))
      (d₂ : DVRCompletionParameters k (Y.presheaf.stalk y₂.val)),
    let φ₁ := actualSchemeFixedBaseStalkMap χ sY sB hχ b.val y₁.val hb₁;
    let φ₂ := actualSchemeFixedBaseStalkMap χ sY sB hχ b.val y₂.val hb₂;
    let b₁ := completedDVRStalkEmbedding d₁ (φ₁ dB.parameter);
    let b₂ := completedDVRStalkEmbedding d₂ (φ₂ dB.parameter);
    ∀ (ho₁ : b₁.order = p * h) (ho₂ : b₂.order = p * h),
      weakValuativeDifferentProfile p h hp hh b₁ ho₁ →
      weakValuativeDifferentProfile p h hp hh b₂ ho₂ →
      ∀ ψ₁ ψ₂ : LaurentSeries k,
        ψ₁ ^ h = (b₁ : LaurentSeries k)⁻¹ →
        ψ₂ ^ h = (b₂ : LaurentSeries k)⁻¹ →
        weakPoleScalar p ψ₁ = weakPoleScalar p ψ₂ := by
  letI := (Litt3.SharedTensors.schemeFunctionFieldPullback ν).toAlgebra
  intro hgalois
  letI := hgalois
  letI := Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr sB b
  letI := Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr sY y₁
  letI := Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr sY y₂
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sB b.val).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sY y₁.val).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sY y₂.val).toAlgebra
  intro dB d₁ d₂
  let φ₁ := actualSchemeFixedBaseStalkMap χ sY sB hχ b.val y₁.val hb₁
  let φ₂ := actualSchemeFixedBaseStalkMap χ sY sB hχ b.val y₂.val hb₂
  let b₁ := completedDVRStalkEmbedding d₁ (φ₁ dB.parameter)
  let b₂ := completedDVRStalkEmbedding d₂ (φ₂ dB.parameter)
  dsimp only
  intro ho₁ ho₂ hprofile₁ hprofile₂ ψ₁ ψ₂ hψ₁ hψ₂
  have hc₁ := positive_parameter_canonical_factor (p * h) b₁ ho₁
  have hc₂ := positive_parameter_canonical_factor (p * h) b₂ ho₂
  let hi₁ := finite_parameter_substitution_injective (p * h) (Nat.mul_pos (by omega) hh)
    b₁ (PowerSeries.divXPowOrder b₁) hc₁.1 hc₁.2
  let hi₂ := finite_parameter_substitution_injective (p * h) (Nat.mul_pos (by omega) hh)
    b₂ (PowerSeries.divXPowOrder b₂) hc₂.1 hc₂.2
  obtain ⟨_, _, _, _, hclass⟩ := weak_two_valuative_different_profiles_equiv_iff
    p h hp hh hdiv b₁ b₂ ho₁ ho₂ hprofile₁ hprofile₂
  apply (hclass ψ₁ ψ₂ hψ₁ hψ₂).mp
  have hfields := actual_galois_smooth_same_source_entire_fiber_fields
    sT sY sG sB f g χ ν hf hg hχ hν hcomm b hug y₁ y₂ hb₁ hb₂ hgalois dB d₁ d₂
  have hm₁ := completedDVRLaurentMap_eq_actual_parameter_substitution dB d₁ φ₁
    (actual_integral_fixed_base_scheme_stalk_injective χ sY sB hχ b.val y₁.val hb₁) hi₁
  have hm₂ := completedDVRLaurentMap_eq_actual_parameter_substitution dB d₂ φ₂
    (actual_integral_fixed_base_scheme_stalk_injective χ sY sB hχ b.val y₂.val hb₂) hi₂
  rw [hm₁, hm₂] at hfields
  exact hfields

end Litt3.QuotientGeometry

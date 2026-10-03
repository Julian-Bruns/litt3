import Definitions.QuotientGeometry.ParameterFieldComparison
import Solutions.QuotientGeometry.WeakLaurentArtinSchreierModel
import Solutions.QuotientGeometry.PoleOneArtinSchreierClasses

namespace Litt3.QuotientGeometry

/-- Equality of the coefficient invariant classifies the original
completed embeddings over the same full downstairs Laurent field.
No normalized-polynomial or abstract-field identification is assumed. -/
theorem weak_laurent_completed_fields_equiv_iff
    {k : Type*} [Field k] [IsAlgClosed k] (p : ℕ) [Fact p.Prime] [CharP k p]
    (φ χ : PowerSeries k →ₐ[k] PowerSeries k)
    (Ψ Ω : LaurentSeries k →+* LaurentSeries k)
    (hΨ : ∀ r : PowerSeries k, Ψ (r : LaurentSeries k) = (φ r : PowerSeries k))
    (hΩ : ∀ r : PowerSeries k, Ω (r : LaurentSeries k) = (χ r : PowerSeries k))
    (hzeroΨ : PowerSeries.constantCoeff (φ PowerSeries.X) = 0)
    (hzeroΩ : PowerSeries.constantCoeff (χ PowerSeries.X) = 0)
    (horderΨ : (Ψ (HahnSeries.single (-1) 1)).order = -(p : ℤ))
    (horderΩ : (Ω (HahnSeries.single (-1) 1)).order = -(p : ℤ))
    (hderivΨ : (LaurentSeries.derivative k (Ψ (HahnSeries.single (-1) 1))).order = -2)
    (hderivΩ : (LaurentSeries.derivative k (Ω (HahnSeries.single (-1) 1))).order = -2) :
    ParameterFieldsEquivalent Ψ Ω ↔ weakLaurentInvariant p Ψ = weakLaurentInvariant p Ω := by
  have hp : 1 < p := (Fact.out : p.Prime).one_lt
  haveI := laurent_series_charP (k := k) p
  obtain ⟨a, ha, hscalar, e, he⟩ :=
    weak_laurent_completed_map_artin_schreier_model p φ Ψ hΨ hzeroΨ horderΨ hderivΨ
  obtain ⟨b, hb, hscalar', e', he'⟩ :=
    weak_laurent_completed_map_artin_schreier_model p χ Ω hΩ hzeroΩ horderΩ hderivΩ
  let A := ArtinSchreierAlgebra (LaurentSeries k) p (HahnSeries.single (-1) a)
  let B := ArtinSchreierAlgebra (LaurentSeries k) p (HahnSeries.single (-1) b)
  haveI : Fact (Irreducible (artinSchreierPolynomial p (HahnSeries.single (-1) a : LaurentSeries k))) :=
    ⟨pole_one_artin_schreier_irreducible p hp a ha⟩
  haveI : Fact (Irreducible (artinSchreierPolynomial p (HahnSeries.single (-1) b : LaurentSeries k))) :=
    ⟨pole_one_artin_schreier_irreducible p hp b hb⟩
  letI : Field A := inferInstance
  letI : Field B := inferInstance
  have hcriterion := pole_one_artin_schreier_fields_equiv_iff p a b ha hb
  constructor
  · rintro ⟨τ, hτ⟩
    let f : A ≃ₐ[LaurentSeries k] B :=
      { __ := (e.trans τ).trans e'.symm
        commutes' := fun r => by
          change e'.symm (τ (e (AdjoinRoot.of _ r))) = AdjoinRoot.of _ r
          rw [he, hτ, ← he', e'.symm_apply_apply] }
    have h := hcriterion.mp ⟨f⟩
    rwa [hscalar, hscalar'] at h
  · intro h
    have hab : a ^ (p - 1) = b ^ (p - 1) := by rwa [hscalar, hscalar']
    obtain ⟨f⟩ := hcriterion.mpr hab
    refine ⟨(e.symm.trans f.toRingEquiv).trans e', ?_⟩
    intro r
    change e' (f (e.symm (Ψ r))) = Ω r
    rw [← he, e.symm_apply_apply]
    have hf := f.commutes r
    rw [AdjoinRoot.algebraMap_eq, AdjoinRoot.algebraMap_eq] at hf
    rw [hf, he']

theorem weak_laurent_invariant_preserved_by_field_identification
    {k : Type*} [Field k] [IsAlgClosed k] (p : ℕ) [Fact p.Prime] [CharP k p]
    (φ χ : PowerSeries k →ₐ[k] PowerSeries k)
    (Ψ Ω : LaurentSeries k →+* LaurentSeries k)
    (hΨ : ∀ r : PowerSeries k, Ψ (r : LaurentSeries k) = (φ r : PowerSeries k))
    (hΩ : ∀ r : PowerSeries k, Ω (r : LaurentSeries k) = (χ r : PowerSeries k))
    (hzeroΨ : PowerSeries.constantCoeff (φ PowerSeries.X) = 0)
    (hzeroΩ : PowerSeries.constantCoeff (χ PowerSeries.X) = 0)
    (horderΨ : (Ψ (HahnSeries.single (-1) 1)).order = -(p : ℤ))
    (horderΩ : (Ω (HahnSeries.single (-1) 1)).order = -(p : ℤ))
    (hderivΨ : (LaurentSeries.derivative k (Ψ (HahnSeries.single (-1) 1))).order = -2)
    (hderivΩ : (LaurentSeries.derivative k (Ω (HahnSeries.single (-1) 1))).order = -2)
    (e : LaurentSeries k ≃+* LaurentSeries k) (he : ∀ r, e (Ψ r) = Ω r) :
    weakLaurentInvariant p Ψ = weakLaurentInvariant p Ω :=
  (weak_laurent_completed_fields_equiv_iff p φ χ Ψ Ω hΨ hΩ hzeroΨ hzeroΩ
    horderΨ horderΩ hderivΨ hderivΩ).mp ⟨e, he⟩

end Litt3.QuotientGeometry

import Definitions.QuotientGeometry.ParameterFieldComparison
import Solutions.QuotientGeometry.LinearizedArtinSchreierModel
import Solutions.QuotientGeometry.PoleOneArtinSchreierClasses

namespace Litt3.QuotientGeometry

/-- Two actual whole Laurent extensions over the SAME fixed parameter
field agree precisely when their nonzero linearized scalars agree. -/
theorem linearized_laurent_fields_equiv_iff
    {k : Type*} [Field k] [IsAlgClosed k] (p : ℕ) [Fact p.Prime] [CharP k p]
    (α γ α' γ' : k) (hα : α ≠ 0) (hγ : γ ≠ 0) (hα' : α' ≠ 0) (hγ' : γ' ≠ 0) :
    let φ := parameterLaurentMap (linearizedParameter p α γ)
      (linearized_parameter_zero p (Fact.out : p.Prime).one_lt α γ)
      (linearized_parameter_injective p (Fact.out : p.Prime).one_lt α γ hα)
    let ψ := parameterLaurentMap (linearizedParameter p α' γ')
      (linearized_parameter_zero p (Fact.out : p.Prime).one_lt α' γ')
      (linearized_parameter_injective p (Fact.out : p.Prime).one_lt α' γ' hα')
    ParameterFieldsEquivalent φ ψ ↔ -α / γ ^ p = -α' / γ' ^ p := by
  have hp : 1 < p := (Fact.out : p.Prime).one_lt
  haveI := laurent_series_charP (k := k) p
  let φ := parameterLaurentMap (linearizedParameter p α γ)
    (linearized_parameter_zero p hp α γ) (linearized_parameter_injective p hp α γ hα)
  let ψ := parameterLaurentMap (linearizedParameter p α' γ')
    (linearized_parameter_zero p hp α' γ') (linearized_parameter_injective p hp α' γ' hα')
  change ParameterFieldsEquivalent φ ψ ↔ -α / γ ^ p = -α' / γ' ^ p
  obtain ⟨a, ha, hscalar, e, he⟩ := linearized_laurent_artin_schreier_model p α γ hα hγ
  obtain ⟨b, hb, hscalar', e', he'⟩ := linearized_laurent_artin_schreier_model p α' γ' hα' hγ'
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
    change e' (f (e.symm (φ r))) = ψ r
    rw [← he, e.symm_apply_apply]
    have hf := f.commutes r
    rw [AdjoinRoot.algebraMap_eq, AdjoinRoot.algebraMap_eq] at hf
    rw [hf, he']

end Litt3.QuotientGeometry

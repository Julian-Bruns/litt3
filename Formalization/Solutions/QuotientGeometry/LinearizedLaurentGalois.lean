import Solutions.QuotientGeometry.LinearizedArtinSchreierModel

namespace Litt3.QuotientGeometry

/-- The original Laurent field over its actual separable two-term
parameter is a cyclic Galois extension of exact degree p. -/
theorem linearized_laurent_extension_cyclic_galois
    {k : Type*} [Field k] [IsAlgClosed k] (p : ℕ) [Fact p.Prime] [CharP k p]
    (α γ : k) (hα : α ≠ 0) (hγ : γ ≠ 0) :
    letI : Algebra (LaurentSeries k) (LaurentSeries k) :=
      (parameterLaurentMap (linearizedParameter p α γ)
        (linearized_parameter_zero p (Fact.out : p.Prime).one_lt α γ)
        (linearized_parameter_injective p (Fact.out : p.Prime).one_lt α γ hα)).toAlgebra
    letI : SMul (LaurentSeries k) (LaurentSeries k) :=
      (parameterLaurentMap (linearizedParameter p α γ)
        (linearized_parameter_zero p (Fact.out : p.Prime).one_lt α γ)
        (linearized_parameter_injective p (Fact.out : p.Prime).one_lt α γ hα)).toAlgebra.toSMul
    letI : Module (LaurentSeries k) (LaurentSeries k) := Algebra.toModule
    FiniteDimensional (LaurentSeries k) (LaurentSeries k) ∧
      Module.finrank (LaurentSeries k) (LaurentSeries k) = p ∧
      IsGalois (LaurentSeries k) (LaurentSeries k) ∧
      IsCyclic (LaurentSeries k ≃ₐ[LaurentSeries k] LaurentSeries k) := by
  have hp : 1 < p := (Fact.out : p.Prime).one_lt
  haveI := laurent_series_charP (k := k) p
  obtain ⟨a, ha, _, e, he⟩ := linearized_laurent_artin_schreier_model p α γ hα hγ
  let E := ArtinSchreierAlgebra (LaurentSeries k) p (HahnSeries.single (-1) a)
  haveI : Fact (Irreducible (artinSchreierPolynomial p (HahnSeries.single (-1) a : LaurentSeries k))) :=
    ⟨pole_one_artin_schreier_irreducible p hp a ha⟩
  letI : Field E := inferInstance
  let AE : Algebra (LaurentSeries k) E := inferInstance
  letI : Algebra (LaurentSeries k) E := AE
  letI : SMul (LaurentSeries k) E := AE.toSMul
  letI : Module (LaurentSeries k) E := Algebra.toModule
  have hEmap : algebraMap (LaurentSeries k) E =
      AdjoinRoot.of (artinSchreierPolynomial p (HahnSeries.single (-1) a : LaurentSeries k)) :=
    AdjoinRoot.algebraMap_eq _
  haveI : FiniteDimensional (LaurentSeries k) E :=
    (artin_schreier_monic_degree p hp (HahnSeries.single (-1) a : LaurentSeries k)).1.finite_adjoinRoot
  have hsource : Module.finrank (LaurentSeries k) E = p :=
    artin_schreier_field_degree p hp (HahnSeries.single (-1) a : LaurentSeries k)
  haveI : IsGalois (LaurentSeries k) E := pole_one_artin_schreier_galois p a ha
  let φ := parameterLaurentMap (linearizedParameter p α γ)
    (linearized_parameter_zero p hp α γ) (linearized_parameter_injective p hp α γ hα)
  letI : Algebra (LaurentSeries k) (LaurentSeries k) := φ.toAlgebra
  letI : SMul (LaurentSeries k) (LaurentSeries k) := φ.toAlgebra.toSMul
  letI : Module (LaurentSeries k) (LaurentSeries k) := Algebra.toModule
  let ε : E ≃ₐ[LaurentSeries k] LaurentSeries k :=
    { __ := e
      commutes' := fun r => by rw [hEmap]; exact he r }
  haveI : FiniteDimensional (LaurentSeries k) (LaurentSeries k) :=
    FiniteDimensional.of_surjective ε.toLinearMap ε.surjective
  have hrank : Module.finrank (LaurentSeries k) (LaurentSeries k) = p :=
    ε.toLinearEquiv.finrank_eq.symm.trans hsource
  haveI : IsGalois (LaurentSeries k) (LaurentSeries k) := IsGalois.of_algEquiv ε
  refine ⟨inferInstance, hrank, inferInstance, ?_⟩
  apply isCyclic_of_prime_card (p := p)
  rw [IsGalois.card_aut_eq_finrank, hrank]

end Litt3.QuotientGeometry

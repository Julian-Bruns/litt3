import Solutions.QuotientGeometry.PoleOneArtinSchreierFields

namespace Litt3.QuotientGeometry

/-- Transports an actual pole-one AS model through a literal base
embedding; scalar actions are tied explicitly to that embedding. -/
theorem pole_one_artin_schreier_field_model_cyclic_galois
    {k L : Type*} [Field k] [Field L] (p : ℕ) [Fact p.Prime] [CharP k p]
    (a : k) (ha : a ≠ 0) (Ψ : LaurentSeries k →+* L)
    (e : ArtinSchreierAlgebra (LaurentSeries k) p (HahnSeries.single (-1) a) ≃+* L)
    (he : ∀ r : LaurentSeries k,
      e (AdjoinRoot.of (artinSchreierPolynomial p (HahnSeries.single (-1) a)) r) = Ψ r) :
    letI : Algebra (LaurentSeries k) L := Ψ.toAlgebra
    letI : SMul (LaurentSeries k) L := Ψ.toAlgebra.toSMul
    letI : Module (LaurentSeries k) L := Algebra.toModule
    FiniteDimensional (LaurentSeries k) L ∧ Module.finrank (LaurentSeries k) L = p ∧
      IsGalois (LaurentSeries k) L ∧ IsCyclic (L ≃ₐ[LaurentSeries k] L) := by
  have hp : 1 < p := (Fact.out : p.Prime).one_lt
  haveI := laurent_series_charP (k := k) p
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
  letI : Algebra (LaurentSeries k) L := Ψ.toAlgebra
  letI : SMul (LaurentSeries k) L := Ψ.toAlgebra.toSMul
  letI : Module (LaurentSeries k) L := Algebra.toModule
  let ε : E ≃ₐ[LaurentSeries k] L :=
    { __ := e
      commutes' := fun r => by rw [hEmap]; exact he r }
  haveI : FiniteDimensional (LaurentSeries k) L :=
    FiniteDimensional.of_surjective ε.toLinearMap ε.surjective
  have hrank : Module.finrank (LaurentSeries k) L = p :=
    ε.toLinearEquiv.finrank_eq.symm.trans hsource
  haveI : IsGalois (LaurentSeries k) L := IsGalois.of_algEquiv ε
  refine ⟨inferInstance, hrank, inferInstance, ?_⟩
  apply isCyclic_of_prime_card (p := p)
  rw [IsGalois.card_aut_eq_finrank, hrank]

end Litt3.QuotientGeometry

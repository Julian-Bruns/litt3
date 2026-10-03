import Solutions.QuotientGeometry.PoleOneArtinSchreier
import Solutions.QuotientGeometry.ArtinSchreierGalois
import Solutions.QuotientGeometry.WeakLaurentLinearization
import Mathlib.GroupTheory.SpecificGroups.Cyclic

namespace Litt3.QuotientGeometry

/-- A nonzero pole-one coefficient constructs an actual cyclic Galois
degree-p Artin--Schreier field over the whole Laurent base field. -/
theorem pole_one_artin_schreier_galois
    {k : Type*} [Field k] (p : ℕ) [Fact p.Prime] [CharP k p] (a : k) (ha : a ≠ 0) :
    letI := laurent_series_charP (k := k) p
    letI : Fact (Irreducible (artinSchreierPolynomial p (HahnSeries.single (-1) a : LaurentSeries k))) :=
      ⟨pole_one_artin_schreier_irreducible p (Fact.out : p.Prime).one_lt a ha⟩
    IsGalois (LaurentSeries k)
      (ArtinSchreierAlgebra (LaurentSeries k) p (HahnSeries.single (-1) a)) := by
  haveI := laurent_series_charP (k := k) p
  haveI : Fact (Irreducible (artinSchreierPolynomial p (HahnSeries.single (-1) a : LaurentSeries k))) :=
    ⟨pole_one_artin_schreier_irreducible p (Fact.out : p.Prime).one_lt a ha⟩
  exact artin_schreier_galois p _

theorem pole_one_artin_schreier_cyclic
    {k : Type*} [Field k] (p : ℕ) [Fact p.Prime] [CharP k p] (a : k) (ha : a ≠ 0) :
    letI := laurent_series_charP (k := k) p
    letI : Fact (Irreducible (artinSchreierPolynomial p (HahnSeries.single (-1) a : LaurentSeries k))) :=
      ⟨pole_one_artin_schreier_irreducible p (Fact.out : p.Prime).one_lt a ha⟩
    IsCyclic (ArtinSchreierAlgebra (LaurentSeries k) p (HahnSeries.single (-1) a) ≃ₐ[LaurentSeries k]
      ArtinSchreierAlgebra (LaurentSeries k) p (HahnSeries.single (-1) a)) := by
  haveI := laurent_series_charP (k := k) p
  haveI : Fact (Irreducible (artinSchreierPolynomial p (HahnSeries.single (-1) a : LaurentSeries k))) :=
    ⟨pole_one_artin_schreier_irreducible p (Fact.out : p.Prime).one_lt a ha⟩
  haveI := pole_one_artin_schreier_galois p a ha
  haveI : FiniteDimensional (LaurentSeries k)
      (ArtinSchreierAlgebra (LaurentSeries k) p (HahnSeries.single (-1) a)) :=
    (artin_schreier_monic_degree p (Fact.out : p.Prime).one_lt _).1.finite_adjoinRoot
  apply isCyclic_of_prime_card (p := p)
  rw [IsGalois.card_aut_eq_finrank,
    artin_schreier_field_degree p (Fact.out : p.Prime).one_lt]

end Litt3.QuotientGeometry

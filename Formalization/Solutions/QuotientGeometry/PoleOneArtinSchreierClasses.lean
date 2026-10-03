import Solutions.QuotientGeometry.PoleOneArtinSchreierFields
import Solutions.QuotientGeometry.ArtinSchreierFieldClasses
import Solutions.QuotientGeometry.ArtinSchreierClasses

namespace Litt3.QuotientGeometry

/-- Every Frobenius-fixed element of an actual Laurent field is a genuine
constant. Prime-subfield membership proves this without coefficient
enumeration, perfection or algebraic closedness. -/
theorem laurent_frobenius_fixed_constant
    {k : Type*} [Field k] (p : ℕ) [Fact p.Prime] [CharP k p]
    (c : LaurentSeries k) (hc : c ^ p = c) :
    ∃ d : k, c = HahnSeries.C d ∧ d ^ p = d := by
  haveI := laurent_series_charP (k := k) p
  have hmem := (Subfield.mem_bot_iff_pow_eq_self (LaurentSeries k) p).mpr hc
  obtain ⟨n, hn⟩ := (mem_bot_iff_intCast p (LaurentSeries k)).mp hmem
  have hconstant : c = HahnSeries.C (n : k) := by rw [← hn, map_intCast]
  refine ⟨(n : k), hconstant, ?_⟩
  apply (HahnSeries.C : k →+* LaurentSeries k).injective
  rw [map_pow, ← hconstant, hc]

/-- Exact classification of genuine pole-one Artin--Schreier fields over
the SAME fixed Laurent base field. Isomorphisms are actual base-algebra
equivalences, not equality of abstract additive quotient labels. -/
theorem pole_one_artin_schreier_fields_equiv_iff
    {k : Type*} [Field k] (p : ℕ) [Fact p.Prime] [CharP k p]
    (a b : k) (ha : a ≠ 0) (hb : b ≠ 0) :
    letI := laurent_series_charP (k := k) p
    letI : Fact (Irreducible (artinSchreierPolynomial p (HahnSeries.single (-1) a : LaurentSeries k))) :=
      ⟨pole_one_artin_schreier_irreducible p (Fact.out : p.Prime).one_lt a ha⟩
    letI : Fact (Irreducible (artinSchreierPolynomial p (HahnSeries.single (-1) b : LaurentSeries k))) :=
      ⟨pole_one_artin_schreier_irreducible p (Fact.out : p.Prime).one_lt b hb⟩
    Nonempty (ArtinSchreierAlgebra (LaurentSeries k) p (HahnSeries.single (-1) a) ≃ₐ[LaurentSeries k]
      ArtinSchreierAlgebra (LaurentSeries k) p (HahnSeries.single (-1) b)) ↔
        a ^ (p - 1) = b ^ (p - 1) := by
  haveI := laurent_series_charP (k := k) p
  haveI : Fact (Irreducible (artinSchreierPolynomial p (HahnSeries.single (-1) a : LaurentSeries k))) :=
    ⟨pole_one_artin_schreier_irreducible p (Fact.out : p.Prime).one_lt a ha⟩
  haveI : Fact (Irreducible (artinSchreierPolynomial p (HahnSeries.single (-1) b : LaurentSeries k))) :=
    ⟨pole_one_artin_schreier_irreducible p (Fact.out : p.Prime).one_lt b hb⟩
  have hp : 1 < p := (Fact.out : p.Prime).one_lt
  let ψ : LaurentSeries k := HahnSeries.single (-1) 1
  have hψ : ψ.order = -1 := by simp [ψ]
  constructor
  · rintro ⟨φ⟩
    obtain ⟨c, v, hc, hcfrob, hline⟩ := artin_schreier_equiv_implies_line_relation p _ _ φ
    obtain ⟨d, hd, hdfrob⟩ := laurent_frobenius_fixed_constant p c hcfrob
    have hdne : d ≠ 0 := by intro h; apply hc; rw [hd, h, map_zero]
    apply (laurent_artin_schreier_lines_iff p hp ψ hψ a b ha hb).mp
    refine ⟨d, hdne, hdfrob, v, ?_⟩
    simpa [ψ, hd, HahnSeries.C_apply, HahnSeries.single_mul_single] using hline
  · intro hinvariant
    obtain ⟨d, hdne, hdfrob, v, hline⟩ :=
      (laurent_artin_schreier_lines_iff p hp ψ hψ a b ha hb).mpr hinvariant
    apply artin_schreier_line_relation_implies_equiv p _ _ (HahnSeries.C d) v
    · simpa only [map_zero] using (HahnSeries.C : k →+* LaurentSeries k).injective.ne hdne
    · rw [← map_pow, hdfrob]
    · simpa [ψ, HahnSeries.C_apply, HahnSeries.single_mul_single] using hline

end Litt3.QuotientGeometry

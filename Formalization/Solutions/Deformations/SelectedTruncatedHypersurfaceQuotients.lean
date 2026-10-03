import Definitions.Deformations.SelectedTruncatedCoefficientPolynomial
import Solutions.Deformations.TruncatedPolynomialRegrouping
import Solutions.Deformations.PolynomialSeriesPowerCutoffRelations
import Solutions.Deformations.SeriesTruncatedHypersurfaceEquivalence

namespace Litt3.Deformations

variable (R : Type*) [CommRing R] (d : ℕ)

/-- The ORIGINAL polynomial hypersurface with unequal powers is
genuinely the unchanged selected-variable series hypersurface over the
actual lower-coordinate quotient. No normal form or dimension is assumed. -/
noncomputable def selectedTruncatedPolynomialHypersurfaceEquiv
    (Q : ℕ) (q : Fin d → ℕ) (P : MvPolynomial (Fin (d + 1)) R) :
    (MvPolynomial (Fin (d + 1)) R ⧸
      (truncatedMonomialIdeal R (Fin (d + 1)) (Fin.cons Q q) ⊔ Ideal.span ({P} : Set _))) ≃ₐ[R]
      (PowerSeries (TruncatedMonomialAlgebra R (Fin d) q) ⧸
        Ideal.span ({PowerSeries.X ^ Q, (selectedTruncatedCoefficientPolynomial R d q P : PowerSeries _)} :
          Set (PowerSeries (TruncatedMonomialAlgebra R (Fin d) q)))) := by
  let B := MvPolynomial (Fin d) R
  let A := TruncatedMonomialAlgebra R (Fin d) q
  let I := truncatedMonomialIdeal R (Fin d) q
  let E := MvPolynomial.finSuccEquiv R d
  let F := selectedTruncatedCoefficientPolynomial R d q P
  have ideals : I.map Polynomial.C ⊔ Ideal.span ({Polynomial.X ^ Q, E P} : Set (Polynomial B)) =
      (truncatedMonomialIdeal R (Fin (d + 1)) (Fin.cons Q q) ⊔ Ideal.span ({P} : Set _)).map E.toRingHom := by
    rw [Ideal.map_sup, fin_succ_truncated_ideal_regrouping, Ideal.map_span,
      Set.image_singleton, Ideal.span_insert, sup_assoc]
    rfl
  let first := Ideal.quotientEquivAlg _ _ E ideals
  let second := polynomialCoefficientRelationQuotientEquiv R B I
    (Ideal.span ({Polynomial.X ^ Q, E P} : Set (Polynomial B)))
  have image : ((Ideal.span ({Polynomial.X ^ Q, E P} : Set (Polynomial B))).map
      (Polynomial.mapRingHom (Ideal.Quotient.mk I)) : Ideal (Polynomial A)) =
      Ideal.span ({Polynomial.X ^ Q, F} : Set (Polynomial A)) := by
    rw [Ideal.map_span, Set.image_insert_eq, Set.image_singleton]
    change Ideal.span {Polynomial.map (Ideal.Quotient.mk I) (Polynomial.X ^ Q), F} = _
    rw [Polynomial.map_pow, Polynomial.map_X]
  let third := Ideal.quotientEquivAlgOfEq (A := Polynomial A) R image
  exact first.trans (second.trans (third.trans
    (polynomialSeriesPowerCutoffRelationEquiv R A Q F)))

/-- The ORIGINAL arbitrary multivariate formal hypersurface is kept
in full while every original unequal power is retained. Rectangular
coefficient reduction and actual coordinate regrouping construct the
coefficient-series quotient to which preparation applies. -/
noncomputable def selectedTruncatedSeriesHypersurfaceEquiv
    (Q : ℕ) (q : Fin d → ℕ) (positiveQ : 0 < Q) (positive : ∀ i, 0 < q i)
    (f : MvPowerSeries (Fin (d + 1)) R) :
    (MvPowerSeries (Fin (d + 1)) R ⧸
      (seriesVariablePowerIdeal R (d + 1) (Fin.cons Q q) ⊔ Ideal.span ({f} : Set _))) ≃ₐ[R]
      (PowerSeries (TruncatedMonomialAlgebra R (Fin d) q) ⧸
        Ideal.span ({PowerSeries.X ^ Q,
          (selectedTruncatedCoefficientPolynomial R d q
            (MvPowerSeries.trunc' R (originalTruncationRectangle (Fin (d + 1)) (Fin.cons Q q)) f) :
              PowerSeries _)} : Set (PowerSeries (TruncatedMonomialAlgebra R (Fin d) q)))) := by
  have allPositive : ∀ i : Fin (d + 1), 0 < (Fin.cons Q q : Fin (d + 1) → ℕ) i := by
    intro i
    induction i using Fin.cases with
    | zero => exact positiveQ
    | succ j => exact positive j
  exact (seriesTruncatedHypersurfaceEquiv R (d + 1) (Fin.cons Q q) allPositive f).trans
    (selectedTruncatedPolynomialHypersurfaceEquiv R d Q q _)

end Litt3.Deformations

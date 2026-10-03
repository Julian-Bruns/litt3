import Solutions.Deformations.NilpotentAdicCompleteness
import Mathlib.RingTheory.PowerSeries.WeierstrassPreparation

namespace Litt3.Deformations

variable (R A : Type*) [CommRing R] [CommRing A] [Algebra R A]

/-- The literal original power polynomial is distinguished at the zero
ideal over every commutative coefficient ring. -/
theorem power_polynomial_distinguished_at_bot (Q : ℕ) :
    (Polynomial.X ^ Q : Polynomial A).IsDistinguishedAt ⊥ := by
  refine ⟨⟨fun {i} hi => ?_⟩, Polynomial.monic_X_pow Q⟩
  have different : i ≠ Q := by
    have bound : i < Q := hi.trans_le (Polynomial.natDegree_X_pow_le Q)
    omega
  simp [Polynomial.coeff_X_pow, different]

/-- The full original polynomial/series cutoff equivalence preserves
every actual polynomial relation. The coefficient ring may be arbitrary. -/
noncomputable def polynomialSeriesPowerCutoffRelationEquiv (Q : ℕ) (f : Polynomial A) :
    (Polynomial A ⧸ Ideal.span ({Polynomial.X ^ Q, f} : Set (Polynomial A))) ≃ₐ[R]
      (PowerSeries A ⧸ Ideal.span ({PowerSeries.X ^ Q, (f : PowerSeries A)} :
        Set (PowerSeries A))) := by
  letI := nilpotent_ideal_is_adic_complete A A (⊥ : Ideal A) 1 (by simp)
  let e := ((power_polynomial_distinguished_at_bot A Q).algEquivQuotient).restrictScalars R |>.trans
    (Ideal.quotientEquivAlgOfEq R (by rw [Polynomial.coe_pow, Polynomial.coe_X]))
  have original : e (Ideal.Quotient.mk (Ideal.span ({Polynomial.X ^ Q} : Set (Polynomial A))) f) =
      Ideal.Quotient.mk (Ideal.span ({PowerSeries.X ^ Q} : Set (PowerSeries A)))
        (f : PowerSeries A) := by
    simp only [e, AlgEquiv.trans_apply, AlgEquiv.restrictScalars_apply,
      Polynomial.IsDistinguishedAt.algEquivQuotient_apply, Ideal.quotient_map_mkₐ,
      Polynomial.coeToPowerSeries.algHom_apply, Algebra.algebraMap_self, PowerSeries.map_id,
      Ideal.Quotient.mkₐ_eq_mk, id_eq, Ideal.quotientEquivAlgOfEq_mk]
  have image : (Ideal.span ({(f : PowerSeries A)} : Set (PowerSeries A))).map
      (Ideal.Quotient.mk (Ideal.span ({PowerSeries.X ^ Q} : Set (PowerSeries A)))) =
      ((Ideal.span ({f} : Set (Polynomial A))).map
        (Ideal.Quotient.mk (Ideal.span ({Polynomial.X ^ Q} : Set (Polynomial A))))).map e.toRingHom := by
    rw [Ideal.map_span, Ideal.map_span, Ideal.map_span,
      Set.image_singleton, Set.image_singleton, Set.image_singleton]
    change Ideal.span {_} = Ideal.span {e _}
    rw [original]
  let middle := Ideal.quotientEquivAlg _ _ e image
  rw [Ideal.span_insert, Ideal.span_insert]
  exact (DoubleQuot.quotQuotEquivQuotSupₐ R (Ideal.span ({Polynomial.X ^ Q} : Set (Polynomial A)))
      (Ideal.span ({f} : Set (Polynomial A)))).symm.trans
        (middle.trans (DoubleQuot.quotQuotEquivQuotSupₐ R
          (Ideal.span ({PowerSeries.X ^ Q} : Set (PowerSeries A)))
          (Ideal.span ({(f : PowerSeries A)} : Set (PowerSeries A)))))

end Litt3.Deformations

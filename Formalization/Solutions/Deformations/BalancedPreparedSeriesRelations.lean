import Solutions.Deformations.BalancedPreparedQuadraticRelations
import Mathlib.RingTheory.PowerSeries.WeierstrassPreparation

set_option maxHeartbeats 800000
set_option synthInstance.maxHeartbeats 100000

namespace Litt3.Deformations

variable {K A : Type*} [Field K] [CommRing A] [Algebra K A]

/-- Genuine Weierstrass preparation transports the ORIGINAL power
relation as well as the original equation; the full two-relation
quotients are compared through their actual quotient maps. -/
noncomputable def balancedPreparedWeierstrassRelationEquiv
    (I : Ideal A) [IsAdicComplete I A] (g : PowerSeries A) (f : Polynomial A)
    (h : PowerSeries A) (factorization : PowerSeries.IsWeierstrassFactorizationAt g f h I)
    (Q : ℕ) :
    (Polynomial A ⧸ Ideal.span ({f, Polynomial.X ^ Q} : Set _)) ≃ₐ[K]
      (PowerSeries A ⧸ Ideal.span ({g, PowerSeries.X ^ Q} : Set _)) := by
  let e := factorization.algEquivQuotient.restrictScalars K
  have original : e (Ideal.Quotient.mk (Ideal.span ({f} : Set (Polynomial A)))
      (Polynomial.X ^ Q)) =
      Ideal.Quotient.mk (Ideal.span ({g} : Set (PowerSeries A))) (PowerSeries.X ^ Q) := by
    simp only [e, AlgEquiv.restrictScalars_apply,
      PowerSeries.IsWeierstrassFactorizationAt.algEquivQuotient_apply,
      Polynomial.IsDistinguishedAt.algEquivQuotient_apply, Ideal.quotient_map_mkₐ,
      Polynomial.coeToPowerSeries.algHom_apply, Algebra.algebraMap_self, PowerSeries.map_id,
      Ideal.Quotient.mkₐ_eq_mk, id_eq, Polynomial.coe_pow, Polynomial.coe_X,
      Ideal.quotientEquivAlgOfEq_mk]
  have image : (Ideal.span ({PowerSeries.X ^ Q} : Set (PowerSeries A))).map
      (Ideal.Quotient.mk (Ideal.span ({g} : Set (PowerSeries A)))) =
      ((Ideal.span ({Polynomial.X ^ Q} : Set (Polynomial A))).map
        (Ideal.Quotient.mk (Ideal.span ({f} : Set (Polynomial A))))).map e.toRingHom := by
    rw [Ideal.map_span, Ideal.map_span, Ideal.map_span,
      Set.image_singleton, Set.image_singleton, Set.image_singleton]
    change Ideal.span {_} = Ideal.span {e _}
    rw [original]
  let middle := Ideal.quotientEquivAlg _ _ e image
  rw [Ideal.span_insert, Ideal.span_insert]
  exact (DoubleQuot.quotQuotEquivQuotSupₐ K (Ideal.span ({f} : Set (Polynomial A)))
    (Ideal.span ({Polynomial.X ^ Q} : Set (Polynomial A)))).symm.trans
      (middle.trans (DoubleQuot.quotQuotEquivQuotSupₐ K
        (Ideal.span ({g} : Set (PowerSeries A)))
        (Ideal.span ({PowerSeries.X ^ Q} : Set (PowerSeries A)))))

end Litt3.Deformations

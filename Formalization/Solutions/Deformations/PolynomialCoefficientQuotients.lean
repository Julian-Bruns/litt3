import Solutions.Deformations.SurjectiveRelationQuotients
import Mathlib.RingTheory.Polynomial.Basic
import Mathlib.Algebra.Polynomial.AlgebraMap

namespace Litt3.Deformations

variable (K A : Type*) [CommRing K] [CommRing A] [Algebra K A]

/-- Actual coefficient reduction transports every full original
polynomial relation, retaining the entire unchanged coefficient ideal. -/
noncomputable def polynomialCoefficientRelationQuotientEquiv
    (I : Ideal A) (J : Ideal (Polynomial A)) :
    (Polynomial A ⧸ (I.map Polynomial.C ⊔ J)) ≃ₐ[K]
      (Polynomial (A ⧸ I) ⧸ J.map (Polynomial.mapRingHom (Ideal.Quotient.mk I))) := by
  let f := Polynomial.mapAlgHom (Ideal.Quotient.mkₐ K I)
  have surjective : Function.Surjective f :=
    Polynomial.map_surjective _ (Ideal.Quotient.mk_surjective)
  have kernel : RingHom.ker f.toRingHom = I.map Polynomial.C := by
    change RingHom.ker (Polynomial.mapRingHom (Ideal.Quotient.mk I)) = _
    rw [Polynomial.ker_mapRingHom, Ideal.mk_ker]
  exact (Ideal.quotientEquivAlgOfEq K (congrArg (fun T => T ⊔ J) kernel.symm)).trans
    (surjectiveRelationQuotientEquiv f surjective J)

end Litt3.Deformations

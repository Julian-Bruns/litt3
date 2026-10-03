import Mathlib.RingTheory.Ideal.Quotient.Operations

namespace Litt3.Deformations

variable {K A B : Type*} [CommSemiring K] [CommRing A] [CommRing B]
  [Algebra K A] [Algebra K B]

/-- Every original relation survives an actual surjective algebra map,
after retaining its entire actual kernel in the source quotient. -/
noncomputable def surjectiveRelationQuotientEquiv (f : A →ₐ[K] B)
    (surjective : Function.Surjective f) (J : Ideal A) :
    (A ⧸ (RingHom.ker f.toRingHom ⊔ J)) ≃ₐ[K] (B ⧸ J.map f.toRingHom) := by
  let e := Ideal.quotientKerAlgEquivOfSurjective surjective
  have original : e.toRingHom.comp (Ideal.Quotient.mk (RingHom.ker f.toRingHom)) = f.toRingHom := by
    apply RingHom.ext
    intro a
    exact Ideal.quotientKerAlgEquivOfSurjective_mk surjective a
  have image : J.map f.toRingHom =
      (J.map (Ideal.Quotient.mk (RingHom.ker f.toRingHom))).map e.toRingHom := by
    rw [Ideal.map_map, original]
  exact (DoubleQuot.quotQuotEquivQuotSupₐ K (RingHom.ker f.toRingHom) J).symm.trans
    (Ideal.quotientEquivAlg _ _ e image)

end Litt3.Deformations

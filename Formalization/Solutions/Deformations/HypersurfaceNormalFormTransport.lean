import Mathlib.RingTheory.Ideal.Quotient.Operations

namespace Litt3.Deformations

variable (R A : Type*) [CommSemiring R] [CommRing A] [Algebra R A]

/-- An actual coefficient algebra automorphism preserving the original
truncation ideal and carrying the hypersurface equation to a unit times
its normal form constructs a genuine equivalence of the full original
quotients. Only the actual coordinate change and equation are inputs. -/
noncomputable def hypersurfaceNormalFormQuotientEquiv (T : Ideal A) (e : A ≃ₐ[R] A)
    (f g : A) (u : Aˣ) (invariant : T.map (e : A →+* A) = T)
    (equation : e f = (u : A) * g) :
    (A ⧸ (T ⊔ Ideal.span ({f} : Set A))) ≃ₐ[R]
      (A ⧸ (T ⊔ Ideal.span ({g} : Set A))) := by
  apply Ideal.quotientEquivAlg _ _ e
  rw [Ideal.map_sup, invariant, Ideal.map_span, Set.image_singleton]
  change T ⊔ Ideal.span ({g} : Set A) = T ⊔ Ideal.span ({e f} : Set A)
  rw [equation, Ideal.span_singleton_mul_left_unit u.isUnit]

end Litt3.Deformations

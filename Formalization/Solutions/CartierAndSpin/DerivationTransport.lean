import Mathlib.RingTheory.Derivation.Basic
import Mathlib.Algebra.Algebra.Equiv

namespace Litt3.CartierAndSpin

variable {R A B : Type*} [CommRing R] [CommRing A] [CommRing B]
  [Algebra R A] [Algebra R B]

/-- Actual derivations are transported through an actual algebra
equivalence, including their domains and Leibniz rule. -/
def transportedDerivation (e : A ≃ₐ[R] B) (D : Derivation R A A) : Derivation R B B where
  toLinearMap := e.toLinearEquiv.toLinearMap.comp
    (D.toLinearMap.comp e.symm.toLinearEquiv.toLinearMap)
  map_one_eq_zero' := by
    change e (D (e.symm 1)) = 0
    rw [map_one, D.map_one_eq_zero, map_zero]
  leibniz' x y := by
    change e (D (e.symm (x * y))) = x • e (D (e.symm y)) + y • e (D (e.symm x))
    rw [map_mul, D.leibniz]
    simp only [smul_eq_mul, map_add, map_mul, e.apply_symm_apply]

theorem transportedDerivation_apply (e : A ≃ₐ[R] B) (D : Derivation R A A) (x : B) :
    transportedDerivation e D x = e (D (e.symm x)) := rfl

theorem transportedDerivation_equivariant (e : A ≃ₐ[R] B) (D : Derivation R A A) (x : A) :
    transportedDerivation e D (e x) = e (D x) := by
  rw [transportedDerivation_apply, e.symm_apply_apply]

theorem transportedDerivation_symm (e : A ≃ₐ[R] B) (D : Derivation R A A) :
    transportedDerivation e.symm (transportedDerivation e D) = D := by
  ext x
  simp only [transportedDerivation_apply, AlgEquiv.symm_symm, e.symm_apply_apply]

end Litt3.CartierAndSpin

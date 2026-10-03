import Mathlib.Algebra.TrivSqZeroExt
import Mathlib.RingTheory.Derivation.Basic
import Mathlib.Tactic

namespace Litt3.Deformations

variable {R A : Type*} [CommRing R] [CommRing A]

/-- A base derivation defines an actual coefficient homomorphism to
the square-zero extension, along any specified coefficient ring map. -/
def derivationGraphAlong (D : Derivation ℤ R R) (f : R →+* A) :
    R →+* TrivSqZeroExt A A where
  toFun c := ⟨f c, f (D c)⟩
  map_zero' := by ext <;> simp
  map_one' := by ext <;> simp
  map_add' c d := by ext <;> simp
  map_mul' c d := by
    ext
    · simp
    · simp [Derivation.leibniz, smul_eq_mul, mul_comm]

@[simp] theorem derivation_graph_along_fst (D : Derivation ℤ R R) (f : R →+* A) (c : R) :
    (derivationGraphAlong D f c).fst = f c := rfl

@[simp] theorem derivation_graph_along_snd (D : Derivation ℤ R R) (f : R →+* A) (c : R) :
    (derivationGraphAlong D f c).snd = f (D c) := rfl

/-- Any literal square-zero graph with identity first projection gives
an actual integral derivation, without assuming the Leibniz conclusion. -/
def squareZeroGraphDerivation (F : A →+* TrivSqZeroExt A A)
    (first : ∀ x, (F x).fst = x) : Derivation ℤ A A where
  toLinearMap := ((TrivSqZeroExt.sndHom A A).restrictScalars ℤ).comp
    F.toIntAlgHom.toLinearMap
  map_one_eq_zero' := by simp
  leibniz' x y := by
    change (F (x * y)).snd = x * (F y).snd + y * (F x).snd
    rw [map_mul, TrivSqZeroExt.snd_mul, first, first]
    simp only [op_smul_eq_smul, smul_eq_mul]

@[simp] theorem square_zero_graph_derivation_apply (F : A →+* TrivSqZeroExt A A)
    (first : ∀ x, (F x).fst = x) (x : A) :
    squareZeroGraphDerivation F first x = (F x).snd := rfl

end Litt3.Deformations

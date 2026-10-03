import Mathlib.Algebra.QuadraticAlgebra.Basic
import Mathlib.RingTheory.IntegralClosure.Algebra.Basic

namespace Litt3.QuotientGeometry

open scoped QuadraticAlgebra

/-- Actual coefficientwise base change on the quadratic coordinate algebra. -/
def quadraticOrderBaseChange
    (R K : Type*) [CommRing R] [CommRing K] [Algebra R K] (a : R) :
    QuadraticAlgebra R a 0 →ₐ[R] QuadraticAlgebra K (algebraMap R K a) 0 where
  toFun z := ⟨algebraMap R K z.re, algebraMap R K z.im⟩
  map_one' := by ext <;> simp
  map_mul' z w := by ext <;> simp [map_add, map_mul]
  map_zero' := by ext <;> simp
  map_add' z w := by ext <;> simp
  commutes' r := by
    change (⟨algebraMap R K r, algebraMap R K 0⟩ :
      QuadraticAlgebra K (algebraMap R K a) 0) = ⟨algebraMap R K r, 0⟩
    simp

instance quadraticOrderFractionAlgebra
    (R K : Type*) [CommRing R] [CommRing K] [Algebra R K] (a : R) :
    Algebra (QuadraticAlgebra R a 0) (QuadraticAlgebra K (algebraMap R K a) 0) :=
  (quadraticOrderBaseChange R K a).toRingHom.toAlgebra

instance quadraticOrderFractionTower
    (R K : Type*) [CommRing R] [CommRing K] [Algebra R K] (a : R) :
    IsScalarTower R (QuadraticAlgebra R a 0) (QuadraticAlgebra K (algebraMap R K a) 0) :=
  IsScalarTower.of_algebraMap_eq fun r => by
    change _ = quadraticOrderBaseChange R K a (algebraMap R (QuadraticAlgebra R a 0) r)
    exact ((quadraticOrderBaseChange R K a).commutes r).symm

def quadraticOrderConjugation
    (R K : Type*) [CommRing R] [CommRing K] [Algebra R K] (a : R) :
    QuadraticAlgebra K (algebraMap R K a) 0 →ₐ[R]
      QuadraticAlgebra K (algebraMap R K a) 0 where
  toRingHom := starRingEnd _
  commutes' r := by
    change star (⟨algebraMap R K r, 0⟩ : QuadraticAlgebra K (algebraMap R K a) 0) =
      ⟨algebraMap R K r, 0⟩
    ext <;> simp

end Litt3.QuotientGeometry

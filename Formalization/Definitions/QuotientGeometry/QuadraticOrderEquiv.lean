import Mathlib.Algebra.QuadraticAlgebra.Basic
import Mathlib.RingTheory.AdjoinRoot

namespace Litt3.QuotientGeometry

open scoped QuadraticAlgebra

/-- The two actual presentations of a monic quadratic coordinate algebra. -/
noncomputable def quadraticMonicOrderEquiv
    (R : Type*) [CommRing R] (a : R) :
    AdjoinRoot (Polynomial.X ^ 2 - Polynomial.C a) ≃ₐ[R] QuadraticAlgebra R a 0 := by
  let p : Polynomial R := Polynomial.X ^ 2 - Polynomial.C a
  let Q := QuadraticAlgebra R a 0
  let θ : Q := QuadraticAlgebra.omega
  have hθ : p.eval₂ (Algebra.ofId R Q) θ = 0 := by
    dsimp only [p]
    rw [Polynomial.eval₂_sub, Polynomial.eval₂_pow, Polynomial.eval₂_X, Polynomial.eval₂_C]
    change (QuadraticAlgebra.omega : QuadraticAlgebra R a 0) ^ 2 -
      algebraMap R (QuadraticAlgebra R a 0) a = 0
    ext <;> simp [QuadraticAlgebra.omega, pow_two, QuadraticAlgebra.algebraMap_eq]
  let f : AdjoinRoot p →ₐ[R] Q := AdjoinRoot.liftAlgHom p (Algebra.ofId R Q) θ hθ
  have hroot : (AdjoinRoot.root p) ^ 2 = algebraMap R (AdjoinRoot p) a := by
    have h := AdjoinRoot.eval₂_root p
    simp only [p, Polynomial.eval₂_sub, Polynomial.eval₂_pow, Polynomial.eval₂_X,
      Polynomial.eval₂_C, sub_eq_zero] at h
    simpa only [AdjoinRoot.algebraMap_eq] using h
  let g : Q →ₐ[R] AdjoinRoot p := QuadraticAlgebra.lift
    ⟨AdjoinRoot.root p, by
      simpa only [← pow_two, zero_smul, add_zero, Algebra.algebraMap_eq_smul_one] using hroot⟩
  have hf : f (AdjoinRoot.root p) = θ := by simp [f]
  have hg : g θ = AdjoinRoot.root p := by
    simp [g, θ, QuadraticAlgebra.lift, QuadraticAlgebra.omega]
  apply AlgEquiv.ofAlgHom f g
  · apply QuadraticAlgebra.algHom_ext
    change f (g θ) = θ
    rw [hg, hf]
  · apply AdjoinRoot.algHom_ext
    change g (f (AdjoinRoot.root p)) = AdjoinRoot.root p
    rw [hf, hg]

end Litt3.QuotientGeometry
